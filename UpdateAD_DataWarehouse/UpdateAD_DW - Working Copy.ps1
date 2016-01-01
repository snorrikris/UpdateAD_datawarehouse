############################################################################################################
# Modify the following parameters:

$TaskTitle = "Update Active Directory data warehouse on SQL server"

# Email settings
$MailTo = "snorri@veritas.is"
$MailFrom = "dummy@dummy.com"
$MailServer = "kerfispostur.veca.is"
$SendMailOnSuccess = $true
$SendMailOnFailure = $true

$connString = "Data Source=snorridev\sqlexpress;Initial Catalog=AD_DW;Integrated Security=TRUE;"


############################################################################################################
# DO NOT MODIFY ANYTHING BELOW THIS LINE
 
$SqlConnection = new-object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = $connString
$result = 99
$global:log = ""
$global:sqllog = ""
$now = Get-Date -Format G
try
{
    #$Sqlconnection.FireInfoMessageEventOnUserErrors=$true
    #Register-ObjectEvent -InputObject $SqlConnection -EventName InfoMessage -Action { Write-Host "$($Event.SourceEventArgs)" } -SupportEvent
    Register-ObjectEvent -InputObject $SqlConnection -EventName InfoMessage -Action { $global:sqllog += "$($Event.SourceEventArgs)`n" } -SupportEvent
    #Register-ObjectEvent -InputObject $SqlConnection -EventName InfoMessage -Action { $global:lop = $global:lop -join " XXX $($Event.SourceEventArgs)" } -SupportEvent

    $global:log += "$now`tConnecting to SQL server...`n"
    $SqlConnection.Open()

    $SqlCommand = $SqlConnection.CreateCommand()
    #$SqlCommand.CommandText = "EXECUTE [dbo].[usp_UpdateADcontacts] @ADpath;"
    $SqlCommand.CommandText = "EXECUTE [dbo].[usp_UpdateADall_tables] @ADpath;"
 
    # Add parameters to pass values to the stored procedure
    $SqlCommand.Parameters.AddWithValue("@ADpath", "LDAP://DC=veca,DC=is") | Out-Null

    $now = Get-Date -Format G
    $global:log += "$now`tExecuting stored procedure...`n"
    $result = $SqlCommand.ExecuteNonQuery()
    Wait-Event -SourceIdentifier "Dummy" -Timeout 2    # Need to wait for all async events to complete.
    $now = Get-Date -Format G
    $global:log += "$now`tResult = $result`n"
    $global:log += $global:sqllog
}
catch
{
    $now = Get-Date -Format G
    $global:log += "$now`tTask failed`n"
    $global:log += "`t$_`n"  #current error
    $global:log += "`t(error) Result = $result`n"
    $global:log += "`tOutput from SQL (if any)`n"
    $global:log += $global:sqllog + "`n"
}
finally
{
    if ($SqlConnection.State -eq "Open") 
    { 
        $now = Get-Date -Format G
        $global:log += "$now`tClosing Connection...`n" 
        # Close the currently open connection. 
        $SqlConnection.Close() 
    } 
}
Write-Host $global:log
if ($SendMailOnSuccess -eq $true -AND $result -eq 0)
{
    Send-MailMessage -To $MailTo -Subject "$TaskTitle - Task succeeded" -Body $global:log -SmtpServer $MailServer -From $MailFrom
}
if ($SendMailOnFailure -eq $true -AND $result -ne 0)
{
    Send-MailMessage -To $MailTo -Subject "$TaskTitle - Task failed" -Body $global:log -SmtpServer $MailServer -From $MailFrom
}
