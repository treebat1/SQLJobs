#https://sqlwhisper.wordpress.com/2014/04/12/powershell-script-to-drop-sql-jobs/


Param([String] $ServerName,
[String] $JobName)

$Module = Get-Module |where-object {$_.Name -like "SQLPS"} | Select-object Name
If ($Module -ne "SQLPS")
{
Import-Module SQLPS
}
$a=new-object Microsoft.SQLServer.Management.Smo.Server $ServerName
$b=$a.Jobserver.Jobs|where-object {$_.Name -like $JobName}
$b.drop()

Remove-Module SQLPS