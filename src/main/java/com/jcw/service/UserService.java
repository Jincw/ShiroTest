package com.jcw.service;

import com.jcw.entity.User;

import java.util.List;

public interface UserService {
    User getUserByName(String name);

    void addUser(User user);

    List<User> listAllUser();
}
