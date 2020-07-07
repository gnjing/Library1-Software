<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<title>Home Page</title>
<link href="main.css" rel="stylesheet" type="text/css">
<link href="index.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://cdn.staticfile.org/font-awesome/4.7.0/css/font-awesome.css">
</head>
	
<body>
	<div id="top">
		<div id="logo">
			<img src="./image/logo/首页.png" alt="logo">
		</div>
		<div id="nav">
				<ul>
				<li><a>首页</a></li>
				<li><a>预约自习座位</a></li>
				<li><a>搜索图书</a></li>
                                <li><a href="UserServlet?page=index&&submit=user">个人主页</a></li>
				<li><a href="admin.jsp">管理员主页</a></li>
				</ul>
		</div>
		<div id="login"><a href="login.jsp">登录/注册</a></div>
	</div>
	<div id="main">
		<div id="input-group">
                    <form action="BookServlet">
			<div class="input-group-btn hidden-xs hidden-sm">
				<select class="fc" name="type">
					<option value="name" id="scope_title1" selected="selected"
							class="EXLSelectedOption">题名</option>
					<option value="author" id="scope_creator1" class="EXLSelectOption">作者</option>
					<option value="publisher" id="scope_lsr031" class="EXLSelectOption">出版社</option>
					<option value="isbn" id="scope_isbn1" class="EXLSelectOption">ISBN</option>
				</select>
			</div><!-- /btn-group -->
			<input type="text" placeholder="请输入搜索关键字"
                               id="searchOpac" name="key">
                        <input type="hidden" name="page" value="index">
                        <button name="submit" value="sousuo" id="sousuo">搜索</button>
			<!--<input id="sousuo" type="submit" value="搜索">-->
                    </form>
		</div>
		<div id="bk1">
			<div id="img1"></div>
			<div id="word">上图为北工大图书馆</div>
		</div>
		<div id="inf">
			<p>通知公告</p>
			<div id="notice">
			<ul>
				<li><p>06-23</p><a>关于2020年夏季毕业生办理图书馆离校的通知</a></li>
				<li><p>06-15</p><a>关于2020年夏季毕业生离校归还图书的通知—更新</a></li>
				<li><p>06-15</p><a>中国大百科全书数据库开通试用</a></li>
				<li><p>06-15</p><a>软件通—计算机技能视频学习系统开通试用</a></li>
			</ul>
			</div>
			<p>图书馆概况</p>
			<div id="notice1">
			<ul>
				<li><i class="fa fa-circle-o"></i><a href="location.html">图书馆布局图</a></li>
				<li><i class="fa fa-circle-o"></i><a>图书馆概况</a></li>
				<li><i class="fa fa-circle-o"></i><a>服务时间</a></li>
			</ul>
			</div>
		</div>
		<div id="footer">
			<p>制作人：管宁静、王文萱、王元芃、柳河</p>
			<p>建议使用兼容性较强的谷歌、火狐浏览器</p>
		</div>
	</div>
</body>
</html>
