Select TOP(1000)CONVERT (date,convert(char(8),jhist.run_date)) AS run_date
, sjob.name
, jhist.step_name
, msdb.dbo.agent_datetime(run_date, run_time) as 'RunDateTime'
,((run_duration/10000*3600 + (run_duration/100)%100*60 + run_duration%100 + 31 ) / 60) as 'RunDurationMinutes'
, message
from msdb.dbo.sysjobhistory AS [jHist]
INNER JOIN [msdb].[dbo].[sysjobs] AS [sJOB]
ON [jHist].[job_id] = [sJOB].[job_id]
Where sJOB.name like '_dly_2000_M-F_DiffBackups'
--And jhist.run_duration > 500
--And 
--[sjob].[enabled] = 1
--And [jHist].step_name like '%Get%'
--And CONVERT (date,convert(char(8),jhist.run_date)) = CONVERT(date,getdate())
--And msdb.dbo.agent_datetime(run_date, run_time) >= '12/9/2015 12:00:00'
--AND message LIKE '%amqp%'
ORDER BY 1,4 desc


--select j.name
--from dbo.sysjobs j
--join dbo.sysjobsteps js on j.job_id = js.job_id
--where js.step_name like '%Get%'
