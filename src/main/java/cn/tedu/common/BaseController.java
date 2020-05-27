package cn.tedu.common;

import javax.servlet.http.HttpServletRequest;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

public class BaseController {

    /**
     * 获取request中的参数，如果请求中没有分页相关参数，则默认当前页数为1、1页10条
     * @param request
     * @return
     */
    public Map<String, Object> getRequestParamter(HttpServletRequest request){
        Map<String, Object> map = new HashMap<String, Object>();
        Enumeration enu=request.getParameterNames();
        while(enu.hasMoreElements()){
            String paraName=(String)enu.nextElement();
            map.put(paraName, request.getParameter(paraName));
        }
        //如果请求中没有分页相关参数，则默认当前页数为1、1页10条
        String current = request.getParameter("current");
        if(current != null && !"".equals(current)){
            map.put("current", current);
        } else {
            map.put("current", 1);
        }
        String size = request.getParameter("size");
        if(size != null && !"".equals(size)){
            map.put("size", size);
        } else {
            map.put("size", 10);
        }
        return map;
    }

}
