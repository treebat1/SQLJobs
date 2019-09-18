#https://www.mssqltips.com/sqlservertip/2787/disable-or-enable-sql-server-agent-jobs-using-powershell/


[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SMO') | out-null
$serverInstance = New-Object ('Microsoft.SqlServer.Management.Smo.Server') "LOCALHOST"
#Create an instance of the Jobs object collection from the JobServer property
foreach ($jobs in ($serverInstance.JobServer.Jobs | Where-Object {$_.Name -in "_adhoc_Execute_RadarIssueExport","_adhoc_Execute_RadarIssueImport","_dly_0400_RLLF_IncrementalLoss_Load","_dly_0715_MSP_GL_Load","_dly_0740_M-F_TabularCapIncentive","_mth_day_1_Load_SBO2000_Files_see_description","_mth_day03_1100_LoanStatsImport","_wkly_Seattle_Specialty_Insurance_Outbound","BIA_Dim_Customer_Relationship_Load","CIMS_Data_Load","Dug","SCRA_Customer_Account_Product_FileOutput","SCRA_Flag_Upddate","_dly_0630_Load_QRM_MBService_csv_Files"}))
{
 $jobs.IsEnabled = $FALSE
 $jobs.Alter()
} 