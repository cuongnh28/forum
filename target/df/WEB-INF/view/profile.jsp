<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
	<title></title>
	<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="css/wangEditor.css">
	<link rel="stylesheet" type="text/css" href="css/base.css">
	<link rel="stylesheet" type="text/css" href="css/profile.css">
</head>
<body>
<%@ include file="header.jsp" %>


	<div class="main w clearfix">
		<div class="m-left">
			<div class="user-image"><img src="${user.headUrl}"></div>
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
                    <c:when test="${following==true}">
                        <a href="unfollow.do?uid=${user.uid}" class="button-unfollow">Unfollow</a>
                    </c:when>
                    <c:otherwise>
                        <a href="follow.do?uid=${user.uid}" class="button-follow">Follow</a>
                    </c:otherwise>
                </c:choose>

			</div>

			<div class="user-post">
				<div class="user-post-title"><span></span>&nbsp;User Post Title</div>
				<ul class="user-post-list">
					<c:forEach items="${postList}" var="post">
						<li>
							<span class="glyphicon glyphicon-file"></span>&nbsp;
							<a href="toPost.do?pid=${post.pid}">${post.title}</a>
							<span class="user-post-time">Publish Time ${post.publishTime}</span>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>

		<div class="m-right">
			<div class="user-follow">
				<div class="user-follow">Follow Counts<span class="user-count">${user.followCount}</span>人</div>
				<div class="user-follower">Follower Counts<span class="user-count">${user.followerCount}</span>人</div>
			</div>
			<div class="user-attr">
				<span class="user-like-count">Like Counts：${user.likeCount}</span>
				<span class="user-post-count">Post Counts：${user.postCount}</span>

			</div>
			<div class="user-scan-count">Scan Counts${user.scanCount}次</div>
		</div>

	</div>

<%@ include file="footer.jsp" %>
<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="js/base.js"></script>
</body>
</html>













