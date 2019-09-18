--Jobs running at the beginning of the period
Select sjob.name
, msdb.dbo.agent_datetime(run_date, run_time) as 'RunStart'
, msdb.dbo.fn_AgentCompletionDateTime(run_date, run_time, run_duration) as 'RunEnd'
, jhist.step_name
,((run_duration/10000*3600 + (run_duration/100)%100*60 + run_duration%100 + 31 ) / 60) as 'RunDurationMinutes'
from msdb.dbo.sysjobhistory AS [jHist]
INNER JOIN [msdb].[dbo].[sysjobs] AS [sJOB]
ON [jHist].[job_id] = [sJOB].[job_id]
where msdb.dbo.agent_datetime(run_date, run_time) < '3/14/2017 17:00:00' --Start before beginning of period
and msdb.dbo.fn_AgentCompletionDateTime(run_date, run_time, run_duration) > '3/14/2017 17:00:00' --End after beginning of period
order by sjob.name, msdb.dbo.agent_datetime(run_date, run_time)
--


--Jobs running during WHOLE period
Select sjob.name
, msdb.dbo.agent_datetime(run_date, run_time) as 'RunStart'
, msdb.dbo.fn_AgentCompletionDateTime(run_date, run_time, run_duration) as 'RunEnd'
, jhist.step_name
,((run_duration/10000*3600 + (run_duration/100)%100*60 + run_duration%100 + 31 ) / 60) as 'RunDurationMinutes'
from msdb.dbo.sysjobhistory AS [jHist]
INNER JOIN [msdb].[dbo].[sysjobs] AS [sJOB]
ON [jHist].[job_id] = [sJOB].[job_id]
where msdb.dbo.agent_datetime(run_date, run_time) < '3/21/2017 14:00:00' --Start before end of period
and msdb.dbo.fn_AgentCompletionDateTime(run_date, run_time, run_duration) > '3/21/2017 18:00:00' --End after begin of period
order by sjob.name, msdb.dbo.agent_datetime(run_date, run_time)
--


--Jobs running during ANY PART of the period
Select sjob.name
, jhist.step_name
, msdb.dbo.agent_datetime(jhist.run_date, jhist.run_time) as 'RunStart'
, msdb.dbo.fn_AgentCompletionDateTime(jhist.run_date, jhist.run_time, jhist.run_duration) as 'RunEnd'
--,((run_duration/10000*3600 + (run_duration/100)%100*60 + run_duration%100 + 31 ) / 60) as 'RunDurationMinutes'
from msdb.dbo.sysjobhistory AS [jHist]
INNER JOIN [msdb].[dbo].[sysjobs] AS [sJOB]
ON [jHist].[job_id] = [sJOB].[job_id]
where (msdb.dbo.agent_datetime(jhist.run_date, jhist.run_time) <= '3/21/2017 18:00:00' --Start before or equal to the end of the period
AND msdb.dbo.fn_AgentCompletionDateTime(jhist.run_date, jhist.run_time, jhist.run_duration) >= '3/21/2017 18:00:00') --End after or equal to the end of the period
OR
(msdb.dbo.agent_datetime(jhist.run_date, jhist.run_time) <= '3/21/2017 14:00:00' --Start before or equal to the beginning of the period
AND msdb.dbo.fn_AgentCompletionDateTime(jhist.run_date, jhist.run_time, jhist.run_duration) >= '3/21/2017 14:00:00') --End after or equal to the beginning of the period
OR
(msdb.dbo.agent_datetime(jhist.run_date, jhist.run_time) >= '3/21/2017 14:00:00' --Start after or equal to the beginning of the period
AND msdb.dbo.fn_AgentCompletionDateTime(jhist.run_date, jhist.run_time, jhist.run_duration) <= '3/21/2017 18:00:00') --End before or equal to the end of the period
OR
(msdb.dbo.agent_datetime(jhist.run_date, jhist.run_time) <= '3/21/2017 14:00:00' --Start before or equal to the beginning of the period
AND msdb.dbo.fn_AgentCompletionDateTime(jhist.run_date, jhist.run_time, jhist.run_duration) >= '3/21/2017 18:00:00') --End after or equal to the end of the period
order by 1
--



