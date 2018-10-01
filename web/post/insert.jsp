<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.util.Objects" %>
<%@ page import="java.util.regex.Pattern" %><%--
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

<%--<%@include file="/partials/nav.jsp" %>--%>
<%
	String title = request.getParameter("title");
	String writer = request.getParameter("writer");
	int count = 1;
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
	try {
		String driverName = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:XE";
		Class.forName(driverName);
		Connection conn = DriverManager.getConnection(url, "iu", "iu1004");
		System.out.println("Oracle Database Connection Success.");

		Statement stmt = conn.createStatement();
		String sql = "INSERT INTO POST(idx, title, writer, reg_date, count, content) " +
				"VALUES(post_seq.nextval, '" + title + "', '" + writer + "', sysdate, " + count + ", '" + content + "')";
		stmt.executeUpdate(sql);

		conn.close();
	} catch (Exception e) {
		System.out.println("Oracle Database Connection Something Problem. <hr>");
		System.out.println(e.getMessage());
		e.printStackTrace();
	} finally {
		out.println("<script>location.href='index.jsp';</script>");
	}
%>

<div class="container">

	<div class="starter-template">
		<h1>게시글 등록</h1><br>


	</div>


</div><!-- /.container -->


<%@include file="/partials/script.jsp" %>

</body>
</html>
