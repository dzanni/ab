<?php
if(isset($_POST['id'])){	
	require_once("../../config.php");
	require_once("../../".DB_INIT_PATH);
	require_once("../../core/inc/category.class.php");
	
	if(isset($_POST['maket'])){
		if(category::chg($dbh, $_POST['id'], 'maket', $_POST['maket'])){
			echo "Макет сохранен!";
		}else{
			echo "Ошибка при сохранении макета!";
		}
	}
	
	if(isset($_POST['shablon'])){
		if(category::chg($dbh, $_POST['id'], 'shablon', $_POST['shablon'])){
			echo "Шаблон сохранен!";
		}else{
			echo "Ошибка при сохранении шаблона!";
		}
	}
}
?>