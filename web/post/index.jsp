<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="post.PostDao" %>
<%@ page import="post.PostDto" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: skyzz
  Date: 2018-10-01
  Time: 오후 5:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="ko">
<head>
	<%@include file="/partials/head.jsp" %>
	<title>게시판 - 게시글 리스트</title>
</head>

<body>

<%--<%@include file="/partials/nav.jsp" %>--%>
<%
	List<PostDto> postList = PostDao.getInstance().getPostList();
	request.setAttribute("postList", postList);
%>

<div class="container">

	<div class="starter-template">
		<h1>게시글 리스트</h1><br>
		<table class="table table-hover">
			<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>날짜</th>
				<th>조회수</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach items="${postList}" var="post">
				<tr>
					<td>${post.idx}</td>
					<td><a href="content.jsp?idx=${post.idx}">${post.title}</a></td>
					<td>${post.writer}</td>
					<td>${post.reg_date}</td>
					<td>${post.count}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<a class="btn btn-primary" href="write.jsp" role="button">글쓰기</a>
	</div>


</div><!-- /.container -->


<%@include file="/partials/script.jsp" %>

</body>
</html>
