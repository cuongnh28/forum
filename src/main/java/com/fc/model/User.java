package com.fc.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class User {

    private Integer userId;

    private String email;
    private String password;
    private Integer actived;
    private String activateCode;
    private String joinTime;

    private String username;
    private String description;
    private String headUrl;
    private String position;
    private String school;
    private String job;

    private Integer postCount;
    private Integer scanCount;
    private Integer likeCount;
    private Integer followCount;
    private Integer followerCount;

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
