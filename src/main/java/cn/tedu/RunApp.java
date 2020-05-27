package cn.tedu;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
@ServletComponentScan
@MapperScan("cn.tedu.ant.*.mapper")//启动类中添加这句，扫描dao文件       第二次提交测试
//("com.baomidou.springboot.*.mapper")
public class RunApp extends SpringBootServletInitializer {
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(RunApp.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(RunApp.class, args);
    }
}
