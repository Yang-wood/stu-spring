<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
		width: 600px;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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
		// 특정 확장자 파일 업로드 제한용 정규식
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		
		// 1byte = 2^3 = 8bit
		// 1KB = 2^10bit = 1024bit
		// 1MB = 2^10K = 1024 * 1024 = 1048576bit
		var maxSize = 5242880;
		
		// 특정 크기 및 특정 확장자 파일 업로드 제한
		function checkExtension(fileName, fileSize) {
			if (fileSize >= maxSize) {
				alert("파일 사이즈 초과");
				return false;
			}
			
			if (regex.test(fileName)) {
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				return false;
			}
		}
		
		var cloneObj = $(".uploadDiv").clone();
		
		
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
			var str = "";
			
			$(uploadResultArr).each(function(i, obj) {
				if (!obj.image) {
					var fileCallPath 
					= encodeURIComponent
					(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
					var fileLink
					= fileCallPath.replace(new RegExp(/\\/g), "/");
					
					str += "<li><div><a href='/download?fileName=" + fileCallPath
							+ "'>" + "<img src='/resources/img/attach.png'>"
							+ obj.fileName + "</a>" + "<span data-file=\'" 
							+ fileCallPath + "\' data-type='file'>x</span>"
							+ "</div></li>";
				} else {
					var fileCallPath = encodeURIComponent
					(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
					var originPath = obj.uploadPath + "\\" + obj.uuid + "_"	+ obj.fileName;
					
					originPath = originPath.replace(new RegExp(/\\/g), "/");
					
					str += "<li><a href=\"javascript:showImage(\'" + originPath + "\')\">"
						+ "<img src='/display?fileName=" + fileCallPath + "'></a>"
						+ "<span data-file=\'" + fileCallPath + "\' data-type='image'>x</span>"
						+ "</li>"
				}
			});
			
			uploadResult.append(str);
		}
	});
</script>
</head>
<body>
	<h1>Upload With Ajax</h1>
	<div class="bigPictureWrapper">
		<div class="bigPicture">
		</div>
	</div>	
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple="multiple">
	</div>
	
	<div class="uploadResult">
		<ul>
			
		</ul>
	</div>
	
	<button id="uploadBtn">Upload</button>
</body>
</html>












