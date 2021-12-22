<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="css/base.css">
</head>
<body>
<%@ include file="header.jsp" %>

<div class="main w clearfix">
    <div class="main-left">
        <div class="share">
            <div class="share-left"><span></span>&nbsp;Topic</div>
            <div class="share-right">
                <a href="toPublish.do"><span class="glyphicon glyphicon-pencil"></span>&nbsp;Write</a>
            </div>
        </div>
        <div class="post">
            <div class="post-wrap">
                <div class="post-choice">
                    <a href="listPostByNewestTime.do?curPage=${pageBean.curPage }"
                       class="post-choice-current">Newest</a>
                    <a href="listPostByHottest.do?curPage=${pageBean.curPage }">Hottest</a>
                    <a href="listPostByLatestTime.do?curPage=${pageBean.curPage }" class="post-choice-last">Latest</a>
                </div>

                <ul class="post-list">
                    <c:forEach items="${pageBean.list}" var="post">
                        <li class="clearfix">
                            <div class="post-image">
                                <a href="toProfile.do?userId=${post.user.userId}"><img src="../../upload/images/${post.user.headUrl}"></a>
                            </div>
                            <div class="post-content">
                                <div class="post-title"><a href="toPost.do?postId=${post.postId}">${post.title}</a>
                                </div>
                                <div class="post-other">
                                    <div class="post-other-left">
                                        <span class="post-username"><a
                                                href="toProfile.do?userId=${post.user.userId}">${post.user.username}</a></span>
                                        <span class="post-time">&nbsp;Post Time: ${post.publishTime}</span>
                                        <span class="post-reply-time">Reply Time: ${post.replyTime}</span>
                                    </div>
                                    <div class="post-other-right">
                                        <span class="post-reply-count">Replies: ${post.replyCount}</span>&nbsp;
                                        <span class="post-like-count">Likes: ${post.likeCount}</span>&nbsp;
                                        <span class="post-scan-count">Scans: ${post.scanCount}</span>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </c:forEach>
                </ul>

                <nav class="col-md-10 col-md-offset-2">
                    <ul class="pagination pagination-sm">
                        <c:choose>
                            <c:when test="${sortBy.equalsIgnoreCase('newestTime')}">
                                <li><a href="listPostByNewestTime.do?curPage=1">Page 1</a></li>
                            </c:when>
                            <c:when test="${sortBy.equalsIgnoreCase('hottest')}">
                                <li><a href="listPostByHottest.do?curPage=1">Page 1</a></li>
                            </c:when>
                            <c:when test="${sortBy.equalsIgnoreCase('latestTime')}">
                                <li><a href="listPostByLatestTime.do?curPage=1">Page 1</a></li>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${pageBean.curPage != 1 }">
<%--                                <li>--%>
<%--                                    <a href="listPostByNewestTime.do?curPage=${pageBean.curPage-1 }"><span>&laquo;</span></a>--%>
<%--                                </li>--%>
                                <c:choose>
                                    <c:when test="${sortBy.equalsIgnoreCase('newestTime')}">
                                        <li><a href="listPostByNewestTime.do?curPage=${pageBean.curPage-1 }"><span>&laquo;</span></a></li>
                                    </c:when>
                                    <c:when test="${sortBy.equalsIgnoreCase('hottest')}">
                                        <li><a href="listPostByHottest.do?curPage=${pageBean.curPage-1 }"><span>&laquo;</span></a></li>
                                    </c:when>
                                    <c:when test="${sortBy.equalsIgnoreCase('latestTime')}">
                                        <li><a href="listPostByLatestTime.do?curPage=${pageBean.curPage-1 }"><span>&laquo;</span></a></li>
                                    </c:when>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <li><span>&laquo;</span></li>
                            </c:otherwise>
                        </c:choose>
                        <c:choose>
                            <c:when test="${pageBean.allPage<=10 }">
                                <c:forEach begin="1" end="${ pageBean.allPage}" var="i">
<%--                                    <li class="pageNum"><a href="listPostByNewestTime.do?curPage=${i }">${i }</a></li>--%>
                                    <c:choose>
                                        <c:when test="${sortBy.equalsIgnoreCase('newestTime')}">
                                            <li class="pageNum"><a href="listPostByNewestTime.do?curPage=${i }">${i }</a></li>
                                        </c:when>
                                        <c:when test="${sortBy.equalsIgnoreCase('latestTime')}">
                                            <li class="pageNum"><a href="listPostByLatestTime.do?curPage=${i }">${i }</a></li>
                                        </c:when>
                                        <c:when test="${sortBy.equalsIgnoreCase('hottest')}">
                                            <li class="pageNum"><a href="listPostByHottest.do?curPage=${i }">${i }</a></li>
                                        </c:when>
                                    </c:choose>
                                </c:forEach>
                            </c:when>
                            <c:when test="${pageBean.curPage<=5 }">
                                <c:forEach begin="1" end="10" var="i">
