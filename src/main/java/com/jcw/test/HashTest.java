package com.jcw.test;

import org.apache.shiro.crypto.hash.SimpleHash;

public class HashTest {
    public static void main(String[] args) {
        String hashAlgorithmName = "MD5";//加密方式
        Object crdentials = "34567";//密码原值
        Object salt = "张飒";//盐值
        int hashIterations = 1024;//加密1024次
        Object result = new SimpleHash(hashAlgorithmName,crdentials,salt,hashIterations);
        System.out.println(result);
    }
}
