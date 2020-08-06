<%--
  Created by IntelliJ IDEA.
  User: wang
  Date: 2020/7/27
  Time: 15:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>表单序列化</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery-3.5.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <script>
    function tesss() {
      $.ajax({
          url:"${pageContext.request.contextPath}/emp/lise1.do",
          type:"post",
          data:$("form").serialize(),
          dataType:"text",
          success:function (data) {
               alert(data)
          }
      })
    }
    </script>
</head>
<body>
<form>
    id：<input type="text" name="id"><br>
    name：<input type="text" name="name"><br>
    <input type="button" value="提交" onclick="tesss()">
</form>
</body>
</html>
