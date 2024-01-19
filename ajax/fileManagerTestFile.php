<?php
	if (isset($_GET['filename'])){ 
		$filename = $_GET['filename']; 
		if ($filename == ""){
			exit();
		} 
		if ($filename[0] == "/"){
			$filename = "..".$filename;
		} 
		$params = @getimagesize($filename);
		echo json_encode(array("width"=>$params[0],"height"=>$params[1]));
	}