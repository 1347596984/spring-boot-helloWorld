package user;

import cn.tedu.ant.sys.entity.User;

import java.time.LocalDate;
import java.util.*;

public class Test {

    public static void main(String[] args) {
//        forEachList();
        TestDD testdd = new TestDD();
        testdd.a();

//        List<Integer> list = Arrays.asList(1,2,3,4,5,6,7);
        //list每个元素进行+1操作，并输出
//        list.stream().map((x) -> ++x).forEach(System.out::println);

//        new Thread(() -> System.out.println("1111")).start();

//        testInterface(() -> System.out.println("1"));


//        testInterfaceFun((Integer i) -> System.out.println("hello World" + i));
    }

    private static void testInterfaceFun(TestInterface testInterface){
        int i = 2;
        testInterface.test(i);
    }

    //lambda循环list
    public static void forEachList(){
        List<User> list = new ArrayList<User>();
        for(int i = 0; i < 8; i++){
            User user = new User();
            user.setId(i);
            user.setName(i + "");
            user.setAge(i);
            user.setEmail(i + "");
            user.setBirthday(LocalDate.now());
            list.add(user);
        }
        //循环输出user数量
        list.stream().forEach(user -> {
            System.out.println(user.toString());
        });
        System.out.println("-------------------------");
        list.forEach(System.out::println);
        System.out.println("-------------------------");
        //循环统计userId ==1的user数量
        long count = list.stream().filter((user -> user.getId() == 1)).count();
        System.out.println(count);

    }
}

 interface  TestInterface<T>{
    void test();
    void test(T param);
}
 interface A{
    default void a (){
        System.out.println("a-a");
    }
}
 interface B{
    default void a (){
        System.out.println("b-a");
    }
}

class TestDD implements A, B{

    @Override
    public void a() {
        System.out.println("testdd-a");
        A.super.a();
        B.super.a();
    }
}