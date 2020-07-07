<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.HashMap" %>

<html>
<head>
<link href="main.css" rel="stylesheet" type="text/css">
<link href="search.css" rel="stylesheet" type="text/css">

<style>
    #searchOpac{
	height: 35px;
	width:250px;
	font-size:14px;
	float:left;
	position: relative;
	z-index: 1;
	margin-top: -66px;
	margin-left: 555px;
	border: 1px solid #ccc;  /*设置输入框边框，边缘线的颜色、大小、及实线虚线*/
	padding: 7px 0px; /*设置输入框高度，也可以用height，但是用height的话，输入框的光标会置于顶部，还要设置其他样式去固定，而且还不一定会兼容很好*/
	border-radius: 3px; /*这个属性石css3里面的,IE不支持*/
	padding-left:90px; /*让广告距离左边5个像素，一开始光标是贴着左边输入框的边缘的*/
	-webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
     box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
     -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
     -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
     transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s
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
        height: 35px;
}
 
th.nobg {
	border-top: 0;
	border-left: 0;
	border-right: 1px solid #C1DAD7;
	background: #C4E1FF;
}

#sousuo{
	font-size:16px;
	width: 60px;
	height: 45px;
	background:linear-gradient(to bottom, #ffffff 5%, #f6f6f6 100%);
	background-color:#FFFFFF;
	-webkit-appearance: button;
	border-radius:3px;
	border:1px solid #ccc;
	display:inline-block;
	cursor:pointer;
	color:#666666;
	font-weight:bold;
	text-decoration:none;
}
#sousuo:hover{
	background:linear-gradient(to bottom, #f6f6f6 5%, #ffffff 100%);
}
#sousuo:active {
	position:relative;
	top:1px;
}
#w123{
    float: left;
    margin-left: 531px;
    margin-top: -207px;
    width:400px;
    height:207px;
}

#cart{
    
}
#search{
    float: left;
    margin-left: 20px;
}

#w456{
    float: left;
    margin-left: 491px;
    margin-top: 120px;
    width:400px;
    height:207px;
}

#check{
    width: 20px;
    height: 20px;
}

#sanshiwu{
    height: 22px;
}


#cart{
	border-top: 2px solid #ccc; 
	margin-top: 20px;
}
#cart p{
	font-size:24px;
	color: #696969;
}


#footer{
	position: absolute;
    bottom: 0;
	height:50px;
	background: #DCDCDC;
	width:100%;
}
#footer button{
	float:right;
	margin-right: 200px;
	margin-top: 10px;
	padding: 5px 20px;
	font-size:16px;
	background: #FFFFFF;
	border: 1px solid #ccc;
	border-radius: 3px;
}
#footer button:hover{
	background:rgba(24 ,116, 205,0.8);
	color:white;
}
#footer button:active {
	position:relative;
	top:1px;
}

</style>

<meta charset="UTF-8">
<title>Search Page</title>
</head>

<body>
	<div id="top">
		<div id="logo">
			<img src="./image/logo/检索图书页.png" alt="logo">
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
                    <div id="w456">
                    <table width="40" height="207" border="0" cellspacing="0" cellpadding="0" top="0px" margin-left="50px">
                        <tr>
                            <th></th>
                        </tr>
                        <%  ArrayList<HashMap<String,Object>> result = (ArrayList<HashMap<String,Object>>)session.getAttribute("book_list");
            if(result==null||result.isEmpty()) { %>
            <form action="BookServlet">
		<div id="input-group">
			<div class="input-group-btn hidden-xs hidden-sm">
				<select class="fc" name="type">
					<option value="name" id="scope_title1" selected="selected" class="EXLSelectedOption">题名</option>
					<option value="author" id="scope_creator1" class="EXLSelectOption">作者</option>
					<option value="publisher" id="scope_lsr031" class="EXLSelectOption">出版社</option>
					<option value="isbn" id="scope_isbn1" class="EXLSelectOption">ISBN</option>
				</select>
			</div><!-- /btn-group -->
                        
                <input type="text" placeholder="请输入搜索关键字" id="searchOpac" name="key">
                <button type="submit" name="submit" value="sousuo" id="sousuo">搜索</button>
		</div>
                <input type="hidden" name="page" value="search" />
            </form>
        <%  }
            else { %>
                    <%  for(int i = 0;i < result.size();i ++) { %>
                    <tr id="check">
                        <td id="sanshiwu"><input type="checkbox" name="<%= result.get(i).get("isbn") %>" value="<%= result.get(i).get("isbn") %>" />
                        <%  } %>
                    </tr>
                    </table>
                    </div>
                    <input type="hidden" name="page" value="search" />
                    <div id="footer">
                    <button type="submit" name="submit" value="add" id="cart">加入购物车</button>
                    </div>
                </form>
                    <form action="BookServlet">
                        <input type="hidden" name="page" value="search" />
                    <!--<div id="footer">-->
                        <button type="submit" name="submit" value="tocart" id="cart">切换购物车</button>
                    </form>>
            <form action="BookServlet">
		<div id="input-group">
			<div class="input-group-btn hidden-xs hidden-sm">
				<select class="fc" >
					<option value="title" id="scope_title1" selected="selected"
							class="EXLSelectedOption">题名</option>
					<option value="creator" id="scope_creator1" class="EXLSelectOption">作者</option>
					<option value="sub" id="scope_sub1" class="EXLSelectOption">主题</option>
					<option value="lsr03" id="scope_lsr031" class="EXLSelectOption">出版社</option>
					<option value="isbn" id="scope_isbn1" class="EXLSelectOption">ISBN</option>
				</select>
			</div><!-- /btn-group -->
                        
                <input type="text" placeholder="请输入搜索关键字" id="searchOpac" name="key">
                <button type="submit" name="submit" value="searh" id="sousuo">搜索</button>
		</div>
                
                <div id="w123">
                <table width="400" height="207" border="0" cellspacing="0" cellpadding="0" top="0px" margin-left="200px">
                    <tr>
                        <th>书名</th>
                        <th>作者</th>
                        <th>出版社</th>
                        <th>isbn</th>
                    </tr>
                    <%  for(int i = 0;i < result.size();i ++) { %>
                        <tr id="check">
                            <td class = "aaa"><%= result.get(i).get("name") %></td>
                            <td class = "aaa"><%= result.get(i).get("author") %></td>
                            <td class = "aaa"><%= result.get(i).get("publisher") %></td>
                            <td class = "aaa"><%= result.get(i).get("isbn") %></td>
                        </tr>
                    <%  } %>
                </table>
                </div>
                <input type="hidden" name="page" value="search" />
            </form>
                
        <%  } %>
	</div>
</body>
</html>
