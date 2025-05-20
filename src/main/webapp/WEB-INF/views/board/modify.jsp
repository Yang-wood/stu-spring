<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../includes/header.jsp" %>
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">Board Modify</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading"> Board Modify Page</div>
            <!-- /.panel-heading -->
            <div class="panel-body">
            
            <form action="/board/modify" method="post" role="form">
	         <div class="form-group">
	           <label>Bno</label> <input class="form-control" name='bno' value="${board.bno}" readonly="readonly">
	         </div>
	         <div class="form-group">
	           <label>Title</label> <input class="form-control" name='title' value="${board.title}" >
	         </div>
	
	         <div class="form-group">
	           <label>Content</label>
	           <textarea class="form-control" rows="3" name='content' >${board.title}</textarea>
	         </div>
	
	         <div class="form-group">
	           <label>Writer</label> <input class="form-control" name='writer' value="${board.writer}" readonly="readonly">
	         </div>
	         <!-- html의 data-속성 이용 -->
	         <button type="submit" data-oper="modify" class="btn btn-default">Modify</button>
	         <button type="submit" data-oper="remove" class="btn btn-danger">Remove</button>
	         <button type="submit" data-oper="list" class="btn btn-info">List</button>
            </form>
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
		var formObj = $("form");
		$("button").on("click", function(e) {
			e.preventDefault();
			
			var operation = $(this).data("oper");
			
			if (operation === "remove") {
				formObj.attr("action", "/board/remove");
			} else if (operation === "list") {
				self.location = "/board/list"

				return;
			}
			
			formObj.submit();
		});
	});
</script>

<%@ include file="../includes/footer.jsp" %>

        