﻿<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="css/wangEditor.css">
    <link rel="stylesheet" type="text/css" href="css/base.css">
    <link rel="stylesheet" type="text/css" href="css/post.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <style>
        p img{
            width: 100%;
        }
        button{
            font-size: 15px!important;
        }
        .dropdown-toggle:after{
            content: none;
        }
        .dropdown-item{
            font-size: 15px;
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>

<div class="main w d-flex">
<%--    post--%>
    <div class="border p-3" style="width: 690px;border-radius: 8px ;">
<%--        first line of post--%>
        <div class="d-flex justify-content-between align-items-center mx-0">
            <p style="font-style: italic">In <a href="#">name of topic</a></p>
            <button class="btn dropdown-toggle p-0" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-ellipsis-h fa-2x" ></i></button>
            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                <c:choose>
                    <c:when test="${post.user.userId==sessionScope.userId}">
                        <form action="/deletePost.do" method="post" class="" style="padding: 2.5px 7.5px">
                            <input type="hidden" name="postId" value="${post.postId}">
                            <button class="btn mx-auto" type="submit" onClick="return confirm('Are you sure?')">Delete</button>
                        </form>
                        <a class="dropdown-item" href="#" style="padding: 6.25px 15px">Edit</a>
                    </c:when>
                </c:choose>
                <a class="dropdown-item" href="#" style="padding: 6.25px 15px">Report</a>
                <a class="dropdown-item" href="#" style="padding: 6.25px 15px">History edit</a>
            </div>
        </div>
<%--    title--%>
        <h2><b>${post.title}</b></h2>
<%--    author & publish date--%>
        <div class="d-flex justify-content-between">
            <p>Author: <a href="toProfile.do?userId=${post.user.userId}">${post.user.username}</a></p>
            <p class="format-date">Publish on: ${post.publishTime}</p>
        </div>
<%--    post content--%>
        <div class="border p-3 mb-3" style="font-size: 15px; border-radius: 8px;  background-color: #F2f2f2">
            ${post.content}
        </div>
<%--    like, comment, view count --%>
        <div class="border-top py-3 d-flex justify-content-between align-items-center" style="font-size: 15px">
            <div class="d-flex align-items-center">
                <div class="rounded-circle bg-primary d-flex justify-content-center align-items-center" style="width: 25px; height: 25px;">
                    <i class="fas fa-thumbs-up"></i>
                </div>
<%--                <p id="like-count" class="my-0 mx-2" style="font-size: 20px">${post.likeCount}</p>--%>
                <p id="like-count" class="my-0 mx-2" style="font-size: 20px"></p>
            </div>
            <div class="d-flex align-items-center">
                <p class="my-0 mx-3">${post.commentCount} comments</p>
                <p class="my-0">${post.scanCount} views </p>
            </div>
        </div>
<%--    like & comment button--%>
        <div class="border-top d-flex" style="font-size: 15px; border-bottom: 1px solid rgb(222, 226, 230)">
<%--            <c:choose>--%>
<%--                <c:when test="${sessionScope.uid==null}">--%>
<%--                    <span class="up-count"><a>赞 ${post.likeCount}</a></span>&nbsp;--%>
<%--                </c:when>--%>
<%--                <c:when test="${liked==true}">--%>
<%--                    <span class="up-count"><a style="color:#2e6da4;">已赞 ${post.likeCount}</a></span>&nbsp;--%>
<%--                </c:when>--%>
<%--                <c:when test="${sessionScope.uid!=null}">--%>
<%--                    <span class="up-count"><a href="#" id="like-button">赞 ${post.likeCount}</a></span>&nbsp;--%>
<%--                </c:when>--%>
<%--            </c:choose>--%>
            <button class="col py-3 btn" id="like-button"><i class="fas fa-thumbs-up"></i> like</button>
            <button class="col py-3 btn" id="comment-button"><i class="far fa-comment-alt"></i> comment</button>
        </div>


<%--        content of comments--%>
        <div id="comment-box" class="d-none">
<%--            box chat--%>
            <c:choose>
                <c:when test="${sessionScope.userId != null}">
                    <div id="comment-area" class="post-comment-textarea">
                            <form action="comment.do" method="post" enctype="multipart/form-data" style="overflow: auto">
                                <input type="hidden" name="postId" value="${post.postId}"/>
                                <textarea name="contentComment" style="height: 100px;max-height: 1000px;"></textarea>
                                <button class="btn btn-primary float-right my-3">Comment</button>
                            </form>
                    </div>
                </c:when>
            </c:choose>
<%--            other comments--%>
            <div class="">
                <c:forEach items="${commentList}" var="comment" varStatus="status">
                    <div class="d-flex my-3">
                        <div class="mr-3"><a href="toProfile.do?userId=${comment.user.userId}">
                            <img src="../../upload/images/${comment.user.headUrl}" class="rounded-circle my-2 b-block" style="width: 40px; height: 40px"></a>
                        </div>
<%--                comment content --%>
                        <div class="" style="font-size: 15px">
                            <div class="d-flex justify-content-between">
                                <div class="item-user-name mx-2"><a href="#">${comment.user.username}</a></div>

                                    <%--                            dropdown-delete comment--%>
                                <button class="btn dropdown-toggle p-0 mx-2" type="button" id="dropdownDelete" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-ellipsis-h" ></i></button>
                                <div class="dropdown-menu" aria-labelledby="dropdownDelete">
                                    <c:choose>
                                        <c:when test="${comment.user.userId==sessionScope.userId}">
                                            <form action="/deleteComment.do" method="post" class="" style="padding: 2.5px 7.5px">
                                                <input type="hidden" name="commentId" value="${comment.commentId}">
                                                <input type="hidden" name="postId" value="${post.postId}">
                                                <button class="btn mx-auto" type="submit" onClick="return confirm('Are you sure?')">Delete</button>
                                            </form>
                                            <a class="dropdown-item" href="#" style="padding: 6.25px 15px">Edit</a>
                                        </c:when>
                                    </c:choose>
                                    <a class="dropdown-item" href="#" style="padding: 6.25px 15px">Report</a>
                                    <a class="dropdown-item" href="#" style="padding: 6.25px 15px">History edit</a>
                                </div>
                            </div>


                            <div class="">
                                <div class="border p-3" style=" background-color: #F2f2f2; border-radius: 8px">${comment.content}</div>
                                <div class="d-flex justify-content-between" style="font-size: 12px">
                                    <div class="format-date mx-3 mt-1">${comment.commentTime}</div>
                                    <c:choose>
                                        <c:when test="${sessionScope.userId != null}">
                                            <a role="button" class="comment-button mx-3 mt-1">Reply</a>
                                        </c:when>
                                    </c:choose>
                                </div>
                            </div>

<%--                            comment comment--%>
                            <c:choose>
                                <c:when test="${sessionScope.userId != null}">
                                    <div class="comment-box pl-5 mt-3 d-none">
                                        <form action="reply.do" method="post" class="d-flex align-items-center">
                                            <input type="hidden" name="postId" value="${post.postId}"/>
                                            <input type="hidden" name="commentId" value="${comment.commentId}"/>
                                            <textarea name="content" class="mx-2 col" style="border-radius: 8px"></textarea>
                                            <button type="submit" class="mx-2 btn btn-secondary">Sent</button>
                                        </form>
                                    </div>
                                </c:when>
                            </c:choose>

                            <c:forEach items="${comment.replyList}" var="reply">
                                <div class="pl-5 d-flex mt-3">
                                    <div class="mr-3"><a href="toProfile.do?userId=${reply.user.userId}">
                                        <img src="../../upload/images/${reply.user.headUrl}" class="rounded-circle my-2 b-block" style="width: 32px; height: 32px"></a>
                                    </div>
                                    <div>
                                        <div class="d-flex justify-content-between">
                                            <div class="item-user-name mx-2"><a href="toProfile.do?userId=${reply.user.userId}">${reply.user.username}</a></div>

<%--                                        dropdown delete comment-comment--%>
                                            <button class="btn dropdown-toggle p-0 mx-2" type="button" id="dropdownDeleteReply" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-ellipsis-h" ></i></button>
                                            <div class="dropdown-menu" aria-labelledby="dropdownDeleteReply">
                                                <c:choose>
                                                    <c:when test="${reply.user.userId==sessionScope.userId}">
                                                        <form action="/deleteReply.do" method="post" style="padding: 2.5px 7.5px">
                                                            <input type="hidden" name="replyId" value="${reply.replyId}">
                                                            <input type="hidden" name="postId" value="${post.postId}">
                                                            <button class="btn mx-auto" type="submit" onClick="return confirm('Are you sure?')">Delete</button>
                                                        </form>
                                                        <a class="dropdown-item" href="#" style="padding: 6.25px 15px">Edit</a>
                                                    </c:when>
                                                </c:choose>
                                                <a class="dropdown-item" href="#" style="padding: 6.25px 15px">Report</a>
                                                <a class="dropdown-item" href="#" style="padding: 6.25px 15px">History edit</a>
                                            </div>
                                        </div>
                                        <div class="">
<%--                                            content comment of comment--%>
                                            <div class="border p-3" style=" background-color: #F2f2f2; border-radius: 8px">${reply.content}</div>
                                            <div class="d-flex justify-content-between" style="font-size: 12px">
                                                <div class="format-date mx-3 mt-1">${reply.replyTime}</div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <div class="col border ml-3 p-3" style="height: fit-content; min-height: 250px; border-radius: 8px; font-size: 15px">
        <div class="hot-user">
            <div class="">
                <div class="hot-user-title mb-3"><span></span><b>Suggested Topics</b></div>
            </div>
            <ul class="hot-user-list">
                <c:forEach items="${suggestedTopics}" var="post">
                    <li class="d-flex justify-content-between">
                        <a href="toPost.do?postId=${post.postId}"><span class="glyphicon glyphicon-file"></span> ${post.title}</a>
                        <span class="format-date user-post-time"> ${post.publishTime}</span>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>

</div>

<%@ include file="footer.jsp" %>
<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="js/wangEditor.js"></script>
<script type="text/javascript" src="js/base.js"></script>
<script src="../../ckeditor/ckeditor.js"></script>
<script type="text/javascript">

<%--    change time format--%>

    function timeSince(date) {

        var seconds = Math.floor((new Date() - date) / 1000);

        var interval = seconds / 31536000;

        if (interval > 1) {
            return Math.floor(interval) + " years ago";
        }
        interval = seconds / 2592000;
        if (interval > 1) {
            return Math.floor(interval) + " months ago";
        }
        interval = seconds / 86400;
        if (interval > 1) {
            return Math.floor(interval) + " days ago";
        }
        interval = seconds / 3600;
        if (interval > 1) {
            return Math.floor(interval) + " hours ago";
        }
        interval = seconds / 60;
        if (interval > 1) {
            return Math.floor(interval) + " minutes ago";
        }
        return Math.floor(seconds) + " seconds ago";
    }

    for (let i = 0; i < document.querySelectorAll('.format-date').length; i++) {
        document.querySelectorAll('.format-date')[i].innerHTML = timeSince(new Date(document.querySelectorAll('.format-date')[i].innerHTML.split('ICT').join('')))
    }

    //comment button

    for (let i = 0; i < document.querySelectorAll('.comment-button').length; i++) {
        document.querySelectorAll('.comment-button')[i].addEventListener('click', () =>{
            document.querySelectorAll('.comment-box')[i].classList.remove('d-none')
        })
    }

    // comment button

    document.querySelector('#comment-button').addEventListener('click', () =>{
        document.querySelector('#comment-box').classList.remove('d-none')
    })


    CKEDITOR.replace('contentComment');

    var likeButton = $("#like-button");
    likeButton.click(function(){
        alert("You have liked it.");
    })
// enum: 1 like, 0 unlike
    likeButton.click(function () {
        console.log('function')
        $.ajax(
            {
            type: "GET",
            url: "/ajaxClickLike.do",
            data: {postId:${post.postId},liked:${!liked}},
            success: function (response, status, xhr) {
                likeButton.text("voted " + response);
                likeButton.removeAttr("href");
                updateLikeCount();
            }
        }
        );
    });
    updateLikeCount();
    function updateLikeCount() {
        var t = $.ajax({
            url: "/getLikeCounts.do",
            type: "GET",
            dataType: "json",
            data: {postId:${post.postId}},
            contentType: "application/json; charset=utf-8"
        });

        t.done(function (result) {
            console.log(result);
            console.log('like: ', ${liked})
            // $("#like-count").remove();
            // $("#like-count");
            document.getElementById("like-count").innerText = result;
        });
    }

</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>
</body>
</html>
