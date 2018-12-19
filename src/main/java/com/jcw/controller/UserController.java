package com.jcw.controller;

import com.jcw.entity.PageBean;
import com.jcw.entity.User;
import com.jcw.service.UserService;
import com.jcw.util.HashUtil;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {

    @Resource
    private UserService userService;

    /**
     * 登录（集成shiro密码验证及密码MD5加密）
     * */
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(@RequestParam("username") String username, @RequestParam("password") String password, HttpServletRequest request) {
        Subject currentUser = SecurityUtils.getSubject();
        if (!currentUser.isAuthenticated()) {
            UsernamePasswordToken upToken = new UsernamePasswordToken(username, password);
            System.out.println("username: " + username + " ---- password: " + password);
            upToken.setRememberMe(false);
            try {
                currentUser.login(upToken);
                request.getSession().setAttribute("msg", username);
                return "welcome";
            } catch (IncorrectCredentialsException ice) {
                request.getSession().setAttribute("msg", "账号/密码不匹配！");
            } catch (LockedAccountException lae) {
                request.getSession().setAttribute("msg", "账户已被冻结！");
            } catch (AuthenticationException ae) {
                request.getSession().setAttribute("msg", ae.getMessage());
            }
        }
        return "redirect:/";
    }

    /**
     * 退出登录
     * */
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(HttpServletRequest request, HttpServletResponse response) {
        Cookie aCookie;
        String cookieName;
        String cookieValue;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                cookieName = cookie.getName();
                cookieValue = cookie.getValue();
                aCookie = new Cookie(cookieName, cookieValue);
                aCookie.setMaxAge(0);//设置为0为立即删除该Cookie
                aCookie.setPath("/");//删除指定路径的cookie,不设置该路径，默认为删除当前路径Cookie
                response.addCookie(aCookie);

            }
        }
        return "redirect:/";
    }

    /**
     * 注册（添加用户信息）
     * */
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String register(User user, HttpServletRequest request) {
        String name = user.getUsername();
        User userByName = userService.getUserByName(name);
        if (userByName != null) {
            request.getSession().setAttribute("msg", "账户已被注册！");
        } else {
            Object hashPass = HashUtil.hashPass(user);
            user.setPassword(hashPass.toString());
            System.out.println("username:" + user.getUsername() + " password:" + user.getPassword() + " email:" + user.getEmail() + " phone:" + user.getPhone());
            userService.addUser(user);
        }
        return "redirect:/";
    }

    //查询所有（未分页）
    /*@RequestMapping(value = "listAllUser",method = RequestMethod.GET)
    public String listAllUser(Model model){
        List<User> userList = userService.listAllUser();
        model.addAttribute("userList",userList);
        return "userList";
    }*/
    /**
     * 多条件查询分页
     * */
    @RequestMapping("/listAllUser")
    public String findByPage(Map<String, Object> conMap,
                             @RequestParam(value = "pageCode", required = false, defaultValue = "1") int pageCode,
                             @RequestParam(value = "pageSize", required = false, defaultValue = "2") int pageSize,
                             Model model) {
        PageBean byPage = userService.findByPage(conMap, pageCode, pageSize);
        // 回显数据
        model.addAttribute("page", byPage);
        return "userList";
    }

    /**
     * ajax根据id删除单个用户
     * */
    @RequestMapping(value = "/delUserById", method = RequestMethod.POST)
    public @ResponseBody Object delete(Integer id) {
        System.out.println("id:" + id);    //调试的时候用的
        User user = userService.selectById(id);
        HashMap<String, String> hash = new HashMap<String, String>();
        if (user != null) {
            hash.put("stateCode", "1");
            userService.delUserById(id);
        } else {
            hash.put("stateCode", "0");
        }
        return hash;
    }

    /**
     * 批量删除
     * */
    @RequestMapping(value = "/delAlluser",method = RequestMethod.GET)
    public String delAlluser(HttpServletRequest request){
        //前台页面传过来的请求类似于：/user/delAlluser?id=1&id=2&id=3 的请求
        //根据request.getParameterValues("id")方法就可以得到字符串类型的数组，类似于String [] ids = ["1","2","3"],  1,2,3表示http请求中的id的值
        String[] ids = request.getParameterValues("id");//request.getParameterValues：根据页面传来的name获取多个参数值
        for (String s:ids) {
            userService.delUserById(Integer.parseInt(s));//Integer.parsInt(字符串类型数字)：将字符串类型数字转成字符串
        }
        return "redirect:/user/listAllUser";
    }
}
