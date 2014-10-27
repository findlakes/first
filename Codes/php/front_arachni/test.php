<?php

include_once "api.php";

$dbg_ret = CallAPI("GET", "http://192.168.145.254:9292/scans.json");

$json_obj = json_decode($dbg_ret);

foreach ($json_obj as &$value) {
	echo " $value->id $value->type  $value->active $value->profile_id $value->url $value->description  $value->status  $value->issue_digests ";
}

?>
