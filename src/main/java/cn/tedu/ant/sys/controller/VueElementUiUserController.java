package cn.tedu.ant.sys.controller;


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
import java.util.Map;

/**
 *
 * vue页面的用户功能   testUserController2+2+2
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
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/queryUserView")
    public ModelAndView queryUserView(HttpServletRequest request, HttpServletResponse response){
        ModelAndView mav = new ModelAndView("/user/vueEle/user_query_list_page");
        return mav;
    }

    /**
     * 查询用户信息
     * @return
     */
    @RequestMapping("/queryUserData")
    @ResponseBody
    public String queryUserData(@RequestBody Map<String, Object> map){
        JSONObject jsonObject = new JSONObject();
        Page<User> pager = iUserService.getUserByMap(map);
        jsonObject.put("map", map);
        jsonObject.put("page", pager);
        return jsonObject.toJSONString();
    }

    /**
     * 保存新增用户信息
     * @return
     */
    @RequestMapping("/saveAddUser")
    @ResponseBody
    public boolean saveAddUser(@RequestBody User user){
        return iUserService.save(user);
    }

    /**
     * 保存修改用户信息
     * @return
     */
    @RequestMapping("/saveSetUser")
    @ResponseBody
    public boolean saveSetUser(@RequestBody User user){
        return iUserService.updateById(user);
    }

    /**
     * 删除用户信息
     * @return
     */
    @RequestMapping("/deleteUser")
    @ResponseBody
    public boolean deleteUser(@RequestBody User user){
        return iUserService.removeById(user.getId());
    }

    /**
     * 获取用户详情--数据
     * @param param
     * @return
     */
    @RequestMapping("/userDetailData")
    @ResponseBody
    public String userDetailData(@RequestBody User param){
        User user = iUserService.getById(param.getId());
        return JSONObject.toJSONString(user);
    }

}

