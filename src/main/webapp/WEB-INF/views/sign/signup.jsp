<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../includes/header.jsp" %>
	<div class="signup-container">
        <form action="/signup" method="post">
            <div class="form-group">
                <label for="name">이름</label>
                <input type="text" id="name" name="name" placeholder="이름을 입력하세요" required>
            </div>

            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email" placeholder="이메일을 입력하세요" required>
            </div>

            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요" required>
            </div>

            <div class="form-group">
                <label for="passwordConfirm">비밀번호 확인</label>
                <input type="password" id="passwordConfirm" name="passwordConfirm" placeholder="비밀번호를 다시 입력하세요" required>
            </div>

            <div class="form-group">
                <label for="phone">전화번호</label>
                <input type="tel" id="phone" name="phone" placeholder="전화번호를 입력하세요" required>
            </div>

            <div class="form-group">
                <label for="address">주소</label>
                <input type="text" id="address" name="address" placeholder="주소를 입력하세요" required>
            </div>

            <div class="form-group">
                <button type="submit" class="signup-btn">회원가입</button>
            </div>
        </form>
        <div class="login-link">
            <p>이미 계정이 있으신가요? <a href="/login">로그인</a></p>
        </div>
    </div>
<%@ include file="../includes/header.jsp" %>