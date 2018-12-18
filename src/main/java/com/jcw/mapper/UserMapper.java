package com.jcw.mapper;

import com.github.pagehelper.Page;
import com.jcw.entity.User;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface UserMapper {
    public User getUserByName(String name);

    void addUser(User user);

    List<User> listAllUser();

    Page<User> findByPage(HashMap<String, Object> user);

    int selectCount();

    List<User> findCondition(Map<String, Object> conMap);

    void delUserById(Integer id);

    User selectById(Integer id);
}
