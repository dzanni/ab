$(document).ready(function(){

	$("#itemList").tablesorter(); 
	$("#itemList1").tablesorter(); 
	
	$("a.status").click(function(){
		$(this).removeClass("status0");
		$(this).removeClass("status1");
		obj = $(this);
		$.post("/install/ajax/chgCategoryModule.php", {id:$(this).attr("title"), status:"status"}, function(data){
			obj.addClass("status"+data);
		});
			   
	});
	$("input.enURL").change(function(){
		id  = $(this).attr('title');
		obj = $(this);
		val = $(this).val();
		if(val == ''){
			$("#shablon"+id).attr("disabled", "disabled");
			$("#maket"+id).attr("disabled", "disabled");
		}else{
			$("#shablon"+id).removeAttr("disabled");
			$("#maket"+id).removeAttr("disabled");
		}
		$.post("/install/ajax/chgCategoryModule.php", {id:id, enURL:val}, function(data){
			obj.val(data);
		});
	});
	
	$("#itemList th").click(function(){
		$("#itemList tr").removeClass("grey white");
		$("#itemList tr:even").removeClass("grey white");
		$("#itemList tr:odd").addClass("grey");
	});
	
	$("#mainCH").change(function(){
		$("input.maketCH").attr("checked",$(this).attr("checked"));
	});

	$("select.shablon").change(function(){
		$.post("/install/ajax/chgCategoryModule.php", {id:$(this).attr("title"), shablon:$(this).val()}, function(data){alert(data);});
	});
		
	$("select.maket").change(function(){
		$.post("/install/ajax/chgCategoryModule.php", {id:$(this).attr("title"), maket:$(this).val()}, function(data){alert(data);});
	});
	
});