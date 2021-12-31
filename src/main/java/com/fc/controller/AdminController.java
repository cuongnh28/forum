package com.fc.controller;

import com.fc.model.Post;
import com.fc.model.User;
import com.fc.service.PostService;
import com.fc.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/")
public class AdminController {

    @Autowired
    private PostService postService;

    @Autowired
    private UserService userService;

    @RequestMapping("/admin.do")
    public String admin(HttpSession session) {
        Integer sessionUid = (Integer) session.getAttribute("userId");
        User user = userService.getUserById(sessionUid);
        if (user.checkIsAdmin()) {
            return "admin/home";
        }
        else {
            return null;
        }
    }

    @RequestMapping("/postPendingTables.do")
    public String postPendingTables(Model model, HttpSession session) {
        List<Post> listPostsNotApprove = postService.listPostsNotApprove();
        model.addAttribute("listPost", listPostsNotApprove);
        Integer sessionUid = (Integer) session.getAttribute("userId");
        User user = userService.getUserById(sessionUid);
        if (user.checkIsAdmin()) {
            return "admin/tables";
        }
        else {
            return null;
        }
    }

    @RequestMapping("/acceptPost.do")
    public String acceptPost(int postId, HttpSession session) {
        Integer sessionUid = (Integer) session.getAttribute("userId");
        User user = userService.getUserById(sessionUid);
        if (user.checkIsAdmin()) {
            postService.acceptPost(postId);
            return "redirect:postPendingTables.do";
        }
        else {
            return null;
        }
    }

    @RequestMapping("/rejectPost.do")
    public String rejectPost(int postId, HttpSession session) {
        Integer sessionUid = (Integer) session.getAttribute("userId");
        User user = userService.getUserById(sessionUid);
        if (user.checkIsAdmin()) {
            postService.rejectPost(postId);
            return "redirect:postPendingTables.do";
        }
        else {
            return null;
        }
    }

}
