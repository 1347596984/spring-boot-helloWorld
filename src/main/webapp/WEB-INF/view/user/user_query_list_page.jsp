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
        .layui-btn-mini{
            height: 25px;
            line-height: 24px;
        }
    </style>
</head>
<body>
<div style="width: 100%;">
    <div>
        <form class="layui-form form" id="form" action="<%=request.getContextPath()%>/sys/user/queryUserView" method="post">
            <table class="layui-table">
                <tr>
                    <td style="width: 10%;" class="query">名称</td>
                    <td style="width: 40%;">
                        <input type="text" class="layui-input queryItem" name="name" id="name" value="${map.name}" maxlength="20">
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
                        <input type="text" class="layui-input queryItem" name="email" id="email" value="${map.email}" maxlength="30">
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
                        <div class="layui-btn layui-btn-normal" onclick="add()">新增</div>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div style="width: 100%;">
        <table  id="resultTable"  lay-filter="resultTable">
            <script type="text/html" id="barDemo">
                <a class="layui-btn layui-btn-mini" lay-event="edit">维护</a>
                <a class="layui-btn layui-btn-danger layui-btn-mini" lay-event="del">删除</a>
                <a class="layui-btn layui-btn-normal layui-btn-mini" lay-event="detail">详细</a>
            </script>
        </table>
    </div>
</div>
<script>
    //获取查询项数据参数
    function getQueryData(){
        return {
            name: $("#name").val(),
            age_start: $("#age_start").val(),
            age_end: $("#age_end").val(),
            email: $("#email").val(),
            birthday_start: $("#birthday_start").val(),
            birthday_end: $("#birthday_end").val()
        }
    }

    //获取数据表格样式
    function getOptions(data){
        return {
            elem: '#resultTable'
            ,url: '<%=request.getContextPath()%>/sys/user/queryUserData'
            ,where:getQueryData()
            ,cols: [
                [
                    {field: 'id', title: 'ID', width: '7%', sort: true, fixed: 'left'}
                    ,{field: 'name',title: '名称', width: '15%', align:'center'}
                    ,{field: 'age',title: '年龄', width: '10%', align:'center'}
                    ,{field: 'email',title: '邮箱', width: '30%', align:'center'}
                    ,{field: 'birthday',title: '出生日期', width: '15%', align:'center'}
                    ,{field: 'operate', title: '操作', width: '23%', toolbar: '#barDemo', align:'center',unresize: true}
                ]
            ]//设置表头
            ,page:true
            // ,limit: 10
            ,parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code": 0, //解析接口状态
                    "msg": "", //解析提示文本
                    "count": res.total, //解析数据长度
                    "data": res.records //解析数据列表
                };
            }
        }
    }

    layui.use(['layer', 'form', 'laydate', 'table'], function(){
        var layer = layui.layer
            ,form = layui.form
            ,laydate = layui.laydate
            ,table = layui.table;

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

        //数据表格样式

        var tableIns = table.render(getOptions());

        window.query = function(){
            table.render(getOptions());
        }

        //监听工具条
        table.on('tool(resultTable)', function(obj){
            var data = obj.data;
            if(obj.event === 'detail'){
                detail(data.id);
            } else if(obj.event === 'del'){
                confirmDelete(data.id);
            } else if(obj.event === 'edit'){
                set(data.id);
            }
        });
    });

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