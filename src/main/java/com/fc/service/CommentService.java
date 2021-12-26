package com.fc.service;

import com.fc.mapper.CommentMapper;
import com.fc.mapper.LogMapper;
import com.fc.model.Comment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommentService {

    @Autowired
    private CommentMapper commentMapper;

    @Autowired
    private LogMapper logMapper;

    public Comment getCommentById(int commentId) {
        Comment comment = commentMapper.getCommentById(commentId);
        return comment;
    }

    public boolean deleteComment(int commentId) {
        try {
            commentMapper.deleteComment(commentId);
            logMapper.deleteLogByComment(commentId);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
