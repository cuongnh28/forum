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

</head>
<body>
<%@ include file="header.jsp" %>


<div class="main w clearfix">

    <div class="main-left">

        <div class="post-content">
            <div class="post-title">
                <span class="glyphicon glyphicon-th"></span>&nbsp;${post.title}
            </div>
            <div class="post-user clearfix">
                <div class="user-image"><a href="toProfile.do?userId=${post.user.userId}"><img
                        src="../../upload/images/${post.user.headUrl}"></a>
                </div>
                <div class="user-info">
                    <div class="user-name">${post.user.username}</div>
                    <div class="post-time">Publish Time ${post.publishTime}</div>
                </div>
                <div class="delete-post">
                    <c:choose>
                        <c:when test="${post.user.userId==sessionScope.userId}">
                            <form action="/deletePost.do" method="post">
                                <input type="hidden" name="postId" value="${post.postId}">
                                <button class="btn btn-danger" type="submit" onClick="return confirm('Are you sure?')">Delete</button>
                            </form>
<%--                            <form action="/editPost.do" method="post">--%>
<%--                                <input type="hidden" name="postId" value="${post.postId}">--%>
<%--                                <button class="btn btn-secondary" type="submit" >Edit</button>--%>
<%--                            </form>--%>
                        </c:when>
                    </c:choose>
                </div>
                <div class="other-count">
                    <span class="reply-count">Replies: ${post.replyCount}</span>&nbsp;
                    <c:choose>
                        <c:when test="${sessionScope.userId==null}">
                            <span class="up-count"><a>Votes: ${post.likeCount}</a></span>&nbsp;
                        </c:when>
                        <c:when test="${liked==true}">
                            <span class="up-count"><a style="color:#2e6da4;">Votes: ${post.likeCount}</a></span>&nbsp;
                        </c:when>
                        <c:when test="${sessionScope.userId!=null}">
                            <span class="up-count"><a href="#" id="like-button">Votes: ${post.likeCount}</a></span>&nbsp;
                        </c:when>
                    </c:choose>
                    <span class="scan-count">Views: ${post.scanCount}</span>
                </div>
            </div>
            <div class="post-desc">
                ${post.content}
            </div>
        </div>


        <div class="post-reply">
            <div class="post-reply-title">
                <h2 class="reply-count"><span class="glyphicon glyphicon-th"></span>&nbsp;Reply: ${post.replyCount}
                </h2>
                <c:choose>
                    <c:when test="${sessionScope.userId != null}">
                        <a href="#reply-area">Wanna reply?</a>
                    </c:when>
                </c:choose>
            </div>
            <div class="post-reply-content">
                <c:forEach items="${replyList}" var="reply" varStatus="status">
                    <div class="post-reply-item clearfix">
                        <div class="item-image"><a href="toProfile.do?userId=${reply.user.userId}"><img
                                src="../../upload/images/${reply.user.headUrl}"></a></div>
                        <div class="delete-reply">
                            <c:choose>
                                <c:when test="${reply.user.userId==sessionScope.userId}">
                                    <form action="/deleteReply.do" method="post">
                                        <input type="hidden" name="replyId" value="${reply.replyId}">
                                        <input type="hidden" name="postId" value="${post.postId}">
                                        <button class="btn btn-danger" type="submit" onClick="return confirm('Are you sure?')">Delete</button>
                                    </form>
