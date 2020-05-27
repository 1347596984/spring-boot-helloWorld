<%@page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>主页</title>
    <link rel="stylesheet" type="text/css" href="/layui/css/layui.css"/>
    <script type="text/javascript" src="/layui/layui.js"></script>```
</head>
<body>
<div>泥耗~~~${map.time}</div>
<div onclick="test()">click</div>
<div><img src="/layui/images/face/0.gif"></div>
<script>
    layui.use(['layer', 'form'], function(){
        var layer = layui.layer
            ,form = layui.form;

        layer.msg('Hello World');
    });
    function test(){
        layer.alert("11")
    }
</script>
</body>
</html>