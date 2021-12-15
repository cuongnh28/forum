package com.fc.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.io.*;

@NoArgsConstructor
@Getter
@Setter
@Entity
public class Topic implements Serializable {

    @Id
    private Integer topicId;
    private String name;
    private String content;
    private String image;

    public Topic(Integer topicId) {
        this.topicId = topicId;
    }

    @Override
    public String toString() {
        return "Topic{" +
                "topicId=" + topicId +
                ", name='" + name + '\'' +
                ", content='" + content + '\'' +
                ", image='" + image + '\'' +
                '}';
    }
}
