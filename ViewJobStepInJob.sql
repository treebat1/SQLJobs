--Exists
select j.name, js.step_name, js.command
from msdb.dbo.sysjobs j
join msdb.dbo.sysjobsteps js on j.job_id = js.job_id
where js.command LIKE '%usp_10175_ForeignMortgageCustomers%'
or js.command like '%ACCT_ADDR_B'
--and 
--js.command like '%CL_DBA%'
--and 
--js.command NOT LIKE '%CL_DBA%'
--and j.name like '_mth%'
--and js.step_name like'%send%'
order by js.step_name
--0


select j.name, js.step_name, js.command
from msdb.dbo.sysjobs j
join msdb.dbo.sysjobsteps js on j.job_id = js.job_id
where js.command LIKE '%transfer_active%'
--and 
--js.command like '%CL_DBA%'
--and 
--js.command NOT LIKE '%CL_DBA%'
--and j.name like '_mth%'
--and js.step_name like'%send%'
order by js.step_name




--Not Exists
/*
select j.name
from msdb.dbo.sysjobs j
where not exists (select 1 from dbo.sysjobsteps js where j.job_id = js.job_id and js.step_name like '%Update_Active_Objects%')
and j.name like 'Reporting Generation%'
and j.name not like '%Decoupled'
and j.name not like '%Session%'
and j.name not like '%Old%'
and j.name not like '%Catchup%'
order by j.name
*/

