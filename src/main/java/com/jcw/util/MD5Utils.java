package com.jcw.util;

import java.security.MessageDigest;
import java.util.UUID;

public class MD5Utils {

    public static String EncoderByMd5( String str ) throws Exception {
        //确定计算方法
        MessageDigest md5= MessageDigest.getInstance("MD5");

        byte[] messageByte = str.getBytes("UTF-8");
        byte[] md5Byte = md5.digest(messageByte);              // 获得MD5字节数组,16*8=128位
        String newstr = bytesToHex(md5Byte);

        return newstr;
    }

    //产生全世界唯一的id
    public static String generateID(){
        return UUID.randomUUID().toString().replace("-","").toUpperCase();
    }

    // 二进制转十六进制
    private static String bytesToHex(byte[] bytes) {
        StringBuffer hexStr = new StringBuffer();
        int num;
        for (int i = 0; i < bytes.length; i++) {
            num = bytes[i];
            if(num < 0) {
                num += 256;
            }
            if(num < 16){
                hexStr.append("0");
            }
            hexStr.append(Integer.toHexString(num));
        }
        return hexStr.toString().toUpperCase();
    }
}

