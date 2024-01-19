<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Установка системы управления интернет-магазином</title>
	<script language="javascript" src="/install/scripts/menu.js"></script>
	<style media="screen" type="text/css">
		@import url("/install/style/main.css");
	</style>
</head>

<body><br /><br />

	<h3>Установка системы управления интернет-магазином</h3>
	<div id="main">
		<form action="/install/" method="post" id="authForm">
				<div>
					<label for="login">Логин:</label>
					<input type="text" name="login" id="login" />
				</div>
				<div>
					<label for="pwd">Пароль:</label>
					<input type="text" name="pwd" id="pwd" />
				</div>
				<div>
					<label for="dbName">Имя DB:</label>
					<input type="text" name="dbName" id="dbName" />
				</div>
				<div>
					<label></label>
					<input type="submit" class="submit" name="mkDbConnectFile" id="mkDbConnectFile" value="Установить параметры" />
				</div>
		</form>
	</div>
</body>
</html>
