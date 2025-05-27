<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../includes/header.jsp" %>
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
	
	.uploadResult ul li image {
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
<script type="text/javascript">
	// 화면에 원본 이미지 표시
	function showImage(fileCallPath) {
		$(".bigPictureWrapper").css("display", "flex").show();
		
		// <img> 태그를 추가하고 jquery의 animate()를 이용해서 지정된 시간동안 화면에서
		//	열리는 효과를 처리
		$(".bigPicture")
		.html("<img src='/display?fileName=" + fileCallPath + "'>")
		.animate({width:'100%', height:'100%'}, 1000);
	}	
	
	
	$(document).ready(function() {
		var formObj = $("form[role='form']");
		
		$("button[type='submit']").on("click", function(e) {
			e.preventDefault();
			
			console.log("submit clicked");
			
			var str = "";
			
			$(".uploadResult ul li").each(function(i, obj) {
				var jobj = $(obj);
				
				console.dir(jobj);
				console.log("-------------------------------");
				console.log(jobj.data("filename"));
				
				str += "<input type='hidden' name='attachList[" + i + "].fileName' value='" + jobj.data("filename") + "'>"; 
				str += "<input type='hidden' name='attachList[" + i + "].uuid' value='" + jobj.data("uuid") + "'>"; 
				str += "<input type='hidden' name='attachList[" + i + "].uploadPath' value='" + jobj.data("path") + "'>"; 
				str += "<input type='hidden' name='attachList[" + i + "].fileType' value='" + jobj.data("type") + "'>"; 
			});
			
			console.log(str);
			formObj.append(str).submit();
		});
		
		// 특정 확장자 파일 업로드 제한용 정규식
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		
		// 1byte = 2^3 = 8bit
		// 1KB = 2^10bit = 1024bit
		// 1MB = 2^10K = 1024 * 1024 = 1048576bit
		var maxSize = 5242880;
		
		// 특정 크기 및 특정 확장자 파일 업로드 제한
		function checkExtension(fileName, fileSize) {
			console.log("검사중:", fileName, fileSize);
			
			if (fileSize >= maxSize) {
				alert("파일 사이즈 초과");
				return false;
			}
			
			if (regex.test(fileName)) {
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				return false;
			}
			return true;
		}
		
		var cloneObj = $(".uploadDiv").clone();
		
		$("input[type='file']").change(function() {
			var formData = new FormData();
			
			var inputFile = $("input[name='uploadFile']");
			
			var files = inputFile[0].files;
			
			for (var i = 0; i < files.length; i++) {
				if (!checkExtension(files[i].name, files[i].size)) {
					return false;
				}
				
				formData.append("uploadFile", files[i]);
			}
			
			$.ajax({
				url : "/uploadAjaxAction",
				processData : false,
				contentType : false,
				data : formData,
				type : "post",
				dataType : "json",
				success : function(result) {
					console.log(result);
					showUploadedFile(result);
				}
			});
		});
		
		$("#uploadBtn").on("click", function(e) {
			var formData = new FormData();
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;
			
			console.log(files);
			
			// 첨부 파일 데이터 formData에 추가
			for (var i = 0; i < files.length; i++) {
				if (!checkExtension(files[i].name, files[i].size)) {
					return false;
				}
				
				formData.append("uploadFile", files[i]);
			}
			
			$.ajax({
				url : "/uploadAjaxAction",
				processData : false,
				contentType : false,
				data : formData,
				type : "POST",
				dataType : "json",
				success : function(result) {
					console.log(result);
					showUploadedFile(result);
					$(".uploadDiv").html(cloneObj.html());
				}
			});
		});
		
		var uploadResult = $(".uploadResult ul");
		
		function showUploadedFile(uploadResultArr) {
			if (!uploadResultArr || uploadResultArr.length == 0) {
				return;
			}
			var uploadUL = $(".uploadResult ul");
			var str = "";
			
			$(uploadResultArr).each(function(i, obj) {
				if (obj.image) {
					var fileCallPath 
					= encodeURIComponent
					(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
					var fileLink
					= fileCallPath.replace(new RegExp(/\\/g), "/");
					
					str += "<li data-path='" + obj.uploadPath + "'";
					str += " data-uuid='" + obj.uuid + "' data-filename='" 
							+ obj.fileName + "' data-type='" + obj.image + "' ></div>";
					str += "<span> " + obj.fileName + "</span>";
					str += "<button type='button' data-file=\'" + fileCallPath + "\' "
					str += "data-type='image' calss='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/display?fileName=" + fileCallPath + "'>";
					str += "</div>";
					str += "</li>";
				} else {
					var fileCallPath 
					= encodeURIComponent
					(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
					var fileLink
					= fileCallPath.replace(new RegExp(/\\/g), "/");
					
					str += "<li data-path='" + obj.uploadPath + "'";
					str += " data-uuid='" + obj.uuid + "' data-filename='" 
							+ obj.fileName + "' data-type='" + obj.image + "' ></div>";
					str += "<span> " + obj.fileName + "</span>";
					str += "<button type='button' data-file=\'" + fileCallPath + "\' "
					str += "data-type='file' calss='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/resources/img/attach.png'></a>";
					str += "</div>";
					str += "</li>";
				}
			});
			
			uploadResult.append(str);
		}
		
		//확대된 원본 이미지 축소
		$(".bigPictureWrapper").on("click", function(e) {
			$(".bigPicture").animate({width:"0%"}, {height:"0%"}, 500);
			
			setTimeout(() => {
				$(this).hide();
			}, 500);
		});
		
		// 첨부 파일 삭제
		$(".uploadResult").on("click", "button", function(e) {
			console.log("delete file");
			
			var targetFile = $(this).data("file");
			var type = $(this).data("type");
			var targetLi = $(this).closest("li");
			
			console.log("targetFile ====> " + targetFile);
				
			$.ajax({
				url : "/deleteFile",
				data : {filename:targetFile, type:type},
				dateType : "text",
				type : "post",
				success : function(result) {
					alert(result);
					
					targetLi.remove();
				}
			});
		});
	});
</script>


<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">Board Register</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading"> Board List Page </div>
            <!-- /.panel-heading -->
            <div class="panel-body">
               
        <form role="form" action="/board/register" method="post">
          <div class="form-group">
            <label>Title</label> <input class="form-control" name='title'>
          </div>

          <div class="form-group">
            <label>Text area</label>
            <textarea class="form-control" rows="3" name='content'></textarea>
          </div>

          <div class="form-group">
            <label>Writer</label> <input class="form-control" name='writer'>
          </div>
          <button type="submit" class="btn btn-default">Submit
            Button</button>
          <button type="reset" class="btn btn-default">Reset Button</button>
        </form>
            </div>
            <!-- /.panel-body -->
        </div>
        <!-- /.panel -->
    </div>
    <!-- /.col-lg-6 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">File Attach</div>
			<div class="panel-body">
				<div class="form-group uploadDiv">
					<input type="file" name="uploadFile" multiple="multiple">
				</div>
				
				<div class="uploadResult">
					<ul>
						
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="../includes/footer.jsp" %>

        