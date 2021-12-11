package com.fc.mapper;

import com.fc.model.Comment;
import com.fc.model.Reply;

import java.util.List;


public interface ReplyMapper {

    void insertReply(Reply reply);

    List<Reply> listReply(int postId);

    void insertComment(Comment comment);

    List<Comment> listComment(Integer replyId);

    String getContentByReplyId(int replyId);

}
