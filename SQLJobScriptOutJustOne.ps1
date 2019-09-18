import-module sqlps -disablenamechecking

$s = new-object microsoft.sqlserver.management.smo.server 'chdc-car-thsql1\datamartdev'
$a = $s.jobserver
$a.Jobs['_DailyTabularModelsServicingRefresh'].script()