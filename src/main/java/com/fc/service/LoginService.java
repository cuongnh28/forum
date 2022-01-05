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

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
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

//        validate input.
//        Pattern p = Pattern.compile("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$");
//        Matcher m = p.matcher(user.getEmail());
//        if (!m.matches()) {
//            return "Email is not right.";
//        }
//
//        p = Pattern.compile("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$");
//        m = p.matcher(user.getPassword());
//
//        if (!m.matches()) {
//            return "Password must contain at least eight characters, at least one number and letter.";
//        }

        if (!user.getPassword().equals(repassword)) {
            return "Password and Confirm password are not matching. Please try again.";
        }

        int emailCount = userMapper.selectEmailCount(user.getEmail());

        if (emailCount > 0) {
            return "This email has been set before, please check your email.";
        }

        user.setActived(0);
        String activateCode = MyUtil.createActivateCode();
        user.setActivateCode(activateCode);
        user.setJoinTime(new Date());
        int index = user.getEmail().indexOf('@');
        String username  = user.getEmail().substring(0,index);

        user.setUsername(username);
//        hash password
//        try {
//            MessageDigest md = MessageDigest.getInstance("MD5");
//            byte[] hashedData = md.digest(user.getPassword().getBytes());
//            user.setPassword(convertByteToHex(hashedData));
//        } catch (NoSuchAlgorithmException e) {
//            throw new RuntimeException(e);
//        }

        user.setHeadUrl("team-1.jpg");

        taskExecutor.execute(new MailTask(activateCode, user.getEmail(), javaMailSender, 1));

        userMapper.insertUser(user);

        return "ok";
    }

    public Map<String, Object> login(User user) {
//  hash password
//        try {
//            MessageDigest md = MessageDigest.getInstance("MD5");
//            byte[] hashedData = md.digest(user.getPassword().getBytes());
//            user.setPassword(convertByteToHex(hashedData));
//        } catch (NoSuchAlgorithmException e) {
//            throw new RuntimeException(e);
//        }

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
        User currentUser = userMapper.selectUserByUserId(userId);

        map.put("status", "yes");
        map.put("userId", userId);
        map.put("headUrl", headUrl);
        map.put("user", currentUser);
        map.put("isAdmin", currentUser.getIsAdmin());
        return map;
    }

    public void activate(String activateCode) {
        userMapper.updateActived(activateCode);
    }

    public static String convertByteToHex(byte[] data) {
        BigInteger number = new BigInteger(1, data);
        String hashtext = number.toString(16);
        // Now we need to zero pad it if you actually want the full 32 chars.
        while (hashtext.length() < 32) {
            hashtext = "0" + hashtext;
        }
        return hashtext;
    }
}
