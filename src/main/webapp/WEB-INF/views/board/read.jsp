<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>

<style type="text/css">
	.uploadResult {
		width: 100%;
		background-color: gray;
	}
	
	.uploadResult ul {
		display: flex;
		flex-flow: row;
		justify-content: center;
		align-items: center;
	}
	
	.uploadResult ul li {
		list-style: none;
		padding: 10px;
	}
	
	.uploadResult ul li img {
		width: 100px;
	}
	
	.bigPictureWrapper {
		position: absolute;
		display: none;
		justify-content: center;
		align-items: center;
		top: 0%;
		width: 100%;
		height: 100%;
		background-color: gray;
		z-index: 100;
	}
	
	.bigPicture {
		position: relative;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	
	.bigPicture img {
		width: 300px;
	}
</style>

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

      <div class="panel-heading">Board Read Page</div>
      <!-- /.panel-heading -->
      <div class="panel-body">

        <div class="form-group">
          <label>Bno</label> <input class="form-control" name='bno' value="${board.bno }" readonly="readonly">
        </div>
        
        <div class="form-group">
          <label>Title</label> <input class="form-control" name='title' value="${board.title }" readonly="readonly">
        </div>

        <div class="form-group">
          <label>Text area</label>
          <textarea class="form-control" rows="3" name='content' readonly="readonly">${board.content }</textarea>
        </div>

        <div class="form-group">
          <label>Writer</label> <input class="form-control" name='writer' value="${board.writer }" readonly="readonly">
        </div>
		<!-- html의 data-속성 이용 -->
        <button data-oper="modify" class="btn btn-default">Modify</button>
        <button data-oper="list" class="btn btn-default">List</button>
        
        <form action="/board/modify" id="operForm" method="get">
        	<input type="hidden" id="bno" name="bno" value="${board.bno }">
        	<input type="hidden" id="pageNum" name="pageNum" value="${cri.pageNum }">
        	<input type="hidden" id="amount" name="amount" value="${cri.amount }">
        	<input type="hidden" id="type" name="type" value="${cri.type }">
        	<input type="hidden" id="keyword" name="keyword" value="${cri.keyword }">
        </form>
      </div>
      <!--  end panel-body -->

    </div>
    <!--  end panel-body -->
  </div>
  <!-- end panel -->
</div>
<!-- /.row -->
<div class="bigPictureWrapper">
	<div class="bigPicture">
	</div>
</div>
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Files</div>
			<div class="panel-body">
				<div class="uploadResult">
					<ul>
					
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>


<!-- 댓글 목록 처리 -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i>Reply
				<button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">New Reply</button>
			</div>
			<div class="panel-body">
				<ul class="chat">
				</ul>
			</div>
			<div class="panel-footer"></div>
		</div>
	</div>
</div>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>ReplyText</label>
					<input class="form-control" name="replytext" value="New Reply!!!">
				</div>
				<div class="form-group">
					<label>Replyer</label>
					<input class="form-control" name="replyer" value="replyer">
				</div>
				<div class="form-group">
					<label>Reply Date</label>
					<input class="form-control" name="replyDate" value="2025-05-22 12:07">
				</div>
			</div>
			<div class="modal-footer">
				<button id="modalModifyBtn" type="button" class="btn btn-warning">Modify</button>
				<button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>
				<button id="modalRegisterBtn" type="button" class="btn btn-primary">Register</button>
				<button id="modalCloseBtn" type="button" class="btn btn-default">Close</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="/resources/js/reply.js"></script>
<script>
	$(document).ready(function() {
		// 댓글 등록
		/* replyService.add(
				{replytext:"JS TEST1", replyer:"tester1", bno:bnoValue},
				
				function(result) {
					//alert("RESULT : " + result);
				}
		);
		
		replyService.getList(
			{bno:bnoValue, page:1},
			
			function(list) {
				for (var i = 0; i < list.length; i++) {
					console.log(list[i]);
				}
			}
		); */
		
		var bnoValue = "${board.bno}";
		var replyUL = $(".chat");
		
		showList(1);
		
		function showList(page) {
			console.log("show list : " + page);
			
			replyService.getList(
				{bno:bnoValue, page:page || 1},
				
				function(replyCnt, list) {
					console.log("replyCnt : " + replyCnt);
					console.log("list : " + list);
					
					// page 번호가 -1로 전달되면 마지막 페이지를 찾아서 다시 호출
					if (page == -1) {
						pageNum = Math.ceil(replyCnt/10.0);
						showList(pageNum);
						return;
					}
					
					var str="";
					
					if (list == null || list.length == 0) {
						return;
					}
					
					for (var i = 0; i < list.length; i++) {
						str += "<li class='left clearfix' data-rno='" + list[i].rno + "'>";
						str += "	<div><div class='header'><strong class='primary-font'>[" + list[i].rno + "] " + list[i].replyer + "</strong>";
						str += "		 <small class='pull-right text-muted'>" + replyService.displayTime(list[i].updatedate) + "</small></div>";
						str += "		 <p>" + list[i].replytext + "</p></div></li>";
					}
					
					replyUL.html(str);
					
					showReplyPage(replyCnt);
				}
			); // end function
		} // end showList
		
		// 페이징 처리
		var pageNum = 1;
		var replyPageFooter = $(".panel-footer");
		
		function showReplyPage(replyCnt) {
			var endNum = Math.ceil(pageNum / 10.0) * 10;
			var startNum = endNum - 9;
			
			var prev = startNum != 1;
			var next = false;
			
			if (endNum * 10 >= replyCnt) {
				endNum = Math.ceil(replyCnt / 10.0);
			}
			
			if (endNum * 10 < replyCnt) {
				next = true;
			}
			
			var str = "<div><ul class='pagination pull-right'>";
			
			if (prev) {
				str += "<li class='page-item'><a class='page-link' href='" + (startNum - 1) + "'>Previos</a></li>";
			}
			
			for (var i = startNum; i <= endNum; i++) {
				var active = pageNum == i ? "active" : "";
				
				str += "<li class='page-item " + active + " '><a class='page-link' href='" + i + "'>" + i + "</a></li>";
			}
			
			if (next) {
				str += "<li class='page-item'><a class='page-link' href='" + (endNum + 1) + "'>Next</a></li>";
			}
			
			str += "</ul></div>";
			
			console.log(str);
			
			replyPageFooter.html(str);
		}
		
		replyPageFooter.on("click", "li a", function(e) {
			e.preventDefault();
			
			console.log("page click");
			
			var targetPageNum = $(this).attr("href");
			
			console.log("targetPageNum : " + targetPageNum);
			
			pageNum = targetPageNum;
			
			showList(pageNum);
		});
		
		var modal = $(".modal");
		var modalInputReplyText = modal.find("input[name='replytext']");
		var modalInputReplyer = modal.find("input[name='replyer']");
		var modalInputReplyDate = modal.find("input[name='replyDate']");
		
		var modalModifyBtn = $("#modalModifyBtn");
		var modalRemoveBtn = $("#modalRemoveBtn");
		var modalRegisterBtn = $("#modalRegisterBtn");
		
		$("#modalCloseBtn").on("click", function(e) {
			modal.modal("hide");
		});
		
		$("#addReplyBtn").on("click", function(e) {
			modal.find("input").val("");
			modalInputReplyDate.closest("div").hide();
			modal.find("button[id != 'modalCloseBtn']").hide();
			
			modalRegisterBtn.show();
			
			$(".modal").modal("show");
		});
		
		modalRegisterBtn.on("click", function(e) {
			var reply = {
				replytext : modalInputReplyText.val(),
				replyer : modalInputReplyer.val(),
				bno : bnoValue
			};
			
			replyService.add(reply, function(result) {
				alert(result);
				
				modal.find("input").val("");
				modal.modal("hide");
				
				showList(-1);
			});
		});
		
		// 댓글 조회 클릭 이벤트
		$(".chat").on("click", "li", function(e) {
			var reply = {rno : $(this).data("rno")};
			
			replyService.get(reply, function(reply) {
				modalInputReplyText.val(reply.replytext);
				modalInputReplyer.val(reply.replyer);
				modalInputReplyDate.val(replyService.displayTime(reply.regdate)).attr("readonly", "readonly");
				modal.data("rno", reply.rno);
				
				modal.find("button[id != 'modalCloseBtn']").hide();
				modalModifyBtn.show();
				modalRemoveBtn.show();
				
				$(".modal").modal("show");
			});
		});
		
		// 댓글 수정
		modalModifyBtn.on("click", function(e) {
			var reply = {
					rno : modal.data("rno"),
					replytext : modalInputReplyText.val()
				};
 			
			replyService.update(reply, function(result) {
				alert(result);
				
				modal.modal("hide");
				
				showList(pageNum);
			});
		});
		
		// 댓글 삭제
		modalRemoveBtn.on("click", function(e) {
			var reply = {
					rno : modal.data("rno")
				};
			
			replyService.remove(reply, function(result) {
				alert(result);
				
				modal.modal("hide");
				showList(pageNum);
			});
		});
	});
</script>
<script>
	$(function() {
		var operForm = $("#operForm");
		
		$("button[data-oper='modify']").on("click", function(e) {
			operForm.attr("action", "/board/modify").submit();
		});
		
		$("button[data-oper='list']").on("click", function(e) {
			operForm.find("bno").remove();
			operForm.attr("action", "/board/list")
			operForm.submit();
		});
	});
</script>
<!-- 첨부파일 처리 -->
<script>
$(document).ready(function() {
	  // 첨부파일 데이터 취득(즉시 실행 함수 사용)
	  (function() {
	  	var bno = "${board.bno}";
	    
	    $.getJSON("/board/getAttachList", {bno: bno}, function(arr) {
	        
	       console.log(arr);
	       
	       var str = "";
	       
	       $(arr).each(function(i, attach){
	    	 //image type
	    	 	 console.log("filetype : ", attach.fileType);
		         if(attach.fileType){
		           console.log("attach.fileType : " + attach.fileType);
		           var fileCallPath =  encodeURIComponent(attach.uploadPath+ "/s_" + attach.uuid +"_" + attach.fileName);
		           
		           str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename='" + attach.fileName + "' data-type='" + attach.fileType + "' ><div>";
		           str += "<img src='/display?fileName=" + fileCallPath+"'>";
		           str += "</div>";
		           str +"</li>";
		         } else {
		           str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename='" + attach.fileName + "' data-type='" + attach.fileType+"' ><div>";
		           str += "<span> "+ attach.fileName + "</span><br/>";
		           str += "<img src='/resources/img/attach.png'></a>";
		           str += "</div>";
		           str +"</li>";
		         }
		       });
	       
	       $(".uploadResult ul").html(str);
	     });//end getjson
	  })();//end function
	  
	  $(".uploadResult").on("click","li", function(e){
	      
	    console.log("view image");
	    
	    var liObj = $(this);
	    
	    var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_" + liObj.data("filename"));

	    if(liObj.data("type")){
	      showImage(path.replace(new RegExp(/\\/g),"/"));
	    } else {
	      //download 
	      self.location ="/download?fileName=" + path;
	    }
	    
	    
	  });
	  
	  // 해당 경로의 이미지 표시
	  function showImage(fileCallPath){
	    $(".bigPictureWrapper").css("display","flex").show();
	    
	    $(".bigPicture")
	    .html("<img src='/display?fileName="+fileCallPath+"' >")
	    .animate({width:"100%", height: "100%"}, 1000);
	    
	  }

	  // 원본 이미지 창 닫기
	  $(".bigPictureWrapper").on("click", function(e){
	    $(".bigPicture").animate({width:"0%", height: "0%"}, 1000);
	    setTimeout(function(){
	      $(".bigPictureWrapper").hide();
	    }, 1000);
	  });
	});

</script>

<%@include file="../includes/footer.jsp"%>











