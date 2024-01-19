// JavaScript Document
$(document).ready(function(){
	$("#itemList").tablesorter(); 
	
	$("#itemList th").click(function(){
		$("#itemList tr").removeClass("grey white");
		$("#itemList tr:even").removeClass("grey white");
		$("#itemList tr:odd").addClass("grey");
	});
	
	$("select.shablon").change(function(){
		$.post("/install/ajax/chgCategory.php", {id:$(this).attr("title"), shablon:$(this).val()}, function(data){alert(data);});
	});
		
	$("select.maket").change(function(){
		$.post("/install/ajax/chgCategory.php", {id:$(this).attr("title"), maket:$(this).val()}, function(data){alert(data);});
	});
	
	$("#content").load("/core/ajax/contentShow.php",{category:category});					   
						   
						   
	$("#close").click(function(){
		$("#dialog").toggle();
	});

	$("#addNewCategoryLink").click(function(){
		$("#dialog").css("display","block");
		$("#newWin").html("Добавление категорий");
		$("#dialogContent").load("/core/ajax/editSystem.php", {id:0,type:'addCategory',parent:$("#addNewCategoryLink").attr('title')});
	});
	
});
	
	
	
	function moveCategoryUp(id){
		$.post("/core/ajax/moveCat.php", {id: id, moveUp : "moveUp"}, function (data){
			$.post("/core/ajax/ajaxMenuLeft.php", {category: $("#parentCategory").attr("value")}, function (data){
				$("#menuHolder").html(data);
			});
		});
		
	}
	function moveCategoryDown(id){
		$.post("/core/ajax/moveCat.php", {id: id, moveDown : "moveDown"}, function (data){
			$.post("/core/ajax/ajaxMenuLeft.php", {category: $("#parentCategory").attr("value")}, function (data){
				$("#menuHolder").html(data);
			});
		});
	}

	function editCategoryParent(id,title){
		$.post("/core/ajax/editSystem.php", {id:id,type:'editCategoryParent'}, function(data){
			document.getElementById('categorySelectDiv').innerHTML = data;
			document.getElementById('titleParentId').value = id;
			document.getElementById('titleParentText').value = title;
		});	
	}
	
	function editCat(id){
		$("#dialog").css("display","block");
		$("#newWin").html("Редактирование категорий");
		$("#dialogContent").load("/core/ajax/editSystem.php", {id:id,type:'editCategory',parent:$("#addNewCategoryLink").attr('title')});
	
	}
	function delCat(id){
		$("#dialog").css("display","block");
		$("#newWin").html("Удаление категорий");
		$("#dialogContent").load("/core/ajax/editSystem.php", {id:id,type:'deleteCategory',parent:$("#addNewCategoryLink").attr('title')});
	
	}
	function addNewTxtBlock(){
		$("#addNewBlock").toggle();
	}
	
//	function //deleteTxtBlock txtUp txtDown
	function deleteTxtBlock(id){
		$("#dialog").css("display","block");
		$("#newWin").html("Удаление текстового блока");
		$("#dialogContent").load("/core/ajax/editSystem.php", {id:id,type:'deleteTxtBlock'});
	}
	
	function txtBlockDown(id){
		$.post("/core/ajax/ajaxTxtBlock.php", { id: id,type:"down" }, function(data){
			alert(data);
		});
		$("#content").load("/core/ajax/contentShow.php",{category:category});
	}
	
	function txtBlockUp(id){
		$.post("/core/ajax/ajaxTxtBlock.php", { id: id,type:"up" }, function(data){
			alert(data);
		});
		$("#content").load("/core/ajax/contentShow.php",{category:category});
	}