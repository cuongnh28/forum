package com.fc.service;

import com.fc.async.MessageTask;
import com.fc.mapper.MessageMapper;
import com.fc.mapper.PostMapper;
import com.fc.mapper.ReplyMapper;
import com.fc.mapper.TopicMapper;
import com.fc.mapper.UserMapper;
import com.fc.model.Comment;
import com.fc.model.Reply;
import com.fc.model.Topic;
import com.fc.model.User;
import com.fc.util.MyConstant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.task.TaskExecutor;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class TopicService {


    @Autowired
    private TopicMapper topicMapper;

    @Autowired
    private ReplyMapper replyMapper;

    @Autowired
    private PostMapper postMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private MessageMapper messageMapper;

    @Autowired
    private TaskExecutor taskExecutor;

    public List<Topic> listTopic() {
        return topicMapper.listTopic();
    }

    public List<String> listImage() {
        return topicMapper.listImage();
    }

    public void addTopic(String name, String content, int sessionUid) {
        User user = new User(sessionUid);
        Topic topic = new Topic();
        topic.setName(name);
        topic.setContent(content);
        topicMapper.insertTopic(topic);
        taskExecutor.execute(new MessageTask(messageMapper, userMapper, postMapper, replyMapper, sessionUid, MyConstant.OPERATION_COMMENT));
    }
}

