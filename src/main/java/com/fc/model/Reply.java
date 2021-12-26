package com.fc.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;
import java.util.List;

@NoArgsConstructor
@Getter
@Setter
public class Reply {

    private Integer replyId;
    private String content;
    private Post post;
    private User user;

    private Date replyTime;

    private List<Comment> commentList;

    public Reply(Integer replyId) {
        this.replyId = replyId;
    }

    @Override
    public String toString() {
        return "Reply{" +
                "replyId=" + replyId +
                ", content='" + content + '\'' +
                ", post=" + post +
                ", user=" + user +
                ", replyTime='" + replyTime + '\'' +
                ", commentList=" + commentList +
                '}';
    }
}
