package com.fc.model;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class Message {

    private Integer messageId;

    private Integer userId;

    private Integer otherId;
    private String otherUsername;
    private String operation;
    private Integer postId;
    private String displayedContent;

    private Date MsgTime;

    @Override
    public String toString() {
        return "Message{" +
                "messageId=" + messageId +
                ", userId=" + userId +
                ", otherId=" + otherId +
                ", otherUsername='" + otherUsername + '\'' +
                ", operation='" + operation + '\'' +
                ", postId=" + postId +
                ", displayedContent='" + displayedContent + '\'' +
                ", MsgTime=" + MsgTime +
                '}';
    }
}
