package com.fc.service;

import com.fc.async.MailTask;
import com.fc.mapper.UserMapper;
import com.fc.model.User;
import com.fc.util.MyConstant;
import com.fc.util.MyUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.task.TaskExecutor;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class LoginService {


    @Autowired
    private UserMapper userMapper;
    @Autowired
    private JavaMailSender javaMailSender;
    @Autowired
    private TaskExecutor taskExecutor;

    public String register(User user, String repassword) {

        Pattern p = Pattern.compile("^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\\.[a-zA-Z0-9_-]{2,3}){1,2})$");
        Matcher m = p.matcher(user.getEmail());
        if (!m.matches()) {
            return "Email is not right.";
        }

        p = Pattern.compile("^\\w{6,20}$");
        m = p.matcher(user.getPassword());
        if (!m.matches()) {
            return "Please enter password again";
        }

        if (!user.getPassword().equals(repassword)) {
            return "Password is not matching with confirm password";
        }

        int emailCount = userMapper.selectEmailCount(user.getEmail());
        if (emailCount > 0) {
            return "This email has been set before.";
        }

        user.setActived(0);
        String activateCode = MyUtil.createActivateCode();
        user.setActivateCode(activateCode);
        user.setJoinTime(MyUtil.formatDate(new Date()));
        int index = user.getEmail().indexOf('@');
        String username  = user.getEmail().substring(0,index);
        user.setUsername(username);
        user.setHeadUrl(MyConstant.QINIU_IMAGE_URL + "head.jpg");

        taskExecutor.execute(new MailTask(activateCode, user.getEmail(), javaMailSender, 1));

        userMapper.insertUser(user);

        return "ok";
    }

    public Map<String, Object> login(User user) {

        Map<String, Object> map = new HashMap<>();
        Integer userId = userMapper.selectUserIdByEmailAndPassword(user);
        if (userId == null) {
            map.put("status", "no");
            map.put("error", "Wrong Username or Password");
            return map;
        }

        int checkActived = userMapper.selectActived(user);
        if (checkActived == 0) {
            map.put("status", "no");
            map.put("error", "Account is not active.");
            return map;
        }

        String headUrl = userMapper.selectHeadUrl(userId);

        map.put("status", "yes");
        map.put("userId", userId);
        map.put("headUrl", headUrl);
        return map;
    }

    public void activate(String activateCode) {
        userMapper.updateActived(activateCode);
    }
}
