package com.fc.service;

import com.fc.async.MessageTask;
import com.fc.mapper.MessageMapper;
import com.fc.mapper.PostMapper;
import com.fc.mapper.ReplyMapper;
import com.fc.mapper.UserMapper;
import com.fc.model.PageBean;
import com.fc.model.Post;
import com.fc.repository.*;
import com.fc.util.MyConstant;
import com.fc.util.MyUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.task.TaskExecutor;
import org.springframework.stereotype.Service;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

import java.util.Date;
import java.util.List;


@Service
public class PostService {

    @Autowired
    private PostMapper postMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private ReplyMapper replyMapper;

    @Autowired
    private MessageMapper messageMapper;

    @Autowired
    private JedisPool jedisPool;

    @Autowired
    private TaskExecutor taskExecutor;

    public List<Post> getPostListByUserId(int userId) {
        return postMapper.listPostByUserId(userId);
    }

    public int publishPost(Post post) {

        post.setPublishTime(MyUtil.formatDate(new Date()));
        post.setReplyTime(MyUtil.formatDate(new Date()));
        post.setReplyCount(0);
        post.setLikeCount(0);
        post.setScanCount(0);
        postMapper.insertPost(post);
        System.out.println(post.getPostId());
        userMapper.updatePostCount(post.getUser().getUserId());

        return post.getPostId();
    }

    public PageBean<Post> listPostByNewestTime(int curPage) {
        int limit = 8;
        int offset = (curPage - 1) * limit;
        int allCount = postMapper.selectPostCount();
        int allPage = 0;
        if (allCount <= limit) {
            allPage = 1;
        } else if (allCount / limit == 0) {
            allPage = allCount / limit;
        } else {
            allPage = allCount / limit + 1;
        }
        List<Post> postList = postMapper.listPostByNewestTime(offset, limit);

        Jedis jedis = jedisPool.getResource();
        for (Post post : postList) {
            post.setLikeCount((int) (long) jedis.scard(post.getPostId() + ":like"));
        }

        PageBean<Post> pageBean = new PageBean<>(allPage, curPage);
        pageBean.setList(postList);

        if (jedis != null) {
            jedisPool.returnResource(jedis);
        }
        return pageBean;
    }

    public PageBean<Post> listPostByLatestTime(int curPage) {
        int limit = 8;
        int offset = (curPage - 1) * limit;
        int allCount = postMapper.selectPostCount();
        int allPage = 0;
        if (allCount <= limit) {
            allPage = 1;
        } else if (allCount / limit == 0) {
            allPage = allCount / limit;
        } else {
            allPage = allCount / limit + 1;
        }
        List<Post> postList = postMapper.listPostByLatestTime(offset, limit);
        Jedis jedis = jedisPool.getResource();
        for (Post post : postList) {
            post.setLikeCount((int) (long) jedis.scard(post.getPostId() + ":like"));
        }

        PageBean<Post> pageBean = new PageBean<>(allPage, curPage);
        pageBean.setList(postList);

        if (jedis != null) {
            jedisPool.returnResource(jedis);
        }
        return pageBean;
    }

    public PageBean<Post> listPostByHottest(int curPage) {
        int limit = 8;
        int offset = (curPage - 1) * limit;
        int allCount = postMapper.selectPostCount();
        int allPage = 0;
        if (allCount <= limit) {
            allPage = 1;
        } else if (allCount / limit == 0) {
            allPage = allCount / limit;
        } else {
            allPage = allCount / limit + 1;
        }
        List<Post> postList = postMapper.listPostByHottest(offset, limit);
        Jedis jedis = jedisPool.getResource();
        for (Post post : postList) {
            post.setLikeCount((int) (long) jedis.scard(post.getPostId() + ":like"));
        }

        PageBean<Post> pageBean = new PageBean<>(allPage, curPage);
        pageBean.setList(postList);

        if (jedis != null) {
            jedisPool.returnResource(jedis);
        }
        return pageBean;
    }

    public PageBean<Post> listPostByTopic(int topicId) {
        int limit = 8;
//        int offset = (topicId - 1) * limit;
        int offset = 0;
        int allCount = postMapper.selectPostCount();
        int allPage = 0;
        if (allCount <= limit) {
            allPage = 1;
        } else if (allCount / limit == 0) {
            allPage = allCount / limit;
        } else {
            allPage = allCount / limit + 1;
        }
        List<Post> postList = postMapper.listPostByTopic(topicId, offset, limit);
        Jedis jedis = jedisPool.getResource();
        for (Post post : postList) {
            post.setLikeCount((int) (long) jedis.scard(post.getPostId() + ":like"));
        }

        PageBean<Post> pageBean = new PageBean<>(allPage, topicId);
        pageBean.setList(postList);

        if (jedis != null) {
            jedisPool.returnResource(jedis);
        }
        return pageBean;
    }

    public List<Post> listPostByTopicId(int topicId, int postId) {
        List<Post> postList = postMapper.listPostByTopicId(topicId, postId);
        return postList;
    }

    public Post getPostByPostId(int postId) {
        postMapper.updateScanCount(postId);
        Post post = postMapper.getPostByPostId(postId);
        Jedis jedis = jedisPool.getResource();
        long likeCount = jedis.scard(postId + ":like");
        post.setLikeCount((int) likeCount);

        if (jedis != null) {
            jedisPool.returnResource(jedis);
        }
        return post;
    }

    public PageBean<Post> searchByTitle(String searchTerm) {
        List<Post> postList = postMapper.searchByTitle(searchTerm);
        Jedis jedis = jedisPool.getResource();
        for (Post post : postList) {
            post.setLikeCount((int) (long) jedis.scard(post.getPostId() + ":like"));
        }
        PageBean<Post> pageBean = new PageBean();
        pageBean.setList(postList);
        return pageBean;
    }

    public String clickLike(int postId, int sessionUid) {
        Jedis jedis = jedisPool.getResource();
        jedis.sadd(postId + ":like", String.valueOf(sessionUid));
        jedis.hincrBy("vote", sessionUid + "", 1);

        taskExecutor.execute(new MessageTask(messageMapper, userMapper, postMapper, replyMapper, postId, 0, sessionUid, MyConstant.OPERATION_CLICK_LIKE));
        String result = String.valueOf(jedis.scard(postId + ":like"));

        if (jedis != null) {
            jedisPool.returnResource(jedis);
        }
        return result;
    }

    public boolean getLikeStatus(int postId, int sessionUid) {
        Jedis jedis = jedisPool.getResource();
        boolean result = jedis.sismember(postId + ":like", String.valueOf(sessionUid));

        if (jedis != null) {
            jedisPool.returnResource(jedis);
        }
        return result;
    }
}

