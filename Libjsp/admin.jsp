<%-- 
    Document   : admin
    Created on : 2020-7-5, 22:55:35
    Author     : lh_11
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.HashMap" %>

<!doctype html>
<html>
<head>
<title>Adminster Page</title>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.staticfile.org/font-awesome/4.7.0/css/font-awesome.css">
<link rel="stylesheet" href="admin.css"/>
<link rel="stylesheet" href="menuBox.css"/>
<link rel="stylesheet" href="./main.css"/>
<script src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
<script src="menuBox.js"></script>
<Script>
		$().ready(function() {
			initLeftNavHeight();
			initMenu();
		})

		/**初始化左侧导航栏高度**/
		function initLeftNavHeight() {
			initHeight();

			function initHeight() {
				var total = document.documentElement.clientHeight;
				var topHeight = $("#top").height();
				$("#leftNav").height(total - topHeight);
			}

			document.body.onresize = function() {
				initHeight();
			}
		}

		/**初始化菜单选项**/
		function initMenu() {
			
			var config02 = {
				//配置菜单的MenuBoxId
				menuBoxId: "#menuBox02",
				//是否可以打开多个上级菜单
				multiple: false,
				//初始化打开的上级菜单的index数组
				openIndex: [-1]
			}
			menuBox.init(config02);
		}
	</Script>
</head>
<body>
	<div id="top">
		<div id="logo">
			<img src="./image/logo/管理员操作页.png" alt="logo">
		</div>
		<div id="nav">
				<ul>
				<li><a>预约自习座位</a></li>
				<li><a>搜索图书</a></li>
				<li><a >个人主页</a></li>
				<li><a >管理员主页</a></li>
				</ul>
		</div>
		<div id="login"><a href="login.jsp">登录/注册</a></div>
	</div>
	<div id="main">
		<div id="left">
			<div id="admin-info">
				<p>admin</p>
                                <button id="logout" type="submit" value="logout">注销</button>
			</div>
		</div>
		<div id="leftNav" class="left-nav">
			<div id="menuBox02" class="menuBox">
					<div class="spMenuBox">					
						<div class="spMenuItem">						
							<div class="spMenu">
								<i class="fa fa-building"></i>
								<a href="admin.jsp"><span style="color:#FFD700">管理员首页</span></a>	
								<i class="fa fa-2x fa-angle-right"></i>				
							</div>
						</div>
						<div class="spMenuItem">
							
                                                        <div class="spMenu">
								<i class="fa fa-book"></i>
								<span>书籍管理</span>
								<i class="fa fa-2x fa-angle-down"></i>
							</div>
							<div class="subMenuBox">
								<a href="borrow.jsp"><span class="subMenu">线下借书</span></a>
								<a href="return.jsp"><span class="subMenu">线下还书</span></a>
								<a href=""><span class="subMenu" >处理线上还书</span></a>
								<a href="add.jsp"><span class="subMenu" >新增图书</span></a>
								<a href="modify.jsp"><span class="subMenu">修改书籍信息</span></a>
							</div>
						</div>
						<div class="spMenuItem">
							<div class="spMenu">
								<i class="fa fa-building"></i>
								<a href="seat.jsp"><span>座位管理</span></a>
								<i class="fa fa-2x fa-angle-right"></i>
							</div>
						</div>
						<div class="spMenuItem">
							<div class="spMenu">
								<i class="fa fa-key"></i>
								<a href="pw.jsp"><span>密码管理</span></a>
								<i class="fa fa-2x fa-angle-right"></i>
							</div>
						</div>
					</div>
				</div>
		</div>
		<div id="right">
			<p>请点击左侧导航栏进入对应页面</p>
		</div>
	</div>
</body>
</html>
