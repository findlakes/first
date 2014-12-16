<?php

function get_xml(){
	$config  = dirname(__FILE__).'/data.xml';
	$xmldata = simplexml_load_file($config,'SimpleXMLElement',LIBXML_NOCDATA);
	return $xmldata;
}

//function for memchache
function get_cache(){
	$memcache_obj = new Memcache;
	$memcache_obj->connect('127.0.0.1', 11211);
	$xmlcache = $memcache_obj->get('xmlcache');
	if($xmlcache){
		return simplexml_load_string($xmlcache);
	}else{
		$xmldata = get_xml();
		$memcache_obj->add('xmlcache', $xmldata->asXML(), false, 5);
		return $xmldata;
	}
}

//xml info.
if(true){
$xmldata = get_xml();
}else{
$xmldata = get_cache();
}


//Read config data.
$ad_loop    = intval($xmldata->ad_loop);
$ad_sites   = $xmldata->sites->site;
$ad_referer = $xmldata->ad_referer;

//create ad script.
$ad_script  = '';
$site_type  = '';
foreach ($ad_sites as $site){
	if('www.'.$site['domain'] == $_SERVER['HTTP_HOST']){
		$ad_script = $site->cpm . $site->cpv . $site->cpc . $site->tj;
		$site_type = $site->type;
	}
}

function make_jump_url($type){

	if($type == 'xiaoshuo'){
		$arr[0]='/book/49110/index.htm';
		$arr[1]='/book/49547/index.htm';
		$arr[2]='/book/11568/index.htm';
		$arr[3]='/xiaoshuo/1.htm';
		$arr[4]='/book/6033/index.htm';
		$rd = rand(0,9);
		if($rd < 5){
			return $arr[$rd];
		}else{
			return '/';
		}
	}
	else if($type == 'shouji'){
		$the_urls = array('/app/soft/','/app/game/','/info/review/','/sepcial/list_1.html','/lastupdate/1.html','/app/lifemap/','/app/office/','/app/movie/','/app/chat/','/app/study/');
		$the_url = $the_urls[rand(0,count($the_urls)-1)];
		$ids_1 = array(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,4,5,1);
		$ids_1_url = '/app/'. $ids_1[rand(0,count($ids_1)-1)] .'.html';
		$rd = rand(0,9);
		switch ($rd){
			case 0:
			  return '/';
			case 2:
			  return $the_url;
			case 4:
			  return $the_url;
			default:
			  return $ids_1_url;
		}
	}else{
		$shows = array(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,16,17,18,8,9,10,11);
		$reads = array(50559,50554,50557,50563,50564,50853,50854,50855,50562,50561);
		$show_url = '/vod-show-id-'. $shows[rand(0,count($shows)-1)] .'-p-1.html';
		$read_url = '/vod-read-id-'. $reads[rand(0,count($reads)-1)] .'.html';
		$play_url = '/vod-play-id-'. $reads[rand(0,count($reads)-1)] .'-sid-0-pid-1.html';
		$rd = rand(0,9);
		switch ($rd){
			case 0:
			  return '/';
			case 2:
			  return $show_url;
			case 4:
			  return $read_url;
			default:
			  return $play_url;
		}
	}
}

function make_jump_content($jump_id, $jump_url, $ad_script){
	$ad_print = '';
	//$ad_print .= '<html><body style="display:none;">';
	$ad_print .= '<form name="form1" method="post" action="'.$jump_url.'">';
	$ad_print .= '<input type="text" name="jump" value="'.$jump_id.'"></form>';
	$ad_print .= '<script type="text/javascript">window.onload = function(){setTimeout("document.form1.submit()",500);};</script>';
	$ad_print .= $ad_script;
	//$ad_print .= '</html></body>';
	return $ad_print;
}

if( isset($_GET['AD']) || (isset($_SERVER['HTTP_REFERER']) && 
	stripos('_'.$_SERVER['HTTP_REFERER'], "$ad_referer")) ) {
	isset($_POST['jump']) ? $jump_id=intval($_POST['jump']) : $jump_id=0;;
	if($jump_id++ < $ad_loop){
		$jump_url = make_jump_url($site_type);
		$jump_prt = make_jump_content($jump_id, $jump_url, $ad_script);
		echo($jump_prt);
	}
	exit();
}else{
		echo($ad_script);
}

?>

