package com.fc.controller;

import com.fc.model.Comment;
import com.fc.model.Post;
import com.fc.model.Reply;
import com.fc.service.CommentService;
import com.fc.service.PostService;
import com.fc.service.ReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/")
public class CommentController {

    @Autowired
    private ReplyService replyService;

    @Autowired
    private PostService postService;
    
    @Autowired
    private CommentService commentService;

    @RequestMapping(value = "/deleteComment.do", method = RequestMethod.POST)
    public String deleteComment(int commentId, int postId, HttpSession session) {
        Integer sessionUid = (Integer) session.getAttribute("userId");
        Comment comment = commentService.getCommentById(commentId);

        if (sessionUid == comment.getUser().getUserId()) {
            if (commentService.deleteComment(commentId)) {
                return "redirect:toPost.do?postId=" + postId;
            }
        }

        return null;
    }
}
