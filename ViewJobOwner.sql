SELECT l.name, j.name
FROM msdb.dbo.sysjobs j
JOIN master.sys.syslogins l ON j.owner_sid = l.sid
ORDER BY l.name
