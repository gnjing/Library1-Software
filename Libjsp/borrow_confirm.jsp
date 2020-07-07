
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.HashMap"%>
<html>
<head>
<meta charset="UTF-8">
<title>Book Confirm Page</title>
<link href="./main.css" rel="stylesheet" type="text/css">
	<style>
		#main #chart{
			margin-top: 100px;
			width:600px;
			height:500px;
			background: rgba(245,245,245);
			box-shadow: 10px 10px 5px #888888;
			margin-left: 420px;
			position:relative;
		}
		#main #chart p{
			padding-top: 30px;
			font-size:20px;
			border:none;
		}
		#main #chart button{
			float:left;
			position:absolute; 
			bottom:50px;
			height:30px;
			width:100px;
			font-size:14px;
			padding: 0px 10px;
			border: 1px solid #cccccc;
			border-radius: 3px;	
			background:linear-gradient(to bottom, #ffffff 5%, #f6f6f6 100%);
			background-color:#FFFFFF;
		}
		#main #chart button:hover{
			background:linear-gradient(to bottom, #f6f6f6 5%, #ffffff 100%);
		}
		#main #chart #back{
			float:left;
			left:180px;
		}
		#main #chart #confirm{
			float:left;
			left:340px;
		}
                
                .word1{
                    float:left;
                    margin-left: 280px;
                }
                .word2{
                    float:left;
                    margin-left: 270px;
                    margin-top: 20px;
                }
                
                #aab{
                    float: left;
                    margin-left:265px;
                    margin-top:10px;
                }
                #w123{
                float:left;
                margin-left: 100px;
                margin-top: 25px;
            }
            
            td {
                border-right: 1px solid #D2E9FF;
                border-bottom: 1px solid #D2E9FF;
                background: #ECF5FF;
                padding: 6px 6px 6px 12px;
                color: #4f6b72;
                text-align: center;
            }

            td.alt {
                background: #ECF5FF;
                color: #797268;
            }
            
            th {
	font: bold 11px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
	color: #4f6b72;
	border-right: 1px solid #D2E9FF;
	border-bottom: 1px solid #D2E9FF;
	border-top: 1px solid #D2E9FF;
	letter-spacing: 2px;
	text-transform: uppercase;
	text-align: left;
	padding: 6px 6px 6px 12px;
	background: #C4E1FF no-repeat;
        text-align: center;
}
 
th.nobg {
	border-top: 0;
	border-left: 0;
	border-right: 1px solid #C1DAD7;
	background: #C4E1FF;
}
	</style>
</head>

<body>
	<div id="top">
		<div id="logo">
			<img src="./image/logo/确认借书页.png" alt="logo">
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
		<div id="login"><a href="login/login.html">登录/注册</a></div>
	</div>
	<div id="main">
		<div id="chart">
			<p>确认借阅信息</p>
			<div class="word1">用户名：</div>
                        <%  ArrayList<HashMap<String,Object>> result = (ArrayList<HashMap<String,Object>>)session.getAttribute("cart_list");
                    String user = (String)session.getAttribute("user");
            if(result==null||result.isEmpty()) { %>
            <%  }
            else { %>
            <div id = "aab"><%= user %></div>
			<div class="word2">书籍信息</div>
                        <form action="BookServlet">
                <div id="w123">
                <table width="400" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <th>书名</th>
                        <th>作者</th>
                        <th>出版社</th>
                        <th>ISBN</th>
                    </tr>
                    <%  for(int i = 0;i<result.size();i ++) { %>
                        <tr>
                            <td class="alt" width="80"><%= result.get(i).get("name") %></td>
                            <td class="alt" width="80"><%= result.get(i).get("author") %></td>
                            <td class="alt" width="80"><%= result.get(i).get("publisher") %></td>
                            <td class="alt" width="80"><%= result.get(i).get("isbn") %></td>
                        </tr>
                    <%  } %>
                </table>
                </div>
            </form>
        <%  } %>
			<button type="submit" name="back" id="back" onclick="javascript:history.back(-1);">返回上一页</button>
                        <a href="http://localhost:8080/Online_bookstore-war/borrow_sucessful.jsp">
                            <form action="BookServlet">
                                <input name="page" value="borrow_confirm" type="hidden">
                                <input name="user" value="<%=(String)session.getAttribute("user")%>" type="hidden">
                                <button type="submit" name="submit" id="confirm" value="continue">确认提交</button>
                            </form>
                        </a>
		</div>
	</div>
</body>
</html>
