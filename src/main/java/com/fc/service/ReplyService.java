package com.fc.service;

import com.fc.async.MessageTask;
import com.fc.mapper.MessageMapper;
import com.fc.mapper.PostMapper;
import com.fc.mapper.ReplyMapper;
import com.fc.mapper.UserMapper;
import com.fc.model.*;
import com.fc.util.MyConstant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.task.TaskExecutor;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class ReplyService {

    @Autowired
    private ReplyMapper replyMapper;

    @Autowired
    private PostMapper postMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private MessageMapper messageMapper;

    @Autowired
    private TaskExecutor taskExecutor;

    public void reply(int sessionUid, int postId, String content) {
        User user = new User(sessionUid);
        Post post = new Post(postId);
        Reply reply = new Reply();
        reply.setUser(user);
        reply.setPost(post);
        reply.setContent(content);
        replyMapper.insertReply(reply);
        postMapper.updateReplyCount(postId);
        postMapper.updateReplyTime(postId);
        taskExecutor.execute(new MessageTask(messageMapper,userMapper,postMapper,replyMapper,postId,0,sessionUid, MyConstant.OPERATION_REPLY));

    }

    public void comment(int postId,int sessionUid, int replyId, String content) {
        User user = new User(sessionUid);
        Reply reply = new Reply(replyId);
        Comment comment = new Comment();
        comment.setUser(user);
        comment.setReply(reply);
        comment.setContent(content);
        replyMapper.insertComment(comment);
        postMapper.updateReplyTime(postId);
        taskExecutor.execute(new MessageTask(messageMapper,userMapper,postMapper,replyMapper,postId,replyId,sessionUid, MyConstant.OPERATION_COMMENT));
    }

    public List<Reply> listReply(int postId) {
        List<Reply> replyList = replyMapper.listReply(postId);
        for(Reply reply : replyList){
            List<Comment> commentList = replyMapper.listComment(reply.getReplyId());
            reply.setCommentList(commentList);
        }
        return replyList;
    }
}

