package com.fc.mapper;

import com.fc.model.Post;
import org.apache.ibatis.annotations.Param;

import java.util.List;


public interface PostMapper {


    List<Post> listPostByUserId(int userId);

    int insertPost(Post post);

    List<Post> listPostByNewestTime(@Param("offset") int offset, @Param("limit") int limit);

    List<Post> listPostByLatestTime(@Param("offset") int offset, @Param("limit") int limit);

    List<Post> listPostByHottest(@Param("offset") int offset, @Param("limit") int limit);

    List<Post> listPostByTopic(@Param("topicId") int topicId, @Param("offset") int offset, @Param("limit") int limit);

    List<Post> listPostByTopicId(@Param("topicId") int topicId, @Param("postId") int postId);

    List<Post> searchByTitle(@Param("title") String title);

    int selectPostCount();

    Post getPostByPostId(int postId);

    void updateReplyCount(int postId);

    void updateScanCount(int postId);

    void updateReplyTime(int postId);

    int getUserIdByPostId(int postId);

    String getTitleByPostId(int postId);

    void deletePost(int postId);

}
