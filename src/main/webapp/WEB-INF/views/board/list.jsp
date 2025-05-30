<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../includes/header.jsp" %>
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">Board</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                Board List Page
            	<button type="button" id="regBtn" class="btn btn-xs pull-right">Register New Board</button>
            </div>
            <!-- /.panel-heading -->
            <div class="panel-body">
                <table width="100%" class="table table-striped table-bordered table-hover">
                    <thead>
                        <tr>
                            <th>#번호</th>
                            <th>제목</th>
                            <th>작성자</th>
                            <th>작성일</th>
                            <th>조회수</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:forEach items="${list }" var="board">
                         <tr>
                             <td>${board.bno}</td>
                             <td><a class="move" href="${board.bno }"> ${board.title}</a></td>
                             <td>${board.writer}</td>
                             <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${board.regdate}"/></td>
                             <td>${board.viewcnt}</td>
                         </tr>
                    	</c:forEach>
                        
                    </tbody>
                </table>
                <!-- 검색 조건과 키워드 -->
                <div class="row">
                	<div class="col-lg-12">
                		<form action="/board/list" method="get" id="searchForm">
                			<select name="type">
                				<option value="" <c:out value="${pageMaker.cri.type == null ? 'selected' : '' }" />>---------</option>
                				<option value="T" <c:out value="${pageMaker.cri.type eq 'T' ? 'selected' : '' }" />>제목</option>
                				<option value="C" <c:out value="${pageMaker.cri.type eq 'C' ? 'selected' : '' }" />>내용</option>
                				<option value="W" <c:out value="${pageMaker.cri.type eq 'W' ? 'selected' : '' }" />>작성자</option>
                				<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC' ? 'selected' : '' }" />>제목 or 내용</option>
                				<option value="TW" <c:out value="${pageMaker.cri.type eq 'TW' ? 'selected' : '' }" />>제목 or 작성자</option>
                				<option value="TWC" <c:out value="${pageMaker.cri.type eq 'TWC' ? 'selected' : '' }" />>제목 or 내용 or 작성자</option>
                			</select>
                			<input type="text" name="keyword" placeholder="검색어" value="${pageMaker.cri.keyword}">
                			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
                			<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
                			<button class="btn btn-default">Search</button>
                		</form>
                	</div>
                </div>
                
                <!-- 페이징 추가 -->
                <div class="pull-right">
                	<ul class="pagination">
                		<c:if test="${pageMaker.prev}">
                			<li class="paginate_button previous">
                				<a href="${pageMaker.startPage - 1}">Previous</a>
                			</li>
                		</c:if>
                		<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                			<li class="paginate_button ${pageMaker.cri.pageNum == num ? 'active' : ''}">
                			 	<a href="${num}">${num}</a>
                			</li>
                		</c:forEach>
                		<c:if test="${pageMaker.next}">
                			<li class="paginate_button next">
                				<a href="${pageMaker.endPage + 1}">Next</a>
                			</li>
                		</c:if>
                	</ul>
                </div>
                
                <form action="/board/list" method="get" id="actionForm">
					<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
					<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
					<input type="hidden" name="type" value="${pageMaker.cri.type}">
					<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
                </form>
                
                
                <!-- Modal 추가 -->
               	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
               		aria-labelleaby="myModallabel" aria-hidden="true">
                	<div class="modal-dialog">
                		<div class="modal-content">
                			<div class="modal-header">
                				<button type="button" class="close" data-dismiss="modal" aria-hidde="true">&times;</button>
                				<h4 class="modal-title" id="myModallabel">Modal title</h4>
                			</div>
                			<div class="modal-body">처리가 완료되었습니다.</div>
                			<div class="modal-footer">
                				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                				<button type="button" class="btn btn-primary">changes</button>
                			</div>
                		</div>
                	</div>
                </div>
            </div>
            <!-- /.panel-body -->
        </div>
        <!-- /.panel -->
    </div>
    <!-- /.col-lg-6 -->
</div>
<!-- /.row -->
<script>
	$(document).ready(function() {
		var result = "${result}";
		
		checkModal(result);
		
		history.replaceState({}, null, null);
		
		function checkModal(result) {
			//중복 모달 방지
			if (result == "" || history.state) {
				return;
			}
			
			if (parseInt(result) > 0) {
				$(".modal-body").html("게시글 " + parseInt(result) + " 번이 등록되었습니다.");
			}
			
			$("#myModal").modal("show");
		}
		
		$("#regBtn").on("click", function() {
			self.location = "/board/register";
		});
		
		var actionForm = $("#actionForm");
		$(".paginate_button a").on("click", function(e) {
			e.preventDefault();
			
			console.log("click");
			
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});
		
		$(".move").on("click", function(e) {
			e.preventDefault();
			
			actionForm.append("<input type='hidden' name='bno' value='"
					+ $(this).attr("href") + "'>");
			actionForm.attr("action", "/board/read");
			actionForm.submit();
		}) 
		
		var searchForm = $("#searchForm");
		$("#searchForm button").on("click", function(e) {
			if (!searchForm.find("option:selected").val()) {
				alert("검색할 종류를 선택하세요");
				
				return false;
			}
			
			if (!searchForm.find("input[name='keyword']").val()) {
				alert("검색어를 입력해주세요");
				
				return false;
			}
			
			searchForm.find("input[name='pageNum']").val("1");
			
			e.preventDefault();
			
			searchForm.submit();
		});
	});
</script>
<%@ include file="../includes/footer.jsp" %>

        