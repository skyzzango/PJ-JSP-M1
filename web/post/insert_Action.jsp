<%@ page import="post.PostDao" %>
<%@ page import="post.PostDto" %>
<%@ page import="java.util.Objects" %>
<%@ page import="java.util.regex.Pattern" %>
<%--
  Created by IntelliJ IDEA.
  User: skyzz
  Date: 2018-10-01
  Time: 오후 6:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="ko">
<head>
	<%@include file="/partials/head.jsp" %>
	<title>게시판 - 게시글 등록</title>
</head>

<body>

<%@include file="/partials/nav.jsp" %>
<%
	String title = request.getParameter("title");
	String writer = request.getParameter("writer");
	String content = request.getParameter("content");
%>
<%
	if (Objects.equals(title, "") || title == null) {
		out.println("title 이 null 입니다.");
	}
	if (Objects.equals(writer, "") || writer == null) {
		out.println("writer 가 null 입니다.");
	} else if (!Pattern.matches("^[_0-9a-zA-Z-]+@[0-9a-zA-Z-]+(.[_0-9a-zA-Z-]+)*$", writer)) {
		out.println("이메일 형식이 아닙니다.");
	}
	if (Objects.equals(content, "") || content == null) {
		out.println("content 가 null 입니다.");
	}
%>
<%
	PostDto post = new PostDto();
	post.setTitle(request.getParameter("title"));
	post.setWriter(request.getParameter("writer"));
	post.setContent(request.getParameter("content"));
	int result = PostDao.getInstance().insertPost(post);
	out.print("<script>");
	if (result == -1) out.println("alert('등록 실패!!')");
	else out.println("alert('등록 완료!!')");
	out.println("location.href='index.jsp';");
	out.print("</script>");
%>

<div class="container">

	<div class="starter-template">
		<h1>게시글 등록</h1><br>


	</div>


</div><!-- /.container -->


<%@include file="/partials/script.jsp" %>

</body>
</html>
