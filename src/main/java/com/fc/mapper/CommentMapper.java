package com.fc.mapper;

import com.fc.model.Comment;

public interface CommentMapper {
    void deleteComment(int commentId);
    Comment getCommentById (int commentId);
}
