package com.hqyj.service.impl;

import com.hqyj.pojo.Person;
import com.hqyj.service.PersonService;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Service;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Service
public class PersonServiceimpl implements PersonService {
    //生成随机字符串
    String filename1= RandomStringUtils.randomAlphanumeric(10);
    String filename2= RandomStringUtils.randomAlphanumeric(10);
    public String checkLogin(Person p, String remenber, HttpServletResponse response,HttpServletRequest request) {
        //1.拿到当前用户
        Subject s = SecurityUtils.getSubject();
        //2.判断当前用户是否被认证，并做相关处理
        if (!s.isAuthenticated()) {
            //UsernamePasswordToken 令牌类  稍后会把保存在里面账号密码和shiro的身份和凭证比对
            UsernamePasswordToken upt = new UsernamePasswordToken(p.getPersonName(), p.getPersonPassword());
            upt.setRememberMe(true);
            try {
                //进行认证(因为我们写了自定义的realm类，所以会自动到realm类里面去认证)
                s.login(upt);
                //登录成功
                s.getSession().setAttribute("userName", p.getPersonName());
               if ("YES".equals(remenber)){
                   //1创建cookie
                   Cookie cookie1=new Cookie("USERNAME", p.getPersonName());
                   //密码加上随机字符串
                   Cookie cookie2=new Cookie("PASSWORD", filename1+p.getPersonPassword()+filename2);
                   //2设置cookie时间
                   cookie1.setMaxAge(60);
                   cookie2.setMaxAge(60);
                   //3回写给浏览器
                   response.addCookie(cookie1);
                   response.addCookie(cookie2);
               }
               if ("NO".equals(remenber)){
                   Cookie[] cookies=request.getCookies();
                   for (Cookie c : cookies) {
//                       if (c.getName().equals("USERNAME")){
//
//                       }
                       c.setMaxAge(0);
                   }
                }
                return "success";
            } catch (AuthenticationException e) {
                //登录失败
                return "ERROR";
            }
        }
        return null;
    }

    @Override
    @RequiresRoles(value={"admin", "user"}, logical= Logical.AND)
    public void fjii() {
        System.out.println("测试");
    }

    @Override
    public Person queryCookie(HttpServletRequest request) {
        Cookie[] cookies=request.getCookies();
        Person p=new Person();
        if (cookies!=null){
            for (Cookie cookie : cookies) {
                if ("USERNAME".equals(cookie.getName())){
                    p.setPersonName(cookie.getValue());
                }
                if ("PASSWORD".equals(cookie.getName())){
                    //将cookie中随机字符串中密码取出来
                    p.setPersonPassword(cookie.getValue().substring(10,13));
                }
            }
            return p;
        }
        return null;
    }

}
