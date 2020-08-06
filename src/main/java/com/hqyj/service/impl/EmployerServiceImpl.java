package com.hqyj.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hqyj.dao.DepartmentMapper;
import com.hqyj.dao.EmployerMapper;
import com.hqyj.pojo.Department;
import com.hqyj.pojo.Employer;
import com.hqyj.service.EmployerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class EmployerServiceImpl implements EmployerService {
    @Autowired
    private EmployerMapper dao;
    @Autowired
    private DepartmentMapper depDao;

    /**
     * 查询分页
     *
     * @param emp
     * @return
     */
    public HashMap<String, Object> selectByPage(Employer emp) {
        PageHelper.startPage(emp.getPage(), emp.getRow());
        //2查询自定义的sql
        List<Employer> list = (List<Employer>) dao.selectByPage(emp);
        //3 转换成分页对象
        PageInfo<Employer> pageInfo = new PageInfo<Employer>(list);
        //构建数据类型
        HashMap<String, Object> map = new HashMap<String, Object>();
        //当前页集合
        map.put("list", pageInfo.getList());
        //总条数
        map.put("count", pageInfo.getTotal());
        //上一页
        map.put("prePage", pageInfo.getPrePage());
        //下一页
        map.put("nextPage", pageInfo.getNextPage());
        //首页
        map.put("indexPage", pageInfo.getFirstPage());
        //尾页
        map.put("endPage", pageInfo.getLastPage());
        //每页显示数
        map.put("allPage", pageInfo.getPageSize());
      //总页数
        map.put("pages",pageInfo.getPages());
        map.put("dept",depDao.select());
        return map;
    }

    public Employer selectByid(Integer id) {
        return dao.selectByPrimaryKey(id);
    }

    public int update(Employer emp) {
        return dao.updateByPrimaryKeySelective(emp);
    }

    public int delete(Integer id) {
        return dao.deleteByPrimaryKey(id);
    }

    public int insert(Employer emp) {
        return dao.insertSelective(emp);
    }

    public List<Department> select() {
        return depDao.select();
    }

    public int del(List<String> list) {
        return dao.del(list);
    }
}
