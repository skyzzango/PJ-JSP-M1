<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %><%--
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

<%--<%@include file="/partials/nav.jsp" %>--%>
<%
	String idx = request.getParameter("idx");
	try {
		String driverName = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:XE";
		ResultSet rs;

		Class.forName(driverName);
		Connection conn = DriverManager.getConnection(url, "iu", "iu1004");
		System.out.println("Oracle Database Connection Success.");

		Statement stmt = conn.createStatement();
		String sql = "SELECT * FROM post WHERE idx = " + idx;
		rs = stmt.executeQuery(sql);

		while (rs.next()) {
			request.setAttribute("idx", rs.getString("idx"));
			request.setAttribute("count", rs.getString("count"));
			request.setAttribute("writer", rs.getString("writer"));
			request.setAttribute("reg_date", rs.getString("reg_date"));
			request.setAttribute("title", rs.getString("title"));
			request.setAttribute("content", rs.getString("content"));
		}
		conn.close();
	} catch (Exception e) {
		System.out.println("Oracle Database Connection Something Problem. <hr>");
		System.out.println(e.getMessage());
		e.printStackTrace();
	}
%>

<div class="container">

	<div class="starter-template">
		<h1>게시글 조회</h1><br>
		<table class="table">
			<tr>
				<th colspan="2">번호</th>
				<td colspan="1">${idx}</td>
				<th colspan="2">조회수</th>
				<td colspan="1">${count}</td>
			</tr>
			<tr>
				<th colspan="2">작성자</th>
				<td colspan="1">${writer}</td>
				<th colspan="2">날짜</th>
				<td colspan="1">${reg_date}</td>
			</tr>
			<tr>
				<th colspan="2">제목</th>
				<td colspan="6">${title}</td>
			</tr>
			<tr style="height: 10rem">
				<th colspan="2">내용</th>
				<td colspan="6">${content}</td>
			</tr>
		</table>
		<a class="btn btn-primary" href="index.jsp" role="button">목록</a>
		<a class="btn btn-danger" href="delete.jsp?idx=${idx}" role="button">삭제</a>
	</div>


</div><!-- /.container -->


<%@include file="/partials/script.jsp" %>

</body>
</html>
