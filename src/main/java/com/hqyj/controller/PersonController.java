package com.hqyj.controller;

import com.hqyj.pojo.Person;
import com.hqyj.service.PersonService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * @ClassName UserController
 * @Description TODO
 * @Author ss
 * @Date 2020/7/28 14:44
 * @Version 1.0
 */
@Controller
@RequestMapping("pc")
public class PersonController {
    @Autowired
    private PersonService ps;

    @RequestMapping("checkLogin.ajax")
    @ResponseBody
    public String checkLogin(Person p, String remenber, HttpServletResponse response,HttpServletRequest request){
        //交给业务层来进行 shiro认证
        String info = ps.checkLogin(p,remenber,response,request);
        return info;
    }
    @RequestMapping("logout.do")
    public String logout(){
        return "index";
    }
    @RequestMapping("showWelcome.do")
    public String showWelcome(){
        return "welcome";
    }
    @RequestMapping(value = "logout.ajax",produces = "application/json;charset=utf-8")
    @ResponseBody
    public Person logoutajax(HttpServletRequest request){
        Subject subject= SecurityUtils.getSubject();
        subject.logout();
       Person p= ps.queryCookie(request);
      return p;
    }
    @RequestMapping("text.do")
    public String losgoutajax(){
      ps.fjii();
      return "";
    }
}
