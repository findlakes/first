<?php

//xml info.
$config  = 'data.xml';
$xmltype = 'SimpleXMLElement';
$xmldata = simplexml_load_file($config,$xmltype,LIBXML_NOCDATA);        //读取xml文件

//Read config data.
$ad_loop    = $xmldata->ad_loop;
$ad_referer = $xmldata->ad_referer;
$sites      = $xmldata->sites->site;

//edit a record.
if(isset($_GET['domain'])){
	if(isset($_POST['ad_loop']))$xmldata->ad_loop = $_POST['ad_loop'];
	if(isset($_POST['ad_referer']))$xmldata->ad_referer = $_POST['ad_referer'];
	foreach ($sites as $site){
		if($site['domain'] == $_GET['domain']){
		if(isset($_POST['type']))$site->type = $_POST['type'];
		if(isset($_POST['cpm'])) $site->cpm  = $_POST['cpm'];
		if(isset($_POST['cpv'])) $site->cpv  = $_POST['cpv'];
		if(isset($_POST['cpc'])) $site->cpc  = $_POST['cpc'];
		if(isset($_POST['tj']))  $site->tj   = $_POST['tj'];
		}
	}
	$newdata=$xmldata->asXML();
	$fp=fopen($config, 'w');
	fwrite($fp, $newdata);
	fclose($fp);
}

?>
<html>
<head>
<title>Dashboard</title>
<head>
<body>

<div class="container">
<div class="row">
<div class="col-md-12">
	<h1>Dashboard</h1>
	<hr />
	<form method="POST" action="?domain=null">
		ad_loop: <input name="ad_loop"    value="<?php echo $ad_loop ?>"><br />
		referer: <input name="ad_referer" value="<?php echo $ad_referer ?>"><br />
		<input type="submit">
	</form>
	<hr />
	<table class="table table-bordered table-hover table-striped">
		<tr><th>domain</th><th>type</th><th>cpm</th><th>cpv</th><th>cpc</th><th>tj</th><th>submit</th></tr>
		<?php foreach ($sites as $site){ ?>
		<tr>
			<form method="POST" action="?domain=<?php echo $site['domain'] ?>">
			<td><?php echo $site['domain'] ?></td>
			<td><input    name="type" size="6" value="<?php echo $site->type ?>"></td>
			<td><textarea name="cpm" rows="4" cols="20"><?php echo trim($site->cpm) ?></textarea></td>
			<td><textarea name="cpv" rows="4" cols="20"><?php echo trim($site->cpv) ?></textarea></td>
			<td><textarea name="cpc" rows="4" cols="20"><?php echo trim($site->cpc) ?></textarea></td>
			<td><textarea name="tj"  rows="4" cols="20"><?php echo trim($site->tj)  ?></textarea></td>
			<td><input    type="submit"></td>
			</form>
		</tr>
		<?php } ?>
	</table>
</div>
</div>
</div>

</body>
</html>

