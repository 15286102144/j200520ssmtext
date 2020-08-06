package com.hqyj.service;

import com.hqyj.pojo.Department;
import com.hqyj.pojo.Employer;

import java.util.HashMap;
import java.util.List;

public interface EmployerService {
    HashMap<String, Object> selectByPage(Employer emp);
    //根据id查询
    Employer selectByid(Integer id);
    //修改
   int update(Employer emp);
   //删除
    int delete(Integer id);
    //添加
    int insert(Employer emp);
    //部门
    List<Department> select();

    int del(List<String> list);
}
