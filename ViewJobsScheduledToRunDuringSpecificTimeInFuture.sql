/*

Script: Find Jobs scheduled to run during a specific time range
Version: 1A

Author Info:
Author  :  Sarabpreet Singh            
E-Mail  :  sarab<AT>Sarabpreet (dot)com           
website :  www.sarabpreet.com                       

To get update on this or all my other scripts\blogs follow me at:           
https://twitter.com/Sarab_SQLGeek
http://www.facebook.com/Sarabpreet.Anand
Blogging @ http://www.sqlservergeeks.com/blogs/sarab
*/


CREATE FUNCTION msdb_time_readable (
    @int_time INT
)
RETURNS TIME(0)
AS 
BEGIN

/*Script: Find Jobs scheduled to run during a specific time range
Version: 1A

Author Info:
Author  :  Sarabpreet Singh            
E-Mail  :  sarab<AT>Sarabpreet (dot)com           
website :  www.sarabpreet.com  
*/

    IF NOT (@int_time BETWEEN 0 AND 235959) 
        RETURN NULL

    DECLARE @str VARCHAR(32) = CAST(@int_time AS VARCHAR(32))
    SELECT @str = REPLICATE('0', 6 - LEN(@str)) + @str
    SELECT @str = STUFF(@str, 3, 0, ':')
    SELECT @str = STUFF(@str, 6, 0, ':')

    RETURN CONVERT(TIME(0), @str, 108)
END
GO


select name,CONVERT(DATE, CAST(next_run_date AS VARCHAR(32)), 112) as date, dbo.msdb_time_readable(next_run_time) as time, js.job_id
from msdb.dbo.sysjobschedules js 
inner join msdb.dbo.sysjobs j
on j.job_id = js.job_id
where enabled = 1
and dbo.msdb_time_readable(next_run_time)  between '14:00:00' and '17:00:00'
order by name


select SUBSTRING(name,19, 50), name, CONVERT(DATE, CAST(next_run_date AS VARCHAR(32)), 112) as date, dbo.msdb_time_readable(next_run_time) as time, js.job_id
from msdb.dbo.sysjobschedules js 
inner join msdb.dbo.sysjobs j
on j.job_id = js.job_id
where enabled = 1
and dbo.msdb_time_readable(next_run_time)  between '14:00:00' and '17:00:00'
order by name
