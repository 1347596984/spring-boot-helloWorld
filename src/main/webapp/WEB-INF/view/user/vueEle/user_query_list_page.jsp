<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>用户信息查询</title>
    <!-- import CSS -->
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <!-- import Vue before Element -->
    <script type="text/javascript" src="/vue/vue.js"></script>
    <!-- import JavaScript -->
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
    <!-- import 异步 -->
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>

    <style>
        .el-table td, .el-table th {
            text-align: center!important;
        }
        .el-form--inline .saveButtion{
            display: block;
            text-align: center;
        }
    </style>

</head>
<body>
<div style="width: 100%;" id="bodyDiv">
    <%--查询项--%>
        <el-card class="box-card">
            <span>名称：</span>
            <el-input v-model="queryParam.name" style="width:200px;" :clearable="true"></el-input>
        <span>年龄：</span>
        <el-input-number v-model="queryParam.age_start" controls-position="right"
                             @change="checkStartAge" :min="1" :max="queryParam.age_end" style="width:200px;"></el-input-number>

            -
            <el-input-number v-model="queryParam.age_end" controls-position="right"
                             @change="checkEndAge" :min="queryParam.age_start" :max="999" style="width:200px;"></el-input-number>

        <span>邮箱：</span>
        <el-input v-model="queryParam.email" style="width:200px;"></el-input>

        <span>出生日期：</span>
            <el-date-picker
                    v-model="queryParam.birthday"
                    type="daterange"
                    format="yyyy 年 MM 月 dd 日" value-format="yyyy-MM-dd"
                    @change="updateQueryParamDate"
                    range-separator="至"
                    start-placeholder="开始日期"
                    end-placeholder="结束日期" style="width:300px;">
            </el-date-picker>

            <el-button type="primary" size="medium" @click="query">查询</el-button>
            <el-button type="warning" size="medium" @click="add">新增</el-button>
        </el-card>
    <%--列表--%>
    <el-table
            :data="page.records"
            border
            v-loading="loading"
            size="mini"
            :highlight-current-row="true"
            style="width: 100%;">
        <el-table-column type="index" label="序号" width="100px" min-width="12%" :index="indexMethod">
        </el-table-column>
        <el-table-column prop="name" label="名称" min-width="15%">
        </el-table-column>
        <el-table-column prop="age" label="年龄" min-width="13%">
        </el-table-column>
        <el-table-column prop="email" label="邮箱" min-width="20%">
        </el-table-column>
        <el-table-column prop="birthday" label="出生日期" min-width="20%">
        </el-table-column>
        <el-table-column label="操作" min-width="20%">
            <template slot-scope="scope">
                <el-button @click="edit(scope.row)" type="primary" size="small">维护</el-button>
                <el-button @click="isDeleteUser(scope.row)" type="danger" size="small">删除</el-button>
                <el-button @click="detail(scope.row)" type="success" size="small">详细</el-button>
            </template>
        </el-table-column>
    </el-table>
    <%--分页--%>
    <el-pagination
            background
            @size-change="setPageTotleQuery"
            @current-change="setPageQuery"
            @prev-click="pageQuery(-1)"
            @next-click="pageQuery(1)"
            :page-sizes="queryParam.limits"
            :page-size="page.size"
            :current-page="page.current"
            layout="total, sizes, prev, pager, next, jumper"
            :total="page.total">
    </el-pagination>

    <%--新增页面--%>
    <el-dialog
            title="用户新增"
            :visible.sync="addView"
            width="30%"
            @close="cleanUserData('userData')"
            center>
        <el-form :model="userData" :inline="true" :rules="rules" ref="userData" label-width="200px" class="demo-form-inline">
            <el-form-item label="名称" prop="name">
                <el-input v-model="userData.name" maxlength="30"></el-input>
            </el-form-item>
            <el-form-item label="年龄" prop="age">
                <el-input type="age" v-model.number="userData.age" onkeyup="this.value=this.value.replace(/[^\d.]/g,'');"
                          maxlength="3" autocomplete="off"></el-input>
            </el-form-item>
            <el-form-item label="邮箱" prop="email">
                <el-input v-model="userData.email" maxlength="30"></el-input>
            </el-form-item>
            <el-form-item label="出生日期" prop="birthday">
                <el-date-picker v-model="userData.birthday" type="date"
                                placeholder="选择日期" format="yyyy 年 MM 月 dd 日" value-format="yyyy-MM-dd"></el-date-picker>
            </el-form-item>
            <el-form-item class="saveButtion">
                <el-button type="primary" @click="saveUser('userData', 'addView')">保存</el-button>
            </el-form-item>
        </el-form>
    </el-dialog>

    <%--维护页面--%>
    <el-dialog
            title="用户维护"
            :visible.sync="editView"
            width="30%"
            @close="cleanUserData('userData')"
            center>
        <el-form :model="userData" :inline="true" :rules="rules" ref="userData" label-width="200px" class="demo-form-inline">
            <el-form-item label="名称" prop="name">
                <el-input v-model="userData.name" maxlength="30"></el-input>
            </el-form-item>
            <el-form-item label="年龄" prop="age">
                <el-input type="age" v-model.number="userData.age" onkeyup="this.value=this.value.replace(/[^\d.]/g,'');"
                          maxlength="3" autocomplete="off"></el-input>
            </el-form-item>
            <el-form-item label="邮箱" prop="email">
                <el-input v-model="userData.email" maxlength="30"></el-input>
            </el-form-item>
            <el-form-item label="出生日期" prop="birthday">
                <el-date-picker v-model="userData.birthday" type="date"
                                placeholder="选择日期" format="yyyy 年 MM 月 dd 日" value-format="yyyy-MM-dd"></el-date-picker>
            </el-form-item>
            <el-form-item class="saveButtion">
                <el-button type="primary" @click="editUser('userData', 'editView')">保存</el-button>
            </el-form-item>
        </el-form>
    </el-dialog>

    <%--详情页面--%>
    <el-dialog
            title="用户详情"
            :visible.sync="detailView"
            width="30%"
            @close="cleanUserData('userData')"
            center>
        <el-form :model="userData" label-width="200px" >
            <el-form-item label="名称:">
                {{userData.name}}
            </el-form-item>
            <el-form-item label="年龄:">
                {{userData.age}}
            </el-form-item>
            <el-form-item label="邮箱:">
                {{userData.email}}
            </el-form-item>
            <el-form-item label="出生日期">
                {{userData.birthday}}
            </el-form-item>
        </el-form>
    </el-dialog>
