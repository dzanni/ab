<?php
require_once ("../start.php");
	
	require_once("../db_connect.php");
	require_once("../inc/translit.php");
	require_once("../inc/options.class.php");
	require_once("../core/inc/category.class.php");
	require_once("../core/inc/txt.class.php");
	require_once("../core/inc/news.php");
	require_once("../inc/spec.class.php");
	require_once("../inc/tovar.php");
	require_once("../inc/firm.php");
	require_once("../inc/curs.php");
	require_once("../inc/order.php");
	require_once("../inc/grp.class.php");
	require_once("../inc/discount.class.php");
		
	require_once('../inc/maket.class.php');
	require_once('../inc/shablon.class.php');
	require_once('../inc/modules.class.php');


	$smarty = new Smarty;
	$smarty->compile_check = true;
	$smarty->debugging = false;
	$smarty->assign("page","index");

	//	addShbln
	
	if(isset($_GET['update'])){
		maket::doInstallv1($dbh);
	}
	if(isset($_POST['addMaket'])){
		$title = $_POST['title'];
		$i = 2;
		$tmpTitle = $title;
		while(maket::ifUnique($dbh, $tmpTitle)>0){
			$tmpTitle = $title."-".$i++;
		}
		$title = $tmpTitle;
		$html = stripslashes($_POST['html']);
		$css = stripslashes($_POST['css']);
		$js = stripslashes($_POST['js']);
		
		if(maket::add($dbh, $title, '', $html, $css, $js)){
			$smarty->assign("message", "Макет успешно добавлен!");
		}else{
			$smarty->assign("error", "Макет не был добавлен!");
		}
		
	}
	if(isset($_POST['editMaket'])){
		$title = $_POST['title'];
		$i = 2;
		$id = $_POST['maketId'];
		$tmpTitle = $title;
		while(maket::ifUnique($dbh, $tmpTitle, $id)>0){
			$tmpTitle = $title."-".$i++;
		}
		$title = $tmpTitle;
		$html = stripslashes($_POST['html']);
		$css = stripslashes($_POST['css']);
		$js = stripslashes($_POST['js']);
		if(maket::edit($dbh, $title, $html, $css, $js, $id)){
			$smarty->assign("message", "Макет успешно обновлен!");
		}else{
			$smarty->assign("error", "Макет не был обновлен!");
		}
		
	}
	
	
	if(isset($_GET['maket'])){
		$smarty->assign('maketEdit',"maket");
		$smarty->assign("page", "maket");
		$maket = maket::getAll($dbh);
		$smarty->assign("maketArray", $maket);
	}elseif(isset($_GET['addMaket'])){
		$smarty->assign('maketEdit',"maket");
		$smarty->assign("page", "addMaket");
		$smarty->assign("type","add");
	}elseif(isset($_GET['editMaket'])){
		$smarty->assign("page", "editMaket");
		$smarty->assign('maketEdit',"maket");
		$smarty->assign("type","edit");
		$maketId = $_GET['id'];
		$smarty->assign('maketId',$maketId);
		$smarty->assign("maketData",maket::getData($dbh, $maketId));
	}
	
	
	
	
	
	if(isset($_POST['deleteSignedShablon'])){
		foreach($_POST['shablon'] as $key => $value){
			shablon::delete($dbh, $value);
		}
	}
	if(isset($_POST['addShablon'])){
		$title = $_POST['title'];
		$i = 2;
		$tmpTitle = $title;
		while(shablon::ifUnique($dbh, $tmpTitle)>0){
			$tmpTitle = $title."-".$i++;
		}
		$title = $tmpTitle;
		$html = stripslashes($_POST['html']);
		$css = stripslashes($_POST['css']);
		$js = stripslashes($_POST['js']);
		
		if(shablon::add($dbh, $title, '', $html, $css, $js)){
			$smarty->assign("message", "Шаблон успешно добавлен!");
		}else{
			$smarty->assign("error", "Шаблон не был добавлен!");
		}
		
	}
	if(isset($_POST['editShablon'])){
		$title = $_POST['title'];
		$i = 2;
		$id = $_POST['shablonId'];
		$tmpTitle = $title;
		while(shablon::ifUnique($dbh, $tmpTitle, $id)>0){
			$tmpTitle = $title."-".$i++;
		}
		$title = $tmpTitle;
		$html = stripslashes($_POST['html']);
		$css = stripslashes($_POST['css']);
		$js = stripslashes($_POST['js']);
		if(shablon::edit($dbh, $title, $html, $css, $js, $id)){
			$smarty->assign("message", "Шаблон успешно обновлен!");
		}else{
			$smarty->assign("error", "Шаблон не был обновлен!");
		}
		
	}
	
	
	if(isset($_GET['shablon'])){
		$smarty->assign("page", "shablon");
		$shablon = shablon::getAll($dbh);
		$smarty->assign("shablonArray", $shablon);
	}elseif(isset($_GET['addShablon'])){
		$smarty->assign("page", "addShablon");
		$smarty->assign("type","add");
	}elseif(isset($_GET['editShablon'])){
		$smarty->assign("page", "editShablon");
		$smarty->assign("type","edit");
		$shablonId = $_GET['id'];
		$smarty->assign('shablonId',$shablonId);
		$smarty->assign("shablonData",shablon::getData($dbh, $shablonId));
	}


	if(isset($_POST['deleteSignedModules'])){
		foreach($_POST['Modules'] as $key => $value){
			modules::delete($dbh, $value);
		}
	}
	if(isset($_POST['addModules'])){
		$title = $_POST['title'];
		$i = 2;
		$tmpTitle = $title;
		while(modules::ifUnique($dbh, $tmpTitle)>0){
			$tmpTitle = $title."-".$i++;
		}
		$title = $tmpTitle;
		$php = $_POST['php'];
		$php = urldecode($php);
				
		if(modules::add($dbh, $title, '', $php)){
			$smarty->assign("message", "Модуль успешно добавлен!");
		}else{
			$smarty->assign("error", "Модуль не был добавлен!");
		}
		
	}
	if(isset($_POST['editModules'])){
		$title = $_POST['title'];
		$i = 2;
		$id = $_POST['modulesId'];
		$tmpTitle = $title;
		while(modules::ifUnique($dbh, $tmpTitle, $id)>0){
			$tmpTitle = $title."-".$i++;
		}
		$title = $tmpTitle;
		$php = stripslashes($_POST['php']);
		$php = urldecode($php);
		if(modules::edit($dbh, $title, $php, $id)){
			$smarty->assign("message", "Модуль успешно обновлен!");
		}else{
			$smarty->assign("error", "Модуль не был обновлен!");
		}
		
	}
	
	
	if(isset($_GET['module'])){
		$smarty->assign("page", "modules");
		$modules = modules::getAll($dbh);
		
		$smarty->assign("allMaket",maket::getAll($dbh));
		$smarty->assign("allShablon",shablon::getAll($dbh));
		
		$smarty->assign("modulesArray", $modules);
	}elseif(isset($_GET['addModule'])){
		$smarty->assign("page", "addModule");
		$smarty->assign("type","add");
	}elseif(isset($_GET['editModule'])){
		$smarty->assign("page", "editModules");
		$smarty->assign("type","edit");
		$modulesId = $_GET['id'];
		$smarty->assign('modulesId',$modulesId);
		$smarty->assign("modulesData",modules::getData($dbh, $modulesId));
	}





if(isset($_GET['editSystem'])){
		$smarty->assign("allMaket",maket::getAll($dbh));
		$smarty->assign("allShablon",shablon::getAll($dbh));
		
		$smarty->assign("page","editSystem");
		if(!isset($_GET['category'])){ #переменная родительского каталога.
			$category = -1; #0 - нулевой уровень (нет родителей)
		}else{
			$category = $_GET['category'];
			settype($category,"integer");
		}
		
			$smarty->assign("parent",$category);
			$smarty->assign("path",getPath($dbh, $category));
			$menu = getCategories($dbh, $category);
			$smarty->assign("menu",$menu);
			$smarty->assign("menuCol",count($menu));

	}






	$smarty->display('index.tpl');

?>