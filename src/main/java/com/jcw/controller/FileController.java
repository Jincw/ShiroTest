package com.jcw.controller;

import com.jcw.service.FileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping(value = "/file")
public class FileController {
    @Autowired
    FileService fileService;
    @RequestMapping(value = "toUpload")
    public String toUpload(){
        return "uploadFile";
    }
    @RequestMapping(value = "filesUpload",method = RequestMethod.POST)
    //requestParam要写才知道是前台的那个数组
    public String filesUpload(@RequestParam("myfiles") MultipartFile[] files,
                              HttpServletRequest request) {
        System.out.println(files.length+"*****************");
        List<String> list = new ArrayList<String>();
        if (files != null && files.length > 0) {
            for (int i = 0; i < files.length; i++) {
                MultipartFile file = files[i];
                // 保存文件
                list = saveFile(request, file, list);
            }
        }
        //写着测试，删了就可以
        for (int i = 0; i < list.size(); i++) {
            fileService.upload(list.get(i));
            System.out.println("集合里面的数据" + list.get(i));
        }
        return "redirect:/file/toUpload";//跳转的页面
    }

    private List<String> saveFile(HttpServletRequest request,
                                  MultipartFile file, List<String> list) {
        // 判断文件是否为空
        if (!file.isEmpty()) {
            try {
                // 保存的文件路径(如果用的是Tomcat服务器，文件会上传到\\%TOMCAT_HOME%\\webapps\\YourWebProject\\upload\\文件夹中
                // )
                String filePath = request.getSession().getServletContext()
                        .getRealPath("/")
                        + "upload/" + file.getOriginalFilename();
                list.add(file.getOriginalFilename());
                File saveDir = new File(filePath);
                if (!saveDir.getParentFile().exists())
                    saveDir.getParentFile().mkdirs();

                // 转存文件
                file.transferTo(saveDir);
                return list;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

}
