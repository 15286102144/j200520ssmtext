<%--
  Created by IntelliJ IDEA.
  User: wang
  Date: 2020/7/27
  Time: 11:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery-3.5.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <script>
        //传数组1
        $(function () {
            var a=["1","李四","djf","flkjjg"];
            $.ajax({
                url:"${pageContext.request.contextPath}/emp/textajax.do",
                //设置传值类型
                //contentType:application/json,
                type:"post",
                dataType:"text",
                traditional:true,
               //  contentType:"application/x-www-form-urlencoded; charset=UTF-8",
                contentType:"application/json",
                 data:JSON.stringify(a),
                success:function (data) {
                    alert(data)
                },
                error: function (data) {

                }
            })
        })
        //传数组2
        $(function () {
            var a=["1","李四","djf","flkjjg"];
            $.ajax({
                url:"${pageContext.request.contextPath}/emp/textajax.do",
                //设置传值类型
                //contentType:application/json,
                type:"post",
                dataType:"text",
                //  contentType:"application/x-www-form-urlencoded; charset=UTF-8",
                contentType:"application/json",
                data:JSON.stringify(a),
                success:function (data) {
                    alert(data)
                },
                error: function (data) {

                }
            })
        })
        //传数组对象
        /* $(function () {
             var b=[{id:2,name:"行政部"},{id:3,name:"行政部"},{id:4,name:"行政部"}];
            $.ajax({
                url:"${pageContext.request.contextPath}/emp/textajax.do",
                //设置传值类型
                //contentType:application/json,
                type:"post",
                dataType:"text",
               //jquery3.1.1需要设置请求头格式  contentType:"application/x-www-form-urlencoded; charset=UTF-8",
                contentType:"application/json",
                data:JSON.stringify(b),
                success:function (data) {
                    alert(data)
                },
                error: function (data) {

                }
            })
        })*/
    </script>
</head>
<body>
<h3>登录页面</h3>
</body>
</html>
