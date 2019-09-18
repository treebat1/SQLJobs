use msdb
go

SET NOCOUNT ON

declare @JobName varchar(100)
declare @DB varchar(100)
declare @ScheduleID int
declare @SQL               nvarchar(4000)

select j.name as JobName, 
       substring(j.name, len('Update Similarity Lists') + 2, len(j.name) - (len('Update Similarity Lists') + 2))  as DB, 
       s.schedule_id
into #a
--select *
from sysjobs as j
       inner join syscategories as c
              on j.category_id = c.category_id
       inner join sysjobschedules as s
              on j.job_id = s.job_id
where j.name like 'Update Similarity Lists %'
       and c.name = 'raiderSQL7\I4'
order by j.name

declare db_Cursor cursor for
select JobName, DB, schedule_id
from #a
order by 1, 2

open db_Cursor

FETCH NEXT FROM db_Cursor 
INTO @JobName, @DB, @ScheduleID

WHILE @@FETCH_STATUS = 0
BEGIN
       select @SQL = 'exec sp_update_schedule @schedule_id = ' + cast(@ScheduleID as varchar(10)) + ', @freq_interval = 3'
--    print @SQL

              BEGIN TRY
                     exec sp_executesql @SQL
              END TRY
              BEGIN CATCH
              END CATCH

    FETCH NEXT FROM db_Cursor 
    INTO @JobName, @DB, @ScheduleID
END

CLOSE db_Cursor
DEALLOCATE db_Cursor

select *
from #a

drop table #a
