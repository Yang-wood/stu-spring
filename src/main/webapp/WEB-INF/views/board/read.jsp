<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../includes/header.jsp" %>
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">Board Read</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading"> Board Read Page</div>
            <!-- /.panel-heading -->
            <div class="panel-body">
	         <div class="form-group">
	           <label>Bno</label> <input class="form-control" name='bno' value="${board.bno}" readonly="readonly">
	         </div>
	         <div class="form-group">
	           <label>Title</label> <input class="form-control" name='title' value="${board.title}" readonly="readonly">
	         </div>
	
	         <div class="form-group">
	           <label>Content</label>
	           <textarea class="form-control" rows="3" name='content' readonly="readonly">${board.title}</textarea>
	         </div>
	
	         <div class="form-group">
	           <label>Writer</label> <input class="form-control" name='writer' value="${board.writer}" readonly="readonly">
	         </div>
	         <!-- html의 data-속성 이용 -->
	         <button data-oper="modify" class="btn btn-default">Modify</button>
	         <button data-oper="list" class="btn btn-default">List</button>
	         
	         <form action="/board/modify" id="operForm" method="get">
	         	<input type="hidden" id="bno" name="bno" value="${board.bno}">
	         	<input type="hidden" id="pageNum" name="pageNum" value="${cri.pageNum}">
	         	<input type="hidden" id="amount" name="amount" value="${cri.amount}">
	         	<input type="hidden" id="type" name="type" value="${cri.type}">
	         	<input type="hidden" id="keyword" name="keyword" value="${cri.keyword}">
	         </form>
            </div>
            <!-- /.panel-body -->
        </div>
        <!-- /.panel -->
    </div>
    <!-- /.col-lg-6 -->
</div>
<!-- /.row -->
<script>
$(function() {
	var operForm = $("#operForm");
	//[]속성부여일때 사용 : 라디오박스 + 체크박스
	$("button[data-oper='modify']").on("click", function(e) {
		operForm.attr("action", "/board/modify").submit();
	});
	$("button[data-oper='list']").on("click", function(e) {
		operForm.attr("action", "/board/list")
		operForm.submit();
	});
});
</script>

<%@ include file="../includes/footer.jsp" %>

        