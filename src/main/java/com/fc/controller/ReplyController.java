package com.fc.controller;

import com.fc.service.ReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/")
public class ReplyController {

    @Autowired
    private ReplyService replyService;

    @RequestMapping("/reply.do")
    public String reply(int postId, String content, HttpSession session) {
        int sessionUid = (int) session.getAttribute("userId");
        replyService.reply(sessionUid, postId, content);
        return "redirect:toPost.do?postId=" + postId;
    }

    @RequestMapping("/comment.do")
    public String comment(int postId, int replyId, String content, HttpSession session) {
        int sessionUid = (int) session.getAttribute("userId");
        replyService.comment(postId, sessionUid, replyId, content);
        return "redirect:toPost.do?postId=" + postId;
    }
}





