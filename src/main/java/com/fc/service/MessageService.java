package com.fc.service;

import com.fc.mapper.MessageMapper;
import com.fc.model.Message;
import com.fc.util.MyUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class MessageService {

    @Autowired
    private MessageMapper messageMapper;

    public Map<String, List<Message>> listMessageByUserId(Integer sessionUid) {
        List<Message> messageList = messageMapper.listMessageByUid(sessionUid);
        Map<String, List<Message>> map = new HashMap<>();
        for (Message message : messageList) {
            String time = MyUtil.formatDate(message.getMsgTime()).substring(0, 11);
            if (map.get(time) == null) {
                map.put(time, new LinkedList<>());
                map.get(time).add(message);
            } else {
                map.get(time).add(message);
            }
        }
        map = sortByTime(map);
        return map;
    }

    public static Map<String, List<Message>> sortByTime(Map<String, List<Message>> map)
    {
        TreeMap<String, List<Message>> sorted = new TreeMap<>();

        sorted.putAll(map);

        return sorted;
    }
}
