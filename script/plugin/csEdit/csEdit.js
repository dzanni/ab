(function( $ ){
	
	// Массив с кнопками для верхнего меню. Type, options - необязательные параметры
	var toolbar = [
		{
			class : "saveBTN",
			title : "Сохранить" ,
			type : "saveBTN"
		},{
			class : "mkHtml visible",
			title : "Режим редактирования кода" 
		},{
			class : "mkVisible html",
			title : "Визуальный режим редактирования" 
		},{
			class : "format visible undo",
			title : "Отменить",
			options : [
				{name:"data-command", value : "Undo"} 
			]
		},{
			class : "format visible redo",
			title : "Вернуть",
			options : [
				{name:"data-command", value : "Redo"} 
			]
		},{
			class : "format visible bold",
			title : "Жирный",
			options : [
				{name:"data-command", value : "Bold"} 
			]
		},{
			class : "format visible italic",
			title : "Курсив",
			options : [
				{name:"data-command", value : "Italic"} 
			]
		}
		/*,{
			class : "format color visible",
			title : "Цвет",
			type : "colorPicker",
			options : [
				{name:"data-command", value : "ForeColor"} 
			]
		}
		*/
		,{
			class : "H_picker saveSelection visible",
			title : "Тип текста",
			type : "H_picker"
		},{
			class : "mkLink saveSelection visible",
			title : "Добавить гипперссылку",
			type : "mkLink"
		},{
			class : "format visible unlink",
			title : "Удалить гипперссылки", 
			options : [
				{name:"data-command", value : "Unlink"} 
			] 
		},{
			class : "format visible insertHorizontalRule",
			title : "Вставить горизонтальную линию", 
			options : [
				{name:"data-command", value : "InsertHorizontalRule"} 
			] 
		},{
			class : "format visible insertUnorderedList" ,
			title : "Добавить маркированный список", 
			options : [
				{name:"data-command", value : "InsertUnorderedList"} 
			] 
		},{
			class : "format visible insertOrderedList",
			title : "Добавить нумерованный список", 
			options : [
				{name:"data-command", value : "InsertOrderedList"} 
			] 
		},{
			class : "format visible indent",
			title : "Добавить отступ", 
			options : [
				{name:"data-command", value : "Indent"} 
			] 
		},{
			class : "format visible outdent",
			title : "Отменить отступ", 
			options : [
				{name:"data-command", value : "Outdent"} 
			]  
		},{
			class : "format visible removeFormat",
			title : "Убрать форматирование", 
			options : [
				{name:"data-command", value : "RemoveFormat"} 
			] 
		},{
			class : "table saveSelection visible",
			title : "Вставить таблицу"
		},{
			class : "paramsEdtTxt visible",
			title : "Добавить оформление текста",
			type : "styles"
		},{
			class : "addImg saveSelection visible",
			title : "Вставить картинку"
		}
	];
	// цвета для выделения
	var colors = ["#000000","#999999","#666666","#FFFFFF","#ff0000", "#00ff00","#0000ff"];
	// Корневая папка
	var rootFolder = "/downloads";
	// форматы для выделения
	var formats = [
		{name:"h1", title: "Заголовок 1 уровня"},
		{name:"h2", title: "Заголовок 2 уровня"},
		{name:"h3", title: "Заголовок 3 уровня"},
		{name:"h4", title: "Заголовок 4 уровня"},
		{name:"h5", title: "Заголовок 5 уровня"},
		{name:"h6", title: "Заголовок 6 уровня"},
		{name:"p", title: "Обычный текст"}
	]; 
	// Подключение стилей для блоков
	var styles = [
		{name:"Выравнивание", variants: [
			{name:"center", title: "центр"},
			{name:"left", title: "слева"},
			{name:"right", title: "справа"},
			{name:"justify", title: "по ширине"}
		]},
		/*{name:"Шрифт", variants: [
			{name:"Tahoma", title: "Tahoma"},
			{name:"Calibri", title: "Calibri"},
			{name:"Arial", title: "Arial"},
			{name:"ComicSansMS", title: "Comic Sans MS"},
			{name:"Isocpeur", title: "Isocpeur"},
			{name:"MonotypeCorsiva", title: "Monotype Corsiva"},
			{name:"Gabriola", title: "Gabriola"} 
		]},*/
		{name:"Размер шрифта", variants: [
			{name:"p12px", title: "12px"} , 
			{name:"p14px", title: "14px"} , 
			{name:"p16px", title: "16px"} , 
			{name:"p18px", title: "18px"} , 
			{name:"p20px", title: "20px"} 
		]},
		{name:"Цвет", variants: [
			{name: "red", title:"Красный"} , 
			{name: "blue", title:"Синий"} , 
			{name: "black", title:"Черный"} , 
			{name: "grey", title:"Серый"} , 
			{name: "green",  title:"Зеленый"} 
		]}
	]
	
	// добавление ссылки. TODO - доделать добавление с открытием в новом окне.
	var linkToolbar = '<div class="linkToolbar topToolbar subWindow"><a class="close"></a><label>URL адрес:</label> <input type="text" class="linkURL longText" /><input type="button" value="OK" class="insertLink" /></div>';
	// редактирование ссылки.
	var linkToolbar2 = '<div class="linkToolbarEdit topToolbar subWindow"><a class="close"></a><label>URL адрес:</label> <input type="text" class="linkURL longText" /><select class="newWindow"><option value="" selected="selected">В том же окне</option><option value="_blank">В новом окне</option></select><input type="button" value="OK" class="editLink" /></div>';
	
	// добавление ссылки. TODO - доделать добавление с открытием в новом окне.
	var tableInsertToolbar = '<div class="tableInsertToolbar topToolbar subWindow"><a class="close"></a><label>Строк:</label> <input type="text" class="cols" /><label>Столбцов:</label> <input type="text" class="rows" /><select class="thHeaderFirst"><option value="thFirst" selected="selected">Шапка таблицы в 1 строке</option><option value="">Без шапки в 1 строке</option></select><input type="button" value="OK" class="insertTable" /></div>';
	
	// при наведении на иконку. 
		$(document).on("mouseover", ".csEdit .toolbar .toobarIcons input", function(){
			var obj = $(this).parents(".csEdit").find(".popupIcons");
			var pos = $(this).offset(); 
			obj.html($(this).data("poptitle")).css("left", pos.left+"px").css("top", pos.top+30+"px").show();
		});
		$(document).on("mouseout", ".csEdit .toolbar .toobarIcons input", function(){
			$(this).parents(".csEdit").find(".popupIcons").hide();
		});
		// редактирование при клике на картинку. 
		$(document).on("click", ".csEdit .txtEditDiv img", function(){
			var obj = $(this).parents(".csEdit"); 
			var toolbar = obj.find(".addEdtImg");
			
			var width = $(this).width();
			var height = $(this).height();
			
			var url = $(this).attr("src"); 
			var urlTest = /\/img\.php\?*/;
			if (urlTest.test(url)){
				// картинка уменьшена.
				url = url.replace(/\/img\.php\?/g, "");
				var arrUrlParts = url.split("&");
				arrUrlParts.forEach(function(urlPart){
					urlPart = urlPart.split("="); 
					if(urlPart[0] == "filename"){
						url = urlPart[1];
					}else if(urlPart[0] == "width"){
						width = urlPart[1];
					}else if(urlPart[0] == "height"){
						height = urlPart[1];
					}
				});
			} 
			 
			methods.getFileInfo(toolbar.find(".url"),"notChgWidthHeight");
			
			toolbar.find(".width").val(width);
			toolbar.find(".height").val(height);
			
			toolbar.find(".url").val(url);
			 
			if ($(this).hasClass("right")){
				toolbar.find(".classAlign").val("right"); 
			}else if($(this).hasClass("left")){
				toolbar.find(".classAlign").val("left"); 
			}else{
				toolbar.find(".classAlign").val(""); 
			}
			toolbar.find(".edtImg").show().data("obj", $(this));
			toolbar.find(".insertImg").hide(); 
			toolbar.show();
		});
		//редактирование картинки
		$(document).on("click", ".csEdit .edtImg", function(){
			var obj = $(this).data("obj"); 
			var toolbar = $(this).parents(".addEdtImg");
			
			var width = toolbar.find(".width").val();
			var height = toolbar.find(".height").val();
			  
			var className = toolbar.find(".classAlign").val(); 
			obj.removeClass("right").removeClass("left");
			if (className != ""){
				obj.addClass(className);
			} 
			
			var baseWidth = toolbar.find(".width").data("baseWidth");
			var baseHeight = toolbar.find(".width").data("baseHeight"); 
			
			var url = toolbar.find(".url").val();
			
			if (width < baseWidth || height < baseHeight){
				url = "/img.php?filename="+url+"&width="+width+"&height="+height;
			}
			obj.attr("src",url);
			
			if (width > 0){
				obj.attr("width",width);
			}else{
				obj.attr("width","");
			}
			if (height > 0){
				obj.attr("height",height);
			}else{
				obj.attr("height","");
			}
			toolbar.hide();
		});
		// редактирование при клике на ссылку. 
		$(document).on("click", ".csEdit .txtEditDiv a", function(){
			var obj = $(this).parents(".csEdit"); 
			var toolbar = obj.find(".linkToolbarEdit");
			toolbar.find(".linkURL").val($(this).attr("href"));
			toolbar.find(".newWindow").val($(this).attr("target"));
			toolbar.find(".editLink").data("obj", $(this));
			toolbar.show();
		});
		// редактирование ссылки
		$(document).on("click", ".csEdit .editLink", function(){
			var obj = $(this).data("obj"); 
			var toolbar = $(this).parents(".linkToolbarEdit");
			var url = toolbar.find(".linkURL").val();
			var target = toolbar.find(".newWindow").val();
			obj.attr("href", url);
			if (target == ""){
				obj.removeAttr("target");
			}else{
				obj.attr("target", target);
			}
			$(this).data("obj","");
			toolbar.hide();
		});
		// добавление параметров блока текста для редактирования(формат)
		$(document).on("click", ".csEdit .txtEditDiv p, .csEdit .txtEditDiv div, .csEdit .txtEditDiv h1, .csEdit .txtEditDiv h2,.csEdit .txtEditDiv h3,.csEdit .txtEditDiv h4,.csEdit .txtEditDiv h5,.csEdit .txtEditDiv h6", function(e){
			var d = new Date();
			var hash = d.valueOf()+" "+e.pageX+" "+e.pageY;
			var current = $(this);
			var obj = $(this).parents(".csEdit").find(".editParamsTxt");
			if (hash != obj.data("hash")){
				obj.data("hash", hash);
				obj.data("obj", current); 
				obj.find("a").each(function(){
					if (current.hasClass($(this).data("class"))){
						$(this).addClass("active");
					}
				});
			}
		});
		// редактирование блока текста (формат)
		$(document).on("click", ".csEdit .editParamsTxt a", function(){
			if ($(this).hasClass("active")){
				return;
			}
			var current = $(this);
			var obj = $(this).parents(".editParamsTxt").data("obj");
			if (obj == undefined){ 
				$(this).parents(".csEdit").find(".selectionErrorInfo").show();
				return false;
			}
			var CSSclassName = $(this).data("class");
			$(this).parents("p").find("a.active").each(function(){
				obj.removeClass($(this).data("class"));
				$(this).removeClass("active");
			});
			if (CSSclassName){
				current.addClass("active");
				obj.addClass(CSSclassName);
			}
		});
		
		// сохранение
		$(document).on("click", ".csEdit .saveBTN", function(){
			var obj = $(this).parents(".csEdit");
			var url = obj.data("saveUrl"); 
			if (url !== undefined){ 
				var dataSend = obj.data(); 
				if (dataSend.viewType == "visible"){ 
					dataSend.txtValue = obj.find(".txtEditDiv").html();
				}else{ 
					dataSend.txtValue = obj.find(".txtEdit").val();
				} 
				dataSend.selection = "";
				$.post(url, dataSend, function(data){ 
					obj.find(".saveInformation").show().find(".saveInfo").html(data);
				});
			}
		});
	
	
	
    var methods = {
    init : function( options ) {
		// генерируем блок для редактирование теста
		var txtParamsToolbar = "";
		styles.forEach(function(item){
			if (item.variants){
				txtParamsToolbar+="<p>"+item.name+": ";
				item.variants.forEach(function(item2){
					txtParamsToolbar+='<a class="'+item2.name+'" data-class="'+item2.name+'"><span>'+item2.title+"</span></a>"; 
				});
				txtParamsToolbar+='<a class="default"><span>Сбросить</span></a>';
				txtParamsToolbar+="</p>";
			}
		});
		txtParamsToolbar = '<div unselectable="on" class="editParamsTxt subWindow">'+txtParamsToolbar+'</div>';
		// генерируем цвета
		var colorsTXT = "";
		colors.forEach(function(item){
			colorsTXT += '<div unselectable="on" class="colorBlock" data-color="'+item+'" style="background:'+item+';"></div>';
		});
		colorsTXT = '<div class="colorBlockSelector" unselectable="on"><div unselectable="on" class="selectedColor" data-color="'+colors[0]+'" style="background:'+colors[0]+';"></div><div unselectable="on" class="addColors subWindow">'+colorsTXT+'</div></div>';
		// КОНЕЦ генерируем цвета
		
		// генерируем форматирования текста
		var hBlockSelector = "";
		formats.forEach(function(item){
			hBlockSelector += '<'+item.name+' unselectable="on" class="format" data-command="FormatBlock" data-params="'+item.name+'">'+item.title+'</'+item.name+'>'; 
		});
		hBlockSelector = '<div class="FormatBlockHolder subWindow"><a class="close"></a>'+hBlockSelector+"</div>";
		// конец форматирования текста
		addImgTxt = '<div class="subWindow addEdtImg topToolbar"><a class="close"></a><div><label>URL:</label><input type="text" class="url" /><a class="browse" data-type="imgOnly" data-parent="addEdtImg">Обзор</a></div><div><label>Ширина:</label><input type="text" class="width" /><label>Высота:</label><input type="text" class="height" /><label>Обтекание:</label><select class="classAlign"><option value="" selected="selected">Нет обтекания</option><option value="right">Текст слева</option><option value="left">Текст справа</option></select></div><div><a class="edtImg">ОК</a><a class="insertImg">Вставить</a></div></div>';
		filemanagers = '<div class="subWindow fileManager fileManagerAllFiles"><a class="close"></a><iframe src="" data-src="/core/fileManager/fileManager.php?iframe=1"></iframe></div>';
		filemanagers += '<div class="subWindow fileManager fileManagerImages"><a class="close"></a><iframe src="" data-src="/core/fileManager/fileManager.php?iframe=1&images=true"></iframe></div>';
		// генерация тулбара
		var selectionError = '<div class="topToolbar subWindow selectionErrorInfo"><a class="close"></a>Вы ничего не выделили. Выделите необходимый элемент или поместите курсор для вставки информации в нужное место</div>';
		var saveInformation = '<div class="topToolbar subWindow saveInformation"><a class="close"></a><div class="saveInfo"></div></div>';
		var toolbarTXT = txtParamsToolbar; 
		var toolbarAdd = ""; 
		toolbar.forEach(function(item, i, arr) {
			attr = "";  
			if (item.options){ 
				item.options.forEach(function(item2, i2, arr2) { 
					attr += item2.name+'="'+item2.value+'" '; 
				});
			}
			//toolbarTXT += "<input type=\"button\" "+attr+" class=\""+item.class+"\" unselectable=\"on\" value=\""+item.title+"\">"; 
			toolbarTXT += "<input type=\"button\" "+attr+" class=\""+item.class+"\" unselectable=\"on\" data-poptitle=\""+item.title+"\">"; 
			
			if (item.type == "colorPicker"){
				toolbarAdd += colorsTXT;
			}else if (item.type == "H_picker"){
				toolbarAdd += hBlockSelector;
			}else if (item.type == "mkLink"){
				toolbarAdd += linkToolbar+linkToolbar2;
			}
		});
		toolbarTXT = "<div class='toobarIcons'>"+toolbarTXT+"</div><div class=\"popupIcons\"></div>";
		toolbarTXT += toolbarAdd;
		toolbarTXT += tableInsertToolbar+addImgTxt+filemanagers+selectionError+saveInformation;
		
		// конец генерации тулбара
		 
		return this.each(function(indx){
			
			$(this).data("viewType","visible").addClass("visible").data("saveUrl",options.saveUrl);
			
        	html = $(this).html();
			
			$(this).html('<div class="toolbar">'+toolbarTXT+'</div><div class="txtEditDiv" data-name="csEdit'+indx+'" contenteditable ="true">'+html+'</div><textarea class="txtEdit">'+html+'</textarea>'); 
			
			$(this).find(".topToolbar").css("width", $(this).width()+"px");
			 
			$(this).find(".table").on("click", function(){ 
				obj = $(this).parents(".csEdit");
				if (methods.saveSelection(obj) == true){
					methods.closeOtherToolBars(obj);
					obj.find(".tableInsertToolbar").show(100); 
				}
			});
			$(this).find(".insertTable").on("click", function(){ 
				obj = $(this).parents(".csEdit");
				cols = parseInt(obj.find(".tableInsertToolbar .cols").val());
				rows = parseInt(obj.find(".tableInsertToolbar .rows").val()); 
				pr = true;
				console.log(cols, rows,obj.find(".tableInsertToolbar .rows").val());
				if (isNaN(cols) || cols <= 0){
					obj.find(".tableInsertToolbar .cols").css("border", "1px red solid");
					pr = false;
				}else{
					obj.find(".tableInsertToolbar .cols").css("border", "");
				}
				if (isNaN(rows) || rows <= 0){
					obj.find(".tableInsertToolbar .rows").css("border", "1px red solid");
					pr = false;
				}else{
					obj.find(".tableInsertToolbar .rows").css("border", "");
				}
				thFirst = obj.find(".tableInsertToolbar .thHeaderFirst").val();
				if (pr){
					table = "";
					for(i=0;i<rows;i++){
						table +="<tr>";
							for(t=0;t<cols;t++){
								tag = "td";
								if (i==0 && thFirst == "thFirst"){
									tag = "th";									
								}
								table +="<"+tag+"></"+tag+">";
							}
						table +="</tr>";
					}
					sel = window.getSelection();
					sel.removeAllRanges();
					sel.addRange( obj.data("selection") );
					range = sel.getRangeAt(0);
					
					var tableElement = document.createElement("table"); 
					tableElement.innerHTML = table;
					range.insertNode(tableElement);
					var br = document.createElement("br");
					range.insertNode(br);
				}else{
					return;
				} 
			});
			
			
			$(this).find(".paramsEdtTxt").on("click", function(){ 
				obj = $(this).parents(".csEdit"); 
				if ($(this).data("status") != "opened"){
					obj.find(".editParamsTxt").show(100); 
					$(this).data("status","opened");
				}else{
					obj.find(".editParamsTxt").hide(100); 
					$(this).data("status","closed");
				}
			});
			$(this).find(".mkHtml").on("click", function(){ 
				var obj = $(this).parents(".csEdit"); 
				if(obj.data("viewType") == "visible"){
					methods.closeOtherToolBars(obj);
					obj.find(".txtEdit").val(obj.find(".txtEditDiv").html());
					//obj.find(".txtEdit").css("height", obj.find(".txtEditDiv").height()+30+"px");
					obj.data("viewType","html");
					obj.removeClass("visible");
					obj.addClass("html");
				}
			});
			$(this).find(".mkVisible").on("click", function(){ 
				var obj = $(this).parents(".csEdit"); 
				if(obj.data("viewType") == "html"){
					obj.find(".txtEditDiv").html(obj.find(".txtEdit").val());
					obj.data("viewType","visible");
					obj.removeClass("html");
					obj.addClass("visible");
				}
			}); 
			$(this).find(".close").on("click", function(){ 
				$(this).parents(".subWindow").hide(); 
			}); 
			$(this).find(".selectedColor").on("click", function(){ 
				obj = $(this).parents(".colorBlockSelector"); 
				methods.closeOtherToolBars(obj);
				obj.find(".addColors").show();
			}); 
			$(this).find(".addColors .colorBlock").on("click", function(){ 
				$(this).parents(".colorBlockSelector").find(".selectedColor").attr("data-color",$(this).attr("data-color")).css("background", $(this).attr("data-color"));
				$(this).parents(".addColors").hide();
			});
			$(this).find(".H_picker").on("click", function(){  
				obj = $(this).parents(".csEdit");  
				if (methods.saveSelection(obj) == true){
					methods.closeOtherToolBars(obj);
					obj.find(".FormatBlockHolder").show(); 
				}

			}); 
			$(this).find(".mkLink").on("click", function(){  
				var obj = $(this).parents(".csEdit");  
				if (methods.saveSelection(obj) == true){
					methods.closeOtherToolBars(obj);
					obj.find(".linkToolbar").show();
				} 
			}); 
			$(this).find(".addImg").on("click", function(){  
				var obj = $(this).parents(".csEdit");  
				if (methods.saveSelection(obj) == true){
					methods.closeOtherToolBars(obj);
					obj.find(".addEdtImg input").val(""); 
					obj.find(".addEdtImg select").val(""); 
					obj.find(".addEdtImg").show();
					obj.find(".addEdtImg .edtImg").hide();
					obj.find(".addEdtImg .insertImg").show(); 
				}
			}); 
			
			$(this).find(".browse").on("click", function(){  
				obj = $(this).parents(".csEdit"); 
				
				if ($(this).data("type") == "imgOnly"){
					fileManager = obj.find(".fileManagerImages"); 
				}else{
					fileManager = obj.find(".fileManagerAllFiles"); 
				}
				fileManagerIframe = fileManager.find("iframe");
				if (fileManagerIframe.attr("src") == ""){
					fileManagerIframe.attr("src", fileManagerIframe.data("src"));
				}
				fileManagerIframe.on('load', function () { 
					var fileManagerIframeData = fileManagerIframe.contents(); 
					fileManagerIframeData.on('click', "tr.file", function () { 
						
						url = $(this).data("filename");
						var folderName = $(this).parents("body").find("#folderForUpload").val();
						if (folderName != ""){
							folderName+="/";
						}
						folders = rootFolder+"/"+folderName; 
						var urlContainer = obj.find(".addEdtImg").find(".url");
						urlContainer.val(folders+url);
						methods.getFileInfo(urlContainer,"");
						fileManager.hide();
					});
				}); 
				fileManager.show();
			});
			 
			$(this).find(".addEdtImg .width").on("keyup", function(){ 
				if ($(this).data("coef")){
					$(this).parents(".addEdtImg").find(".height").val(Math.round($(this).val()*$(this).data("coef"))); 
				}
			});
			$(this).find(".addEdtImg .height").on("keyup", function(){ 
				if ($(this).data("coef")){
					$(this).parents(".addEdtImg").find(".width").val(Math.round($(this).val()*$(this).data("coef"))); 
				}
			});
			
			$(this).find(".insertImg").on("click", function(){
				var parent = $(this).parents(".addEdtImg");
				var obj = $(this).parents(".csEdit"); 
				
				var sel = window.getSelection();
				sel.removeAllRanges();  
				sel.addRange( obj.data("selection") );
				var range=sel.getRangeAt(0);
				
				var width = parent.find(".width").val();
				var height = parent.find(".height").val();
				var baseWidth = parent.find(".width").data("baseWidth");
				var baseHeight = parent.find(".width").data("baseHeight"); 
				var url = parent.find(".url").val();
				
				if (width < baseWidth || height < baseHeight){
					url = "/img.php?filename="+url+"&width="+width+"&height="+height;
				}
				
				var img = document.createElement("img"); 
				img.src = url;
				img.width = parent.find(".width").val();
				img.height = parent.find(".height").val();
				
				var className = parent.find(".classAlign").val();
				if (className != ""){
					img.className = className;
				} 
				
				range.insertNode(img); 
				parent.hide();
			});
			
				
			
			$(this).find(".insertLink").on("click", function(){  
				var obj = $(this).parents(".csEdit"); 
				objParent = $(this).parents(".linkToolbar");
				
				sel = window.getSelection();
				sel.removeAllRanges();
				sel.addRange( obj.data("selection") );
				
				document.execCommand("CreateLink", false, objParent.find(".linkURL").val()); 
				
				if ( objParent.find(".newWindow").val() ){
					newNode.target = objParent.find(".newWindow").val();  
				}  
				objParent.hide();
			});  
			$(this).find(".format").on("click", function(){ 
				obj = $(this).parents(".csEdit");  
				methods.closeOtherToolBars(obj);
				if($(this).attr("data-params")){
					params = $(this).attr("data-params");
				}else{
					params = null;
				} 
				if ($(this).attr("data-command") == "ForeColor"){
					params = $(this).parents(".csEdit").find(".colorBlockSelector .selectedColor").attr("data-color");
				} else if ($(this).attr("data-command") == "FormatBlock"){
					sel = window.getSelection();
					sel.removeAllRanges();
					sel.addRange( obj.data("selection") );
					obj.find(".FormatBlockHolder").hide();
					params = "<"+params+">";
				} 
				document.execCommand($(this).attr("data-command"), false, params); 
			});
			$(this).find("input.select").on("click", methods.getSelectedText);  
        });
		
	}, 
	getFileInfo : function(obj, chg){ 
		$.getJSON("/ajax/fileManagerTestFile.php",{filename:obj.val()}, function(data){
			if(data){
				if (data.width){
					if (chg != "notChgWidthHeight"){
						obj.parents(".addEdtImg").find(".width").val(data.width).data("coef", data.height / data.width).data("baseWidth",data.width);
						obj.parents(".addEdtImg").find(".height").val(data.height).data("coef", data.width / data.height).data("baseHeight",data.height);
					}else{
						obj.parents(".addEdtImg").find(".width").data("coef", data.height / data.width).data("baseWidth",data.width);
						obj.parents(".addEdtImg").find(".height").data("coef", data.width / data.height).data("baseHeight",data.height);
					}
				}else{
					if (chg != "notChgWidthHeight"){
						obj.parents(".addEdtImg").find(".width").val("").data("coef","");
						obj.parents(".addEdtImg").find(".height").val("").data("coef","");
					}
				}
				return 1;
			}else{
				return 0;
			}
		});
	}, 
	closeOtherToolBars : function (obj){
		obj.find(".topToolbar,.subWindow").hide();
	},
	saveSelection : function(obj){
		//obj - ".csEdit" element
		var sel = window.getSelection().anchorNode;
		if (sel == "undefined" || sel == null){ 
			obj.find(".selectionErrorInfo").show();
			return false;
		}
		sel = sel.parentElement;
		var pr = false; 
		var nameParentDiv = obj.find(".txtEditDiv").data("name");
		while (sel && pr == false){  
			var nameTmp = sel.getAttribute("data-name");
			if (nameTmp == nameParentDiv){
				pr = true; 
			} 
			sel = sel.parentElement;
		}
		if (pr){
			obj.data("selection", window.getSelection().getRangeAt(0).cloneRange()); 
			return true;
		}else{
			obj.find(".selectionErrorInfo").show(); 
			return false;
		}
		
	},
	// функция для получение выделенного текста
	getSelectedText : function(){
	    var text = "";
	    if (window.getSelection) {
	        text = window.getSelection();
	    }else if (document.getSelection) {
	        text = document.getSelection();
	    }else if (document.selection) {
	        text = document.selection.createRange().text;
	    }
		window.getSelection().getRangeAt(0).startContainer.parentNode; 
		alert(text);
	    //return text.toString();
	}, 
    update : function( content ) {
	}
  };
  $.fn.csEdit = function( method ) {  
    if ( methods[method] ) {
      return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ));
    } else if ( typeof method === 'object' || ! method ) {
      return methods.init.apply( this, arguments );
    } else {
      $.error( 'Метод ' +  method + ' в jQuery.csEdit не существует' );
    }    
  }; 
})( jQuery );