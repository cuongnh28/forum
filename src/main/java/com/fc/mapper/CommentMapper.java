package com.fc.mapper;

import com.fc.model.Comment;
import com.fc.model.Reply;

import java.util.List;

public interface CommentMapper {

    void insertComment(Comment comment);

    List<Comment> listComment(int postId);

    String getContentByCommentId(int commentId);

    Comment getCommentById (int commentId);

    void deleteComment(int commentId);

}
