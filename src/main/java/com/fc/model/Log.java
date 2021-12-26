package com.fc.model;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class Log {

    private Integer logId;

    private Integer userId;

    private Integer replyId;
    private Integer commentId;
    private String otherUsername;
    private String operation;
    private Integer postId;
    private String displayedContent;

    private Date MsgTime;

    @Override
    public String toString() {
        return "Log{" +
                "logId=" + logId +
                ", userId=" + userId +
                ", replyId=" + replyId +
                ", commentId=" + commentId +
                ", otherUsername='" + otherUsername + '\'' +
                ", operation='" + operation + '\'' +
                ", postId=" + postId +
                ", displayedContent='" + displayedContent + '\'' +
                ", MsgTime=" + MsgTime +
                '}';
    }
}