<%--                                    <li class="pageNum"><a href="listPostByNewestTime.do?curPage=${i }">${i }</a></li>--%>
                                    <c:choose>
                                        <c:when test="${sortBy.equalsIgnoreCase('newestTime')}">
                                            <li class="pageNum"><a href="listPostByNewestTime.do?curPage=${i }">${i }</a></li>
                                        </c:when>
                                        <c:when test="${sortBy.equalsIgnoreCase('latestTime')}">
                                            <li class="pageNum"><a href="listPostByLatestTime.do?curPage=${i }">${i }</a></li>
                                        </c:when>
                                        <c:when test="${sortBy.equalsIgnoreCase('hottest')}">
                                            <li class="pageNum"><a href="listPostByHottest.do?curPage=${i }">${i }</a></li>
                                        </c:when>
                                    </c:choose>
                                </c:forEach>
                            </c:when>
                            <c:when test="${pageBean.allPage-pageBean.curPage<5 }">
                                <c:forEach begin="${pageBean.allPage-9 }" end="${ pageBean.allPage}" var="i">
<%--                                    <li class="pageNum"><a href="listPostByNewestTime.do?curPage=${i }">${i }</a></li>--%>
                                    <c:choose>
                                        <c:when test="${sortBy.equalsIgnoreCase('newestTime')}">
                                            <li class="pageNum"><a href="listPostByNewestTime.do?curPage=${i }">${i }</a></li>
                                        </c:when>
                                        <c:when test="${sortBy.equalsIgnoreCase('latestTime')}">
                                            <li class="pageNum"><a href="listPostByLatestTime.do?curPage=${i }">${i }</a></li>
                                        </c:when>
                                        <c:when test="${sortBy.equalsIgnoreCase('hottest')}">
                                            <li class="pageNum"><a href="listPostByHottest.do?curPage=${i }">${i }</a></li>
                                        </c:when>
                                    </c:choose>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <c:forEach begin="${pageBean.curPage-4 }" end="${ pageBean.curPage+5}" var="i">--%>
<%--                                    <li class="pageNum"><a href="listPostByNewestTime.do?curPage=${i }">${i }</a></li>--%>
                                    <c:choose>
                                        <c:when test="${sortBy.equalsIgnoreCase('newestTime')}">
                                            <li class="pageNum"><a href="listPostByNewestTime.do?curPage=${i }">${i }</a></li>
                                        </c:when>
                                        <c:when test="${sortBy.equalsIgnoreCase('latestTime')}">
                                            <li class="pageNum"><a href="listPostByLatestTime.do?curPage=${i }">${i }</a></li>
                                        </c:when>
                                        <c:when test="${sortBy.equalsIgnoreCase('hottest')}">
                                            <li class="pageNum"><a href="listPostByHottest.do?curPage=${i }">${i }</a></li>
                                        </c:when>
                                    </c:choose>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                        <c:choose>
                            <c:when test="${pageBean.curPage!=pageBean.allPage }">
<%--                                <li>--%>
<%--                                    <a href="listPostByNewestTime.do?curPage=${pageBean.curPage+1 }"><span>&raquo;</span></a>--%>
<%--                                </li>--%>
                                <c:choose>
                                    <c:when test="${sortBy.equalsIgnoreCase('newestTime')}">
                                        <li><a href="listPostByNewestTime.do?curPage=${pageBean.curPage+1 }"><span>&raquo;</span></a></li>
                                    </c:when>
                                    <c:when test="${sortBy.equalsIgnoreCase('latestTime')}">
                                        <li><a href="listPostByLatestTime.do?curPage=${pageBean.curPage+1 }"><span>&raquo;</span></a></li>
                                    </c:when>
                                    <c:when test="${sortBy.equalsIgnoreCase('hottest')}">
                                        <li><a href="listPostByHottest.do?curPage=${pageBean.curPage+1 }"><span>&raquo;</span></a></li>
                                    </c:when>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <li><span>&raquo;</span></li>
                            </c:otherwise>
                        </c:choose>
                        <c:choose>
                            <c:when test="${sortBy.equalsIgnoreCase('newestTime')}">
                                <li><a href="listPostByNewestTime.do?curPage=${pageBean.allPage}">All page</a></li>
                            </c:when>
                            <c:when test="${sortBy.equalsIgnoreCase('latestTime')}">
                                <li><a href="listPostByLatestTime.do?curPage=${pageBean.allPage}">All page</a></li>
                            </c:when>
                            <c:when test="${sortBy.equalsIgnoreCase('hottest')}">
                                <li><a href="listPostByHottest.do?curPage=${pageBean.allPage}">All page</a></li>
                            </c:when>
                        </c:choose>
                    </ul>
                </nav>

            </div>
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
                        <a href="toProfile.do?userId=${user.userId}" class="hot-user-image"><img src="../../upload/images/${user.headUrl}"></a>
                        <a href="toProfile.do?userId=${user.userId}" class="hot-user-name">${user.username}</a>
                    </li>
                </c:forEach>
            </ul>
        </div>

        <div class="hot-user">
            <div class="clearfix">
                <div class="hot-user-title"><span></span>&nbsp;New Users</div>
            </div>
            <ul class="hot-user-list">
                <c:forEach items="${userList}" var="user">
                    <li class="clearfix">
                        <a href="toProfile.do?userId=${user.userId}" class="hot-user-image"><img src="../../upload/images/${user.headUrl}"></a>
                        <a href="toProfile.do?userId=${user.userId}" class="hot-user-name">${user.username}</a>
                    </li>
                </c:forEach>
            </ul>
        </div>

    </div>
</div>

<%@ include file="footer.jsp" %>
<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="js/base.js"></script>
<script type="text/javascript">
    $(function () {
        var curPage = ${pageBean.curPage};
        $(".pageNum").each(function () {
            if ($(this).text() == curPage) {
                $(this).addClass("active");
            }
        });
    });

</script>
</body>
</html>
