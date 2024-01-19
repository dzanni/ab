<html>
<head>
{literal}
<style>
*{
	margin:0px;
	padding:0px;
	color:#fff;
}
body{
	background:#A3D9FE;
}
#main{
	width:600px;
	height:200px;
	margin:auto;
	padding:50px 0px;
}
h1{
	color:#fff;
	font-weight:normal;
	font-size:36px;
}
h2{
	font-weight:normal;
}
p{
	margin:2px 0px;
}
a:hover{
	text-decoration:none;
}

</style>
{/literal}
	
</head>
<body>
	<div id="main">
		<h1>404 ошибка</h1>
		<p>страница не найдена или удалена</p>
		<p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>
		<h2>Вы можете перейти по ссылкам:</h2>
		<p><a href="/">Главная страница Интернет-магазина</a></p>
		{assign var=url value=''}
		{foreach item=data from=$catlist}
			{assign var=url value=$url|cat:"/"|cat:$data}
			<p><a href="{$url}/">http://{$host}{$url}/</a></p>
		{/foreach}
		
	</div>
</body>
</html>