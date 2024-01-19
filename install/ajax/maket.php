<?php

	require_once("../../config.php");
	require_once("../../".DB_INIT_PATH);
	require_once("../../inc/translit.php");
	require_once("../../inc/maket.class.php");
	
	if(isset($_POST['maketTitle'])){	
		echo maket::ifUnique($dbh, $_POST['maketTitle']);
	}
?>