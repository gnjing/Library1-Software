<%-- 
    Document   : modify
    Created on : 2020-7-6, 0:30:19
    Author     : lh_11
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<title>Modify Page</title>
	<link rel="stylesheet" href="https://cdn.staticfile.org/font-awesome/4.7.0/css/font-awesome.css">
	<link rel="stylesheet" href="./admin.css"/>
	<link rel="stylesheet" href="./menuBox.css"/>
	<link rel="stylesheet" href="./main.css"/>
	<link rel="stylesheet"  href="inputBox.css"/>
	<script src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
	<script src="./menuBox.js"></script>
	<script>
		var a = 0;
		//添加一行
		 function addNewLine(){
			if(a>5){
				document.getElementsByClassName("tianjia").disabled = "disabled";
				return;
			}
			a++;
			var tar = "<div id=\"input-group"+a+"\" class=\"in-group\">";
			tar+="<div class=\"input-group-btn hidden-xs hidden-sm\">";
			tar+="<select class=\"fc\" id=\"in"+a+"\" name=\"in"+a+"\">";
			tar+="<option value=\"num\" id=\"scope_num"+a+"\"selected=\"selected\" class=\"EXLSelectedOption\">馆藏数量</option>";
			tar+="<option value=\"title\" id=\"scope_title"+a+"\" class=\"EXLSelectOption\">书籍名称</option>";
			tar+="<option value=\"author\" id=\"scope_author"+a+"\" class=\"EXLSelectOption\">作者</option>";
			tar+="<option value=\"lsr\" id=\"scope_Isr"+a+"\" class=\"EXLSelectOption\">出版社</option>";
			tar+="<option value=\"bnum\" id=\"scope_bnum" +a+"\class=\"EXLSelectOption\">可借本数</option>";
			tar+="<option value=\"suoqu\" id=\"scope_suoqu" +a+"\class=\"EXLSelectOption\">索取号</option>";
			tar+="<option value=\"location\" id=\"scope_location" +a+"\class=\"EXLSelectOption\">书架位置</option>";
			tar+="</select>";
			tar+="</div>";
			tar+="<input type=\"text\" placeholder=\"请输入修改信息\" id=\"searchOpac"+a+"\" name=\"searchOpac"+a+"\" class=\"search\">";
			tar+="<input id=\"tianjia" +a+"\" type=\"submit\" value=\"+\" class=\"tianjia\" onclick=\"addNewLine()\">";
			tar+="<input id=\"shanchu"+a+"\" type=\"submit\" value=\"-\" class=\"shanchu\" onclick=\"deleteNewLine()\">";
			tar += "</div>";
			$("#main #right #sheet #form #chart").append(tar); 
		}
		function deleteNewLine(){
			$("#main #right #sheet #form #chart #input-group"+a+" ").remove();
			a--;
		}
		function checkform(){
			var v1="";
			var v2="";
			var group = document.getElementsByClassName('fc');
			var len=a+1;
			for(var m=0; m<=len; m++){
				v1=document.getElementById("in" + m).value;
				console.log(v1);
				for(var n=m+1; n<=len; n++){
					v2=document.getElementById("in" + n).value;
					console.log(v2);
					if(v1==v2){
						alert("规格重复");
						console.log(1);
						return false;
					}
				}
			}
		}
	</script>	
	<style>
		#main #right #sheet{
			height:700px;
			width:600px;
			float:left;
			margin-left: 120px;
			margin-top: 0px;
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
			height: 20px;
			width:200px;
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
			width:80px;
			height:30px;
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
			<img src="./image/logo/修改图书页.PNG" alt="logo">
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
								<a href="borrow.jsp"><span class="subMenu" >线下借书</span></a>
								<a href="return.jsp"><span class="subMenu">线下还书</span></a>
								<a href="return_check.jsp"><span class="subMenu">处理线上还书</span></a>
								<a href="add.jsp"><span class="subMenu" >新增图书</span></a>
								<a href="modify.jsp"><span class="subMenu" style="color:#27408B">修改书籍信息</span></a>								
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
				<p>修改图书信息</p>
				<form action="BookServlet" id="form">
                                    <input type="hidden" name="page" value="modify">
					<div class="title">ISBN：
						<input  placeholder="请输入ISBN" type="text" id="aisbn" name="isbn" required="true">
					</div>
					<div id="chart">
						<div id="input-group" class="in-group">
							<div class="input-group-btn hidden-xs hidden-sm">
								<select class="fc" id="in0" name="in0">
									<option value="num" id="scope_num0" selected="selected" class="EXLSelectedOption">馆藏数量</option>
									<option value="title" id="scope_title0" class="EXLSelectOption">书籍名称</option>
									<option value="author" id="scope_author0" class="EXLSelectOption">作者</option>
									<option value="lsr" id="scope_lsr0" class="EXLSelectOption">出版社</option>
									<option value="bnum" id="scope_bnum0" class="EXLSelectOption">可借本数</option>
									<option value="suoqu" id="scope_suoqu0" class="EXLSelectOption">索取号</option>
									<option value="location" id="scope_location0" class="EXLSelectOption">书架位置</option>
								</select>
							</div><!-- /btn-group -->
							<input type="text" placeholder="请输入修改信息" id="searchOpac0" name="searchOpac0" class="search">
							<input id="tianjia" type="submit" value="+" class="tianjia" onclick="addNewLine()">
							<input id="shanchu" type="submit" value="-" class="shanchu" onclick="deleteNewLine()">
						</div>
					</div>				
					<div class="title">管理员用户名：
						<input  placeholder="admin" type="text" disabled="disabled" name="submit" id="ad_name">
					</div>
					<br><br>
					<button id="baocun" type="submit" name="submit" value="save" onClick="checkform()">保存</button>
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

