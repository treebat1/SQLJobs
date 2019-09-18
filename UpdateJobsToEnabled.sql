-- Set @enabled = 1 or @enabled = 0 
-- Run generated script 
SELECT 'EXEC msdb.dbo.sp_update_job @job_name=N'''+s.NAME+''' , @enabled = 1' 
FROM msdb..sysjobs s 
left join msdb.sys.syslogins l on s.owner_sid = l.sid
where s.name like 'Update%'
and s.enabled = 0
order by s.name