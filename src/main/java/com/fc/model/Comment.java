package com.fc.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Column;
import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
public class Comment {

    private Integer commentId;

    private String content;
    private Reply reply;
    private User user;
    private String isPublish = "N";

    private Date commentTime;

    @Override
    public String toString() {
        return "Comment{" +
                "commentId=" + commentId +
                ", content='" + content + '\'' +
                ", reply=" + reply +
                ", user=" + user +
                ", commentTime='" + commentTime + '\'' +
                '}';
    }
}
