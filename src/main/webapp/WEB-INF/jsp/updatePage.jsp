<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>修改页面</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery-3.1.1.min.js"></script>
</head>
<body>
<form action="${pageContext.request.contextPath}/emp/update.do" method="post">
    <table class="table">
        <tr>
            <td>编号</td>
            <td><input type="text" name="id" value="${emp.id}"></td>
        </tr>
        <tr>
            <td>姓名</td>
            <td><input type="text" name="empName" value="${emp.empName}" ></td>
        </tr>
        <tr>
            <td>性别</td>
            <td><input type="text" name="sex"  value="${emp.sex}"></td>
        </tr>
        <tr>
            <td>职位</td>
            <td><input type="text" name="job" value="${emp.job}" ></td>
        </tr>
        <tr>
            <td>部门</td>
            <td>
            <select name="dId">
                <c:forEach items="${dep}" var="x">
                 <option value="${x.id}">${x.name}</option>
                </c:forEach>
            </select>
            </td>
        </tr>
        <tr>
            <td><span style="color: red">${info}</span></td>
            <td colspan="2"><button type="submit">保存</button></td>

        </tr>
    </table>
</form>
</body>
</html>
