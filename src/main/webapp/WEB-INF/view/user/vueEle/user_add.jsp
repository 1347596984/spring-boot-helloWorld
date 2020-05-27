<%@page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>用户新增</title>
    <!-- import CSS -->
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <!-- import Vue before Element -->
    <script type="text/javascript" src="/vue/vue.js"></script>
    <!-- import JavaScript -->
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
    <!-- import 异步 -->
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <style>
        #saveButtion{
            display: block;
            text-align: center
        }
    </style>
</head>
<body>
<div id="app" style="width: 100%;">
    <el-form :model="ruleForm" :inline="true" :rules="rules" ref="ruleForm" label-width="200px" class="demo-form-inline">
        <el-form-item label="名称" prop="name">
            <el-input v-model="ruleForm.name" maxlength="30"></el-input>
        </el-form-item>
        <el-form-item label="年龄" prop="age">
            <el-input type="age" v-model.number="ruleForm.age" onkeyup="this.value=this.value.replace(/[^\d.]/g,'');"
                      maxlength="3" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="邮箱" prop="email">
            <el-input v-model="ruleForm.email" maxlength="30"></el-input>
        </el-form-item>
        <el-form-item label="出生日期" prop="birthday">
            <el-date-picker v-model="ruleForm.birthday" type="date"
                            placeholder="选择日期" format="yyyy 年 MM 月 dd 日" value-format="yyyy-MM-dd"></el-date-picker>
        </el-form-item>
        <el-form-item id="saveButtion">
            <el-button type="primary" @click="submitForm('ruleForm')">保存</el-button>
            <el-button @click="resetForm('ruleForm')">重置</el-button>
        </el-form-item>
    </el-form>
</div>
<script>
   var vm =  new Vue({
        el: '#app',
        data() {
            var checkEmail = (rule, value, callback) => {
                if (!value) {
                    return callback(new Error('邮箱不能为空'));
                }
                setTimeout(() => {
                    if (!/^([a-zA-Z0-9]+[-_\.]?)+@[a-zA-Z0-9]+\.[a-z]+$/.test(value)) {
                        callback(new Error('请输入正确邮箱'));
                    } else {
                        callback();
                    }
                }, 1000);
            };
            var checkBirthday = (rule, value, callback) => {
                if (!value) {
                    return callback(new Error('出生日期不能为空'));
                } else{
                    callback();
                }
            };
            return {
                ruleForm: {
                    name: '',
                    birthday: '',
                    age: '',
                    email: '',
                },
                rules: {
                    name: [
                        { required: true, message: '请输入名称', trigger: 'blur' },
                        { min: 1, max: 10, message: '长度在 1 到 10 个字符', trigger: 'blur' }
                    ],
                    age: [
                        { required: true, message: '请输入年龄', trigger: 'blur' },
                    ],
                    email: [
                        { validator: checkEmail, trigger: 'blur' }
                    ],
                    birthday: [
                        { validator: checkBirthday, trigger: 'blur' }
                    ],
                }
            };
        },
        methods: {
            submitForm(formName) {
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        axios.post('<%=request.getContextPath()%>/sys/user/ele/saveAddUser', this.ruleForm).then(function (response) {  //处理后台返回的数据。
                            if(response.data){
                                vm.$message({
                                    message: '保存成功',
                                    showClose: true,
                                    type: 'success',
                                    onClose: function(){
                                        window.parent.layer.closeAll();
                                        window.parent.query();
                                    }
                                });
                            } else {
                                vm.$message({
                                    message: '用户信息保存失败',
                                    showClose: true,
                                    type: 'error'
                                });
                            }
                        }).catch(function (error) {  //发生错误时的处理
                            vm.$message({
                                message: '用户信息保存失败',
                                showClose: true,
                                type: 'error'
                            });
                        });
                    } else {
                        this.$message({
                            message: '请填写完必填项',
                            showClose: true,
                            type: 'warning'
                        });
                        return false;
                    }
                });
            }
        }
    })
</script>
</body>
</html>