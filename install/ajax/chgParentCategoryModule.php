<?php
	require_once("../../config.php");
	require_once("../../".DB_INIT_PATH);
	require_once("../../core/inc/category.class.php");
	
if(isset($_POST['type']) && $_POST['type']=='add'){
	echo '
	<input style="width:400px;" type="text" disabled="disabled" value="Категория не выбрана" id="titleParentText" />
	<input type="hidden" value="" id="titleParentId" name="titleParentId" />
	<input type="hidden" value="'.$_POST['id'].'" name="id" />
	<div id="categorySelectDiv"><strong>Выберите категорию из списка:</strong><br />';
	if(isset($_POST['id'])){
		$c = getPath($dbh, $_POST['id']);
		echo "<div class=\"holder\">";
		echo "<a  onClick='editCategoryParent(-1,\"Категория не выбрана\")'>Сайт</a>/";
		foreach ($c as $key){
			
				echo "<a  onClick='editCategoryParent($key[id],\"".str_replace('"',"",$key['title'])."\")'>".str_replace('"',"",$key['title'])."</a>/";
			
		}
		echo "</div>";
		
		$c = getCategories($dbh, $_POST['id']);
		foreach ($c as $key){
			echo "<a  onClick='editCategoryParent($key[id],\"".str_replace('"',"",$key['title'])."\")'>".str_replace('"',"",$key['title'])."</a><br />";
		}
		echo '</div>
		<div class="holder">
		</div>';
	}else{
		$c = getCategories($dbh, -1);
			foreach ($c as $key){
			echo "<a  onClick='editCategoryParent($key[id],\"".str_replace('"',"",$key['title'])."\")'>".str_replace('"',"",$key['title'])."</a><br />";
		}
	}
}else{	
	echo '
	<label>Выбранная категория для перемещения: </label> <input style="width:400px;" type="text" disabled="disabled" value="Категория для перемещения не выбрана" id="titleParentText" />
	<input type="hidden" value="" id="titleParentId" name="titleParentId" />
	<input type="hidden" value="'.$_POST['id'].'" name="id" />
	<div id="categorySelectDiv"><strong>Выберите категорию для перемещения из списка:</strong><br />';
	if(isset($_POST['id'])){
		$c = getPath($dbh, $_POST['id']);
		echo "<div class=\"holder\">";
		echo "<a  onClick='editCategoryParent(\"0\",\"Категория для перемещения не выбрана\")'>Сайт</a>/";
		foreach ($c as $key){
			
				echo "<a  onClick='editCategoryParent($key[id],\"".str_replace('"',"",$key['title'])."\")'>".str_replace('"',"",$key['title'])."</a>/";
			
		}
		echo "</div>";
		
		$c = getCategories($dbh, $_POST['id']);
		foreach ($c as $key){
			echo "<a  onClick='editCategoryParent($key[id],\"".str_replace('"',"",$key['title'])."\")'>".str_replace('"',"",$key['title'])."</a><br />";
		}
		echo '</div>
		<div class="holder">
		<a  id="editParentCategoryForModule" onClick="editParentCategoryForModule()" >Изменить категорию для модуля</a></div>';
	}else{
		$c = getCategories($dbh, -1);
			foreach ($c as $key){
			echo "<a  onClick='editCategoryParent($key[id],\"".str_replace('"',"",$key['title'])."\")'>".str_replace('"',"",$key['title'])."</a><br />";
		}
	}
}	
?>