package com.jcw.mapper;

import com.jcw.entity.User;

import java.util.List;

public interface UserMapper {
    public User getUserByName(String name);

    void addUser(User user);

    List<User> listAllUser();
}
