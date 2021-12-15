package com.fc.controller;

import com.fc.model.Topic;
import com.fc.service.TopicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/")
public class TopicController {

    @Autowired
    private TopicService topicService;

    @RequestMapping("/listTopic.do")
    public String listTopic(Model model) {
        List<Topic> topicList = topicService.listTopic();
        model.addAttribute("topicList", topicList);
        return "topic";
    }

    @RequestMapping("/listImage.do")
    public String listImage(Model model) {
        List<String> imageList = topicService.listImage();
        model.addAttribute("imageList", imageList);
        return "image";
    }

    @RequestMapping("/addTopic.do")
    public String addTopic(String name, String content, Model model, HttpSession session) {
        int sessionUid = (int) session.getAttribute("userId");
        topicService.addTopic(name, content, sessionUid);
        List<Topic> topicList = topicService.listTopic();
        model.addAttribute("topicList", topicList);
        return "topic";
    }

}





