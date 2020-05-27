package cn.tedu.ant.sys.controller;


import cn.tedu.ant.sys.entity.User;
import cn.tedu.ant.sys.service.IUserService;
import cn.tedu.common.BaseController;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * <p>
 *  前端控制器 testUserController
 * </p>
 *
 * @author zjp
 * @since 2020-05-22
 */
@RestController
@RequestMapping("/sys/user")
public class UserController extends BaseController {

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
        ModelAndView mav = new ModelAndView("/user/user_query_list_page");
        return mav;
    }

    /**
     * 查询用户信息--数据
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/queryUserData")
    public Page queryUserData(HttpServletRequest request, HttpServletResponse response){
        Map<String, Object> map = super.getRequestParamter(request);
        Page<User> pager = iUserService.getUserByMap(map);
        return pager;
    }


    /**
     * 新增用户页面
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/addUser")
    public ModelAndView addUser(HttpServletRequest request, HttpServletResponse response){
        ModelAndView mav = new ModelAndView("/user/user_add");
        return mav;
    }

    /**
     * 保存新增用户信息
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/saveAddUser")
    @ResponseBody
    public boolean saveAddUser(HttpServletRequest request, HttpServletResponse response){
        Map<String, Object> map = super.getRequestParamter(request);
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
        ModelAndView mav = new ModelAndView("/user/user_update");
        Map<String, Object> map = super.getRequestParamter(request);
        mav.addObject("result", iUserService.getById(Integer.valueOf(String.valueOf(map.get("id")))));
        mav.addObject("map", map);
        return mav;
    }

    /**
     * 保存修改用户信息
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/saveSetUser")
    @ResponseBody
    public int saveSetUser(HttpServletRequest request, HttpServletResponse response){
        Map<String, Object> map = super.getRequestParamter(request);
        return iUserService.saveSetUserByMap(map);
    }

    /**
     * 删除用户信息
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/deleteUser")
    @ResponseBody
    public boolean deleteUser(HttpServletRequest request, HttpServletResponse response){
        Map<String, Object> map = super.getRequestParamter(request);
        return iUserService.removeById(Integer.valueOf(String.valueOf(map.get("id"))));
    }

    /**
     * 用户详情
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/userDetail")
    public ModelAndView userDetail(HttpServletRequest request, HttpServletResponse response){
        ModelAndView mav = new ModelAndView("/user/user_detail");
        Map<String, Object> map = super.getRequestParamter(request);
        User user = iUserService.getById(Integer.valueOf(String.valueOf(map.get("id"))));
        mav.addObject("result", user);
        return mav;
    }

}

