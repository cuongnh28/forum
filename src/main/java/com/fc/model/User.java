package com.fc.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.io.*;

@Getter
@Setter
@NoArgsConstructor
@Entity
public class User implements Serializable {

    @Id
    private Integer userId;

    @Column
    private String email;
    @Column
    private String password;
    @Column
    private Integer actived;
    @Column
    private String activateCode;
    @Column
    private String joinTime;

    @Column
    private String username;
    @Column
    private String description;
    @Column
    private String headUrl;
    @Column
    private String position;
    @Column
    private String school;
    @Column
    private String job;

    @Column
    private Integer postCount;
    @Column
    private Integer scanCount;
    @Column
    private Integer likeCount;
    @Column
    private Integer followCount;
    @Column
    private Integer followerCount;

    private FullName fullName;

    public User(Integer userId) {
        this.userId = userId;
    }

    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", actived=" + actived +
                ", activateCode='" + activateCode + '\'' +
                ", joinTime='" + joinTime + '\'' +
                ", username='" + username + '\'' +
                ", description='" + description + '\'' +
                ", headUrl='" + headUrl + '\'' +
                ", position='" + position + '\'' +
                ", school='" + school + '\'' +
                ", job='" + job + '\'' +
                ", likeCount=" + likeCount +
                ", postCount=" + postCount +
                ", scanCount=" + scanCount +
                ", followCount=" + followCount +
                ", followerCount=" + followerCount +
                '}';
    }
}
