<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery-3.1.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</head>
<body onload="load(1)">
<table class="table">
    <thead>
    <th><input type="checkbox" name="all" onclick="allselect()">全选</th>
    <th>编号</th>
    <th>姓名</th>
    <th>性别</th>
    <th>职位</th>
    <th>修改时间</th>
    <th>部门</th>
    <th>操作</th>
    <button type="button" onclick="addPage(this)" class="btn btn-success btn-sm">添加</button>
    <button type="button" onclick="dell()" class="btn btn-success btn-sm">批量删除</button>
    <button type="button" onclick="addwin()" class="btn btn-success btn-sm">同一模态框添加</button>
    <button type="button" onclick="prePage()" class="btn btn-success btn-sm">上一页</button>
    <button type="button" onclick="nextPage()" class="btn btn-success btn-sm">下一页</button>
    </thead>
    <tbody id="tb">
    </tbody>
</table>
<div class="modal fade" id="one" style="top:200px">
    <div class="modal-dialog">
        <div class="modal-content">
            <!--头部-->
            <div class="modal-header" style="background-color: green; height: 20px;">
            </div>
            <div class="modal-body">
                <table class="table" border="0">
                    <tr>
                        <td><input type="hidden" id="id"></td>
                    </tr>
                    <tr>
                        <td>姓名</td>
                        <td><input type="text" id="empName"></td>
                    </tr>
                    <tr>
                        <td>性别</td>
                        <td>
                            <input type="radio" value="男" name="sex">男
                            <input type="radio" value="女" name="sex">女
                        </td>
                    </tr>
                    <tr>
                        <td>职位</td>
                        <td><select  id="job">
                            <option value="">---请选择职位---</option>
                            <option value="经理">经理</option>
                            <option value="员工">员工</option>
                            <option value="董事长">董事长</option>
                        </select></td>
                    </tr>
                    <tr>
                        <td>修改时间</td>
                        <td><input type="date" id="updateTime"></td>
                    </tr>

                    <tr>
                        <td>部门</td>
                        <td><select id="dept">

                           </select></td>
                    </tr>
                    <tr>
                        <td><span style="color:red" id=""></span></td>
                        <td colspan="2">
                            <button type="button" class="btn btn-success btn-sm" onclick="save()">保存</button>
                            <button type="button" class="btn btn-success btn-sm" onclick="closeone(this)">关闭</button>
                        </td>

                    </tr>
                </table>
            </div>

        </div>
    </div>
</div>
<div class="modal fade" id="two" style="top:200px">
    <div class="modal-dialog">
        <div class="modal-content">
            <!--头部-->
            <div class="modal-header" style="background-color: green; height: 20px;">
            </div>
            <div class="modal-body">
                <table class="table" border="0">
                    <tr>
                        <td>姓名</td>
                        <td><input type="text" id="empName1"></td>
                    </tr>
                    <tr>
                        <td>性别</td>
                        <td><input type="text" id="sex1"></td>
                    </tr>
                    <tr>
                        <td>职位</td>
                        <td><input type="text" id="job1"></td>
                    </tr>
                    <tr>
                        <td>修改时间</td>
                        <td><input type="dete" id="updateTime1"></td>
                    </tr>

                    <tr>
                        <td>部门</td>
                        <td><input type="text" id="dept1"></td>
                    </tr>
                    <tr>
                        <td><span style="color:red" id=""></span></td>
                        <td colspan="2">
                            <button type="button" class="btn btn-success btn-sm" onclick="add()">提交</button>
                            <button type="button" class="btn btn-success btn-sm" onclick="closetwo(this)">关闭</button>
                            <button type="button" class="btn btn-success btn-sm" onclick="del()">清空</button>
                        </td>

                    </tr>
                </table>
            </div>

        </div>
    </div>
</div>
</body>
</html>
<script>
    var nPage;
    var raPage;
    var dId;
    function load(p) {
        $.ajax({
            url: "${pageContext.request.contextPath}/emp/ajax.do",
            type: "get",
            data:{"Page":p},
            dataType: "json",
            success: function (data) {//响应成功后执行
                nPage=data.nextPage;
                raPage=data.prePage;
                var html = "";
                    for (var i = 0; i < data.list.length; i++) {
                       dId= data.list[i].dId;
                        html += "<tr>" +
                            "<td><input type='checkbox' name='allId' value='"+data.list[i].id+"'></td>" +
                            "<td>" + data.list[i].id + "</td>" +
                            "<td>" + data.list[i].empName + "</td>" +
                            "<td>" + data.list[i].sex + "</td>" +
                            "<td>" + data.list[i].job + "</td>" +
                            "<td>" + data.list[i].updateTime + "</td>" +
                            "<td>" + data.list[i].dep.name + "</td>" +
                            "<td><button type='button' onclick='updatePage(this)' class=\"btn btn-success btn-sm\">修改</button><button type='button' onclick='deletePage(this)' class=\"btn btn-success btn-sm\" style=\"background-color: red\">删除</button></td>" +
                            "</tr>"

                }
                $("#tb").html(html)
                var opt="";
                for (var i = 0; i < data.dept.length; i++) {
                    opt+="<option value='"+data.dept[i].dId+"'>"+data.dept[i].name+"</option>"
                }
                $("#dept").html(opt)
            },
            error: function (data) {
                //响应失败执行

            }
        })
    }

    //修改
    function updatePage(obj) {
        var id = $(obj).parent().parent().find("td").eq(1).text();
        var empName = $(obj).parent().parent().find("td").eq(2).text();
        var sex = $(obj).parent().parent().find("td").eq(3).text();
        var job = $(obj).parent().parent().find("td").eq(4).text();
        var updateTime = $(obj).parent().parent().find("td").eq(5).text();
        var dept = $(obj).parent().parent().find("td").eq(6).text();
        $("#one").modal("show");
        //显示在模态框中
        $("#id").val(id);
        $("#empName").val(empName);
        $("input[value='"+sex+"']").prop("checked",true);
        $("#job").find("option[value='"+job+"']").prop("selected",true);
        $("#updateTime").val(updateTime);
        $("#dept option:contains('"+dept+"')").prop("selected",true);



    }
