// JavaScript Document
$(document).ready(function(){
	var IE='\v'=='v';


	if(IE) {

		$("#menuContent li.liFirst").hover(function(){
			$(this).parent().find('ul').stop();
			$(this).parent().find('ul').css("display","none");
			$(this).find('ul:first').stop(true, true);
			$(this).find('ul:first').css("display","block");
			$(this).find('ul:first').css("overflow","visible");
			$(this).find('ul:first').fadeIn("fast");
			
		},function(){
			$(this).find('ul:first').css("display","none");
		});

		$("#menuContent li.liFirst > ul > li").hover(function(){
			$(this).parent().find('ul').stop();
			$(this).parent().find('ul').css("display","none");
			$(this).find('ul:first').stop(true, true);
			$(this).find('ul:first').css("display","block");
			$(this).find('ul:first').css("width","0px");
			$(this).find('ul:first').css("overflow","visible");
			$(this).find('ul:first').animate({width: "230px",opacity: "1"}, 300 ,function(){
				$(this).animate({width: "220px",opacity: "1"}, 50, function(){$(this).css("width","220px");});
			});
		},function(){
			$(this).find('ul:first').css("width","0px");
			$(this).find('ul:first').css("display","none");
		});

		$("#menuContent li.liFirst > ul > li > ul > li").hover(function(){
			$(this).parent().find('ul').stop();
			$(this).parent().find('ul').css("display","none");
			$(this).find('ul:first').stop(true, true);
			$(this).find('ul:first').css("display","block");
			$(this).find('ul:first').css("width","0px");
			$(this).find('ul:first').css("overflow","visible");
			$(this).find('ul:first').animate({width: "220px",opacity: "1"}, 300);
		},function(){
			$(this).find('ul:first').css("width","0px");
			$(this).find('ul:first').css("display","none");
		});

	}else{

		$("#menuContent li.liFirst").hover(function(){
			$(this).parent().find('ul').stop();
			$(this).parent().find('ul').css("display","none");
			$(this).find('ul:first').stop(true, true);
			$(this).find('ul:first').css("display","block");
			$(this).find('ul:first').css("overflow","visible");
			$(this).find('ul:first').fadeIn("fast");
			
		},function(){
			$(this).find('ul:first').css("display","none");
		});
		
		$("#menuContent li li").hover(function(){
			$(this).parent().find('ul').stop();
			$(this).parent().find('ul').css("display","none");
			$(this).find('ul:first').stop(true, true);
			$(this).find('ul:first').css("display","block");
			$(this).find('ul:first').css("width","0px");
			$(this).find('ul:first').css("overflow","visible");
			$(this).find('ul:first').animate({width: "230px",opacity: "1"}, 300 ,function(){
				$(this).animate({width: "220px",opacity: "1"}, 50, function(){$(this).css("width","220px");});
			});
		},function(){
			$(this).find('ul:first').css("width","0px");
			$(this).find('ul:first').css("display","none");
		});
	}




});