package user;

import cn.tedu.RunApp;
import cn.tedu.ant.sys.entity.User;
import cn.tedu.ant.sys.service.IUserService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.core.toolkit.support.SFunction;
import com.baomidou.mybatisplus.extension.conditions.query.LambdaQueryChainWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@RunWith(SpringJUnit4ClassRunner.class)
@SpringBootTest(classes = RunApp.class)
@WebAppConfiguration
public class UserTest {

    @Autowired
    private IUserService iUserService;

    public User getUser(){
        User user = new User();
        user.setName("张三");
        user.setAge(21);
        user.setId(32);
        user.setEmail("12");
        user.setBirthday(LocalDate.parse("2020-04-30"));
        return user;
    }
    public Map<String, Object> getMap(){
        Map<String, Object> map = new HashMap<>();
//        map.put("id", "");
//        map.put("name", "t");
        map.put("age", "6");
//        map.put("email", "");
//        map.put("birthday", "");
        return map;
    }

    @Test
    public void testQueryUserFun(){
        User user = getUser();
        Map<String, Object> map = getMap();
        Map<SFunction<User, ?>, Object> map2 = new HashMap<>();

        LambdaQueryChainWrapper<User> lambdaQuerywrapper = iUserService.lambdaQuery();
//        List<User> list = lambdaQuerywrapper.allEq(true, (k, v) -> k.apply(user).equals(user.getName()), map2, true).list();

//        List<User> listMap = lambdaQuerywrapper.getBaseMapper().selectByMap(map);
//        listMap.forEach(System.out::println);
//        System.out.println("--------------------------------------------------");

        List<User> list = lambdaQuerywrapper
                //该查询条件为 (age = 4  and name = 4) or ( age = 11and name = 11)
//                .and(i->i.eq(User::getAge, "4").eq(User::getName, "4"))
//                .or(i->i.eq(User::getAge, "11").eq(User::getName, "11"))

                //该查询条件为 (age = 21) or (name like %张三% and age = 2) or (age = 2)
//                .eq(User::getAge, user.getAge())
//                .or().like(User::getName, user.getName())
//                .and(i -> i.eq(User::getAge, "2"))
//                .or().eq(User::getAge, "2")

                //该查询条件为 (age = 21) or (name like %张三% and age = 2) or (age = 2)
//                .eq(User::getAge, user.getAge())
//                .or(i -> i.like(User::getName, user.getName()).eq(User::getAge, "23"))
//                .or(i -> i.eq(User::getAge, 2))


//                .between(User::getAge, 11, 0)

                //根据group by birthday having birthday >= 2020-05-12
                .groupBy(User::getBirthday)
                .having( "birthday > date('2020-05-12')")


                .list();


        list.forEach(System.out::println);
        System.out.println(list.size());

    }

    @Test
    public void newIdFun(){
        User user = new User();
        user.setId(3);
        user.setName("wangwu");
        user.setAge(23);
        user.setEmail("");
        user.setBirthday(LocalDate.parse("2020-12-21"));

//        Number id = customIdGenerator.nextId(user);
//        System.out.println(id);
    }

    @Test
    public void queryUserFun2(){
        LambdaQueryWrapper<User> qw = Wrappers.<User>lambdaQuery();
        qw.ge(User::getAge, 0);
        Page<User> page = new Page<>(2, 4);
        Page<User> iPage = iUserService.getBaseMapper().selectPage(page, qw);
        List<User> users = iPage.getRecords();
        users.forEach(System.out::println);
    }

    @Test
    public void queryUserFun(){
        LambdaQueryWrapper<User> qw = Wrappers.<User>lambdaQuery();
        qw.ge(User::getAge, 18);
        Page<User> page = new Page<>(0, 0);
        Page<User> iPage = iUserService.getBaseMapper().selectPage(page, qw);
        System.out.println("总页数：" + iPage.getPages());
        System.out.println("总数：" + iPage.getTotal());
        System.out.println("页数：" + iPage.getSize());
        System.out.println("页码：" + iPage.getCurrent());
        List<User> records = iPage.getRecords();
        records.forEach(System.out::println);
        System.out.println("---------------------");

        Page page1 = new Page(0, 0);
        IPage<Map<String, Object>> iPage1 = iUserService.getBaseMapper().selectMapsPage(page1, qw);
        System.out.println("总页数：" + iPage1.getPages());
        System.out.println("总数：" + iPage1.getTotal());
        System.out.println("页数：" + iPage1.getSize());
        System.out.println("页码：" + iPage1.getCurrent());


//        User user = new User();
//        user.setAge("23");
//        QueryChainWrapper<User> queryChainWrapper = iUserService.query().eq("id", "1");
//        System.out.println(queryChainWrapper);
//        mysqlMapper.getAll(Wrappers.<MysqlData>lambdaQuery().eq(MysqlData::getGroup, 1));

//        LambdaQueryWrapper<User> lambdaQueryWrapper = new QueryWrapper<User>().lambda().ge(user);
//        LambdaQueryWrapper<User> lambdaQueryWrapper = iUserService.getBaseMapper().selectList();

    }

    @Test
    public void setUserFun(){
        User user = new User();
        user.setId(3);
        user.setName("wangwu");
        user.setAge(23);
        user.setEmail("");
        user.setBirthday(LocalDate.parse("2020-12-21"));
        System.out.println(iUserService.getBaseMapper().updateById(user));
    }

    @Test
    public void addUserFun(){
        User user = new User();
        user.setName("lishi");
        user.setAge(23);
        user.setEmail("123@qq.com");
        user.setBirthday(LocalDate.of(2012, 2, 3));
        System.out.println(iUserService.save(user));
    }

    @Test
    public void delUserFun(){
        System.out.println(iUserService.getBaseMapper().deleteById("3"));
    }

    @Test
    public void fun2(){
        User user = iUserService.getById("1");
        System.out.println(user);
//        UserExample userExample = new UserExample();
//        UserExample.Criteria criteria = userExample.createCriteria();
//        criteria.andUsernameNotEqualTo("arong");
//        List<User> users = userMapper.selectByExample(userExample);
//        for (User user : users) {
//            System.out.println(user.getUsername());
//        }

    }
}
