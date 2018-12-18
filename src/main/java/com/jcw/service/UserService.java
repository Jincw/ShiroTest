package com.jcw.service;

import com.jcw.entity.PageBean;
import com.jcw.entity.User;

import java.util.List;
import java.util.Map;

public interface UserService {
    User getUserByName(String name);

    void addUser(User user);

    List<User> listAllUser();

    PageBean findByPage(Map<String, Object> conMap, int pageCode, int pageSize);

    void delUserById(Integer id);

    User selectById(Integer id);
}
