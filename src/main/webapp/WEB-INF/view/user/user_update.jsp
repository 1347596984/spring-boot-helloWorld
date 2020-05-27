<%@page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>维护用户</title>
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
        .note{
            color:red;
        }
    </style>
</head>
<body>
<div style="width: 100%;">
    <div>
        <form class="layui-form form" id="form" action="" method="post">
            <input type="hidden"  name="id" id="id" value="${map.id}">
            <table class="layui-table">
                <tr>
                    <td style="width: 10%;" class="query">名称<span class="note">*</span></td>
                    <td style="width: 40%;">
                        <input type="text" class="layui-input queryItem" name="name" id="name" value="${result.name}" maxlength="10">
                    </td>
                    <td style="width: 10%;" class="query">年龄</td>
                    <td style="width: 40%;">
                        <input type="text" class="layui-input queryItem" name="age"  maxlength="3" value="${result.age}"
                               onkeyup="this.value=this.value.replace(/[^\d]/g,'') "
                        >
                    </td>
                </tr>
                <tr>
                    <td  class="query">邮箱<span class="note">*</span></td>
                    <td >
                        <input type="text" class="layui-input queryItem" name="email" id="email" value="${result.email}" maxlength="30">
                    </td>
                    <td  class="query">出生日期<span class="note">*</span></td>
                    <td >
                        <input type="text" style="width: 86%;" class="layui-input" readonly="readonly" value="${result.birthday}"
                               name="birthday" id="birthday">
                    </td>
                </tr>
                <tr>
                    <td colspan="4" style="text-align: center">
                        <div class="layui-btn" onclick="save()">保存</div>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
<script>
    layui.use(['layer', 'form', 'laydate', 'table'], function(){
        var layer = layui.layer
            ,form = layui.form
            ,laydate = layui.laydate
            ,table = layui.table;

        //执行一个laydate实例
        var birthday = laydate.render({
            elem: '#birthday',
            type: 'date',
            trigger: 'click'
        });

    });

    //校验必填项是否填写
    function checkValue(){
        var name = $("#name").val();
        var email = $("#email").val();
        var birthday = $("#birthday").val();
        if(name == ""){
            layer.alert('名称不能为空，请输入', {icon: 2, end:function(){
                    $("#name").focus();
                }});
            return false;
        }
        if(email == ""){
            layer.alert('邮箱不能为空，请输入', {icon: 2, end:function(){
                    $("#email").focus();
                }});
            return false;
        }
        if(birthday == ""){
            layer.alert('出生日期不能为空，请输入', {icon: 2, end:function(){
                    $("#birthday").click();
                }});
            return false;
        }
        return true;
    }

    //保存
    function save(){
        if(checkValue()){
            $.ajax({
                url: '<%=request.getContextPath()%>/sys/user/saveSetUser',
                data: $("#form").serialize(),
                dataType: 'JSON',
                type: 'POST',
                success: function(data){
                    console.log("data", data);
                    if(data > 0){
                        layer.alert('保存成功', {icon: 1, end:function(){
                                window.parent.layer.closeAll();
                                window.parent.query();
                            }});
                    } else {
                        layer.alert('用户信息保存失败，请重试', {icon: 2});
                    }
                },
                error: function(){
                    layer.alert('保存失败，请重试', {icon: 2});
                }
            })
        }
    }

</script>
</body>
</html>