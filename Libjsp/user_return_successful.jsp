<%-- 
    Document   : user_return_successful
    Created on : 2020-7-5, 22:28:20
    Author     : lh_11
--%>

<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.HashMap" %>

<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<title>Return Book Successful</title>
	<style>
		html {min-width:700px;}
		body {text-align:center;margin:0;background:#fff;}
		body > div {text-align:center;margin-right:auto;margin-left:auto;}
		#main{
			width:600px;
			height:400px;
			background: rgba(245,245,245);
			box-shadow: 10px 10px 5px #888888;
			margin-top: 200px;
			padding-top: 40px;
		}
		#main p{
			font-size:24px;
		}
		#main #inf p{
			font-size:18px;
			text-align: center;
		}
		#main button{
			margin-top: 20px;
			height:30px;
			width:100px;
			font-size:16px;
			background: #FFFFFF;
			border-radius: 3px;
			border: 1px solid #ccc;  
		}
		#main button:hover{
			background:rgba(24 ,116, 205,0.8);
			color:white;
		}
		#main button:active {
			position:relative;
			top:1px;
		}
	</style>
</head>

<body>
	<div id="main">
		<p>还书成功！</p>
		<div id="inf">
			<p>用户名：</p>
                        <%  ArrayList<HashMap<String,Object>> br_list = (ArrayList<HashMap<String,Object>>)session.getAttribute("br_list");
            if(br_list==null||br_list.isEmpty()) { %>
        <%  }
            else { %>
            <div id = "aab"><%= (String)session.getAttribute("user") %></div>
            
        <%  } %>
			<p>还书本数：</p>
                         <%  
            if(br_list==null||br_list.isEmpty()) { %>
        <%  }
            else { %>
            <form action="Bookervlet">
                <div id="w123">
                    <div class = "aaa"><%= br_list.size() %></div>
                </div>
            </form>
        <%  } %>
			<p>书籍名称：</p>
                        <%  
            if(br_list==null||br_list.isEmpty()) { %>
        <%  }
            else { %>
            
            <form action="BookServlet">
                <div id="w123">
                    <% for(int i = 0;i < br_list.size();i ++){ %>
                    <div class = "aaa"><%= br_list.get(i).get("book_name") %></div>
                    <%}%>
                </div>
            </form>
        <%  } %>
		</div>
                <form action="UserServlet">
		<button type="submit" id="submit" name="submit" value="user" onClick="javascript:window.location.href='user.jsp'"
>返回还书页</button>
                    <input type="hidden" name="page" value="index">
                    </form>
	</div>
</body>
</html>
