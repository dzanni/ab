<?php
if(isset($_POST['id'])){	
	require_once("../../config.php");
	require_once("../../".DB_INIT_PATH);
	require_once("../../inc/modules.class.php");
	
	if(isset($_POST['maket'])){
		if(modules::chg($dbh, $_POST['id'], 'maket', $_POST['maket'])){
			echo "Макет сохранен!";
		}else{
			echo "Ошибка при сохранении макета!";
		}
	}
	
	if(isset($_POST['shablon'])){
		if(modules::chg($dbh, $_POST['id'], 'shablon', $_POST['shablon'])){
			echo "Шаблон сохранен!";
		}else{
			echo "Ошибка при сохранении шаблона!";
		}
	}
	
	if(isset($_POST['varName'])){
		if(modules::addVar($dbh, $_POST['id'], $_POST['varName'], $_POST['varValue'])){
			echo "1";
		}else{
			echo "0";
		}
	}
	
	if(isset($_POST['action'])){
		if($_POST['action']=='delete'){
			if(modules::delVar($dbh, $_POST['id'], $_POST['varId'])){
				echo "1";
			}else{
				echo "0";
			}
		}
	}
	
	if(isset($_POST['status'])){
		echo modules::chgStatus($dbh, $_POST['id']);
	}
	
	if(isset($_POST['enURL'])){
		require_once("../../inc/translit.php");
		require_once("../../core/inc/category.class.php");
		echo modules::chgenURL($dbh, $_POST['enURL'], $_POST['id']);
	}
	
	if(isset($_POST['newValue'])){
		if(modules::updateVar($dbh, $_POST['varId'], $_POST['newValue'])){
			echo "Изменения сохранены";
		}else{
			echo "Ошибка при сохранении изменений";
		}
	}
	
	if(isset($_POST['category'])){
		if(modules::chg($dbh, $_POST['id'], 'category', $_POST['category'])){
			echo "Категория сохранена!";
		}else{
			echo "Ошибка при сохранении категории!";
		}
	}
	
	
}

?>