//保存
    function save() {
        //获取模态框中的值
        var id = $("#id").val();
        var empName = $("#empName").val();
        var sex = $("input:checked").val();
        var job = $("#job").val();
        var updateTime = $("#updateTime").val();
        var dept = dId;
       if (id!=""){
           //构建js对象
           var Page = {
               "id": id,
               "empName": empName,
               "sex": sex,
               "job": job,
               "updateTime": updateTime,
               "dId": dept
           };
           console.log(Page);
           //发送ajax请求
           $.ajax({
               url: "${pageContext.request.contextPath}/emp/updateajax.do",
               type: "get",
               data: Page,
               dateType: "json",
               success: function (data){
                   alert(data.info)
                   load(1);
                   $("#one").modal("hide");
               }
           });
       }else {
           //构建js对象
          var Page = {
               "empName": empName,
               "sex": sex,
               "job": job,
               "updateTime": updateTime,
               "dId": dept
           };
           console.log(Page);
           //发送ajax请求
           $.ajax({
               url: "${pageContext.request.contextPath}/emp/addajax.do",
               type: "get",
               data: Page,
               dateType: "json",
               success: function (data) {
                   alert(data.inf)
                   load(1);
                   $("#one").modal("hide");
               }
           });
       }

    }
    //删除
    function deletePage(obj) {
        var id = $(obj).parent().parent().find("td").eq(1).text();

        //发送ajax请求
        $.ajax({
            url: "${pageContext.request.contextPath}/emp/deleteajax.do",
            type: "get",
            data: {"id":id},
            dateType: "json",
            success: function (data) {
                alert(data.info)
                load(1);
                $("#one").modal("hide");
            }
        });
    }
    //添加
    function addPage(obj) {
        $("#two").modal("show");
    }
    //提交
    function add() {
        //获取模态框中的值
        var empName = $("#empName1").val();
        var sex = $("#sex1").val();
        var job = $("#job1").val();
        var updateTime = $("#updateTime1").val();
        var dept = $("#dept1").val();
        var tf;
        if ("行政"==dept){
            tf=1;
        }else if ("管理"==dept){
            tf=2;
        }else if ("人事"==dept){
            tf=3;
        }else if ("开发"==dept){
            tf=4;
        }
        //构建js对象
        var Page = {
            "empName": empName,
            "sex": sex,
            "job": job,
            "updateTime": updateTime,
            "dId": tf
        };
        //发送ajax请求
        $.ajax({
            url: "${pageContext.request.contextPath}/emp/addajax.do",
            type: "get",
            data: Page,
            dateType: "json",
            success: function (data) {
                alert(data.inf);
                $("#two").modal("hide");
                load(1);
            }
        });

    }
    function closeone(obj) {
        $("#one").modal("hide");
    }
    function closetwo(obj) {
        $("#two").modal("hide");
    }
    function del() {
        var empName = $("#empName1").val(null);
        var sex = $("#sex1").val(null);
        var job = $("#job1").val(null);
        var updateTime = $("#updateTime1").val(null);
        var dept = $("#dept1").val(null);
    }
    //下一页
    function nextPage() {
        load(nPage);
    }
    //上一页
    function prePage() {
        load(nPage);
    }
    function addwin() {
        $("#id").val(null);
        $("#empName").val(null);
        $("input[name='sex']:checked").prop("checked",false);
        $("#job").find("option").prop("selected",false);
        $("#dept").find("option").prop("selected",false);
$("#one").modal("show");
    }
    //全选
    function allselect() {
        $("input[name='allId']").prop("checked",$("input[name='all']").prop("checked"));
    }
    //批量删除
    function dell() {
        //确认框
        var rr = confirm("你确定要删除吗?");
        //点击确定返回的true
        if(rr){
            var allId="";
            $("input[name='allId']:checked").each(function(){
                allId += $(this).val()+",";
            })
            console.log(allId)

            //发送ajax请求
            $.ajax({
                url:"${pageContext.request.contextPath}/emp/delAjax.do",
                type:"get",
                data:{"id":allId},
                //设置传值的类型
              // contentType:application/JSON,
                dataType:"json",
                success:function (data) {
                    if(data.inf){
                        alert("删除成功");
                        //刷新
                        load(1)
                    }

                }
            })
        }
    }
</script>