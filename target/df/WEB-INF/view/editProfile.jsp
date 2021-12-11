<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
	<title></title>
	<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="css/wangEditor.css">
	<link rel="stylesheet" type="text/css" href="css/base.css">
	<link rel="stylesheet" type="text/css" href="css/editProfile.css">
</head>
<body>
<%@ include file="header.jsp" %>


	<div class="main w clearfix">
		<div class="edit-header"><span></span>&nbsp;Update Profile</div>
		<form action="editProfile.do" method="post">
			<div class="edit-title">
                <input type="hidden" name="uid" value="${user.uid}">
				Username：<input type="text" name="username" value="${user.username}">
			</div>
			<div class="edit-title">
				Description：<input type="text" name="description" value="${user.description}">
			</div>
			<div class="edit-title">
				Position：<input type="text" name="position" value="${user.position}">
			</div>
			<div class="edit-title">
				School：<input type="text" name="school" value="${user.school}">
			</div>
			<div class="edit-title">
				Job：<input type="text" name="job" value="${user.job}">
			</div>
			<div class="relative">
				<button class="edit-submit">Submit</button>
			</div>
		</form>

        <div style="margin-top: 60px;"></div>
		<div class="edit-header"><span></span>&nbsp;Change Password</div>
		<form action="updatePassword.do" method="post">
			<div class="edit-title">
                <div class="text-danger">${passwordError}</div>
				Current Password：<input type="password" name="password">
			</div>
			<div class="edit-title">
				New Password：<input type="password" name="newpassword">
			</div>
			<div class="edit-title">
				Confirm New Password：<input type="password" name="repassword">
			</div>
			<div class="relative">
				<button class="edit-submit">Submit</button>
			</div>
		</form>

        <div style="margin-top: 60px;"></div>
        <div class="edit-header"><span></span>&nbsp;Change Avatar</div>
        <form action="updateHeadUrl.do" method="post" enctype="multipart/form-data">
            <div class="edit-title">
				<span class="text-danger">${error3}</span>
                <input type="file" name="myFileName">
            </div>
            <div class="relative">
                <button class="edit-submit">Change</button>
            </div>
        </form>

	</div>


<%@ include file="footer.jsp" %>
<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>

</body>
</html>













