<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2020/7/20
  Time: 13:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.5.0.min.js"></script>
</head>
<body>
<input type="hidden" style="color: red" value="${info}">
<div>
    <form action="${pageContext.request.contextPath}/emp/list.do" method="post">
        图书名称：<input type="text" name="empName" id="empName" value="${empName}">
        作者：<input type="text" name="sex" id="sex" value="${sex}">
        出版社：<input type="text" name="sex" id="sex1" value="${sex}">
        <button type="submit" class="btn btn-success btn-sm" style="background-color: aquamarine">查询</button>
    </form>
    <form action="${pageContext.request.contextPath}/emp/addPage.do" method="post">
        <button type="submit" class="btn btn-success btn-sm">添加</button>
    </form>
</div>
<table class="table">
    <thead>
    <th>编号</th>
    <th>书名</th>
    <th>主题</th>
    <th>作者</th>
    <th>出版社</th>
    <th>总数</th>
    <th>价格</th>
    <th>图书图片</th>
    <th>图书查看</th>
    </thead>
    <tbody>
    <c:forEach items="${data.list}" var="x">
        <tr>
            <td>${x.id}</td>
            <td>${x.empName}</td>
            <td>${x.sex}</td>
            <td>${x.job}</td>
            <td>${x.updateTime}</td>
            <td>${x.dId}</td>
            <td>
                <a href="${pageContext.request.contextPath}/emp/updatePage.do?id=${x.id}" class="btn btn-success btn-sm">修改</a>
                <a href="${pageContext.request.contextPath}/emp/delete.do?id=${x.id}" class="btn btn-success btn-sm" style="background-color: red">删除</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<a href="${pageContext.request.contextPath}/emp/list.do?page=${data.prePage}&empName=${empName}&sex=${sex}"
   class="btn btn-success btn-sm" style="background-color: #5bc0de">上一页</a>
<a href="${pageContext.request.contextPath}/emp/list.do?page=${data.nextPage}&empName=${empName}&sex=${sex}"
   class="btn btn-success btn-sm" style="background-color: chartreuse">下一页</a>
<a href="${pageContext.request.contextPath}/emp/list.do?page=${data.indexPage}&empName=${empName}&sex=${sex}"
   class="btn btn-success btn-sm">首页</a>
<a href="${pageContext.request.contextPath}/emp/list.do?page=${data.endPage}&empName=${empName}&sex=${sex}"
   class="btn btn-success btn-sm" style="background-color:blue">尾页</a>
总条数：<input type="text" value="${data.count}" style="width: 50px;height:30px">
每页显示数：<input type="text" value="${data.allPage}" style="width: 50px;height:30px">
总页数：<input type="text" value="${data.pages}" style="width: 50px;height:30px">
<a href="javascript:void(0)" onclick="prePage(0)" class="btn btn-success btn-sm">js上一页</a>
<a href="javascript:void(0)" onclick="prePage(1)" class="btn btn-success btn-sm">js下一页</a>
</body>
</html>
<script>
    //上一页
    function prePage(p) {
        var page;
        if (p==0){
            //js方式获取request对象的值
            page = '${data.prePage}';
        }else{
            page = '${data.nextPage}';
        }
        console.log("page="+page);
        var empName=$("#empName").val();
        var sex = $("#sex").val();
        console.log("empName="+empName)
        console.log("sex="+sex)
        //发送请求
        window.location.href="${pageContext.request.contextPath}/emp/list.do?page="+page+"&empName="+empName+"&sex="+sex+"";
    }
</script>