--Unique List of Job Names running during ANY PART of the period
declare @StartDateTime as datetime
declare @EndDateTime as datetime

set @StartDateTime = '5/09/2017 14:00:00'
set @EndDateTime = '5/09/2017 17:00:00'


Select DISTINCT(sjob.name)
from msdb.dbo.sysjobhistory AS [jHist]
INNER JOIN [msdb].[dbo].[sysjobs] AS [sJOB]
ON [jHist].[job_id] = [sJOB].[job_id]
where (msdb.dbo.agent_datetime(jhist.run_date, jhist.run_time) <= @EndDateTime --Start before or equal to the end of the period
AND msdb.dbo.fn_AgentCompletionDateTime(jhist.run_date, jhist.run_time, jhist.run_duration) >= @EndDateTime) --End after or equal to the end of the period
OR
(msdb.dbo.agent_datetime(jhist.run_date, jhist.run_time) <= @StartDateTime --Start before or equal to the beginning of the period
AND msdb.dbo.fn_AgentCompletionDateTime(jhist.run_date, jhist.run_time, jhist.run_duration) >= @StartDateTime) --End after or equal to the beginning of the period
OR
(msdb.dbo.agent_datetime(jhist.run_date, jhist.run_time) >= @StartDateTime --Start after or equal to the beginning of the period
AND msdb.dbo.fn_AgentCompletionDateTime(jhist.run_date, jhist.run_time, jhist.run_duration) <= @EndDateTime) --End before or equal to the end of the period
OR
(msdb.dbo.agent_datetime(jhist.run_date, jhist.run_time) <= @StartDateTime --Start before or equal to the beginning of the period
AND msdb.dbo.fn_AgentCompletionDateTime(jhist.run_date, jhist.run_time, jhist.run_duration) >= @EndDateTime) --End after or equal to the end of the period
order BY 1

/*
name	step_name	RunStart	RunEnd
Catalog Import Nissen	(Job outcome)	2017-01-30 12:30:00.000	2017-01-30 13:06:45.000
Catalog Import Nike API NEW	(Job outcome)	2017-01-30 12:00:01.000	2017-01-30 13:28:09.000
*/



/* Helper Function */


/*
use msdb
go

Create function [dbo].[fn_AgentCompletionDateTime] (@agentdate int, @agenttime int, @agentduration int)

returns datetime

as

begin

declare @date datetime,

@year int,

@month int,

@day int,

@hour int,

@min int,

@sec int,

@datestr nvarchar(40),

@runduration int

select @year = (@agentdate / 10000)

select @month = (@agentdate - (@year * 10000)) / 100

select @day = (@agentdate - (@year * 10000) - (@month * 100))

select @hour = (@agenttime / 10000)

select @min = (@agenttime - (@hour * 10000)) / 100

select @sec = (@agenttime - (@hour * 10000) - (@min * 100))

select @runduration = case when @agentduration <100 then @agentduration

when @agentduration between 100 and 999 then left(@agentduration,1)*60+right(@agentduration,2)

when @agentduration between 1000 and 9999 then left(@agentduration,2)*60+right(@agentduration,2)

when @agentduration > 9999 then left(@agentduration,len(@agentduration)-4)*3600+left(right(@agentduration,4),2)*60+right(@agentduration,2)

end

select @datestr = convert(varchar(4), @year) + N'-' +

convert(varchar(2), @month) + N'-' +

convert(varchar(4), @day) + N' ' +

replace(convert(varchar(2), @hour) + N':' +

convert(varchar(2), @min) + N':' +

convert(varchar(2), @sec), ' ', '0')

select @date = convert(datetime, @datestr)

select @date =dateadd(ss,@runduration,@date)

return @date

end

*/




