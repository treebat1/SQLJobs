--Script to change ending step on job based on content of a job step.




sp_update_jobstep 
@job_name ='Reporting Generation Staples' 
, @step_id = 10
, @on_success_action = 1 
, @on_fail_action = 2 


--sucess action codes
/*
1
Quit with success.
2
Quit with failure.
3
Go to next step.
4
Go to step success_step_id.
*/


SELECT j.name, js.*
FROM msdb.dbo.sysjobsteps js
JOIN msdb.dbo.sysjobs j
ON js.job_id = j.job_id
WHERE step_name = 'Staging Table Rebuild Index Split Partition Update Statistics'
--AND j.name LIKE 'Reporting Generation%'
ORDER BY name

SELECT on_success_action
, on_fail_action 
from msdb.dbo.sysjobsteps 
WHERE step_name = 'Staging Table Rebuild Index Split Partition Update Statistics'


UPDATE msdb.dbo.sysjobsteps 
SET on_success_action = 3
WHERE step_name = 'Staging Table Rebuild Index Split Partition Update Statistics'
AND on_success_action = 4


UPDATE msdb.dbo.sysjobsteps 
SET on_success_action = 4
, on_success_step_id = step_id + 2
WHERE step_name = 'Staging Table Rebuild Index Split Partition Update Statistics'




SELECT j.name, js.*
FROM msdb.dbo.sysjobsteps js
JOIN msdb.dbo.sysjobs j
ON js.job_id = j.job_id
WHERE step_name like 'Start%'
AND j.name LIKE 'Reporting Generation%'
ORDER BY j.name

--what are the jobs that are missing the maintenance step
UPDATE msdb.dbo.sysjobsteps
SET on_success_action = 3
WHERE on_success_action = 4
AND step_name = 'Session Summary IS TS'
AND job_id IN (
						SELECT j.job_id
						FROM msdb.dbo.sysjobsteps js1
						JOIN msdb.dbo.sysjobs j ON js1.job_id = j.job_id
						WHERE js1.step_name like 'Start%'
						AND j.name LIKE 'Reporting Generation%'
						AND NOT EXISTS (SELECT 1 FROM msdb.dbo.sysjobsteps js2 WHERE js2.job_id = j.job_id AND js2.step_name = 'Staging Table Rebuild Index Split Partition Update Statistics')
				)


SELECT js.step_id, js.step_name, js.command, js.on_success_action, js.on_success_step_id
FROM msdb.dbo.sysjobsteps js
WHERE js.job_id IN (
						SELECT j.job_id
						FROM msdb.dbo.sysjobsteps js1
						JOIN msdb.dbo.sysjobs j ON js1.job_id = j.job_id
						WHERE js1.step_name like 'Start%'
						AND j.name LIKE 'Reporting Generation%'
						AND NOT EXISTS (SELECT 1 FROM msdb.dbo.sysjobsteps js2 WHERE js2.job_id = j.job_id AND js2.step_name = 'Staging Table Rebuild Index Split Partition Update Statistics')
					)
AND js.on_success_action = 
AND js.step_name = 'Session Summary IS TS'
ORDER BY js.job_id, js.step_id


--update jobs back to next step
UPDATE msdb.dbo.sysjobsteps
SET on_success_action = 3
WHERE on_success_action = 1
AND step_name = 'Staging Table Rebuild Index Split Partition Update Statistics'
AND job_id IN (
						SELECT j.job_id
						FROM msdb.dbo.sysjobs j 
						WHERE j.name LIKE 'Reporting Generation%'
				)