</div>
<script>
    var resultData = {
        /*查询相关*/
        queryParam: {
            name: '',
            age_start:  1,
            age_end: 999,
            email: '',
            birthday_start: '',
            birthday_end: '',
            birthday: ['', ''],
            page: '1',
            limit: '10',
            limits: [10, 20, 30]
        },
        page: {
            records: [],
            current: 1,
            hitCount: false,
            orders: [],
            pages: 1,
            searchCount: true,
            size: 10,
            total: 1,
        },
        /*新增相关*/
        addView: false,
        /*维护相关*/
        editView: false,
        /*详情相关*/
        detailView: false,
        loading: false,
        userData:{
            name: '',
            birthday: '',
            age: '',
            email: '',
            id: '',
        }
    };
    var vm = new Vue({
        el: '#bodyDiv',
        data: resultData,
        //页面加载自动调用
        mounted(){
            this.query();
        },
        //校验相关
        computed:{
            rules() {
                var checkEmail = (rule, value, callback) => {
                    if (!value) {
                        return callback(new Error('邮箱不能为空'));
                    }
                    if (!/^([a-zA-Z0-9]+[-_\.]?)+@[a-zA-Z0-9]+\.[a-z]+$/.test(value)) {
                        callback(new Error('请输入正确邮箱'));
                    } else {
                        callback();
                    }
                };
                var checkBirthday = (rule, value, callback) => {
                    if (!value) {
                        return callback(new Error('出生日期不能为空'));
                    } else{
                        callback();
                    }
                };
                return {
                    name: [
                        { required: true, message: '请输入名称', trigger: 'blur' },
                    ],
                    age: [
                        { required: true, message: '请输入年龄', trigger: 'blur' },
                    ],
                    email: [
                        { required: true, validator: checkEmail, trigger: 'blur' }
                    ],
                    birthday: [
                        { required: true, validator: checkBirthday, trigger: 'blur' }
                    ],
                };
            }
        },
        methods: {
            //校验数字是否为空
            checkStartAge(data){
                if(data === undefined){
                    this.$set(this.queryParam, 'age_start', 1);
                }
            },
            //校验数字是否为空
            checkEndAge(data){
                if(data === undefined){
                    this.$set(this.queryParam, 'age_end', 999);
                }
            },
            //生成序号
            indexMethod(index) {
                return (resultData.page.current - 1) * 10 + (index + 1);
            },
            //修改出生日期时，将值分别赋给birthday_start、birthday_end
            updateQueryParamDate(dates) {
                if(dates === null) {
                    resultData.queryParam.birthday_start = "";
                    resultData.queryParam.birthday_end = "";
                } else {
                    resultData.queryParam.birthday_start = dates[0];
                    resultData.queryParam.birthday_end = dates[1];
                }
            },
            //返回空的user对象
            newUser() {
                return {
                    name: '',
                    birthday: '',
                    age: '',
                    email: '',
                    id: '',
                }
            },
            //清空用户信息
            cleanUserData(item) {
                this[item] = this.newUser();
            },
            //初始化查询
            query() {
                resultData.queryParam.page = 1;
                resultData.queryParam.limit = 10;
                this.queryData();
            },
            //查询数据
            queryData(){
                resultData.loading = true;
                axios.post('<%=request.getContextPath()%>/sys/user/ele/queryUserData', this.queryParam)
                 .then(function (response){
                    resultData.queryParam = response.data.map;
                    resultData.page = response.data.page;
                    resultData.queryParam.page = response.data.page.current;
                    resultData.loading = false;
                }).catch(function (error){
                    resultData.loading = false;
                })
            },
            //上一页、下一页查询
            pageQuery(number) {
                resultData.queryParam.page = resultData.queryParam.page + number;
                this.queryData();
            },
            //点击页数
            setPageQuery(val) {
                this.queryParam.page = val;
                this.queryData();
            },
            //设置每页条数
            setPageTotleQuery(val) {
                resultData.queryParam.limit = val;
                this.queryData();
            },
            //新增
            add() {
                this.addView = true
            },
            //保存用户信息
            saveUser(formName, view){
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        axios.post('<%=request.getContextPath()%>/sys/user/ele/saveAddUser', this[formName]).then(function (response) {  //处理后台返回的数据。
                            if(response.data){
                                vm.$message({ message: '保存成功', showClose: true, duration: 1000, type: 'success',
                                    onClose: function(){
                                        vm.userData = vm.newUser();
                                        vm[view] = false;
                                        vm.query();
                                    }
                                });
                            } else {
                                vm.$message({ message: '用户信息保存失败', showClose: true, duration: 1000, type: 'error' });
                            }
                        }).catch(function (error) {  //发生错误时的处理
                            vm.$message({ message: '用户信息保存失败', showClose: true, duration: 1000, type: 'error' });
                        });
                    } else {
                        this.$message({ message: '请填写完必填项', showClose: true, duration: 1000, type: 'warning' });
                    }
                });
            },
            //维护
            edit(row) {
                this.editView = true
                this.userData.id = row.id;
                axios.post('<%=request.getContextPath()%>/sys/user/ele/userDetailData' , this.userData).then(function(response){
                    vm.userData = response.data
                }).catch(function(error){
                    vm.$message({ message: '用户信息获取失败', showClose: true, duration: 1000, type: 'error' });
                })
            },
            //保存维护信息
            editUser(formName, view){
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        axios.post('<%=request.getContextPath()%>/sys/user/ele/saveSetUser', this[formName])
                        .then(function (response) {  //处理后台返回的数据。
                            if(response.data){
                                vm.$message({message: '保存成功', showClose: true, duration: 1000, type: 'success',
                                    onClose: function(){
                                        vm.userData = vm.newUser();
                                        vm[view] = false;
                                        vm.query();
                                    }
                                });
                            } else {
                                vm.$message({ message: '用户信息保存失败', showClose: true, duration: 1000, type: 'error' });
                            }
                        }).catch(function (error) {  //发生错误时的处理
                            vm.$message({ message: '用户信息保存失败', showClose: true, duration: 1000, type: 'error'});
                        });
                    } else {
                        this.$message({ message: '请填写完必填项', showClose: true, duration: 1000, type: 'warning' });
                    }
                });
            },
            //详细
            detail(row){
                this.detailView = true
                this.userData.id = row.id;
                axios.post('<%=request.getContextPath()%>/sys/user/ele/userDetailData' , this.userData)
                    .then(function(response){
                        vm.userData = response.data
                    }).catch(function(error){
                    vm.$message({ message: '用户信息获取失败', showClose: true, type: 'error', duration: 1000 });
                })
            },
            //提示是否删除用户
            isDeleteUser(row) {
                this.$confirm('是否删除该用户?', '提示', { confirmButtonText: '是', cancelButtonText: '否', type: 'warning' })
                    .then(() => {
                        this.deleteUser(row);
                    }).catch(() => {
                    this.$message({ type: 'info', message: '已取消删除', duration: 1000});
                })
            },
            //删除用户
            deleteUser(user){
                axios.post('<%=request.getContextPath()%>/sys/user/ele/deleteUser', user).then(response => {
                    if(response.data){
                        this.$message({ type: 'success', showClose: true, message: '删除成功!', duration: 1000,
                            onClose: function(){
                                vm.query();
                            }
                        });
                    } else {
                        this.$message({ type: 'error', showClose: true, message: '删除失败!' ,duration: 1000});
                    }
                }).catch(error => {
                    this.$message({ type: 'error', showClose: true, message: '删除失败!' ,duration: 1000});
                })
            },
        },

    })
</script>
</body>
</html>