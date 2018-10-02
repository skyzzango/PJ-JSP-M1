<%@ page import="post.PostDao" %>
<%@ page import="post.PostDto" %><%--
  Created by IntelliJ IDEA.
  User: skyzz
  Date: 2018-10-01
  Time: 오후 8:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="ko">
<head>
	<%@include file="/partials/head.jsp" %>
	<title>게시판 - 게시글 조회</title>
</head>

<body>

<%@include file="/partials/nav.jsp" %>
<%
	int idx = Integer.parseInt(request.getParameter("idx"));
	PostDto post = PostDao.getInstance().getPost(idx);
	request.setAttribute("post", post);
%>

<div class="container">

	<div class="starter-template">
		<h1>게시글 조회</h1><br>
		<table class="table">
			<tr>
				<th colspan="2">번호</th>
				<td colspan="1">${post.idx}</td>
				<th colspan="2">조회수</th>
				<td colspan="1">${post.count}</td>
			</tr>
			<tr>
				<th colspan="2">작성자</th>
				<td colspan="1">${post.writer}</td>
				<th colspan="2">날짜</th>
				<td colspan="1">${post.reg_date}</td>
			</tr>
			<tr>
				<th colspan="2">제목</th>
				<td colspan="6">${post.title}</td>
			</tr>
			<tr style="height: 10rem">
				<th colspan="2">내용</th>
				<td colspan="6">${post.content}</td>
			</tr>
		</table>
		<a class="btn btn-primary" href="index.jsp" role="button">목록</a>
		<a class="btn btn-danger" href="delete_Action.jsp?idx=${post.idx}" role="button">삭제</a>
	</div>


</div><!-- /.container -->


<%@include file="/partials/script.jsp" %>

</body>
</html>
