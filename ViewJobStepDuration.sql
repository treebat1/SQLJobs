Select --TOP(10)
CONVERT (date,convert(char(8),jhist.run_date)) AS run_date
, sjob.name as 'JobName'
, jhist.step_name as 'StepName'
, msdb.dbo.agent_datetime(run_date, run_time) as 'RunDateTime'
,((run_duration/10000*3600 + (run_duration/100)%100*60 + run_duration%100 + 31 ) / 60) as 'RunDurationMinutes'
,((run_duration/10000*3600 + (run_duration/100)%100*60 + run_duration%100 + 31 ) / 3600) as 'RunDurationHours'
, CONVERT (date,convert(char(8),jhist.run_date)) as 'RunDate'
, case  run_status when 0 then 'failed' when 1 then 'succeeded' when 2 then 'retry' when 3 then 'canceled' end as 'Status'
, retries_attempted
, message
from msdb.dbo.sysjobhistory AS [jHist]
INNER JOIN [msdb].[dbo].[sysjobs] AS [sJOB]
ON [jHist].[job_id] = [sJOB].[job_id]
Where 
(run_duration/10000*3600 + (run_duration/100)%100*60 + run_duration%100 + 31 ) / 60 > 30
--And [jHist].step_name = 'Run Export Powershell Script'
and msdb.dbo.agent_datetime(run_date, run_time) >= '2016/10/29 18:00'
Order by 5 desc