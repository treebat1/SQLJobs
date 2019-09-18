--view job history for one specific step

--Elapsed time in the execution of the job or step in HHMMSS format.

SELECT j.name JobName
, c.name CategoryName
, h.run_duration
, CASE WHEN LEN(h.run_duration) BETWEEN 1 AND 2 THEN 'seconds'
		WHEN LEN(h.run_duration) BETWEEN 3 AND 4 THEN 'minutes'
		WHEN LEN(h.run_duration) BETWEEN 5 AND 6 THEN 'hours'
		ELSE '' END AS [Time_Unit]
 , h.run_date
 , h.step_name
 , h.run_status
 , h.[message]
FROM msdb.dbo.sysjobhistory h
JOIN msdb.dbo.sysjobs j ON h.job_id = j.job_id
join msdb.dbo.syscategories c on c.category_id = j.category_id
WHERE h.run_status in (0,2) --Failed, Retry
and h.run_date >= '20190909'
and h.step_name <> '(Job outcome)'
ORDER BY h.run_date desc


SELECT j.name JobName
, h.step_name
FROM msdb.dbo.sysjobhistory h
JOIN msdb.dbo.sysjobs j ON h.job_id = j.job_id
join msdb.dbo.syscategories c on c.category_id = j.category_id
WHERE h.run_status in (0,2) --Failed, Retry
and h.run_date >= '20190909'
and h.step_name <> '(Job outcome)'
group by j.name, h.step_name
order by 1, 2

