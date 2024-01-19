$(document).ready(function(){
	
	
	$("#innerNavigation a").click(function(){
		$("#innerNavigation a").removeClass("selected");
		$(this).addClass("selected");
		
		$("#inerForText div").css("display", "none");
		$("#"+$(this).attr("title")+"Edit").css("display", "block");
	});
	

	$.post("/install/ajax/maket.php",{maketTitle:$(this).val()}, function(data){
			if(data>0){	
				$("#titleErr").html("Такое имя шаблона уже существует");
			}else{
				$("#titleErr").html("");
			}
		});
	
	
	$("#title").keyup(function(){
		$.post("/install/ajax/maket.php",{maketTitle:$(this).val()}, function(data){
			if(data>0){	
				$("#titleErr").html("Такое имя шаблона уже существует");
			}else{
				$("#titleErr").html("");
			}
		});
	});
	
	$("#addShbln").click(function(){
		$("#jsText").val(myCpWindowJS.getCode());
		$("#htmlText").val(myCpWindow.getCode());
		$("#cssText").val(myCpWindowCSS.getCode());
		$("#shablonCreate").submit();
	});
	
	
	
	
});