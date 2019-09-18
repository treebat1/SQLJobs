use msdb
go



exec msdb.dbo.sp_help_job @job_name = '_dly_2000_M-F_DiffBackups'