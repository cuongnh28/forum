package com.fc.controller;

import com.fc.model.Message;
import com.fc.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/")
public class MessageController {

    @Autowired
    private MessageService messageService;

    @RequestMapping("/toMessage.do")
    public String toMessage(Model model, HttpSession session) {
        Integer sessionUid = (Integer) session.getAttribute("userId");
        Map<String, List<Message>> map = messageService.listMessageByUserId(sessionUid);
        model.addAttribute("map", map);
//        System.out.println(map);
        return "message";
    }

}
