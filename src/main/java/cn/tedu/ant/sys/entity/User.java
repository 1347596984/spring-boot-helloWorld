package cn.tedu.ant.sys.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.time.LocalDate;
import java.io.Serializable;

/**
 * <p>
 * 
 * </p>
 *
 * @author zjp
 * @since 2020-05-22
 */
@TableName(value = "user")
public class User implements Serializable {

    private static final long serialVersionUID=1L;

//    @TableId(value = "id", type = IdType.INPUT)
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField(value = "name")
    private String name;

    //updateStrategy    该字段可以设置为null
    @TableField(value = "age", updateStrategy = FieldStrategy.IGNORED)
    private Integer age;

    @TableField(value = "email")
    private String email;

    @TableField(value = "birthday")
    private LocalDate birthday;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public LocalDate getBirthday() {
        return birthday;
    }

    public void setBirthday(LocalDate birthday) {
        this.birthday = birthday;
    }

    @Override
    public String toString() {
        return "User{" +
        "id=" + id +
        ", name=" + name +
        ", age=" + age +
        ", email=" + email +
        ", birthday=" + birthday +
        "}";
    }
}
