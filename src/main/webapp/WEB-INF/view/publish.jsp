<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
	<title></title>
	<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="css/wangEditor.css">
	<link rel="stylesheet" type="text/css" href="css/base.css">
	<link rel="stylesheet" type="text/css" href="css/publis
	h.css">
</head>
<body>
<%@ include file="header.jsp" %>


	<div class="main w clearfix">
		<form action="publishPost.do" method="post" id="new-post-form">
            <input type="hidden" name="userId" value="${sessionScope.userId}">

			<div class="pub-header"><span></span>&nbsp;Text here (Not translate)</div>
			<div class="pub-title">
				<input type="text" name="title" placeholder="Input here text">
			</div>
			<div class="pub-topic">
				<span>Topic：</span>
				<div class="topic-list">
					<c:forEach items="${topicList}" var="topic">
                        <a class="topics" href="#" title="${topic.topicId}" onclick="chooseTopic(this)">${topic.name}</a>
<%--						<input>--%>
                    </c:forEach>
				</div>
			</div>

			<div class="pub-textarea">
				<div style="width: 920px;">
					<textarea name="content" id="input-content" style="height: 300px;max-height: 1000px;"></textarea>
				</div>
                <button class="pub-button">Publish</button>
			</div>
		</form>

	</div>

<%@ include file="footer.jsp" %>
<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="js/wangEditor.js"></script>
<script type="text/javascript" src="js/base.js"></script>
<script src="../../ckeditor/ckeditor.js"></script>
<script type="text/javascript">
	window.onload = function () {
		let form = document.getElementById("new-post-form");
		form.onsubmit = function (ev) {
			ev.preventDefault();
			let selectedTopics = document.getElementsByClassName("selectedTopic");
			let data = {
				title: document.getElementsByName("title")[0].value,
				content: CKEDITOR.instances["input-content"].getData(),
				topic: {topicId: selectedTopics != null && selectedTopics.length > 0 ? selectedTopics[0].getAttribute("title") : null},
				user: {userId: document.getElementsByName("userId")[0].value}
			};

			// validate here
			if (data.title == null || data.title === "") {
				alert("Chưa Nhập Topic");
				return;
			}

			addNewPost(data, "/publishPost.do");
		};
	};

	// larry
	function addNewPost(post, url) {
		let req = new XMLHttpRequest();
		req.open("POST", url, true);
		req.setRequestHeader("Content-Type", "application/json");
		req.responseType = "text";
		req.onreadystatechange = function () {
			if (this.readyState !== XMLHttpRequest.DONE) {
				return;
			}
			if (this.status !== 200) {
				alert("Error! Can't publish post!");
			} else {
				window.location = "/toPost.do?postId=" + this.responseText;
			}
		};
		req.send(JSON.stringify(post));
	}

	function chooseTopic(topicElement) {
		topicElement.classList.add("selectedTopic");
	}



	CKEDITOR.replace('content');
    $(function(){
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
        //     'link',
        //     'table',
        //     'emotion',
        //     '|',
        //     'img',
        //     'insertcode',
        //     '|',
        //     'undo',
        // ];
		//
        // editor.config.uploadImgUrl = 'upload.do';
        // editor.config.uploadImgFileName = 'myFileName';
        // editor.create();

        var topics = $(".topics");
        var topicId = $("#topicId");
        topics.click(function(){
            for(var i=0;i<topics.length;i++){
                $(topics[i]).css("background-color","#fff");
            }
            $(this).css("background-color","#1abc9c");
            topicId.val(this.title);
        });

    });
    
</script>
</body>
</html>













