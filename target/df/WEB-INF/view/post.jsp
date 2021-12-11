﻿<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
	<title></title>
	<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="css/wangEditor.css">
	<link rel="stylesheet" type="text/css" href="css/base.css">
	<link rel="stylesheet" type="text/css" href="css/post.css">
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
					<div class="user-image"><a href="toProfile.do?uid=${post.user.uid}"><img src="${post.user.headUrl}"></a></div>
					<div class="user-info">
						<div class="user-name">${post.user.username}</div>
						<div class="post-time">Publish Time ${post.publishTime}</div>
					</div>
					<div class="other-count">
						<span class="reply-count"><a href="#">Reply count ${post.replyCount}</a></span>&nbsp;
                        <c:choose>
                            <c:when test="${sessionScope.uid==null}">
                                <span class="up-count"><a>Like count ${post.likeCount}</a></span>&nbsp;
                            </c:when>
                            <c:when test="${liked==true}">
                                <span class="up-count"><a style="color:#2e6da4;">Like count ${post.likeCount}</a></span>&nbsp;
                            </c:when>
                            <c:when test="${sessionScope.uid!=null}">
                                <span class="up-count"><a href="#" id="like-button">Like count ${post.likeCount}</a></span>&nbsp;
                            </c:when>
                        </c:choose>
						<span class="scan-count"><a href="#">Scan count ${post.scanCount}</a></span>
					</div>
				</div>
				<div class="post-desc">
					${post.content}
				</div>
			</div>



			<div class="post-reply">
				<div class="post-reply-title">
					<h2 class="reply-count"><span class="glyphicon glyphicon-th"></span>&nbsp;${post.replyCount}Reply count</h2>
					<a href="#reply-area">reply area</a>
				</div>
				<div class="post-reply-content">
                    <c:forEach items="${replyList}" var="reply" varStatus="status">
                        <div class="post-reply-item clearfix">
                            <div class="item-image"><a href="toProfile.do?uid=${reply.user.uid}"><img src="${reply.user.headUrl}"></a></div>
                            <div class="item-info">
                                <div class="item-user-name"><a href="#">${reply.user.username}</a></div>
                                <div class="item-content">${reply.content}</div>
                                <div class="item-date">Reply Time ${reply.replyTime}</div>

                                <div class="item-more">
                                    <c:forEach items="${reply.commentList}" var="comment">
                                        <div class="item-wrap">
                                            <div class="item-more-1">
                                                <a href="toProfile.do?uid=${comment.user.uid}" class="item-more-user">${comment.user.username}</a>
                                                <span>：</span>
                                                <span class="item-more-content">${comment.content}</span>
                                            </div>

                                            <div class="item-more-date">${comment.commentTime}</div>
                                            <div class="item-more-other">
                                                <a href="#s${status.count}" class="item-more-reply">Status count</a>&nbsp;
                                            </div>
                                        </div>
                                    </c:forEach>

                                    <div class="reply-input">
                                        <form action="comment.do" method="post">
                                            <input type="hidden" name="pid" value="${post.pid}"/>
                                            <input type="hidden" name="rid" value="${reply.rid}"/>
                                            <textarea id="s${status.count}" name="content"></textarea>
                                            <button type="submit">Submit</button>
                                        </form>
                                    </div>
                                </div>

                            </div>
                            <div class="item-other">
                                <a href="#s${status.count}" class="item-reply">Count</a>&nbsp;
                            </div>

                        </div>
                    </c:forEach>
				</div>
			</div>



			<div id="reply-area" class="post-reply-textarea">
				<div style="width: 650px;margin: 10px 20px">
					<form action="reply.do" method="post" enctype="multipart/form-data">
						<input type="hidden" name="pid" value="${post.pid}" />
						<textarea name="content" id="textarea" style="height: 200px;max-height: 1000px;"></textarea>
						<button class="reply-button">Reply</button>
					</form>
				</div>
			</div>

		</div>


		<div class="main-right">
			<div class="hot-user">
				<div class="clearfix"><div class="hot-user-title"><span></span>&nbsp;Hot User</div></div>
				<ul class="hot-user-list">
                    <li class="clearfix">
                        <a href="https://www.facebook.com/cuongnh28/" class="hot-user-image"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/JPEG_example_flower.jpg/300px-JPEG_example_flower.jpg"></a>
                        <a href="https://www.facebook.com/cuongnh28/" class="hot-user-name">cuongnh28</a>
                    </li>
