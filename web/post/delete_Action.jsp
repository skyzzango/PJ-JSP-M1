<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %><%--
  Created by IntelliJ IDEA.
  User: skyzz
  Date: 2018-10-01
  Time: 오후 9:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="ko">
<head>
	<%@include file="/partials/head.jsp" %>
	<title>게시판 - 게시글 삭제</title>
</head>

<body>

<%@include file="/partials/nav.jsp" %>
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
		String sql = "DELETE FROM post WHERE idx = " + idx;
		stmt.executeQuery(sql);
		conn.close();
	} catch (Exception e) {
		System.out.println("Oracle Database Connection Something Problem. <hr>");
		System.out.println(e.getMessage());
		e.printStackTrace();
	}
%>
<script>
	alert("게시글이 삭제 되었습니다.");
	location.href = "redirect_Action.jsp";
</script>

<div class="container">

	<div class="starter-template">
		<h1>게시글 삭제</h1><br>


	</div>


</div><!-- /.container -->


<%@include file="/partials/script.jsp" %>

</body>
</html>
