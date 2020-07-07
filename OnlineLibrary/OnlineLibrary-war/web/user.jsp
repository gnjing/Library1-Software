<%-- 
    Document   : user
    Created on : 2020-7-5, 21:04:14
    Author     : lh_11
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.HashMap"%>
<html>
    <head>
        <meta charset="UTF-8">
            <title>User Page</title>
            <link href="./main.css" rel="stylesheet" type="text/css">
            <link href="user.css" rel="stylesheet" type="text/css">
            <link href="user_style.css" rel="stylesheet" type="text/css">
        <style>
            .w123 table{
                float:left;
                margin-left:200px;
            }
            
           
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
            
            #rrr{
                float: left;
                margin-top: 250px;
                margin-left: -250px;
                height:30px;
                width:100px;
                font-size:16px;
                background: #FFFFFF;
                border-radius: 3px;
                border: 1px solid #ccc;  
            }
            #rrr:hover{
                background:#66B3FF;
                color:white;
            }
            #rrr:active{
                position:relative;
                top:1px;
            }
            
            #logout{
                float: top;
                height: 30px;
                width:80px;
                background:white;
                margin-top: -15px;
                border: 1px solid #ccc; 
                border-radius: 3px; 
            }
            #logout:hover{
                background: #FFA500;
                color:white;
                border: 1px solid #FF8C00; 
            }
            #logout:active{
                position:relative;
                top:1px;
            }
            
            #ddd{
                float: left;
                margin-top: 230px;
                margin-left: -250px;
                height:30px;
                width:100px;
                font-size:16px;
                background: #FFFFFF;
                border-radius: 3px;
                border: 1px solid #ccc;  
            }
            #ddd:hover{
                background:#66B3FF;
                color:white;
            }
            #ddd:active{
                position:relative;
                top:1px;
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
		<img src="./image/logo/个人主页.png" alt="logo">
            </div>
            <div id="nav">
		<ul>
		<li><a>首页</a></li>
		<li><a>预约自习座位</a></li>
		<li><a>搜索图书</a></li>
                <li><a href="user.jsp">个人主页</a></li>
                <li><a>管理员主页</a></li>
                </ul>
            </div>
            <div id="login"><a href="login.html">登录/注册</a></div>
	</div>
	<div id="main">
            <div id="left">
                <div id="user-info">
                    <p>用户名：</p>
                    <%  HashMap<String,Object> stu_info = (HashMap<String,Object>)session.getAttribute("stu_info");
                        ArrayList<HashMap<String,Object>> br_list = (ArrayList<HashMap<String,Object>>)session.getAttribute("br_list");
                        ArrayList<HashMap<String,Object>> order_list = (ArrayList<HashMap<String,Object>>)session.getAttribute("order_list");
                        
                    if(stu_info==null||stu_info.isEmpty()) {
                        } else { %>
                        <p><%= stu_info.get("user") %><p>
                        <p>学号：</p>
                        <p><%= stu_info.get("no") %></p>
		</div>
		<input type="submit" id="logout" value="注销">
		<ul>
                    <li><a  href="user.jsp" style="color:#98F5FF;">
			<div class="image">
                            <img src="./image/house.PNG" alt="我的首页"></div>
                                我的首页</a>
                    </li>
                    <li><a href="changepw.jsp">
			<div class="image">
                            <img src="./image/key.PNG" alt="修改密码"></div>
				修改密码</a>
                    </li>
		</ul>
            </div>
            <div id="right">
		<div id="jieyue">
                    <p>我的借阅</p>
                    <form action="BookServlet">
                        <div class="w123">
                            <table width="400" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <th></th>
                                    <th>书名</th>
                                    <th>作者</th>
                                    <th>出版社</th>
                                    <th>借阅时间</th>
                                </tr>
                            <%  for(int i = 0;i < br_list.size();i ++) { 
                            if(br_list.get(i).get("return_date").equals("0000-01-01")){%>
                            <tr>
                                <td width="30">
                                <input type="checkbox" name="<%= br_list.get(i).get("br_num") %>" value="<%= br_list.get(i).get("br_num") %>" />
                                <td class="alt" width="80"><%= br_list.get(i).get("book_name") %></td>
                                <td class="alt" width="80"><%= br_list.get(i).get("book_author") %></td>
                                <td class="alt" width="80"><%= br_list.get(i).get("book_publisher") %></td>
                                <td class="alt" width="80"><%= (String)br_list.get(i).get("borrow_date")+ " "+(String)br_list.get(i).get("borrow_time") %></td>
                            </tr>
                            
                            <%  }} %>
                            </table>
                        </div>
                        <input type="hidden" name="page" value="user"/>
                        <button type="submit" name="submit" value="return" id="rrr">还书</button>
                    </form>
		</div>
                <div id="yuyue">
                    <p>我的预约</p>
                    <form action="SeatServlet" method="post">
                        <div class="w123">
                            <table width="400" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <th></th>
                                    <th>学号</th>
                                    <th>座位位置</th>
                                    <th>预约时间</th>
                                </tr>
                            <%  for(int i = 0;i < order_list.size();i ++) { %>
                            <tr>
                                <td width="30"><input type="checkbox" 
                                                  name="<%= (String)stu_info.get("no") 
                                                          + (String)order_list.get(i).get("seat_place") 
                                                          + (String)order_list.get(i).get("ordertime") %>" 
                                                  value="<%= (String)stu_info.get("no") 
                                                          + (String)order_list.get(i).get("seat_place") 
                                                          + (String)order_list.get(i).get("ordertime") %>"  />
                                <td class="alt" width="80"><%= stu_info.get("no") %></td>
                                <td class="alt" width="80"><%= order_list.get(i).get("seat_place") %></td>
                                <td class="alt" width="80"><%= order_list.get(i).get("order_time") %></td>
                            </tr>
                            <%  } %>
                            </table>
                        </div>
                        <input type="hidden" name="page" value="user"/>
                        <button type="submit" name="submit" value="quiaoyuyue" id="ddd">取消预约</button>
                    </form>
                    <%  } %>
                </div>
            </div>
	</div>
    </body>
</html>
