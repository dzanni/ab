<?php 
if(isset($_GET['id'])){
	if (file_exists("images/photo/".$_GET['id'].".jpg")){
		$filename="images/photo/".$_GET['id'].".jpg";
		$pr = true;
	}else{
		$filename="images/noimg.jpg";
		$pr = false;
	}
}else{
	if($_GET['filename'] == ""){
		$filename="images/noimg.jpg";
		$pr = false;
	}else{
		$filename = "images/photo/".$_GET['filename'];
		$pr = true;
	}
}


list($width, $height) = getimagesize($filename);

	$new_width = 100;


if(isset($_GET['h']) && !isset($_GET['w'])){
	if($_GET['h']>$height){
		$image = imagecreatefromjpeg($filename);
		header('Content-type: image/jpeg');
		imagejpeg($image,NULL, 85);
		exit();
	}
}
if(isset($_GET['w']) && !isset($_GET['h'])){
	if($_GET['w']>$width){
		$image = imagecreatefromjpeg($filename);
		header('Content-type: image/jpeg');
		imagejpeg($image,NULL, 85);
		exit();
	}
}
if(isset($_GET['w']) && isset($_GET['h'])){
	if($_GET['w']>$width && $_GET['h']>$height){
		$image = imagecreatefromjpeg($filename);
		header('Content-type: image/jpeg');
		imagejpeg($image,NULL, 85);
		exit();
	}
}	

if(isset($_GET['h'])){
	$new_height = $_GET['h'];
	$new_width = $new_height/$height*$width;
	if(isset($_GET['w']) && $_GET['w'] < $new_width){
		$new_width = $_GET['w'];	
		$new_height = $new_width/$width*$height; 
	}
	
}else{
	if(isset($_GET['w'])){
		$new_width = $_GET['w'];	
	}
	$new_height = $new_width/$width*$height; 
}
/*if ($width>$height){
	
}else{
	$new_width = $new_height/$height*$width;
}*/

$image_p = imagecreatetruecolor($new_width, $new_height);
$image = imagecreatefromjpeg($filename);
imagecopyresampled($image_p, $image, 0, 0, 0, 0, $new_width, $new_height, $width, $height);

/*
$watermark = 'images/logo2.png';
$wh = getimagesize($watermark);
$fh = array($new_width,$new_height);
$rwatermark = imagecreatefrompng($watermark); //Иногда может понадобиться наложить прозрачный png, тогда заменяем функцию на imagecreatefrompng
if($pr) imagecopy($image_p, $rwatermark, $fh[0] - $wh[0], $fh[1] - $wh[1], 0, 0, $wh[0], $wh[1]);

imagedestroy($rwatermark);*/


header('Content-type: image/jpeg');
imagejpeg($image_p,NULL, 85); 
?>