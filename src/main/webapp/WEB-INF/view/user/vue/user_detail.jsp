<%@page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>用户详细</title>
    <link rel="stylesheet" type="text/css" href="/layui/css/layui.css"/>
    <script type="text/javascript" src="/layui/layui.js"></script>
    <script type="text/javascript" src="/vue/vue.js"></script>
    <script type="text/javascript" src="/jquery/jquery-3.4.1.js"></script>
    <style>
        .query{
            background-color: #acd6ef;
            border: none;
            text-align: right;
        }

    </style>
</head>
<body>
<div style="width: 100%;">
    <table style="width: 100%;" class="layui-table" id="resultTable">
        <tr>
            <td style="width: 10%;" class="query">名称</td>
            <td style="width: 40%;">{{result.name}}</td>
            <td style="width: 10%;" class="query">年龄</td>
            <td style="width: 40%;">{{result.age}}</td>
        </tr>
        <tr>
            <td class="query">邮箱</td>
                <td>{{result.email}}</td>
            <td class="query">出生日期</td>
            <td>{{result.birthday}}</td>
        </tr>
    </table>

</div>
<script>
    var detailDataVue = {
        result:${resultJSON}
    };
    var vm = new Vue({
        el: '#resultTable',
        data: detailDataVue
    })

    <%--window.onload = function(){--%>
    <%--    var queryParam = {'id': '${map.id}'};--%>
    <%--    console.log("ajaxStart", queryParam);--%>
    <%--    $.ajax({--%>
    <%--        url:'<%=request.getContextPath()%>/sys/user/userDetailData',--%>
    <%--        data: queryParam,--%>
    <%--        type: "POST",--%>
    <%--        dataType: 'json',--%>
    <%--        success: function(resultData){--%>
    <%--            console.log("ajaxend", resultData)--%>
    <%--            detailDataVue.result = resultData;--%>
    <%--        }--%>
    <%--    })--%>
    <%--}--%>
</script>
</body>
</html>