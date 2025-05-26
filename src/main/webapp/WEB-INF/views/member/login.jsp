<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="/member/loginPost" method="post">
		아이디 : <input name="userid" type="text"><br>
		비밀번호 : <input name="userpw" type="password">
		<button type="submit">로그인</button>
	</form>
</body>
</html>