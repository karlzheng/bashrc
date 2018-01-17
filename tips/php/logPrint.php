require_once 'log.php';
//protected/apps/member/controller/weixinController.php

$logHandler= new CLogFileHandler(BASE_PATH."/logs/".date('Y-m-d').'.log');
$log = Log::Init($logHandler, 15);
Log::DEBUG("begin wx notify");

