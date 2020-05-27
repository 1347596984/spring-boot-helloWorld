<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>用户信息查询</title>
    <link rel="stylesheet" type="text/css" href="/layui/css/layui.css"/>
    <script type="text/javascript" src="/layui/layui.js"></script>
    <script type="text/javascript" src="/jquery/jquery-3.4.1.js"></script>
    <style>
        .layui-table tbody tr:hover{
            background-color: transparent;
        }
        .queryItem{
            width: 86%;
        }
        .query{
            background-color: #acd6ef;
            border: none;
            text-align: right;
        }

    </style>
</head>
<body>
<div style="width: 100%;">
    <div>
        <form class="layui-form form" id="form" action="<%=request.getContextPath()%>/sys/user/queryUser" method="post">
            <table class="layui-table">
                <tr>
                    <td style="width: 10%;" class="query">名称</td>
                    <td style="width: 40%;">
                        <input type="text" class="layui-input queryItem" name="name" value="${map.name}" maxlength="20">
                    </td>
                    <td style="width: 10%;" class="query">年龄</td>
                    <td style="width: 40%;">
                        <input type="text" style="width: 42%; display: inline-block;" class="layui-input" onkeyup="this.value=this.value.replace(/[^\d]/g,'') "
                               name="age_start" value="${map.age_start}" id="age_start" maxlength="3">
                        -
                        <input type="text" style="width: 42%; display: inline-block;" class="layui-input" onkeyup="this.value=this.value.replace(/[^\d]/g,'') "
                               name="age_end" value="${map.age_end}" id="age_end" maxlength="3">
                    </td>
                </tr>
                <tr>
                    <td  class="query">邮箱</td>
                    <td >
                        <input type="text" class="layui-input queryItem" name="email" value="${map.email}" maxlength="30">
                    </td>
                    <td  class="query">出生日期</td>
                    <td >
                        <input type="text" style="width: 42%; display: inline-block;" class="layui-input" readonly="readonly"
                               name="birthday_start" value="${map.birthday_start}" id="birthday_start">
                        -
                        <input type="text" style="width: 42%; display: inline-block;" class="layui-input" readonly="readonly"
                               name="birthday_end" value="${map.birthday_end}" id="birthday_end">
                    </td>
                </tr>
                <tr>
                    <td colspan="4" style="text-align: center">
                        <div class="layui-btn" onclick="query()">查询</div>
                        <div class="layui-btn" onclick="add()">新增</div>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div style="width: 100%;">
        <table class="layui-table" id="resultTable" style="text-align: center;">
            <tr style="background-color: #acd6ef;">
                <th style="background-color: #acd6ef;width: 7%;">序号</th>
                <th style="background-color: #acd6ef;width: 15%;">名称</th>
                <th style="background-color: #acd6ef;width: 10%;">年龄</th>
                <th style="background-color: #acd6ef;width: 30%;">邮箱</th>
                <th style="background-color: #acd6ef;width: 15%;">出生日期</th>
                <th style="background-color: #acd6ef;width: 23%;">操作</th>
            </tr>
            <c:forEach items="${page.records}" var="item" varStatus="status">
                <tr>
                    <td>${(page.current - 1) * 10 + status.count }</td>
                    <td>${item.name}</td>
                    <td>${item.age}</td>
                    <td>${item.email}</td>
                    <td>${item.birthday}</td>
                    <td style="text-align: center">
                        <div class="layui-btn" onclick="set('${item.id}')">维护</div>
                        <div class="layui-btn" onclick="confirmDelete('${item.id}')">删除</div>
                        <div class="layui-btn" onclick="detail('${item.id}')">详细</div>
                    </td>
                </tr>

            </c:forEach>
        </table>

    </div>
</div>
<script>
    layui.use(['layer', 'form', 'laydate', 'table'], function(){
        var layer = layui.layer
            ,form = layui.form
            ,laydate = layui.laydate
            ,table = layui.table
            ,select = layui.select;

        //执行一个laydate实例
        var birthday_start = laydate.render({
            elem: '#birthday_start',
            type: 'date',
            done: function(value, date){
                console.log("data", date)
                birthday_end.config.min={
                    year:date.year,
                    month:date.month-1,//关键
                    date:date.date,
                }
            }
        });
        var birthday_end = laydate.render({
            elem: '#birthday_end',
            type: 'date',
            done: function(value, date){
                console.log("data", date)
                birthday_start.config.max={
                    year:date.year,
                    month:date.month-1,//关键
                    date:date.date,
                }
            }

        });
    });

    //查询
    function query(){
        document.getElementById("form").submit();
    }

    //新增
    function add(){
        layer.open({
            title: '用户信息新增',
            type: 2,
            area:['50%', '50%'],

            content: ['<%=request.getContextPath()%>/sys/user/addUser', 'no']
        });
    }

    //维护
    function set(id){
        layer.open({
            title: '用户信息维护',
            type: 2,
            area:['50%', '50%'],

            content: ['<%=request.getContextPath()%>/sys/user/setUser?id=' + id, 'no']
        });
    }

    //详细
    function detail(id){
        layer.open({
            title:'用户信息详细',
            type: 2,
            area:['50%', '20%'],

            content: ['<%=request.getContextPath()%>/sys/user/userDetail?id=' + id , 'no']
        });
    }

    //删除用户
    function confirmDelete(id){
        layer.confirm('是否删除该用户？', {
            icon:3,
            btn:['是','否'],
            btn1:function(){
                deleteUser(id)
            },
            btn2:function(index){
                layer.close(index);
            }
        });
    }

    function deleteUser(id){
        $.ajax({
            url: '<%=request.getContextPath()%>/sys/user/deleteUser',
            data: {id: id},
            dataType: 'json',
            type: 'POST',
            success: function(data){
                console.log('data', data)
                if(data){
                    layer.alert('删除成功', {icon: 1, end:function(){
                            query();
                        }});
                }
            },
            error: function(){
                layer.alert('删除失败，请重试', {icon: 2, end:function(){
                    layer.closeAll();
                    }});
            }
        })
    }

</script>
</body>
</html>