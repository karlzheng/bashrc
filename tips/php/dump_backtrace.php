1.
debug_print_backtrace();

2.
require_once 'log.php';
$logHandler= new CLogFileHandler(BASE_PATH."/logs/".date('Y-m-d').'.log');
$log = Log::Init($logHandler, 15);
$html = "\n";
$array = debug_backtrace();
foreach($array as $row) {
		$html .= '调用方法:'.$row['function']."\t\t".$row['file'].':'.$row['line'].'行'." \n";
}
Log::DEBUG($html);
