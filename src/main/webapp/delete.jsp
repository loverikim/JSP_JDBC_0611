<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
</head>
<body>
	<h2>회원탈퇴</h2>
	<hr>
	<form action="deleteOk.jsp">
		탈퇴할 회원번호 : <input type="text" name="memberNum">
		<input type="submit" value="회원탈퇴">
	</form>
	<!-- 회원탈퇴 탈퇴성공 탈퇴실패 만들기 -->
</body>
</html>