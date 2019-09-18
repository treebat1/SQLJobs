msdb.dbo.sp_help_job @execution_status = 1

IF EXISTS(SELECT 1 
			FROM msdb.dbo.sysjobs J 
			JOIN msdb.dbo.sysjobactivity A 
			ON A.job_id=J.job_id 
			WHERE J.name like N'%Transfer Subject_Target_Session_End_State Staples%' 
			AND A.run_requested_date IS NOT NULL 
			AND A.stop_execution_date IS NULL)
RAISERROR ('Transfer Subject_Target_Session_End_State Staples Job still running!', 0, 1) WITH NOWAIT
			
SELECT j.*, a.*
FROM msdb.dbo.sysjobs J 
JOIN msdb.dbo.sysjobactivity A 
ON A.job_id=J.job_id 
			
			
			
exec reporting4.msdb.dbo.sp_start_job @job_name = 'Transfer Staples Staging Data'

    
    
    
    

    
   
    