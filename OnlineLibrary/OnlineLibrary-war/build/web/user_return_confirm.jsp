<%-- 
    Document   : user_return_confirm
    Created on : 2020-7-5, 22:12:14
    Author     : lh_11
--%>

<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.HashMap" %>
<html>
<head>
<meta charset="UTF-8">
<link href="./main.css" rel="stylesheet" type="text/css">
<!doctype html>
<title>Book Confirm Page</title>
	<style>
            .w123 table{border-right:1px solid #D2E9FF;border-bottom:1px solid #D2E9FF} 
            .w123 table td{border-left:1px solid #D2E9FF;border-top:1px solid #D2E9FF} 
            .w123 table{
                float:left;
                margin-left:300px;
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
	</style>
</head>

<body>
	<div id="top">
		<div id="logo">
			<img src="./image/logo/确认还书页.png" alt="logo">
		</div>
		<div id="nav">
				<ul>
				<li><a>预约自习座位</a></li>
				<li><a>搜索图书</a></li>
				<li><a href="UserServlet?page=index&&submit=user">个人主页</a></li>
				<li><a>管理员主页</a></li>
				</ul>
		</div>
		<div id="login"><a href="login.html">登录/注册</a></div>
	</div>
	<div id="main">
		<div id="chart">
			<p>确认还书信息</p>
			<div class="word1">用户名：</div>
                        <%  ArrayList<HashMap<String,Object>> br_list = (ArrayList<HashMap<String,Object>>)session.getAttribute("br_list");
            if(br_list==null||br_list.isEmpty()) { %>
        <%  }
            else { %>
            <p><%= (String)session.getAttribute("usernum") %><p>
			<div class="word2">书籍信息</div>
                        
            <form action="BookServlet">
                <div id="w123">
                <table width="400" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <th>书名</th>
                        <th>作者</th>
                        <th>出版社</th>
                        <th>借阅时间</th>
                    </tr>
                    <%  for(int i = 0;i < br_list.size();i ++) { %>
                        <tr>
                            <td class = "aaa"><%= br_list.get(i).get("book_name") %></td>
                            <td class = "aaa"><%= br_list.get(i).get("book_author") %></td>
                            <td class = "aaa"><%= br_list.get(i).get("book_publisher") %></td>
                            <td class = "aaa"><%= br_list.get(i).get("borrow_date") %></td>
                        </tr>
                    <%  } %>
                </table>
                </div>
                <input type="hidden" name="page" value="user_return_confirm" />
            </form>
        <%  } %>
			<button type="submit" name="back" id="back" onclick="javascript:history.back(-1);">返回上一页</button>
                        <form action="BookServlet">
                    <% for(int i = 0;i < br_list.size();i ++){%>
                        <input type="hidden" name="<%= br_list.get(i).get("br_num") %>" value="<%= br_list.get(i).get("br_num") %>">
                    <% }%>
                    <input name="page" value="user_return_confirm" type="hidden">
                    <input type="hidden" name="user" value="<%=(String)session.getAttribute("usernum")%>">
                        <button type="submit" name="submit" value="submit" id="confirm">确认提交</button>
                        </form>
                </div>
	</div>
</body>
</html>
