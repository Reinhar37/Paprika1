<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<%@ include file="../../includes/header.jsp"%>

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800" id="boardTitle">자유 게시판</h1>
                    <form role="form" action="/board/register" method="post">
						<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	                    <div class="card shadow p-3">
	                        <div class="card-header py-3">
								<h4 class="widget-title pull-left">글쓰기</h4>
	                        </div>
		                    <div class="mb-3">
							  <label class="form-label">제목</label>
							  <input type="email" class="form-control" name="title" id="title">
							</div>
							<sec:authentication property="principal" var="pinfo"/>
					        <sec:authorize access="isAuthenticated()">
							<div class="mb-3">
							  <label class="form-label">작성자</label>
							  <input type="email" class="form-control" name="writer" id="writer" value="${pinfo.username}" readonly="readonly">
							</div>
	                        </sec:authorize>
							<div class="mb-3">
							  <label class="form-label">내용</label>
							  <textarea class="form-control" name="content" id="contentB" rows="20"></textarea>
							</div>
		                    <div class="row">
								<div class="col-md-12">
									<div class="panel panel-default">
										<div class="panel-heading">File Attach</div>
										<div class="panel-body">
											<div class="form-group uploadDiv">
												<input type="file" name="uploadFile" multiple="multiple">
											</div>
											<div class="uploadResult">
												<ul class="d-flex list-inline">
												</ul>
											</div>
										</div>
									</div>
								</div>
							</div>
		                    <div class="row">
								<div class="col-sm-offset-3 col-sm-12">
									<button type="reset" class="btn btn-secondary float-right m-1">Reset</button>
									<button href="javascript:void(0)" type="submit"  class="btn btn-success float-right m-1">Register</button>
								</div>
							</div>
	                    </div>
                    </form>

                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->
<script>
function showImage(fileCallPath) {
	$(".bigPictureWrapper").css("display", "flex").show();
	
	$(".bigPicture").html("<img src='/display?fileName=" + fileCallPath + "'>").animate({width: '100%', height: '100%'}, 1000);
	
}
	$(document).ready(function () {
		
		var csrfHeaderName="${_csrf.headerName}";
		var csrfTokenValue="${_csrf.token}";
		
		var formObj = $("form[role=form]");
		
		$("button[type=submit]").on("click", function (e) {
			e.preventDefault();
			
			var str = "";
			
			$(".uploadResult ul li").each(function (i, obj) {
				
				let jobj = $(obj);
				
				let type = (jobj.data('type') == true)?"1":"0";
				
				
				str += "<input type='hidden' name='attachList[" + i + "].fileName' value='" + jobj.data('filename') + "'>";
				str += "<input type='hidden' name='attachList[" + i + "].uuid' value='" + jobj.data('uuid') + "'>";
				str += "<input type='hidden' name='attachList[" + i + "].uploadPath' value='" + jobj.data('path') + "'>";
				str += "<input type='hidden' name='attachList[" + i + "].fileType' value='" + type + "'>";
				
			});
			
			if($("#title").val() == ''){
				alert("제목을 입력해주세요.");
				$("#title").focus();
				return;
			}
			if($("#contentB").val() == ''){
				alert("내용을 입력해주세요.");
				$("#contentB").focus();
				return;
			}
			
			//console.log(str);
			formObj.append(str).submit();
		});
		
		let regex = new RegExp("(.*?)\.(png|gif|jpg|txt)$");
		let maxSize = 5242880;  //5Mbyte
		
		function checkExtension(fileName, fileSize) {
			if(fileSize >= maxSize){
				alert("파일 사이즈 초과");
				return false;
			}
			
			if(!regex.test(fileName)){
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				return false;
			}
			return true;
		}
		
		var cloneObj = $(".uploadDiv").clone();
		
		$(".uploadDiv").on("change", "input[type=file]", function () {
			let formData = new FormData();
			let inputFile = $("input[name='uploadFile']");
			
			let files = inputFile[0].files;
			
			console.log(files);
			
			for(let i = 0; i < files.length; i++){
				if(!checkExtension(files[i].name, files[i].size)){
					return false;
				}
				formData.append("uploadFile", files[i]);
			}
			
			$.ajax({
				url:'/uploadAjaxAction',
				processData: false,
				contentType: false,
				data: formData,
				type: 'POST',
				dataType: 'json',
				beforeSend: function (xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success: function (result) {
					console.log(result);
					// input type="file" 을 초기화
					$(".uploadDiv").html(cloneObj.html());
					
					// ajax 결과값을 출력
					showUploadedFile(result);
				}
			});
		});
		
		let uploadResult = $(".uploadResult ul");
		
		function showUploadedFile(uploadResultArr) {
			
			if(!uploadResultArr || uploadResultArr.length == 0){
				return;
			}
			
			let str = "";
			
			$(uploadResultArr).each(function (i, obj) {
				
				let fileDownPath = obj.uploadPath + "/" + obj.uuid + "_" + encodeURIComponent(obj.fileName);
				
				if(!obj.image){
					str += "<li class='list-inline-item' data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-fileName='" + obj.fileName + "' data-type='" + obj.image + "'>";
					str += "<div>";
					str += "<span><a href='/download?fileName=" + fileDownPath + "'>" + obj.fileName + "</a></span>"
					str += "<img src='/resources/img/attach.png'>"
					str += "<button data-file='" + fileDownPath + "' data-type='file' type='button' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button>";
					str += "</div>"
					str += "</li>";
				}else {
					let fileCallPath = encodeURIComponent(obj.uploadPath + "/thum_" + obj.uuid + "_" + obj.fileName);
					//console.log(fileCallPath);
					fileDownPath = fileDownPath.replace(new RegExp(/\\/g), "/");
					
					str += "<li class='list-inline-item' data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-fileName='" + obj.fileName + "' data-type='" + obj.image + "'>";
					str += "<div>";
					str += "<span><a href='/download?fileName=" + fileDownPath + "'>" + obj.fileName + "</a></span>"
					str += "<a href='javascript:showImage(\"" + fileDownPath + "\")'><img src='/display?fileName=" + fileCallPath + "'></a>";
					str += "<button data-file='" + fileCallPath + "' data-type='image' type='button' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button>";
					str += "</div>"
					str += "</li>";
				}
			});
			
			uploadResult.append(str);
		}
		
		$(".bigPictureWrapper").on("click", function () {
			$(".bigPicture").animate({width: '0%', height: '0%'}, 1000);
			setTimeout(()=>{
				$(this).hide();
			}, 1000);
		});
		
		$(".uploadResult").on("click", "button", function () {
			let targetFile = $(this).data("file");
			let type = $(this).data("type");
			let my = $(this);
			
			$.ajax({
				url: '/deleteFile',
				data: {fileName:targetFile, type:type},
				dataType: 'text',
				type: 'post',
				beforeSend: function (xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success: function (result) {
					my.parent().parent().remove();
				}
			});
			
		});
		
	});
</script>
<%@ include file="../../includes/footer.jsp"%>
           