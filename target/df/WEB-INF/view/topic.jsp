<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="css/base.css">
    <link rel="stylesheet" type="text/css" href="css/topic.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<body>
<%@ include file="header.jsp" %>

<div class="main w clearfix">
    <div class="main-left">
        <div class="share">
            <div class="share-left"><span class="glyphicon glyphicon-th-large"></span>&nbsp;Home Topics</div>
            <div class="share-right">
                <c:choose>
                    <c:when test="${sessionScope.userId != null}">
                        <a href="#" id="open-mask"><span class="glyphicon glyphicon-pencil"></span>&nbsp;Up Topic</a>
                    </c:when>
                </c:choose>
            </div>
        </div>
        <div class="topic-root">
            <div class="topic-root-wrap">
                <c:forEach items="${topicList}" var="topic">
                    <a href="listPostByTopic.do?topicId=${topic.topicId}">${topic.name}</a>
                </c:forEach>

            </div>
        </div>
        <div class="topic-list">
            <div class="topic-list-wrap clearfix">
                <c:forEach items="${topicList}" var="topic" varStatus="status">
                    <c:choose>
                        <c:when test="${status.count % 2 !=0}">
                            <div class="topic-odd relative">
                                <a href="#" class="topic-image"><img src="../../upload/images/${topic.image}"></a>
                                <div class="topic-content">
                                    <a href="listPostByTopic.do?topicId=${topic.topicId}"
                                       class="topic-name">${topic.name}</a>
                                    <a href="listPostByTopic.do?topicId=${topic.topicId}"
                                       class="topic-desc">${topic.content}</a>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="topic-even relative">
                                <a href="#" class="topic-image"><img src="../../upload/images/${topic.image}"></a>
                                <div class="topic-content">
                                    <a href="listPostByTopic.do?topicId=${topic.topicId}"
                                       class="topic-name">${topic.name}</a>
                                    <a href="listPostByTopic.do?topicId=${topic.topicId}"
                                       class="topic-desc">${topic.content}</a>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>
        </div>
        <div class="topic-more">
            <a href="#">More</a>
        </div>
    </div>
    <div class="main-right">
        <div class="hot-user">
            <div class="clearfix">
                <div class="hot-user-title"><span></span>&nbsp;Hot Users</div>
            </div>
            <ul class="hot-user-list">
                <c:forEach items="${hotUserList}" var="user">
                    <li class="clearfix">
                        <a href="toProfile.do?userId=${user.userId}" class="hot-user-image"><img
                                src="../../upload/images/${user.headUrl}"></a>
                        <a href="toProfile.do?userId=${user.userId}" class="hot-user-name">${user.username}</a>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>

<div class="mask"></div>
<div class="upon-mask">
    <form action="addTopic.do" enctype="multipart/form-data" method="post">
        <div class="edit-title">
            <span class="text-danger">${error4}</span>
            <input type="text" name="name" placeholder="Topic" required>
            <input type="text" name="content" placeholder="Content">
            <input type="file" name="myFileName" required>
        </div>
        <div class="relative">
            <button type="submit">Confirm</button>
        </div>
    </form>
    <span id="close-mask">×</span>
</div>
<%@ include file="footer.jsp" %>
<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="js/base.js"></script>
<script type="text/javascript">
    $(function () {

        var openMask = $("#open-mask");
        var closeMask = $("#close-mask");
        var mask = $(".mask");
        var uponMask = $(".upon-mask");

        openMask.click(function () {
            mask.show();
            uponMask.show();
        });

        closeMask.click(function () {
            mask.hide();
            uponMask.hide();
        });
    });
</script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
        integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
        integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"></script>
</body>
</html>













