package com.fc.service;

import com.fc.async.MailTask;
import com.fc.mapper.UserMapper;
import com.fc.model.Info;
import com.fc.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.task.TaskExecutor;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.Transaction;

import java.util.List;


@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private JavaMailSender javaMailSender;

    @Autowired
    private TaskExecutor taskExecutor;

    @Autowired
    private JedisPool jedisPool;

    public User getProfile(int sessionUid, int userId) {
        if (sessionUid != userId) {
            userMapper.updateScanCount(userId);
        }
        User user = userMapper.selectUserByUserId(userId);
        Jedis jedis = jedisPool.getResource();
        user.setFollowCount((int) (long) jedis.scard(userId + ":follow"));
        user.setFollowerCount((int) (long) jedis.scard(userId + ":fans"));
        String likeCount = jedis.hget("vote", userId + "");
        if (likeCount == null) {
            user.setLikeCount(0);
        } else {
            user.setLikeCount(Integer.valueOf(likeCount));
        }

        if (jedis != null) {
            jedisPool.returnResource(jedis);
        }
        return user;
    }

    public User getEditInfo(int userId) {
        return userMapper.selectEditInfo(userId);
    }

    public void updateUser(User user) {
        userMapper.updateUser(user);
    }

    public void record(StringBuffer requestURL, String contextPath, String remoteAddr) {
        Info info = new Info();
        info.setRequestUrl(requestURL.toString());
        info.setContextPath(contextPath);
        info.setRemoteAddr(remoteAddr);
        userMapper.insertInfo(info);
    }

    public List<User> listUserByTime() {
        return userMapper.listUserByTime();
    }

    public List<User> listUserByHot() {
        return userMapper.listUserByHot();
    }

    public void updateHeadUrl(int userId, String headUrl) {
        userMapper.updateHeadUrl(userId, headUrl);
    }

    public void updateCover(int userId, String headUrl) {
        userMapper.updateCover(userId, headUrl);
    }

    public void unfollow(int sessionUid, int userId) {
        Jedis jedis = jedisPool.getResource();
        Transaction tx = jedis.multi();
        tx.srem(sessionUid + ":follow", String.valueOf(userId));
        tx.srem(userId + ":fans", String.valueOf(sessionUid));
        tx.exec();

        if (jedis != null) {
            jedisPool.returnResource(jedis);
        }
    }

    public void follow(int sessionUid, int userId) {
        Jedis jedis = jedisPool.getResource();
        Transaction tx = jedis.multi();
        tx.sadd(sessionUid + ":follow", String.valueOf(userId));
        tx.sadd(userId + ":fans", String.valueOf(sessionUid));
        tx.exec();
        if (jedis != null) {
            jedisPool.returnResource(jedis);
        }
    }

    public boolean getFollowStatus(int sessionUid, int userId) {
        Jedis jedis = jedisPool.getResource();
        boolean following = jedis.sismember(sessionUid + ":follow", String.valueOf(userId));
        if (jedis != null) {
            jedisPool.returnResource(jedis);
        }
        return following;
    }

    public String updatePassword(String password, String newpassword, String repassword, int sessionUid) {

        String oldPassword = userMapper.selectPasswordByUserId(sessionUid);
        if (!oldPassword.equals(password)) {
            return "You are entering wrong password";
        }

        if (newpassword.length() < 6 || newpassword.length() > 20) {
            return "Length is < 6 or > 20";
        }

        if (!newpassword.equals(repassword)) {
            return "Re password are not matching with new password";
        }

        userMapper.updatePassword(newpassword, sessionUid);
        return "ok";
    }

    public void forgetPassword(String email) {
        String verifyCode = userMapper.selectVerifyCode(email);
        System.out.println("verifyCode:" + verifyCode);
        taskExecutor.execute(new MailTask(verifyCode, email, javaMailSender, 2));
    }

    public void verifyForgetPassword(String code) {
        System.out.println("Code：" + code);
        userMapper.updatePasswordByActivateCode(code);
        System.out.println("Code：" + code);
    }

    public User getUserById (int userId) {
        return userMapper.selectUserByUserId(userId);
    }

}

