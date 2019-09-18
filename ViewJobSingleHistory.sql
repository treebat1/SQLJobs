EXEC msdb.dbo.sp_help_jobhistory 
    @job_name = N'_dly_2000_M-F_DiffBackups'
	, @step_id = 2
	--, @minimum_run_duration = 100 --HHMMSS format
	, @mode = 'full'
	--, @mode = 'summary'
	--, @run_status = 0;
	, @start_run_date = '20181001'
GO