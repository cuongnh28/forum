package com.fc.controller;

import com.fc.model.*;
import com.fc.service.PostService;
import com.fc.service.CommentService;
import com.fc.service.TopicService;
import com.fc.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
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
    private CommentService commentService;


    @RequestMapping("/toPublish.do")
    public String toPublish(Model model) {
        List<Topic> topicList = topicService.listTopic();
        model.addAttribute("topicList", topicList);
        return "publish";
    }

    @RequestMapping(value = "/publishPost.do", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<Integer> publishPost(@RequestBody Post post) {
        int id = postService.publishPost(post);
        return new ResponseEntity<>(id, HttpStatus.OK);
    }

    @RequestMapping("/listPostByNewestTime.do")
    public String listPostByNewestTime(int curPage, Model model) {
        PageBean<Post> pageBean = postService.listPostByNewestTime(curPage);
        List<User> userList = userService.listUserByTime();
        List<User> hotUserList = userService.listUserByHot();
        String sortBy = "newestTime";
        model.addAttribute("pageBean", pageBean);
        model.addAttribute("userList", userList);
        model.addAttribute("hotUserList", hotUserList);
        model.addAttribute("sortBy", sortBy);
        return "index";
    }

    @RequestMapping("/listPostByLatestTime.do")
    public String listPostByLatestTime(int curPage, Model model) {
        PageBean<Post> pageBean = postService.listPostByLatestTime(curPage);
        List<User> userList = userService.listUserByTime();
        List<User> hotUserList = userService.listUserByHot();
        String sortBy = "latestTime";
        model.addAttribute("sortBy", sortBy);
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
        String sortBy = "hottest";
        model.addAttribute("sortBy", sortBy);
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
        String sortBy = "topic";
        model.addAttribute("sortBy", sortBy);
        model.addAttribute("pageBean", pageBean);
        model.addAttribute("userList", userList);
        model.addAttribute("hotUserList", hotUserList);
        return "index";
    }

    @RequestMapping("/toPost.do")
    public String toPost(int postId, Model model, HttpSession session) {
        Integer sessionUid = (Integer) session.getAttribute("userId");
        Post post = postService.getPostByPostId(postId);
        if (post != null) {
            postService.insertPostVisit(post.getPostId());
            List<Comment> commentList = commentService.listComment(postId);
            List<Post> listPostsSameTopic = postService.listPostByTopicId(post.getTopic().getTopicId(), postId);

            boolean liked = false;
            if (sessionUid != null) {
                liked = postService.getLikeStatus(postId, sessionUid);
            }
            model.addAttribute("post", post);
            model.addAttribute("commentList", commentList);
            model.addAttribute("liked", liked);
            model.addAttribute("suggestedTopics", listPostsSameTopic);
            return "post";
        }
        return null;
    }

    @RequestMapping(value="/searchPost.do", method = RequestMethod.GET)
    public String search(String searchTemp, Model model, HttpSession session) {
        PageBean<Post> pageBean = postService.searchByTitle(searchTemp);
        List<User> userList = userService.listUserByTime();
        List<User> hotUserList = userService.listUserByHot();
        model.addAttribute("pageBean", pageBean);
        model.addAttribute("userList", userList);
        model.addAttribute("hotUserList", hotUserList);
        return "index";
    }

    @RequestMapping("/deletePost.do")
    public String deletePost(int postId, Model model, HttpSession session) {
        Integer sessionUid = (Integer) session.getAttribute("userId");
        Post post = postService.getPostByPostId(postId);

        if (sessionUid == post.getUser().getUserId()) {
            if (postService.deletePost(postId)) {
                PageBean<Post> pageBean = postService.listPostByNewestTime(1);
                List<User> userList = userService.listUserByTime();
                List<User> hotUserList = userService.listUserByHot();
                String sortBy = "newestTime";
                model.addAttribute("sortBy", sortBy);
                model.addAttribute("pageBean", pageBean);
                model.addAttribute("userList", userList);
                model.addAttribute("hotUserList", hotUserList);
                return "index";
            }
        }

        return null;
    }

    @RequestMapping("/editPost.do")
    public String editPost(int postId, Model model, HttpSession session) {
        Integer sessionUid = (Integer) session.getAttribute("userId");
        Post post = postService.getPostByPostId(postId);

        return "index";
    }

    @RequestMapping(value = "/ajaxClickLike.do", method = RequestMethod.GET)
    public @ResponseBody
    String ajaxClickLike(int postId, boolean liked, HttpSession session) {
        int sessionUid = (int) session.getAttribute("userId");
        boolean isCheck = liked;
        return postService.clickLike(postId, sessionUid);
    }

    @RequestMapping(value = "/getLikeCounts.do", method = RequestMethod.GET)
    public ResponseEntity<Integer> getSampleData (int postId, HttpSession session, Model model) {
//        int a = postId;
        Post post = postService.getPostByPostId(postId);
        int likeCount = post.getLikeCount();
        boolean liked = false;
        Integer sessionUid = (Integer) session.getAttribute("userId");
        if (sessionUid != null) {
            liked = postService.getLikeStatus(postId, sessionUid);
        }
        model.addAttribute("liked", liked);
        return new ResponseEntity<>(likeCount, HttpStatus.OK);
    }

}
