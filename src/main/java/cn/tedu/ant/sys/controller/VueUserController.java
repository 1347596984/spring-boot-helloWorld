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
 * vue页面的用户功能   testUserConttroller3
 * <p>
 *  前端控制器
 * </p>
 *
 * @author zjp
 * @since 2020-05-22
 */
@RestController
@RequestMapping("/sys/user/vue")
public class VueUserController extends BaseController {

    @Autowired
    private IUserService iUserService;

    /**
     * 查询用户信息
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/queryUser")
    public ModelAndView queryUser(HttpServletRequest request, HttpServletResponse response){
        ModelAndView mav = new ModelAndView("/user/user_query_list");
        Map<String, Object> map = super.getRequestParamter(request);

        Page<User> iPage = iUserService.getUserByMap(map);

        mav.addObject("page", iPage);
        mav.addObject("map", map);
        return mav;

    }

    /**
     * 查询用户信息页面
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/queryUserView")
    public ModelAndView queryUserView(HttpServletRequest request, HttpServletResponse response){
        ModelAndView mav = new ModelAndView("/user/vue/user_query_list_page");
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
     * 新增用户页面
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/addUser")
    public ModelAndView addUser(HttpServletRequest request, HttpServletResponse response){
        ModelAndView mav = new ModelAndView("/user/vue/user_add");
        return mav;
    }

    /**
     * 保存新增用户信息
     * @return
     */
    @RequestMapping("/saveAddUser")
    @ResponseBody
    public boolean saveAddUser(@RequestBody Map<String, Object> map){
//        Map<String, Object> map = super.getRequestParamter(request);
        return iUserService.saveAddUserByMap(map);
    }

    /**
     * 维护用户页面
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/setUser")
    public ModelAndView setUser(HttpServletRequest request, HttpServletResponse response){
        ModelAndView mav = new ModelAndView("/user/vue/user_update");
        Map<String, Object> map = super.getRequestParamter(request);
        User user = iUserService.getById(Integer.valueOf(String.valueOf(map.get("id"))));
        mav.addObject("result", user);
        mav.addObject("resultJSON", JSONObject.toJSONString(user));
        mav.addObject("map", map);
        return mav;
    }

    /**
     * 保存修改用户信息
     * @return
     */
    @RequestMapping("/saveSetUser")
    @ResponseBody
    public boolean saveSetUser(@RequestBody Map<String, Object> map){
//        Map<String, Object> map = super.getRequestParamter(request);
        return iUserService.saveSetUserByMapReturnBoolean(map);
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
     * 用户详情
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/userDetailVue")
    public ModelAndView userDetailVue(HttpServletRequest request, HttpServletResponse response){
        ModelAndView mav = new ModelAndView("/user/vue/user_detail");
        Map<String, Object> map = super.getRequestParamter(request);
        User user = iUserService.getById(Integer.valueOf(String.valueOf(map.get("id"))));
        mav.addObject("resultJSON", JSONObject.toJSONString(user));
        mav.addObject("map", map);
        return mav;
    }


    /**
     * 用户详情---页面
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/userDetailVueView")
    public ModelAndView userDetailVueView(HttpServletRequest request, HttpServletResponse response){
        ModelAndView mav = new ModelAndView("/user/vue/user_detail");
        Map<String, Object> map = super.getRequestParamter(request);
        mav.addObject("map", map);
        return mav;
    }

    /**
     * 获取用户详情--数据
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/userDetailData")
    @ResponseBody
    public String userDetailData(HttpServletRequest request, HttpServletResponse response){
        Map<String, Object> map = super.getRequestParamter(request);
        User user = iUserService.getById(Integer.valueOf(String.valueOf(map.get("id"))));
        return JSONObject.toJSONString(user);
    }

}

