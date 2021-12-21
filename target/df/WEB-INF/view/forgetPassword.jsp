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

    <div style="margin-top: 60px;"></div>
    <div class="edit-header"><span></span>&nbsp;Forget Password</div>
    <form action="afterForgetPassword.do" method="post">
        <div class="edit-title">
            <div class="text-danger">${passwordError}</div>
            Your email：<input type="email" name="email">
        </div>
        <div class="relative">
            <button class="forget-submit">Submit</button>
        </div>
    </form>

</div>


<%@ include file="footer.jsp" %>
<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>

</body>
</html>













