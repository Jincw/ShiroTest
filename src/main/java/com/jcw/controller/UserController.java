package com.jcw.controller;

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

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {

    @Resource
    private UserService userService;

    @RequestMapping(value = "login", method = RequestMethod.POST)
    public String login(@RequestParam("username") String username, @RequestParam("password") String password, HttpServletRequest request) {
        Subject currentUser = SecurityUtils.getSubject();
        if (!currentUser.isAuthenticated()) {
            UsernamePasswordToken upToken = new UsernamePasswordToken(username, password);
            System.out.println("username: "+username+" ---- password: "+password);
            upToken.setRememberMe(false);
            try {
                currentUser.login(upToken);
                request.getSession().setAttribute("msg",username);
                return "welcome";
            } catch (IncorrectCredentialsException ice) {
                request.getSession().setAttribute("msg","账号/密码不匹配！");
            } catch (LockedAccountException lae) {
                request.getSession().setAttribute("msg","账户已被冻结！");
            } catch (AuthenticationException ae) {
                request.getSession().setAttribute("msg",ae.getMessage());
            }
        }
        return "redirect:/";
    }
    @RequestMapping(value = "logout", method = RequestMethod.GET)
    public String logout(HttpServletRequest request, HttpServletResponse response){
        Cookie aCookie;
        String cookieName;
        String cookieValue;
        Cookie[] cookies = request.getCookies();
        if(cookies!=null){
            for (Cookie cookie: cookies) {
                cookieName = cookie.getName();
                cookieValue = cookie.getValue();
                aCookie = new Cookie(cookieName,cookieValue);
                aCookie.setMaxAge(0);//设置为0为立即删除该Cookie
                aCookie.setPath("/");//删除指定路径的cookie,不设置该路径，默认为删除当前路径Cookie
                response.addCookie(aCookie);

            }
        }
        return "redirect:/";
    }
    @RequestMapping(value = "register",method = RequestMethod.POST)
    public String register(User user,HttpServletRequest request){
        String name = user.getUsername();
        User userByName = userService.getUserByName(name);
        if (userByName!=null){
            request.getSession().setAttribute("msg","账户已被注册！");
        }else {
            Object hashPass = HashUtil.hashPass(user);
            user.setPassword(hashPass.toString());
            System.out.println("username:"+user.getUsername()+" password:"+user.getPassword()+" email:"+user.getEmail()+" phone:"+user.getPhone());
            userService.addUser(user);
        }
        return "redirect:/";
    }
    @RequestMapping(value = "listAllUser",method = RequestMethod.GET)
    public String listAllUser(Model model){
        List<User> userList = userService.listAllUser();
        model.addAttribute("userList",userList);
        return "userList";
    }
}
