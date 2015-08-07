<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 07.08.2015
  Time: 16:50
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="com.flower.dao.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>JSP Page</title>
</head>
<body>
<h1>All Emp:</h1>
<jsp:useBean class="com.flower.dao.MyDAO" id="myDAO" scope="application"/>
<table border="1">
  <%
    for (Emp e : myDAO.getAllEmp()) {
  %>
  <tr>
    <td><%=e.getEmpno()%></td>
    <td><%=e.getEname()%></td>
  </tr>
  <%
    }
  %>
</table>
</body>
</html>

