<%-- 
    Document   : cart
    Created on : 2020-7-5, 16:35:36
    Author     : lh_11
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.HashMap" %>
<html>
<head>
<meta charset="UTF-8">
<title>Seat Page</title>
<link href="./main.css" rel="stylesheet" type="text/css">
<link href="cart.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://cdn.staticfile.org/font-awesome/4.7.0/css/font-awesome.css">
<style>
            
            td {
                border-right: 1px solid #D2E9FF;
                border-bottom: 1px solid #D2E9FF;
                background: #ECF5FF;
                padding: 6px 6px 6px 12px;
                color: #4f6b72;
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
#bor{
    float: left;
    margin-left: 525px;
    margin-top: -10px;
}
            </style>
</head>

<body>
	<div id="top">
		<div id="logo">
			<img src="image/logo/购物车页.png" alt="logo">
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
            <form action="BookServlet">
		<div id="input-group">
			<div class="input-group-btn hidden-xs hidden-sm">
				<select class="fc" name="type">
					<option value="name" id="scope_title1" selected="selected"
							class="EXLSelectedOption">题名</option>
					<option value="author" id="scope_creator1" class="EXLSelectOption">作者</option>
					<option value="publisher" id="scope_lsr031" class="EXLSelectOption">出版社</option>
					<option value="isbn" id="scope_isbn1" class="EXLSelectOption">ISBN</option>
				</select>
			</div><!-- /btn-group -->
                        <input type="hidden" name="page" value="cart" />
			<input type="text" placeholder="请输入搜索关键字" id="searchOpac" name="key">
			<button id="sousuo" type="submit" value="sousuo" name="submit">搜索</button>
		</div>
                </form>
		<div id="cart">
			<p>购物车  <i class="fa fa-shopping-cart"></i></p>
                        <%  ArrayList<HashMap<String,Object>> result = (ArrayList<HashMap<String,Object>>)session.getAttribute("cart_list");
            if(result==null||result.isEmpty()) { %>
        <%  }
            else { %>
            <form action="BookServlet">
                <div id="bor">
                <table width="400" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <th></th>
                        <th>书名</th>
                        <th>作者</th>
                    </tr>
                    <%  for(int i = 0;i < result.size();i++) { %>
                    <tr>
                        <td><input type="checkbox" name="<%= result.get(i).get("isbn") %>" value="<%= result.get(i).get("isbn") %>" />
                        <td><%= result.get(i).get("name") %></td>
                        <td><%= result.get(i).get("author") %></td>
                        <!--<td><input type="text" name="<%= result.get(i).get("isbn") %>" value="<%= result.get(i).get("isbn") %>"/></td>-->
                    </tr>
                    <%  } %>
                </table>
                </div>
            </form>
        <%  } %>
		</div>		
	</div>
	<div id="footer">
            <form action="BookServlet">
                <input type="hidden" name="page" value="cart">
                <button name="submit" id="submit" type="submit" value="cart_confirm">提交订单</button>
            </form>
        </div>
</body>
</html>
