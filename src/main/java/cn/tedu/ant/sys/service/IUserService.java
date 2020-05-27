package cn.tedu.ant.sys.service;

import cn.tedu.ant.sys.entity.User;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.Map;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author zjp
 * @since 2020-05-22
 */
public interface IUserService extends IService<User> {

    /**
     * 通过map保存user信息
     * @param map
     * @return
     */
    boolean saveAddUserByMap(Map<String, Object> map);


    /**
     * 查询user信息
     * @param map
     * @return
     */
    Page<User> getUserByMap(Map<String, Object> map);

    /**
     * 通过map修改user信息
     * @param map
     * @return
     */
    int saveSetUserByMap(Map<String, Object> map);

    /**
     * 通过map修改user信息
     * @param map
     * @return
     */
    boolean saveSetUserByMapReturnBoolean(Map<String, Object> map);

}