<%--                                    <form action="/editReply.do" method="post">--%>
<%--                                        <input type="hidden" name="postId" value="${post.postId}">--%>
<%--                                        <button class="btn btn-secondary" type="submit" >Edit</button>--%>
<%--                                    </form>--%>
                                </c:when>
                            </c:choose>
                        </div>
                        <div class="item-info">
                            <div class="item-user-name"><a href="#">${reply.user.username}</a></div>
                            <div class="item-content">${reply.content}</div>
                            <div class="item-date">Reply Time: ${reply.replyTime}</div>

                            <div class="item-more">
                                <c:forEach items="${reply.commentList}" var="comment">
                                    <div class="item-wrap">
                                        <div class="item-more-1">
                                            <a href="toProfile.do?userId=${comment.user.userId}"
                                               class="item-more-user">${comment.user.username}</a>
                                            <span>：</span>
                                            <span class="item-more-content">${comment.content}</span>
                                        </div>

                                        <div class="item-more-date">${comment.commentTime}</div>
                                    </div>
                                    <div class="delete-comment">
                                        <c:choose>
                                            <c:when test="${comment.user.userId==sessionScope.userId}">
                                                <form action="/deleteComment.do" method="post">
                                                    <input type="hidden" name="commentId" value="${comment.commentId}">
                                                    <input type="hidden" name="postId" value="${post.postId}">
                                                    <button class="btn btn-danger" type="submit" onClick="return confirm('Are you sure?')">Delete</button>
                                                </form>
                                                <%--                                    <form action="/editReply.do" method="post">--%>
                                                <%--                                        <input type="hidden" name="postId" value="${post.postId}">--%>
                                                <%--                                        <button class="btn btn-secondary" type="submit" >Edit</button>--%>
                                                <%--                                    </form>--%>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                </c:forEach>

                                <c:choose>
                                    <c:when test="${sessionScope.userId != null}">
                                        <div class="reply-input">
                                            <form action="comment.do" method="post">
                                                <input type="hidden" name="postId" value="${post.postId}"/>
                                                <input type="hidden" name="replyId" value="${reply.replyId}"/>
                                                <textarea name="content"></textarea>
                                                <button type="submit">Submit</button>
                                            </form>
                                        </div>
                                    </c:when>
                                </c:choose>
                            </div>

                        </div>
<%--                        <div class="item-other">--%>
<%--                            <a href="#s${status.count}" class="item-reply">Count</a>&nbsp;--%>
<%--                        </div>--%>

                    </div>
                </c:forEach>
            </div>
        </div>


        <c:choose>
            <c:when test="${sessionScope.userId != null}">
                <div id="reply-area" class="post-reply-textarea">
                    <div style="width: 650px;margin: 10px 20px">
                        <form action="reply.do" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="postId" value="${post.postId}"/>
                            <textarea name="contentReply" id="textarea" style="height: 200px;max-height: 1000px;"></textarea>
                            <button class="reply-button">Reply</button>
                        </form>
                    </div>
                </div>
            </c:when>
        </c:choose>

    </div>

    <div class="main-right">
        <div class="hot-user">
            <div class="clearfix">
                <div class="hot-user-title"><span></span>&nbsp;Suggested Topics</div>
            </div>
            <ul class="hot-user-list">
                <c:forEach items="${suggestedTopics}" var="post">
                    <li>
                        <span class="glyphicon glyphicon-file"></span>&nbsp;
                        <a href="toPost.do?postId=${post.postId}">${post.title}</a>
                        <span class="user-post-time"> ${post.publishTime}</span>
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
    CKEDITOR.replace('contentReply');
    // var editor = new wangEditor('textarea');
    //
    // editor.config.menus = [
    //     'source',
    //     '|',
    //     'bold',
    //     'underline',
    //     'italic',
    //     'strikethrough',
    //     'eraser',
    //     'fontsize',
    //     '|',
    //     'table',
    //     'link',
    //     '|',
    //     'img',
    //     'insertcode',
    //     '|',
    //     'undo',
    // ];
    //
    // editor.config.uploadImgUrl = 'upload.do';
    // editor.config.uploadImgFileName = 'myFileName';
    //
    //
    // editor.create();

    var likeButton = $("#like-button");
    likeButton.click(function () {
        $.ajax({
            type: "GET",
            url: "ajaxClickLike.do",
            data: {postId:${post.postId}},
            success: function (response, status, xhr) {
                likeButton.text("voted " + response);
                likeButton.removeAttr("href");
            }
        });
    });

</script>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
        integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>
</body>
</html>
