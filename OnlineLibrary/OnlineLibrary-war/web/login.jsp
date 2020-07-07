<%-- 
    Document   : login
    Created on : 2020-7-5, 17:35:05
    Author     : lh_11
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>
<link href="login.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="main">
		<div id="logo">
			<img src="./image/logo/登录页.PNG" alt="logo">
		</div>
		<div id="sheet">
			<p>用户登录</p>
			<form id="form" action="UserServlet">
				账号：
				<input  placeholder="请输入用户名" type="text" name="user" required="true">
				<br><br>
				密码：
				<input  placeholder="请输入密码" type="password" name="pwd" required="true">
				<br><br><br>
                                <input type="hidden" name="page" value="login">
				<button id="denglu" type="submit" name="submit" value="denglu" >登录</button>
			</form> 
			<br>
			<a href="register.html">注册</a>
		</div>
	</div>
</body>
</html>
