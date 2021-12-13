package com.fc.controller;

import com.fc.model.*;
import com.fc.service.PostService;
import com.fc.service.ReplyService;
import com.fc.service.TopicService;
import com.fc.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/")
public class PostController {

    @Autowired
    private UserService userService;

    @Autowired
    private PostService postService;

    @Autowired
    private TopicService topicService;

    @Autowired
    private ReplyService replyService;


    @RequestMapping("/toPublish.do")
    public String toPublish(Model model) {
        List<Topic> topicList = topicService.listTopic();
        model.addAttribute("topicList", topicList);
        return "publish";
    }

    @RequestMapping("/publishPost.do")
    public String publishPost(Post post) {
        int id = postService.publishPost(post);
        return "redirect:toPost.do?postId=" + id;
    }

    @RequestMapping("/listPostByNewestTime.do")
    public String listPostByNewestTime(int curPage, Model model) {
        PageBean<Post> pageBean = postService.listPostByNewestTime(curPage);
        List<User> userList = userService.listUserByTime();
        List<User> hotUserList = userService.listUserByHot();
        model.addAttribute("pageBean", pageBean);
        model.addAttribute("userList", userList);
        model.addAttribute("hotUserList", hotUserList);
        return "index";
    }

    @RequestMapping("/listPostByLatestTime.do")
    public String listPostByLatestTime(int curPage, Model model) {
        PageBean<Post> pageBean = postService.listPostByLatestTime(curPage);
        List<User> userList = userService.listUserByTime();
        List<User> hotUserList = userService.listUserByHot();
        model.addAttribute("pageBean", pageBean);
        model.addAttribute("userList", userList);
        model.addAttribute("hotUserList", hotUserList);
        return "index";
    }

    @RequestMapping("/listPostByHottest.do")
    public String listPostByHottest(int curPage, Model model) {
        PageBean<Post> pageBean = postService.listPostByHottest(curPage);
        List<User> userList = userService.listUserByTime();
        List<User> hotUserList = userService.listUserByHot();
        model.addAttribute("pageBean", pageBean);
        model.addAttribute("userList", userList);
        model.addAttribute("hotUserList", hotUserList);
        return "index";
    }

    @RequestMapping("/listPostByTopic.do")
    public String listPostByTopic(int topicId, Model model) {
        PageBean<Post> pageBean = postService.listPostByTopic(topicId);
        List<User> userList = userService.listUserByTime();
        List<User> hotUserList = userService.listUserByHot();
        model.addAttribute("pageBean", pageBean);
        model.addAttribute("userList", userList);
        model.addAttribute("hotUserList", hotUserList);
        return "index";
    }

    @RequestMapping("/toPost.do")
    public String toPost(int postId, Model model, HttpSession session) {
        Integer sessionUid = (Integer) session.getAttribute("userId");
        Post post = postService.getPostByPostId(postId);
        List<Reply> replyList = replyService.listReply(postId);
        List<Post> listPostsSameTopic = postService.listPostByTopicId(post.getTopic().getTopicId(), postId);

        boolean liked = false;
        if (sessionUid != null) {
            liked = postService.getLikeStatus(postId, sessionUid);
        }
        model.addAttribute("post", post);
        model.addAttribute("replyList", replyList);
        model.addAttribute("liked", liked);
        model.addAttribute("suggestedTopics", listPostsSameTopic);
        return "post";
    }

//    @RequestMapping("/search.do")
//    public String toPost(String q, Model model, HttpSession session) {
//        Integer sessionUid = (Integer) session.getAttribute("userId");
//        List<Post> listPostsSameTopic = postService.seachByTitle(q);
//
//        boolean liked = false;
//        if (sessionUid != null) {
//            liked = postService.getLikeStatus(postId, sessionUid);
//        }
//        model.addAttribute("post", post);
//        model.addAttribute("replyList", replyList);
//        model.addAttribute("liked", liked);
//        model.addAttribute("suggestedTopics", listPostsSameTopic);
//        return "post";
//    }

    @RequestMapping(value = "/ajaxClickLike.do", produces = "text/plain;charset=UTF-8")
    public @ResponseBody
    String ajaxClickLike(int postId, HttpSession session) {
        int sessionUid = (int) session.getAttribute("userId");
        return postService.clickLike(postId, sessionUid);
    }
}
