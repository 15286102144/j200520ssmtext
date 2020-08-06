<%--
  Created by IntelliJ IDEA.
  User: wang
  Date: 2020/7/24
  Time: 8:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery-3.1.1.min.js"></script>
</head>
<body>
<h3>表单上传</h3>
<%--enctype="multipart/form-data" 表单上传属性--%>
<form action="${pageContext.request.contextPath}/emp/upload.do" method="post" enctype="multipart/form-data">
<%--    multiple="multiple" 一次选择多个文件--%>
<input type="file" name="files" multiple="multiple">
<input type="submit" value="上传">
</form>
<span style="color: red">${info}</span>
<h3>Ajax上传</h3>
<form id= "uploadForm">
   <input type="file" multiple="multiple" name="files">
    <input type="button" value="上传" onclick="doUpload()" />
</form>
</body>
</html>
<script>
    function doUpload() {
//将form表单元素的name与value进行组合
        var formData = new FormData(document.getElementById("uploadForm"));
        console.log(formData);
        $.ajax({
            url: ' ${pageContext.request.contextPath}/emp/fileTransAjax.do' ,
            type: 'POST',
            data: formData,
            contentType: false,  //contentType 主要设置你发送给服务器的格式,文件上传固定格式，设置为false
            processData: false,  //processData默认情况下会将发送的数据序列化以适应默认的内容类型application/x-www-form-urlencoded
            success: function (data) {
                if(data){
                    alert("上传成功")
                }else{
                    alert("上传失败")
                }
            }
        });
    }
</script>