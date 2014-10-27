<?php

include_once "api.php";

$get_token = CallAPI("GET", "http://192.168.145.254:9292/scans/new");

//echo($get_token);

if(preg_match('/<input name="authenticity_token" type="hidden" value="(.*)" \/>/i', $get_token, $matches)){
    //var_dump($matches);
	$authenticity_token = $matches[1];
	//echo $authenticity_token;
}

$post_data = array (
"utf8" => "&#x2713;",
"scan[url]" => "http://www.abc.com",
"scan[profile_id]" => "1",
"scan[description]" => "",
"scan[user_ids][]" => "",
"scan[type]" => "direct",
"scan[instance_count]" => "1",
"scan[schedule][start_at]" => "",
"scan[schedule][stop_after]" => "0",
"scan[schedule][every_minute]" => "",
"scan[schedule][every_hour]" => "",
"scan[schedule][every_day]" => "",
"scan[schedule][every_month]" => "",
"scan[schedule][every_month]" => "",
"scan[schedule][basetime]" => "finished_at",
"authenticity_token" => $authenticity_token,
"commit" => "Go!"
);

$dbg_ret = CallAPI("POST", "http://192.168.145.254:9292/scans", $post_data);

echo($dbg_ret);

exit();

$json_obj = json_decode($dbg_ret);

var_dump($json_obj);

?>
