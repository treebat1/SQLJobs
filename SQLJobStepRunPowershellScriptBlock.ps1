powershell.exe -command {

$ADGroupName = "Cl_DataMart_Developers"
$ActiveDirectoryGroupName = @{label="ActiveDirectoryGroupName";expression={$ADGroupName}}

Get-ADGroupMember -Identity $ADGroupName | Get-ADObject -Properties Name, DisplayName, Title, Department |  Select-Object  -Property $ActiveDirectoryGroupName, Name, DisplayName, Title, Department | Write-SqlTableData -ServerInstance "CHDC-CAR-THSQL2\DATAMARTDEV" -ConnectionTimeout 10 -DatabaseName "Sys_Admin" -SchemaName "SecurityBackup" -TableName "ActiveDirectoryGroupMember"

}