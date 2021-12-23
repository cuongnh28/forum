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
    public String deleteComment(int commentId, int postId, Model model, HttpSession session) {
        Integer sessionUid = (Integer) session.getAttribute("userId");
        Comment comment = commentService.getCommentById(commentId);

        if (sessionUid == comment.getUser().getUserId()) {
            if (commentService.deleteComment(commentId)) {
                Post post = postService.getPostByPostId(postId);
                List<Reply> replyList = replyService.listReply(postId);
                List<Post> listPostSameTopic = postService.listPostByTopicId(post.getTopic().getTopicId(), postId);

                boolean liked = false;
                if (sessionUid != null) {
                    liked = postService.getLikeStatus(postId, sessionUid);
                }
                model.addAttribute("post", post);
                model.addAttribute("replyList", replyList);
                model.addAttribute("liked", liked);
                model.addAttribute("suggestedTopics", listPostSameTopic);
                return "post";
            }
        }

        return null;
    }
}
