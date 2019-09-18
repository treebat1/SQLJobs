--View Jobs Using SSIS

select s.name, js.step_name, js.last_run_date, js.command
from msdb.dbo.sysjobsteps js
join msdb.dbo.sysjobs s on js.job_id = s.job_id
where subsystem = 'SSIS'
and s.enabled = 1
order by js.command