<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="css/wangEditor.css">
    <link rel="stylesheet" type="text/css" href="css/base.css">
    <link rel="stylesheet" type="text/css" href="css/profile.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

</head>
<body>
<%@ include file="header.jsp" %>


<div class="main w clearfix">
    <div class="m-left">
        <div class="user-image"><img src="../../upload/images/${user.headUrl}"></div>
        <div class="user-info">
            <div class="user-name">${user.username}</div>
            <div class="user-desc">${user.description}</div>
            <div class="user-position">Position：${user.position}</div>
            <div class="user-school">School：${user.school}</div>
            <div class="user-job">Job：${user.job}</div>
        </div>
        <div class="clearfix" style="border-bottom: 1px dashed #ddd;"></div>
        <div class="user-button">
            <c:choose>
                <c:when test="${following == true && sessionScope.userId != null}">
                    <a href="unfollow.do?userId=${user.userId}" class="button-unfollow">Unfollow</a>
                </c:when>
                <c:otherwise>
                    <c:choose>
                        <c:when test="${sessionScope.userId != null}">
                            <a href="follow.do?userId=${user.userId}" class="button-follow">Follow</a>
                        </c:when>
                    </c:choose>
                </c:otherwise>
            </c:choose>

        </div>

        <div class="user-post">
            <div class="user-post-title"><span></span>&nbsp;User Post Title</div>
            <ul class="user-post-list">
                <c:forEach items="${postList}" var="post">
                    <li>
                        <span class="glyphicon glyphicon-file"></span>&nbsp;
                        <a href="toPost.do?postId=${post.postId}">${post.title}</a>
                        <span class="user-post-time">Publish Time ${post.publishTime}</span>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>

    <div class="m-right">
        <div class="user-follow">
            <div class="user-follow">Following: <span class="user-count">${user.followCount}</span></div>
            <div class="user-follower">Followers: <span class="user-count">${user.followerCount}</span></div>
        </div>
        <div class="user-attr">
            <span class="user-like-count">Like Counts：${user.likeCount}</span><br/>
            <span class="user-post-count">Post Counts：${user.postCount}</span>

        </div>
        <div class="user-scan-count">Scans: ${user.scanCount}</div>
    </div>

</div>

<%@ include file="footer.jsp" %>
<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="js/base.js"></script>
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













