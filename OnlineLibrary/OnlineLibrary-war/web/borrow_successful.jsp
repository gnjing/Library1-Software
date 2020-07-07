<%-- 
    Document   : borrow_successful
    Created on : 2020-7-5, 17:24:16
    Author     : lh_11
--%>

<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.HashMap"%>

<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<title>Borrow Book Successful</title>
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
	<div id="logo"></div>
	<div id="main">
		<p>借书成功！</p>
		<div id="inf">
			<p>用户名：</p>
                        
        <%  ArrayList<HashMap<String,Object>> result = (ArrayList<HashMap<String,Object>>)session.getAttribute("cart_list");
        String user = (String)session.getAttribute("user");
            if(result==null||result.isEmpty()) { %>
        <%  }
            else { %>
            <div id = "aab"><%= user %></div>
            
        <%  } %>
			<p>借书本数：</p>
                        <%  
            if(result==null||result.isEmpty()) { %>
        <%  }
            else { %>
            <form action="BookServlet">
                <div id="w123">
                            <div class = "aaa"><%= result.size()%></div>
                </div>
            </form>
        <%  } %>
                        
			<p>书籍名称：</p>
                        <%  
            if(result==null||result.isEmpty()) { %>
        <%  }
            else { %>
            <form action="BookServlet">
                <div id="w123">
                    <%  for(int i = 0;i < result.size();i ++) { %>
                            <div class = "aaa"><%= result.get(i).get("name") %></div>
                    <%  } %>
                </div>
            </form>
        <%  } %>
		</div>
		<button type="submit" id="submit" value="submit" onClick="javascript:window.location.href='index.html'">返回首页</button>
	</div>
</body>
</html>
