package cn.tedu.ant.sys.service.impl;

import cn.tedu.ant.sys.entity.User;
import cn.tedu.ant.sys.mapper.UserMapper;
import cn.tedu.ant.sys.service.IUserService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.conditions.query.LambdaQueryChainWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author zjp
 * @since 2020-05-22
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {


    @Override
    public boolean saveAddUserByMap(Map<String, Object> map) {
        User user = new User();
        user.setName(String.valueOf(map.get("name")));
        user.setEmail(String.valueOf(map.get("email")));
        if(!isEmpty(map.get("age"))) {
            user.setAge(Integer.valueOf(String.valueOf(map.get("age"))));
        }
        if(!isEmpty(map.get("birthday"))){
            user.setBirthday(LocalDate.parse(String.valueOf(map.get("birthday"))));
        }
        return super.save(user);
    }

    @Override
    public Page<User> getUserByMap(Map<String, Object> map) {

        Page<User> page = new Page<>(Integer.valueOf(String.valueOf(map.get("page"))), Integer.valueOf(String.valueOf(map.get("limit"))));
        LambdaQueryChainWrapper<User> lambdaQuerywrapper = super.lambdaQuery();
        //姓名
        return lambdaQuerywrapper.like(!isEmpty(map.get("name")), User::getName, String.valueOf(map.get("name")))
                          .like(!isEmpty(map.get("email")), User::getEmail, String.valueOf(map.get("email")))
                          .ge(!isEmpty(map.get("age_start")), User::getAge, String.valueOf(map.get("age_start")))
                          .le(!isEmpty(map.get("age_end")), User::getAge, String.valueOf(map.get("age_end")))
                          .ge(!isEmpty(map.get("birthday_start")), User::getBirthday, String.valueOf(map.get("birthday_start")))
                          .le(!isEmpty(map.get("birthday_end")), User::getBirthday, String.valueOf(map.get("birthday_end")))
                          .page(page);
    }

    /**
     * 如果该字符串为null或""，则返回false， 否则返回true
     * @param objIn
     * @return
     */
    private static boolean isEmpty(Object objIn){
        if (objIn == null){
            return true;
        }

        return objIn.toString().trim().length() <= 0;
    }

    @Override
    public int saveSetUserByMap(Map<String, Object> map) {
        User user = new User();
        user.setId(Integer.valueOf(String.valueOf(map.get("id"))));
        user.setName(String.valueOf(map.get("name")));
        user.setEmail(String.valueOf(map.get("email")));

        if(!isEmpty(map.get("age"))){
            user.setAge(Integer.valueOf(String.valueOf(map.get("age"))));
        }
        if(!isEmpty(map.get("birthday"))){
            user.setBirthday(LocalDate.parse(String.valueOf(map.get("birthday"))));
        }
        return super.getBaseMapper().updateById(user);
    }

    @Override
    public boolean saveSetUserByMapReturnBoolean(Map<String, Object> map) {
        User user = new User();
        user.setId(Integer.valueOf(String.valueOf(map.get("id"))));
        user.setName(String.valueOf(map.get("name")));
        user.setEmail(String.valueOf(map.get("email")));

        if(!isEmpty(map.get("age"))){
            user.setAge(Integer.valueOf(String.valueOf(map.get("age"))));
        }
        if(!isEmpty(map.get("birthday"))){
            user.setBirthday(LocalDate.parse(String.valueOf(map.get("birthday"))));
        }
        return super.updateById(user);
    }
}
