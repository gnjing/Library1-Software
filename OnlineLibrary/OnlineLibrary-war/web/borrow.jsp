<%-- 
    Document   : borrow
    Created on : 2020-7-5, 23:23:13
    Author     : lh_11
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<title>Untitled Document</title>
	<link rel="stylesheet" href="https://cdn.staticfile.org/font-awesome/4.7.0/css/font-awesome.css">
	<link rel="stylesheet" href="admin.css"/>
	<link rel="stylesheet" href="menuBox.css"/>
	<link rel="stylesheet" href="main.css"/>
	<script src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
	<script src="menuBox.js"></script>
	<style>
		#main #right #sheet{
			height:600px;
			width:600px;
			float:left;
			margin-left: 150px;
			margin-top: 100px;
		}
		#main #right #sheet p{
			font-family: Cambria, 'Hoefler Text', 'Liberation Serif', Times, 'Times New Roman', 'serif';
			font-size: 28px;
			margin-top: 60px;
			text-align: center;
		}
		#main #right #sheet #form{
			margin-top: 40px;

		}
		#main #right #sheet #form input{
			margin-left:5px;
			border: 1px solid #ccc;  /*设置输入框边框，边缘线的颜色、大小、及实线虚线*/
			padding: 7px 0px; /*设置输入框高度，也可以用height，但是用height的话，输入框的光标会置于顶部，还要设置其他样式去固定，而且还不一定会兼容很好*/
			border-radius: 3px; /*这个属性石css3里面的,IE不支持*/
			padding-left:5px; /*让广告距离左边5个像素，一开始光标是贴着左边输入框的边缘的*/
			-webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
			 box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
			 -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
			 -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
			 transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s
		}
		#main #right #sheet #form .title{
			font-size:16px;
			text-align: right;
			margin-right:200px;
		}
		#main #right  #sheet #form button{
			padding: 5px 20px;
			font-size:16px;
			background: #FFFFFF;
			text-align: center;
			margin-left:0px;
			border: 1px solid #ccc;
			border-radius: 3px;
		}
		#main#right  #sheet #form button:hover{
			background:rgba(24 ,116, 205,0.8) !important;
			color:white;
		}
		#main #right #sheet #form button:active{
			position:relative;
			top:1px;
		}
	</style>
</head>

<body>
	<div id="top">
		<div id="logo">
			<img src="./image/logo/线下借书页.png" alt="logo">
		</div>
		<div id="nav">
				<ul>
				<li><a>首页</a></li>
				<li><a>预约自习座位</a></li>
				<li><a>搜索图书</a></li>
				<li><a>个人主页</a></li>
				<li><a>管理员主页</a></li>
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
								<a href="admin.jsp"><span>管理员首页</span></a>	
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
								<a href="borrow.jsp"><span class="subMenu" style="color:#27408B">线下借书</span></a>
								<a href="return.jsp"><span class="subMenu">线下还书</span></a>
								<a href="return_check.jsp"><span class="subMenu">处理线上还书</span></a>
								<a href="add.jsp"><span class="subMenu">新增图书</span></a>
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
			<div id="sheet">
				<p>管理员借书</p>
				<form action="BookServlet" id="form">
                                    <input type="hidden" name="page" value="borrow">
				<div class="title">学号：
					<input  placeholder="请输入学号" type="text" name="no" required="true">
				</div>
				<br>
				<div class="title">待借书的ISBN：
					<input  placeholder="请输入ISBN" type="text" name="isbn" required="true">
				</div>
				<br><br>
				<button id="tijiao" type="submit" name="submit" value="borrow">提交</button>
			</form> 
			</div>
		</div>
	</div>
</body>
<script>
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
				openIndex: [-1,1]
			}
			menuBox.init(config02);
		}
	</script>
</html>
