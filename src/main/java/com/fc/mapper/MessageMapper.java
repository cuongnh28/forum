package com.fc.mapper;

import com.fc.model.Message;

import java.util.List;

public interface MessageMapper {

    void insertMessage(Message message);

    List<Message> listMessageByUid(Integer userId);

    void deleteMassage(int postId);

}