<%--                    <li class="clearfix">--%>
<%--                        <a href="http://gold.xitu.io/" class="hot-user-image"><img src="http://tva3.sinaimg.cn/crop.0.0.227.227.180/005SiNxyjw8f6nd2g4erxj306g06c74g.jpg"></a>--%>
<%--                        <a href="http://gold.xitu.io/" class="hot-user-name">稀土掘金</a>--%>
<%--                    </li>--%>
<%--                    <li class="clearfix">--%>
<%--                        <a href="https://segmentfault.com/" class="hot-user-image"><img src="http://tva2.sinaimg.cn/crop.0.0.180.180.180/795bf814jw1e8qgp5bmzyj2050050aa8.jpg"></a>--%>
<%--                        <a href="https://segmentfault.com/" class="hot-user-name">SegmentFault</a>--%>
<%--                    </li>--%>
<%--                    <li class="clearfix">--%>
<%--                        <a href="http://www.nowcoder.com/" class="hot-user-image"><img src="http://tva2.sinaimg.cn/crop.163.177.629.629.180/8116e3ccjw8er0ic82ljxj20qo0zk0u6.jpg"></a>--%>
<%--                        <a href="http://www.nowcoder.com/" class="hot-user-name">牛客网</a>--%>
<%--                    </li>--%>
<%--                    <li class="clearfix">--%>
<%--                        <a href="http://www.importnew.com/" class="hot-user-image"><img src="http://tva3.sinaimg.cn/crop.0.0.200.200.180/b254dc71jw1edshiof1s8j205k05kweh.jpg"></a>--%>
<%--                        <a href="http://www.importnew.com/" class="hot-user-name">ImportNew</a>--%>
<%--                    </li>--%>
<%--                    <li class="clearfix">--%>
<%--                        <a href="http://www.imooc.com/" class="hot-user-image"><img src="http://tva4.sinaimg.cn/crop.39.34.440.440.180/c5131475tw1egjkvkxkltj20e80e83yr.jpg"></a>--%>
<%--                        <a href="http://www.imooc.com/" class="hot-user-name">慕课网</a>--%>
<%--                    </li>--%>
<%--                    <li class="clearfix">--%>
<%--                        <a href="http://www.jikexueyuan.com/" class="hot-user-image"><img src="http://tva4.sinaimg.cn/crop.0.0.1022.1022.180/005xFAqKgw1ena5m2p0nrj30sg0sgwge.jpg"></a>--%>
<%--                        <a href="http://www.jikexueyuan.com/" class="hot-user-name">极客学院</a>--%>
<%--                    </li>--%>
<%--                    <li class="clearfix">--%>
<%--                        <a href="http://www.maiziedu.com/" class="hot-user-image"><img src="http://tva2.sinaimg.cn/crop.0.0.283.283.180/ac95fb6cjw1f4gyjr7exkj207w07wdg0.jpg"></a>--%>
<%--                        <a href="http://www.maiziedu.com/" class="hot-user-name">麦子学院</a>--%>
<%--                    </li>--%>
<%--                    <li class="clearfix">--%>
<%--                        <a href="http://study.163.com/" class="hot-user-image"><img src="http://tva1.sinaimg.cn/crop.0.0.200.200.180/ba94de6bjw1eldy8chcy0j205k05kq2r.jpg"></a>--%>
<%--                        <a href="http://study.163.com/" class="hot-user-name">网易云课堂</a>--%>
<%--                    </li>--%>
<%--                    <li class="clearfix">--%>
<%--                        <a href="https://www.xuetangx.com/" class="hot-user-image"><img src="http://tva3.sinaimg.cn/crop.0.0.208.208.180/005CvE72jw8ep4f11x1qnj305s05swek.jpg"></a>--%>
<%--                        <a href="https://www.xuetangx.com/" class="hot-user-name">学堂在线</a>--%>
<%--                    </li>--%>
<%--                    <li class="clearfix">--%>
<%--                        <a href="https://www.jisuanke.com/" class="hot-user-image"><img src="http://tva1.sinaimg.cn/crop.0.0.500.500.180/005FHjdCjw8ezalw82qynj30dw0dwq33.jpg"></a>--%>
<%--                        <a href="https://www.jisuanke.com/" class="hot-user-name">计蒜客</a>--%>
<%--                    </li>--%>
<%--                    <li class="clearfix">--%>
<%--                        <a href="https://www.shiyanlou.com/" class="hot-user-image"><img src="http://tva4.sinaimg.cn/crop.3.0.123.123.180/005AWTo8gw1elmhwrcdndj303m03m3yd.jpg"></a>--%>
<%--                        <a href="https://www.shiyanlou.com/" class="hot-user-name">实验楼</a>--%>
<%--                    </li>--%>
				</ul>
			</div>
		</div>
	</div>



<%@ include file="footer.jsp" %>
<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="js/wangEditor.js"></script>
<script type="text/javascript" src="js/base.js"></script>
<script type="text/javascript">
    var editor = new wangEditor('textarea');

    editor.config.menus = [
        'source',
        '|',
        'bold',
        'underline',
        'italic',
        'strikethrough',
        'eraser',
        'fontsize',
        '|',
        'link',
        'table',
        'emotion',
        '|',
        'img',
        'insertcode',
        '|',
        'undo',
     ];
     
     editor.config.uploadImgUrl = 'upload.do';
     editor.config.uploadImgFileName = 'myFileName';

		
    editor.create();

    var likeButton = $("#like-button");
    likeButton.click(function(){
        $.ajax({
            type:"GET",
            url:"ajaxClickLike.do",
            data:{pid:${post.pid}},
            success:function(response,status,xhr){
                likeButton.text("赞 "+response);
                likeButton.removeAttr("href");
            }
        });
    });
    
</script>
</body>
</html>