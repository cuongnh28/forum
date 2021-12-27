package com.fc.controller;

import com.fc.model.Post;
import com.fc.service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/")
public class AdminController {

    @Autowired
    private PostService postService;

    @RequestMapping("/admin.do")
    public String admin() {
        return "admin/home";
    }

    @RequestMapping("/postPendingTables.do")
    public String postPendingTables(Model model) {
        List<Post> listPostsNotApprove = postService.listPostsNotApprove();
        model.addAttribute("listPost", listPostsNotApprove);
        return "admin/tables";
    }

    @RequestMapping("/acceptPost.do")
    public String acceptPost(int postId) {
        postService.acceptPost(postId);
        return "redirect:postPendingTables.do";
    }

    @RequestMapping("/rejectPost.do")
    public String rejectPost(int postId) {
        postService.rejectPost(postId);
        return "redirect:postPendingTables.do";
    }

}
