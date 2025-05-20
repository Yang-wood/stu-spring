<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../includes/header.jsp" %>
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">Board Content</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading"> Content </div>
            <!-- /.panel-heading -->
            <div class="panel-body">
               
        <form role="form" method="post">
          <div class="form-group">
            <label>Title</label> <input class="form-control" name='content'
            value="${board.title}" readonly="readonly">
          </div>
          <div class="form-group">
            <label>Content</label>
            <textarea class="form-control" rows="3" name='content' readonly="readonly">
            ${board.content}
            </textarea>
          </div>
          <div class="form-group">
            <label>Writer</label> <input class="form-control" name='writer'
            value="${board.writer}" readonly="readonly">
          </div>
          <button type="button" class="btn btn-default" onclick="window.history.back();">뒤로가기
           </button>
         </form>
            </div>
            <!-- /.panel-body -->
        </div>
        <!-- /.panel -->
    </div>
    <!-- /.col-lg-6 -->
</div>
<!-- /.row -->
<%@ include file="../includes/footer.jsp" %>

        