<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script language="javascript" type="text/javascript" src="/install/scripts/jquery.js"></script>
{if $page == "maket"}
	<title>Система редактирования макетов</title>
	
	<script language="javascript" src="/script/plugin/jquery.tablesorter.min.js"></script>
	<script language="javascript" type="text/javascript" src="/install/scripts/maket.js"></script>
	

{elseif ($page == "addMaket" || $page == "editMaket")}
	{if $page == "editMaket"}
		<title>Система редактирования макетов</title>
	{else}	
		<title>Система добавления макетов</title>
	{/if}
	<script language="javascript" type="text/javascript" src="/install/scripts/addMaket.js"></script>
	
	<script src="/install/codepress/codepress.js" type="text/javascript"></script>  


{/if}


{if $page == "modules"}
	<title>Система редактирования модулей</title>
	<script language="javascript" src="/script/plugin/jquery.tablesorter.min.js"></script>
	<script language="javascript" type="text/javascript" src="/install/scripts/maket.js"></script>
	
	


{elseif ($page == "addModule" || $page == "editModules")}
	{if $page == "editModules"}
		<title>Система редактирования модулей</title>
	{else}	
		<title>Система добавления модулей</title>
	{/if}
	
	<script language="javascript" src="/script/plugin/jquery.tablesorter.min.js"></script>
	<script language="javascript" type="text/javascript" src="/install/scripts/addModules.js"></script>
	<script src="/install/codepress/codepress.js" type="text/javascript"></script>  


{/if}

{if $page == "shablon"}
	<title>Система редактирования шаблонов</title>
	<script language="javascript" src="/script/plugin/jquery.tablesorter.min.js"></script>
	<script language="javascript" type="text/javascript" src="/install/scripts/maket.js"></script>
	


{elseif ($page == "addShablon" || $page == "editShablon")}
	{if $page == "editShablon"}
		<title>Система редактирования шаблонов</title>
	{else}	
		<title>Система добавления шаблонов</title>
	{/if}
	<script language="javascript" type="text/javascript" src="/install/scripts/addShablon.js"></script>
	
	<script src="/install/codepress/codepress.js" type="text/javascript"></script>  

	
{elseif $page == "editSystem"}
	<title>Система редактирования информации</title>
	<script language="javascript" src="/script/plugin/jquery.tablesorter.min.js"></script>
	<script language="javascript" type="text/javascript">
		var category = {$parent};
	</script>
	<script language="javascript" type="text/javascript" src="/install/scripts/editSystem.js"></script>

    
{/if}

	<script language="javascript" src="/install/scripts/menu.js"></script>
	<style media="screen" type="text/css">
		@import url("/install/style/main.css");
	</style>
</head>

<body>
	<div id="mainCoreMenu">
			<ul id="menuContent">
				<li class="liFirst"><a class="aFirst" href="/install/">Главное меню</a>
				<li class="liFirst"><a class="aFirst">Вывод информации</a>
					<ul>
						<li><a class="hasSubmenu" href="/install/maket/">Система редактирования макетов</a>
							<ul>
								<li><a href="/install/addMaket/">Добавить макет</a></li>
							</ul>
						</li>
						<li><a href="/install/shablon/" class="hasSubmenu" >Система редактирования шаблонов</a>
							<ul>
								<li/><a href="/install/addShablon/">Добавить шаблон</a></li>
							</ul>
						</li>
						
						<!--<li class="hasSubmenu"><a href="/{$data1.titleEn}/{$data2.id}/">asd</a>
							<ul>
								<li class="hasSubmenu"><a href="/{$data1.titleEn}/{$data3.id}/">asd</a>
									<ul>
										<li><a href="/{$data1.titleEn}/{$data4.id}/">asd</a></li>
									</ul>
								</li>
							</ul>
						</li>-->
						
					</ul>
				</li>
				<li class="liFirst"><a class="aFirst">Категории</a>
					<ul>
						<li><a href="/install/editSystem/">Сопоставление категорий и шаблонов/макетов</a></li>
					</ul>
				</li>
				<li class="liFirst"><a class="aFirst">Работа с модулями</a>
					<ul>
						<li><a href="/install/modules/">Редактирование модулей</a></li>
						<li><a href="/install/addModule/">Добавить новый модуль</a></li>
					</ul>
				</li>
				<li class="liFirst"><a class="aFirst"  href="/install/sxd/">Восстановление системы</a>
				</li>
			</ul>
		</div>
	
	<div id="main">
	{if $message}
    	<div id="message">{$message}</div>
    {/if}
	{if $error}
    	<div class="error">{$error}</div>
    {/if}
	
	{if $page=="maket"}
		{include file="maket.tpl"}
	{elseif ($page == "addMaket" || $page == "editMaket")}
		{include file="addMaket.tpl"}
	{/if}
	
	{if $page=="shablon"}
		{include file="shablon.tpl"}
	{elseif ($page == "addShablon" || $page == "editShablon")}
		{include file="addMaket.tpl"}
	{/if}
	
	{if $page=="modules"}
		{include file="modules.tpl"}
	{elseif ($page == "addModule" || $page == "editModules")}
		{include file="addModule.tpl"}
	{/if}
	
	{if $page=="editSystem"}
		{include file="editSystem.tpl"}
	{/if}
	</div>
</body>
</html>