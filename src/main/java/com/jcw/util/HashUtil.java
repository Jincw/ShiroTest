package com.jcw.util;

import com.jcw.entity.User;
import org.apache.shiro.crypto.hash.SimpleHash;

public class HashUtil {
    public static Object hashPass(User user){
        String hashAlgorithmName = "MD5";//加密方式
        Object crdentials = user.getPassword();//密码原值
        Object salt = user.getUsername();//盐值
        int hashIterations = 1024;//加密1024次
        Object result = new SimpleHash(hashAlgorithmName,crdentials,salt,hashIterations);
        System.out.println("Hash result is :"+result);
        return result;
    }
}
