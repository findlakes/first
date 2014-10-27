<?php

include_once "api.php";

$dbg_ret = CallAPI("GET", "http://192.168.145.254:9292/scans/".$_GET['id']."/issues.json");

$json_obj = json_decode($dbg_ret);

//var_dump($json_obj);
/*
foreach ($json_obj as &$value) {
	echo "$value->id <br /> $value->name <br /> $value->url <br /> $value->description  ";
	echo "";
}
*/
?>

<!DOCTYPE html>
<!-- saved from url=(0048)http://v3.bootcss.com/examples/starter-template/ -->
<html lang="en">
  <head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="icon" href="http://v3.bootcss.com/favicon.ico">
    <title>宇宙扫描</title>
    <link href="http://v3.bootcss.com/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="http://v3.bootcss.com/examples/starter-template/starter-template.css" rel="stylesheet">
  </head>

  <body>

    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="/front_arachni">宇宙牌儿</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li class="active"><a href="#">首页</a></li>
            <li><a href="#">关于</a></li>
            <li><a href="#">捐赠</a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>

    <div class="container">
		<div class="starter-template">
			<div class="jumbotron">
				<h1>宇宙扫描报告</h1>
					<p class="lead">宇宙无敌扫描器（Web Vulnerability Scanner）是一个自动化的Web应用程序安全测试工具，它可以扫描宇宙中任何可通过Web浏览器访问的和遵循HTTP/HTTPS规则的Web站点和Web应用程序</p>
			</div>
			<div class="list ">
				<h3 class="text-center">扫描列表</h3>
				<table class="table table-hover table-bordered text-left">
				  <thead>
					<tr>
					  <th width="60px" class="text-center">序号</th>
					  <th width="60px" class="text-center">名称</th>
					  <th class="text-left">描述</th>
					  <th width="160px" class="text-center">任务状态</th>
					  <th width="120px" class="text-center">任务进度</th>
					  <th width="120px">操作</th>
					</tr>
				  </thead>
				  <tbody>
<?php
foreach ($json_obj as &$value) {
?>
<tr>
  <td><?php echo $value->id ?></td>
  <td><?php echo $value->name ?></td>
  <td><?php echo $value->description ?></td>
  <td class="text-left"><?php echo $value->url ?></td>
  <td><?php echo $value->severity ?></td>
  <td>
	<a href="#"><button type="button" class="btn btn-primary btn-xs">详细</button></a>
	<button type="button" class="btn btn-danger btn-xs">帮助</button>
  </td>
</tr>
<?php
}
?>
					<tr>
					  <td>--</td>
					  <td>--</td>
					  <td>--</td>
					  <td>--</td>
					  <td>--</td>
					  <td>
						<button type="button" class="btn btn-primary btn-xs">报告 </button>
						<button type="button" class="btn btn-danger btn-xs">删除</button>
					  </td>
					</tr>
				  </tbody>
				</table>
			</div>
      </div>

    </div><!-- /.container -->

</body></html>

