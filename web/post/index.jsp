<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
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

<%@include file="/partials/nav.jsp" %>
<%
	int pageNum = 1;
	int totalCount = PostDao.getInstance().getPostCnt();
	int pageSize = 10;
	int totalPage = totalCount / pageSize;
	if (totalCount % pageSize > 0) totalPage++;

	if (request.getParameter("pageNum") != null) {
		pageNum = Integer.parseInt(request.getParameter("pageNum"));
		if (pageNum < 1) pageNum = 1;
		else if (pageNum > totalPage) pageNum = totalPage;
	}
	List<PostDto> postList = PostDao.getInstance().getPostList(pageNum);
	request.setAttribute("postList", postList);
	request.setAttribute("totalCount", totalCount);
	request.setAttribute("pageNum", pageNum);
%>

<div class="container">

	<div class="starter-template">
		<h1>게시글 리스트</h1><br>
		<a class="btn btn-primary" href="write.jsp" role="button">글쓰기</a>
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

		<%
			if (totalCount > 0) {
				int pageBlock = 10;
				request.setAttribute("pageBlock", pageBlock);
				int imsi = totalCount % pageSize == 0 ? 0 : 1;
				request.setAttribute("imsi", imsi);
				int pageCount = totalCount / pageSize + imsi;
				request.setAttribute("pageCount", pageCount);
				int startPage = ((pageNum - 1) / pageBlock) * pageBlock + 1;
				request.setAttribute("startPage", startPage);
				int endPage = startPage + pageBlock - 1;
				request.setAttribute("endPage", endPage > pageCount ? pageCount : endPage);
				if (endPage > pageCount) {
					endPage = pageCount;
				}
				System.out.println("totalCount: " + totalCount);
				System.out.println("totalPage: " + totalPage);
				System.out.println("pageNum: " + pageNum);
				System.out.println("pageBlock: " + pageBlock);
				System.out.println("imsi: " + imsi);
				System.out.println("pageCount: " + pageCount);
				System.out.println("startPage: " + startPage);
				System.out.println("endPage: " + endPage);
			}
		%>

		<c:set var="page" value="9"/>
		<fmt:formatNumber value="${startPage}" type="number" var="startPage1"/>
		<fmt:formatNumber value="${pageNum}" type="number" var="pageNum1"/>
		<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-center">
				<c:choose>
					<c:when test="${startPage1 < pageNum1}">
						<li class="page-item">
							<a class="page-link" href="index.jsp?pageNum=1">First</a>
						</li>
						<li class="page-item">
							<a class="page-link" href="index.jsp?pageNum=${startPage - pageBlock}" tabindex="-1">Previous</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a class="page-link disabled" href="index.jsp?pageNum=1">First</a>
						</li>
						<li class="page-item">
							<a class="page-link disabled" href="index.jsp?pageNum=${startPage - pageBlock}"
							   tabindex="-1">Previous</a>
						</li>
					</c:otherwise>
				</c:choose>
				<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
					<c:choose>
						<c:when test="${i == pageNum}">
							<li class="page-item active">
								<a class="page-link" href="index.jsp?pageNum=${i}">${i}</a>
							</li>
						</c:when>
						<c:otherwise>
							<li class="page-item">
								<a class="page-link" href="index.jsp?pageNum=${i}">${i}</a>
							</li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:choose>
					<c:when test="${endPage+0 > pageNum+0}">
						<li class="page-item">
							<a class="page-link" href="index.jsp?pageNum=${startPage+pageBlock}">Next</a>
						</li>
						<li class="page-item">
							<a class="page-link" href="index.jsp?pageNum=${pageCount}">Last</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item disabled">
							<a class="page-link" href="index.jsp?pageNum=${startPage+pageBlock}">Next</a>
						</li>
						<li class="page-item disabled">
							<a class="page-link" href="index.jsp?pageNum=${pageCount}">Last</a>
						</li>
					</c:otherwise>
				</c:choose>
			</ul>
		</nav>

		<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-center">
				<% if (totalCount > 0) {
					int pageBlock = 10;
					int imsi = totalCount % pageSize == 0 ? 0 : 1;
					int pageCount = totalCount / pageSize + imsi;
					int startPage = ((pageNum - 1) / pageBlock) * pageBlock + 1;
					int endPage = startPage + pageBlock - 1;
					if (endPage > pageCount) {
						endPage = pageCount;
					}
					if (startPage > pageBlock) { %>
				<li class="page-item">
					<a class="page-link" href="index.jsp?pageNum=1">First</a>
				</li>
				<li class="page-item">
					<a class="page-link" href="index.jsp?pageNum=<%=startPage-pageBlock%>" tabindex="-1">Previous</a>
				</li>
				<% } else { %>
				<li class="page-item">
					<a class="page-link disabled" href="index.jsp?pageNum=1">First</a>
				</li>
				<li class="page-item">
					<a class="page-link disabled" href="index.jsp?pageNum=<%=startPage-pageBlock%>"
					   tabindex="-1">Previous</a>
				</li>
				<% }
					for (int i = startPage; i <= endPage; i++) {
						if (i == pageNum) { %>
				<li class="page-item active"><a class="page-link" href="index.jsp?pageNum=<%=i%>"><%=i%>
				</a></li>
				<% continue;
				} %>
				<li class="page-item"><a class="page-link" href="index.jsp?pageNum=<%=i%>"><%=i%>
				</a></li>
				<% }
					if (endPage < pageCount) { %>
				<li class="page-item">
					<a class="page-link" href="index.jsp?pageNum=<%=startPage+pageBlock%>">Next</a>
				</li>
				<li class="page-item">
					<a class="page-link" href="index.jsp?pageNum=<%=pageCount%>">Last</a>
				</li>
				<% } else { %>
				<li class="page-item disabled">
					<a class="page-link" href="index.jsp?pageNum=<%=startPage+pageBlock%>">Next</a>
				</li>
				<li class="page-item disabled">
					<a class="page-link" href="index.jsp?pageNum=<%=pageCount%>">Last</a>
				</li>
				<% }
				} %>
			</ul>
		</nav>

	</div>


</div><!-- /.container -->


<%@include file="/partials/script.jsp" %>

</body>
</html>
