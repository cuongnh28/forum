<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" import="java.util.*" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<div class="header clearfix">
    <div class="w">
        <h1 class="logo"><a href="toIndex.do">Home</a></h1>
        <ul class="left-nav">
            <li class="current-nav"><a href="toIndex.do">Home</a></li>
            <li><a href="listTopic.do">Topics</a></li>
<%--            <li><a href="listImage.do">Images</a></li>--%>
            <li><a href="toMessage.do">Activity Log</a></li>
        </ul>

        <ul class="right-nav">
            <c:choose>
                <c:when test="${sessionScope.userId != null}">
                    <li class="login2 relative">
                        <a href="toMyProfile.do" id="profile"><img src="../../upload/images/${sessionScope.user.headUrl}"></a>
                        <ul id="down-menu">
                            <li><a href="toMyProfile.do">My Profile</a></li>
                            <li><a href="logout.do">Log out</a></li>
                        </ul>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="login">
                        <a href="toLogin.do">Login</a>
                            <%--                        <a href="toLogin.do">/</a>--%>
                        <a href="toLogin.do#register">Register</a>
                    </li>
                </c:otherwise>
            </c:choose>


            <li>
                <form action="/search.do" method="get">
                    <div class="small-3 columns">
<%--                        <span class="glyphicon glyphicon-search">--%>
                        <input type="text" name="searchTemp">
                        <input type="submit" value="Search">
<%--                        </span>--%>
                    </div>
                </form>
            </li>
<%--            <li><input type="text"></li>--%>
        </ul>
    </div>
</div>
