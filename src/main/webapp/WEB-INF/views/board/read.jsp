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
	         <button data-per="modify" class="btn btn-default">
	         	<a href="/board/modify?bno=${board.bno }">Modify</a>
	          </button>
	         <button data-per="list" class="btn btn-default">
	         <a href="/board/list">List<a>
	         </button>
            </div>
            <!-- /.panel-body -->
        </div>
        <!-- /.panel -->
    </div>
    <!-- /.col-lg-6 -->
</div>
<!-- /.row -->
<<script>
$(document).ready(function() {
	
);
</script>

<%@ include file="../includes/footer.jsp" %>

        