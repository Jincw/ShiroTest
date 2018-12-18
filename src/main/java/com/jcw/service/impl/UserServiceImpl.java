package com.jcw.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.jcw.entity.PageBean;
import com.jcw.entity.User;
import com.jcw.mapper.UserMapper;
import com.jcw.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    UserMapper userMapper;
    @Override
    public User getUserByName(String name) {
        return userMapper.getUserByName(name);
    }

    @Override
    public void addUser(User user) {
        userMapper.addUser(user);
    }

    @Override
    public List<User> listAllUser() {
        return userMapper.listAllUser();
    }

    @Override
    public PageBean findByPage(Map<String, Object> conMap, int pageCode, int pageSize) {
        HashMap<String,Object> map = new HashMap<String,Object>();
        PageBean<User> pageBean = new PageBean<User>();

        //封装当前页
        pageBean.setPageCode(pageCode);
        pageBean.setPageSize(pageSize);

        // 封装总记录数（从数据库中查询）
        int totalCount = userMapper.selectCount();
        System.out.println("查询到的总记录数："+totalCount);
        pageBean.setTotalCount(totalCount);

        //封装总页数
        double tc = totalCount;
        Double num = Math.ceil(tc / pageSize);
        pageBean.setTotalPage(num.intValue());

        // 设置limit分页查询的起始位置和终止位置
        map.put("start",(pageCode - 1) * pageSize);
        map.put("size",pageBean.getPageSize());

        //封装每页显示的数据
        List<User> list = userMapper.findByPage(map);
        pageBean.setBeanList(list);

        // 分页查询功能也要封装显示起始页和终止页
        conMap.put("start",(pageCode - 1) * pageSize);
        conMap.put("size",pageBean.getPageSize());

        // 封装
        List<User> listCondition = userMapper.findCondition(conMap);
        pageBean.setBeanList(listCondition);
        return pageBean;
    }

    @Override
    public void delUserById(Integer id) {
        userMapper.delUserById(id);
    }

    @Override
    public User selectById(Integer id) {
        return userMapper.selectById(id);
    }
}
