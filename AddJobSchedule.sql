EXEC msdb.dbo.sp_add_jobschedule @job_name = 'Daily Transaction Log Backup.Subplan_1'
, @name=N'Every 15 Minutes'
, 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=15, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20150507, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959


exec msdb.dbo.sp_update_schedule @name = 'Daily Transaction Log Backup', @enabled = 0