--view job history for one specific step

--Elapsed time in the execution of the job or step in HHMMSS format.

SELECT avg(h.run_duration) AverageRunDuration, j.name JobName
FROM msdb.dbo.sysjobhistory h
JOIN msdb.dbo.sysjobs j ON h.job_id = j.job_id
join msdb.dbo.syscategories c on c.category_id = j.category_id
WHERE c.name = 'Raider11\I12'
group by j.name
having avg(h.run_duration) > 400
ORDER BY avg(h.run_duration) desc,j.name

--run_duration Elapsed time in the execution of the job or step in HHMMSS format.


