<%--
  Created by IntelliJ IDEA.
  User: wang
  Date: 2020/7/30
  Time: 10:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://shiro.apache.org/tags"  prefix="shiro"%>

<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery-3.5.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</head>
<body>
<%--获取登录用户名--%>
<shiro:user>
    欢迎<shiro:principal></shiro:principal>登录！！<br>
</shiro:user>
<%--拥有name属性得角色显示标签里的内容--%>
<shiro:hasRole name="user">
    <a href="/user.jsp">用户页面</a><br>
</shiro:hasRole>
<shiro:hasRole name="admin">
    <a href="/admin.jsp">管理员页面</a><br>
</shiro:hasRole>
<%--没有neme属性显示标签里的内容--%>
<shiro:lacksRole name="admin">
    没有admin这个角色<br>
</shiro:lacksRole>
<a href="/pc/logout">退出用户</a>
</body>
</html>
