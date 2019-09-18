--view job history for one specific step

--Elapsed time in the execution of the job or step in HHMMSS format.




SELECT h.run_duration, j.name JobName
--, c.name CategoryName
, CASE WHEN LEN(h.run_duration) BETWEEN 1 AND 2 THEN 'seconds'
		WHEN LEN(h.run_duration) BETWEEN 3 AND 4 THEN 'minutes'
		WHEN LEN(h.run_duration) BETWEEN 5 AND 6 THEN 'hours'
		ELSE '' END AS [Time_Unit]
 , h.run_date
 --, h.step_name
FROM msdb.dbo.sysjobhistory h
JOIN msdb.dbo.sysjobs j ON h.job_id = j.job_id
join msdb.dbo.syscategories c on c.category_id = j.category_id
WHERE --h.step_name LIKE '%USER_DATABASES%FULL%'
--AND h.run_date = 20170503
--AND CASE WHEN LEN(run_duration) BETWEEN 1 AND 2 THEN 'seconds'
--		WHEN LEN(run_duration) BETWEEN 3 AND 4 THEN 'minutes'
--		WHEN LEN(run_duration) BETWEEN 5 AND 6 THEN 'hours'
--		ELSE '' END = 'hours'
--AND 
j.name LIKE '%Weekly%'
--ORDER BY h.run_durationDESC
ORDER BY h.run_duration




SELECT h.run_duration
, CASE WHEN LEN(h.run_duration) BETWEEN 1 AND 2 THEN 'seconds'
		WHEN LEN(h.run_duration) BETWEEN 3 AND 4 THEN 'minutes'
		WHEN LEN(h.run_duration) BETWEEN 5 AND 6 THEN 'hours'
		ELSE '' END AS [Time_Unit]
 , h.run_date
FROM msdb.dbo.sysjobhistory h
WHERE --c.name = 'Raider11\I12'
h.step_name LIKE '%USER_DATABASES%FULL%'
AND h.run_date between 20171022 AND 20171101
--AND CASE WHEN LEN(run_duration) BETWEEN 1 AND 2 THEN 'seconds'
--		WHEN LEN(run_duration) BETWEEN 3 AND 4 THEN 'minutes'
--		WHEN LEN(run_duration) BETWEEN 5 AND 6 THEN 'hours'
--		ELSE '' END = 'hours'
--AND name LIKE '%cin%'
--ORDER BY h.run_durationDESC
ORDER BY h.run_date desc


