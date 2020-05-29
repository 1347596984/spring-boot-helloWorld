package cn.tedu.ant.sys.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import javax.validation.constraints.*;
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
    @NotEmpty(message = "名称不能为空")
    private String name;

    //updateStrategy    该字段可以设置为null
    @TableField(value = "age", updateStrategy = FieldStrategy.IGNORED)
    @NotNull(message = "年龄不能为空")
    @Max(value = 999, message = "年龄最大不能超过3位数")
    @Min(value = 1, message = "年龄最小不能小于1")
    private Integer age;

    @TableField(value = "email")
    @NotEmpty(message = "邮箱不能为空")
    @Email(message = "邮箱格式错误")
    private String email;

    @TableField(value = "birthday")
    @NotNull(message = "出生日期不能为空")
    @Past(message = "日期不能大于现在")
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
