use msdb
go

select date_modified, name, enabled, *
from msdb.dbo.sysjobs s
order by s.date_modified desc