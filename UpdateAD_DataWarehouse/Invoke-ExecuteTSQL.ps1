﻿# Source: http://poshcode.org/3784

#######################
<#
.SYNOPSIS
Execute T-SQL Statments and return messages from SQL Server (print).
.DESCRIPTION
Execute T-SQL Statments and return messages from SQL Server (print).
.INPUTS
None
    You cannot pipe objects to Invoke-ExecuteTSQL 
.OUTPUTS
PSObject :
Boolean Exitcode = $True or $False indicating if the query ran successfully 
String  ErrorMessage = The ErrorMessage if not ran successfully
String  Message = Messages from SQL Server (print)
.EXAMPLE
Invoke-ExecuteTSQL -SQLInstanceName . -DatabaseName YourDB -UserName YourUserName -PassWord YourPassword -Query $Query -verbose
This command runs a T-SQL Query using UserName and Password
.EXAMPLE
Invoke-ExecuteTSQL -SQLInstanceName . -DatabaseName YourDB -Query $Query -verbose
This command runs a T-SQL Query using TrustedConnection
.LINK
Invoke-ExecuteTSQL 
#> 
 
function Invoke-ExecuteTSQL { 

	[cmdletbinding()]

	Param(
		[Parameter(Position=0,Mandatory = $true)]
		[ValidateNotNullorEmpty()]
		[string]$SQLInstanceName,
			
		[Parameter(Position=1,Mandatory = $true)]
		[ValidateNotNullorEmpty()]
		[string]$DatabaseName,
			
		[Parameter(Position=2)]
		[string]$UserName,
			
		[Parameter(Position=3)]
		[string]$PassWord,	
			
		[Parameter(Position=4,Mandatory = $true)]
		[ValidateNotNullorEmpty()]
		[string]$Query	

		)
	function Get-SQLConnectionEvent($EventID) {
	
		write-output (Get-Event -SourceIdentifier $EventID -ErrorAction SilentlyContinue  | 
		Select -ExpandProperty SourceEventArgs | 
		Select -ExpandProperty message) 
		Remove-Event -SourceIdentifier $EventID -ErrorAction SilentlyContinue
	}
	try {
		$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
		
		#if($Username -and $Password) {
			Write-Verbose "Connecting to SQL Server using trusted connection"
			$SqlConnection.ConnectionString = "Server=$($SQLInstanceName);Database=$($DatabaseName);Integrated Security=True"
	#	} else {
	#		Write-Verbose "Connecting to SQL Server using Username and Password"
	#		$SqlConnection.ConnectionString = "Server=$($SQLInstanceName);Database=$($DatabaseName);UID=$($Username);PWD=$($Password)"
	#	}

	 	$eventID = "SQLConnectionEvent$(Get-date -format 'yyyyMMddThhmmss')";
		
		write-verbose "Registering the event $eventID" 
	 	Register-ObjectEvent -inputObject $SqlConnection -eventName InfoMessage -sourceIdentifier $eventID
        #$SqlConnection.FireInfoMessageEventOnUserErrors = $true;
		
		$SqlCmd = New-Object System.Data.SqlClient.SqlCommand
		$SqlCmd.Connection = $SqlConnection
		$SqlCmd.CommandTimeout = 0
		$SqlCmd.Connection.Open()

		write-verbose "Running the Query" 

		$SqlCmd.CommandText = $Query
		$SqlCmd.ExecuteNonQuery() | Out-Null
		$ExitCode = $true
		$Message = Get-SQLConnectionEvent $eventID
		$ErrorMessage = ""
	} catch {
		$ExitCode = $false
		#$Message = Get-SQLConnectionEvent $eventID
		$Message = ""
		$ErrorMessage = $_.exception
	}
	Finally {
		if ($SqlCmd.Connection.State -eq [System.Data.ConnectionState]::Open) {
			write-verbose "Closing Connection" 
	            	$SqlCmd.Connection.Close()
			$SqlCmd.Connection.Dispose()
	    }
    }

	Write-Output (New-Object psobject -Property @{	'ExitCode' = $ExitCode
							'Message' = $Message	
  							'ErrorMessage' = $ErrorMessage})
    #Write-Output "ExitCode: $ExitCode"
    #Write-Output "Message:`n$Message"
    #Write-Output "ErrorMessage:`n$ErrorMessage"

}

$Query = "EXECUTE [dbo].[usp_UpdateADcontacts] 'LDAP://DC=veca,DC=is'"
#Invoke-ExecuteTSQL -SQLInstanceName snorridev\sqlexpress -DatabaseName AD_DW -Query $Query -verbose
$result = Invoke-ExecuteTSQL -SQLInstanceName snorridev\sqlexpress -DatabaseName AD_DW -Query $Query -verbose
Write-Output $result.ExitCode
Write-Output $result.Message
Write-Output $result.ErrorMessage

