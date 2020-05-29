package cn.tedu.ant.sys.controller;


import cn.tedu.ant.sys.entity.JSONResult;
import cn.tedu.ant.sys.entity.User;
import cn.tedu.ant.sys.service.IUserService;
import cn.tedu.common.BaseController;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.util.Map;

/**
 *
 * vue页面的用户功能
 * <p>
 *  前端控制器
 * </p>
 *
 * @author zjp
 * @since 2020-05-22
 */
@RestController
@RequestMapping("/sys/user/ele")
public class VueElementUiUserController extends BaseController {

    @Autowired
    private IUserService iUserService;

    /**
     * 查询用户信息页面
     * @return
     */
    @RequestMapping("/queryUserView")
    public ModelAndView queryUserView(){
        ModelAndView mav = new ModelAndView("/user/vueEle/user_query_list_page");
        return mav;
    }

    /**
     * 查询用户信息
     * @return
     */
    @RequestMapping("/queryUserData")
    @ResponseBody
    public JSONResult queryUserData(@RequestBody Map<String, Object> map){
        Page<User> pager = iUserService.getUserByMap(map);
        JSONResult<Page> jsonResult = new JSONResult<Page>();
        jsonResult.setCode(JSONResult.OK);
        jsonResult.setMsg("查询成功");
        jsonResult.setData(pager);
        return jsonResult;
    }

    /**
     * 保存新增用户信息
     * @return
     */
    @RequestMapping("/saveAddUser")
    @ResponseBody
    public JSONResult saveAddUser(@RequestBody @Valid User user){
        JSONResult<Boolean> jsonResult = new JSONResult<Boolean>();
        jsonResult.setCode(JSONResult.OK);
        jsonResult.setMsg("保存成功");
        jsonResult.setData(iUserService.save(user));
        return jsonResult;
    }

    /**
     * 保存修改用户信息
     * @return
     */
    @RequestMapping("/saveSetUser")
    @ResponseBody
    public JSONResult saveSetUser(@RequestBody @Valid User user){
        JSONResult<Boolean> jsonResult = new JSONResult<Boolean>();
        jsonResult.setCode(JSONResult.OK);
        jsonResult.setMsg("保存成功");
        jsonResult.setData(iUserService.updateById(user));
        return jsonResult;
    }

    /**
     * 删除用户信息
     * @return
     */
    @RequestMapping("/deleteUser")
    @ResponseBody
    public JSONResult deleteUser(@RequestBody Integer id){
        JSONResult<Boolean> jsonResult = new JSONResult<Boolean>();
        jsonResult.setCode(JSONResult.OK);
        jsonResult.setMsg("删除成功");
        jsonResult.setData(iUserService.removeById(id));
        return jsonResult;
    }


    /**
     * 获取用户详情--数据
     * @param id
     * @return
     */
    @RequestMapping("/userDetailData")
    @ResponseBody
    public JSONResult userDetailData(@RequestBody Integer id){
        JSONResult<User> jsonResult = new JSONResult<User>();
        jsonResult.setCode(JSONResult.OK);
        jsonResult.setMsg("查询成功");
        jsonResult.setData(iUserService.getById(id));
        return jsonResult;
    }

}

