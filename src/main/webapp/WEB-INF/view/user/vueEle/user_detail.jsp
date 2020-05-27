<%@page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>用户详细</title>
    <!-- import CSS -->
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <!-- import Vue before Element -->
    <script type="text/javascript" src="/vue/vue.js"></script>
    <!-- import JavaScript -->
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
    <!-- import 异步 -->
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>

    <style>
        .query{
            background-color: #acd6ef;
            border: none;
            text-align: right;
        }

    </style>
</head>
<body>
<div id="app" style="width: 100%;">
    <el-form :model="ruleForm" :inline="true" ref="ruleForm" label-width="200px" class="demo-form-inline">
        <el-form-item label="名称" prop="name">
            <el-input v-model="ruleForm.name" :disabled="true"></el-input>
        </el-form-item>
        <el-form-item label="年龄" prop="age">
            <el-input type="age" v-model.number="ruleForm.age" :disabled="true" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="邮箱" prop="email">
            <el-input v-model="ruleForm.email" :disabled="true"></el-input>
        </el-form-item>
        <el-form-item label="出生日期" prop="birthday">
            <el-date-picker v-model="ruleForm.birthday" type="date" :disabled="true"
                            placeholder="选择日期" format="yyyy 年 MM 月 dd 日" value-format="yyyy-MM-dd"></el-date-picker>
        </el-form-item>
    </el-form>
</div>
<script>
    var detailDataVue = {
        ruleForm: {
            name: '',
            birthday: '',
            email: '',
            age: '',
            id: ${map.id}
        }
    };
    var vm = new Vue({
        el: '#app',
        data: detailDataVue,
        methods:{
            queryUserData: function(){
                axios.post('<%=request.getContextPath()%>/sys/user/ele/userDetailData' , this.ruleForm).then(function(response){
                    console.log("data", response.data);
                    detailDataVue.ruleForm = response.data
                }).catch(function(error){
                    vm.$message({
                        message: '用户信息获取失败，请刷新页面',
                        showClose: true,
                        type: 'error'
                    });
                })
            }
        },
        mounted(){
            this.queryUserData();
        }
    })
</script>
</body>
</html>