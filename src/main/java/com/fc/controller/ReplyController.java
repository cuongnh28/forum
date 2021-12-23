package com.fc.controller;

import com.fc.model.Post;
import com.fc.model.Reply;
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
public class ReplyController {

    @Autowired
    private ReplyService replyService;

    @Autowired
    private PostService postService;

    @RequestMapping("/reply.do")
    public String reply(int postId, String contentReply, HttpSession session) {
        int sessionUid = (int) session.getAttribute("userId");
        replyService.reply(sessionUid, postId, contentReply);
        return "redirect:toPost.do?postId=" + postId;
    }

    @RequestMapping("/comment.do")
    public String comment(int postId, int replyId, String content, HttpSession session) {
        int sessionUid = (int) session.getAttribute("userId");
        replyService.comment(postId, sessionUid, replyId, content);
        return "redirect:toPost.do?postId=" + postId;
    }

    @RequestMapping(value = "/deleteReply.do", method = RequestMethod.POST)
    public String deleteReply(int replyId, int postId, Model model, HttpSession session) {
        Integer sessionUid = (Integer) session.getAttribute("userId");
        Reply reply = replyService.getReplyById(replyId);

        if (sessionUid == reply.getUser().getUserId()) {
            if (replyService.deleteReply(replyId)) {
                postService.updateReplyCount(postId);
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





