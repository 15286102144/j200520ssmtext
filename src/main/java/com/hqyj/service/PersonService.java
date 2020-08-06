package com.hqyj.service;

import com.hqyj.pojo.Person;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface PersonService {
    String checkLogin(Person p, String remenber, HttpServletResponse response,HttpServletRequest request);

    void fjii();

    Person queryCookie(HttpServletRequest request);
}
