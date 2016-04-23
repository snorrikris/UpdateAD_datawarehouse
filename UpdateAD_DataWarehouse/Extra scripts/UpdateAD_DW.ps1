# Note to run this script using Task Scheduler:
# Create new task.
# Set task action: Start a program
#     Program/script: powershell
#     Arguments:      -nologo -File "C:\Scripts\UpdateAD_DW.ps1"

############################################################################################################
# Modify the following parameters:

$ADpath = "LDAP://DC=contoso,DC=com"    # <-- your AD domain

$TaskTitle = "Update Active Directory data warehouse on SQL server"

# Email settings
$MailTo = "admin@contoso.com"
$MailFrom = "dummy@dummy.com"
$MailServer = "mail.contoso.com"
$SendMailOnSuccess = $true
$SendMailOnFailure = $true

#SQL connection string
$connString = "Data Source=yourserver\sqlexpress;Initial Catalog=AD_DW;Integrated Security=TRUE;"


############################################################################################################
# DO NOT MODIFY ANYTHING BELOW THIS LINE

$TaskStatus = $true
 
$SqlConnection = new-object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = $connString
$global:log = ""

$global:log += "************************************************************************`n"
$global:log += "Task - $TaskTitle - starting`n"
[string] $PSverMajor = $PSVersionTable.PSVersion.Major
[string] $PSverMinor = $PSVersionTable.PSVersion.Minor
$global:log += "`nPowerShell version: $PSverMajor.$PSverMinor`n"
$global:log += "Computername: $env:computername`n"
$global:log += "Username: $env:username`n"
$now = Get-Date -Format G
$global:log += "$now`tConnecting to SQL server...`n"
try
{
    $SqlConnection.Open()
}
catch
{
    $TaskStatus = $false
    $now = Get-Date -Format G
    $global:log += "$now`tOpen SQL connection failed`n"
    $global:log += "Connection string: $connString`n"
    $global:log += "$_`n"  #current error
}

function ExecuteUpdateAD_SP { 

	[cmdletbinding()]

	Param(
		[Parameter(Position=0,Mandatory = $true)]
		[ValidateNotNullorEmpty()]
		[string]$SPcmdText,

		[Parameter(Position=1,Mandatory = $true)]
		[ValidateNotNullorEmpty()]
		[string]$AD_Path

		)
	function Get-SQLConnectionEvent($EventID) {
	
		write-output (Get-Event -SourceIdentifier $EventID -ErrorAction SilentlyContinue  | 
		Select -ExpandProperty SourceEventArgs | 
		Select -ExpandProperty message) 
		Remove-Event -SourceIdentifier $EventID -ErrorAction SilentlyContinue
	}
    try
    {
        $global:log += "`n-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=`n"
        $now = Get-Date -Format G
        $global:log += "$now`tExecuting stored procedure...`n$SPcmdText`nADpath: $AD_Path`n"

        if ($SqlConnection.State -ne "Open") 
        {
            $global:log += "No connection to SQL server.`n"
            return $false
        }

        [string] $evtguid = [guid]::NewGuid()
	 	$eventID = "SQLConnectionEvent_$evtguid";
	 	Register-ObjectEvent -inputObject $SqlConnection -eventName InfoMessage -sourceIdentifier $eventID

        $SqlCommand = $SqlConnection.CreateCommand()
        $SqlCommand.CommandText = $SPcmdText
        $SqlCommand.Parameters.AddWithValue("@ADpath", $AD_Path) | Out-Null

        $SqlCommand.ExecuteNonQuery() | Out-Null

        # Get messages from SQL query
        Wait-Event -SourceIdentifier $eventID -Timeout 2 | Out-Null   # Need to wait for all async events to complete.
		$Message = Get-SQLConnectionEvent $eventID
        $global:log += $Message
    }
    catch
    {
        $now = Get-Date -Format G
        $global:log += "$now`tTask failed`n"
        $global:log += "`t$_`n"  #current error
        return $false
    }
    return $true
}

$cmds = @(
    "EXECUTE [dbo].[usp_UpdateADusers] @ADpath;",
	"EXECUTE [dbo].[usp_UpdateADcontacts] @ADpath;",
	"EXECUTE [dbo].[usp_UpdateADcomputers] @ADpath;",
	"EXECUTE [dbo].[usp_UpdateADwell_known_sids] @ADpath;",
	"EXECUTE [dbo].[usp_UpdateADgroups] @ADpath;",
	"EXECUTE [dbo].[usp_UpdateADusersPhotos] @ADpath;")

foreach ($cmd in $cmds) {
    $ExecResult = ExecuteUpdateAD_SP -SPcmdText $cmd -AD_Path $ADpath
    if($ExecResult -eq $false) {
        $TaskStatus = $false
    }
}

if ($SqlConnection.State -eq "Open") 
{ 
    $now = Get-Date -Format G
    $global:log += "`n`n$now`tClosing Connection...`n" 
    $SqlConnection.Close() # Close the currently open connection.
} 

$global:log += "************************************************************************`n"
$global:log += "Task - $TaskTitle - ends`n"
#Write-Host $global:log

if ($SendMailOnSuccess -eq $true -AND $TaskStatus -eq $true)
{
    Send-MailMessage -To $MailTo -Subject "$TaskTitle - Task succeeded" -Body $global:log -SmtpServer $MailServer -From $MailFrom
}
if ($SendMailOnFailure -eq $true -AND $TaskStatus -eq $false)
{
    Send-MailMessage -To $MailTo -Subject "$TaskTitle - Task failed" -Body $global:log -SmtpServer $MailServer -From $MailFrom
}
