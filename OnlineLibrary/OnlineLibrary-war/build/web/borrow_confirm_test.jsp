<%-- 
    Document   : search
    Created on : 2020-7-4, 21:27:22
    Author     : lh_11
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% String br_list = (String)session.getAttribute("br_list"); 
            String order_list = (String)session.getAttribute("order_list");%>
        
        <h1><%=br_list%></h1>
        <h1><%=order_list%></h1>
    </body>
</html>
