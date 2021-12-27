package com.fc.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.io.*;
import java.util.Date;

@NoArgsConstructor
@Getter
@Setter
@Entity
public class Post implements Serializable {
    @Id
    private Integer postId;
    @Column
    private String title;
    @Column
    private String content;
    @Column
    private Date publishTime;
    @Column
    private Date replyTime;
    @Column
    private Integer replyCount;
    @Column
    private Integer likeCount;
    @Column
    private Integer scanCount;
    @Column
    private String isPublish;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "userId")
    private User user;

    private Topic topic;


    public Post(Integer postId) {
        this.postId = postId;
    }

    @Override
    public String toString() {
        return "Post{" +
                "postId=" + postId +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", publishTime='" + publishTime + '\'' +
                ", replyTime='" + replyTime + '\'' +
                ", replyCount=" + replyCount +
                ", likeCount=" + likeCount +
                ", scanCount=" + scanCount +
                ", user=" + user +
                ", topic=" + topic +
                '}';
    }
}
