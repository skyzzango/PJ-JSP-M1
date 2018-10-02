<%--
  Created by IntelliJ IDEA.
  User: skyzz
  Date: 2018-10-01
  Time: 오후 5:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="ko">
<head>
	<%@include file="/partials/head.jsp" %>
	<title>게시판 - 게시글 작성</title>
</head>

<body>

<%@include file="/partials/nav.jsp" %>


<div class="container">

	<div class="starter-template">
		<h1>게시글 작성</h1><br>
		<form action="insert_Action.jsp" method="post" onsubmit="return formCheck();">
			<div class="form-group">
				<label for="title">제목</label>
				<input type="text" class="form-control" name="title" id="title" placeholder="">
			</div>
			<div class="form-group">
				<label for="writer">작성자</label>
				<input type="text" class="form-control" name="writer" id="writer" placeholder="">
			</div>
			<div class="form-group">
				<label for="content">내용</label>
				<textarea class="form-control" name="content" id="content" rows="5"></textarea>
			</div>
			<button type="submit" class="btn btn-primary">Submit</button>
		</form>

	</div>


</div><!-- /.container -->


<%@include file="/partials/script.jsp" %>

</body>
</html>
