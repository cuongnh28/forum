package com.fc.async;

import com.fc.mapper.MessageMapper;
import com.fc.mapper.PostMapper;
import com.fc.mapper.ReplyMapper;
import com.fc.mapper.UserMapper;
import com.fc.model.Message;
import com.fc.model.User;
import com.fc.util.MyConstant;

public class MessageTask implements Runnable {

    private MessageMapper messageMapper;
    private UserMapper userMapper;
    private PostMapper postMapper;
    private ReplyMapper replyMapper;
    private int postId;
    private int replyId;
    private int sessionUid;
    private int operation;

    public MessageTask(MessageMapper messageMapper, UserMapper userMapper, PostMapper postMapper, ReplyMapper replyMapper, int postId, int replyId, int sessionUid, int operation) {
        this.messageMapper = messageMapper;
        this.userMapper = userMapper;
        this.postMapper = postMapper;
        this.replyMapper = replyMapper;
        this.postId = postId;
        this.replyId = replyId;
        this.sessionUid = sessionUid;
        this.operation = operation;
    }

    public MessageTask(MessageMapper messageMapper, UserMapper userMapper, PostMapper postMapper, ReplyMapper replyMapper, int sessionUid, int operation) {
        this.messageMapper = messageMapper;
        this.userMapper = userMapper;
        this.postMapper = postMapper;
        this.replyMapper = replyMapper;
        this.sessionUid = sessionUid;
        this.operation = operation;
    }

    @Override
    public void run() {
        Message message = new Message();
        int userId = postMapper.getUserIdByPostId(postId);
        message.setUserId(userId);

        User user = userMapper.selectUsernameByUserId(sessionUid);
        message.setOtherId(user.getUserId());
        message.setOtherUsername(user.getUsername());
        message.setPostId(postId);

        if(operation== MyConstant.OPERATION_CLICK_LIKE){
            message.setOperation(" click like ");
            message.setDisplayedContent(postMapper.getTitleByPostId(postId));
        }else if(operation==MyConstant.OPERATION_REPLY){
            message.setOperation(" reply ");
            message.setDisplayedContent(postMapper.getTitleByPostId(postId));
        }else if(operation==MyConstant.OPERATION_COMMENT){
            message.setOperation(" comment ");
            String content = replyMapper.getContentByReplyId(replyId);
            message.setDisplayedContent(content.substring(content.indexOf("<p>") + 3,content.indexOf("</p>")));
        }

        messageMapper.insertMessage(message);
    }
}


