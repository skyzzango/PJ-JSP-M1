<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="post.PostDto" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.util.ArrayList" %><%--
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
	try {
		String driverName = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:XE";
		ResultSet rs;

		Class.forName(driverName);
		Connection conn = DriverManager.getConnection(url, "iu", "iu1004");
		System.out.println("Oracle Database Connection Success.");

		Statement stmt = conn.createStatement();
		String sql = "SELECT * FROM post ORDER BY idx DESC";
		rs = stmt.executeQuery(sql);

		ArrayList<PostDto> postList = new ArrayList<>();

		while (rs.next()) {
			PostDto post = new PostDto();
			post.setIdx(rs.getInt("idx"));
			post.setTitle(rs.getString("title"));
			post.setWriter(rs.getString("writer"));
			post.setReg_date(rs.getString("reg_date"));
			post.setCount(rs.getInt("count"));
			postList.add(post);
		}
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

<%
		conn.close();
	} catch (Exception e) {
		System.out.println("Oracle Database Connection Something Problem. <hr>");
		System.out.println(e.getMessage());
		e.printStackTrace();
	}
%>

<%@include file="/partials/script.jsp" %>

</body>
</html>
