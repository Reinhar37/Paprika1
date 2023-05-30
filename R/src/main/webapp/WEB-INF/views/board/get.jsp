<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<%@ include file="../../includes/header.jsp"%>
<style>
	.bigPictureWrapper{
		position: absolute;
		display: none;
		justify-content: center;
		align-items:  center;
		top: 0%;
		width: 100%;
		height: 100%;
		background-color: gray;
		z-index: 100;
		background: rgba(255,255,255,0.5);
	}
	.bigPicture{
		position: relative;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	.bigPicture img{
		width: 600px;
	}
</style>

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800" id="boardTitle">자유 게시판</h1>

                    <!-- DataTales Example -->
                    <div class="card shadow">
                        <div class="card-header py-3">
                        	<div class="row">
	                            <h4 class="m-0 widget-title pull-left col-sm-8">${board.title }</h4>
	                            <div class="col-sm-4">
	                            	<form action="/board/modify">
	                            		<input type="hidden" name="pageNum" value="${cri.pageNum }">
										<input type="hidden" name="pageNum" value="${cri.amount }">
										<input type="hidden" name="type" value="${cri.type }">
										<input type="hidden" name="keyword" value="${cri.keyword }">
										<input type="hidden" class="form-control" id="bno" name="bno"
										value="${board.bno }" readonly="readonly">
										<a href="list${cri.listLink }" role="button" data-oper="list" class="btn btn-secondary float-right m-1">List</a>
										<sec:authentication property="principal" var="pinfo"/>
										<sec:authorize access="isAuthenticated()">
											<c:if test="${pinfo.username eq board.writer }">
												<button type="submit" data-oper="modify" class="btn btn-success float-right m-1">Modify</button>
											</c:if>
										</sec:authorize>
	                            	</form>
	                            </div>
	                        </div>
							<small class="pull-right text-muted">${board.writer }</small>
							<c:if test = "${board.regDate == board.updateDate }">
						        <small class="pull-right text-muted">
									<fmt:formatDate value="${board.regDate }" pattern="yyyy년 MM월 dd일 hh시 mm분 ss초"/>
								</small>
						    </c:if>
						    <c:if test = "${board.regDate != board.updateDate }">
						        <small class="pull-right text-muted">
									Create.<fmt:formatDate value="${board.regDate }" pattern="yyyy년 MM월 dd일"/>
								</small>
								<small class="pull-right text-muted">
									Last Update.<fmt:formatDate value="${board.updateDate }" pattern="yyyy년 MM월 dd일 hh시 mm분 ss초"/>
								</small>
						    </c:if>
                        </div>
                        <div class="card-body">
                        	${board.content }
                        </div>
                        <div class="row p-4">
							<div class="col-md-12">
								<div class="panel panel-default">
									<hr>
									<div class="panel-heading">File Attach</div>
									<div class="panel-body">
										<div class="uploadResult">
											<ul class="d-flex list-inline">
											</ul>
										</div>
									</div>
								</div>
							</div>
						</div>
                    </div>
                    
                    
                    <div class="card shadow">
                        <div class="card-header py-3">
                        	<div class="row">
	                            <h4 class="m-0 widget-title pull-left col-sm-3"><i class="fa fa-comments fa-fw"></i>Reply</h4>
								
								<div class="col-sm-9" >
									<sec:authorize access="isAuthenticated()">
										<button id="addReplyBtn" class="btn btn-primary btn-sm float-right">New Reply</button>
									</sec:authorize>
								</div>
	                        </div>
                        </div>
                        <div class="card-body">
                        	<div class="panel-body">
								<ul class="chat">
									<li class="left clearfix" data-rno="12">
										<div>
											<div class="header">
												<strong class="primary-font">user00</strong> <small
													class="pull-right text-muted">2018-01-01 13:13</small>
											</div>
											<p>Good job!</p>
										</div>
										<hr>
									</li>
								</ul>
							</div>
								<div class="panel-footer float-right">
									여기에 댓글페이징
								</div>
                        </div>
                    </div>
                    

                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->
            
<!-- Modal 추가 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4 class="modal-title" id="myModalLabel">Reply Modal</h4>
		</div>
		<div class="modal-body">
			<div class="form-group">
				<label>Reply</label>
				<textarea class="form-control" name="reply" id="reply"></textarea>
			</div>
			<div class="form-group">
				<label>Replyer</label>
				<input class="form-control" name="replyer" id="replyer" readonly="readonly"></input>
			</div>
			<div class="form-group">
				<label>Reply Date</label>
				<input class="form-control" name="replyDate" id="replyDate" readonly="readonly"></input>
			</div>
		</div>
			<div class="modal-footer">
				
				<sec:authentication property="principal" var="pinfo"/>
				<button id="modalModBtn" type="button" class="btn btn-success">Modify</button>
				<button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>
				<button id="modalRegisterBtn" type="button" class="btn btn-success">Register</button>
				<button id="modalCloseBtn" type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				<!-- <button type="button" class="btn btn-primary">Save changes</button> -->
			</div>
		</div>
	</div>
</div>

<script src="/resources/js/reply.js"></script>
<script>
$(document).ready(function(){
	
	var csrfHeaderName="${_csrf.headerName}";
	var csrfTokenValue="${_csrf.token}";
	
	$(document).ajaxSend(function (e, xhr, options) {
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});
	
	<sec:authorize access="isAuthenticated()">
		var replyer = "<sec:authentication property="principal.username"/>"
	</sec:authorize>
	
	var bnoValue = '<c:out value="${board.bno }"/>';
		
	var replyUL = $(".chat");		
	var replyPageFooter = $(".panel-footer");

	var pageNum = 1;
	var replyCnt2 = 0;
	
	
	showList(1);
	showReplyPage(1);
	
	function showList(page){

		
		replyService.getList({bno:bnoValue, page:page|| 1}, function(replyCnt, list){

			replyCnt2 = replyCnt;
			
			if(page == -1){
				pageNum = Math.ceil(replyCnt/10.0);
				showList(pageNum);
				return;
			}
			
			
			var str = ""; 
			
			if(list == null || list.length == 0){
				
				replyUL.html("");
				
				return;
			}
			
			
			len = list.length || 0;
			for(var i = 0; i < len; i++){
				str += '<li class="left clearfix" data-rno = "'+list[i].rno+'">';
				str += '<div>';
				str += '<div class="header">';
				str += '<strong class="primary-font">'+list[i].replyer+'</strong>';
				str += '<small class="float-right text-muted">'+replyService.displayTime(list[i].replyDate)+'</small>';
				str += '</div>';
				str += '<p>'+list[i].reply+'</p>';
				str += '</div>';
				str += '<hr>';
				str += '</li>';			
			}
			
			replyUL.html(str);
			
			showReplyPage(replyCnt);
			
		});


	}
			
	//모달창 띄우기
	var modal = $("#myModal");
	var modalInputReply = $('#reply');
	var modalInputReplyer = $('#replyer');
	var modalInputReplyDate = $('#replyDate');
	
	
	var modalModBtn = $("#modalModBtn");
	var modalRemoveBtn = $("#modalRemoveBtn");
	var modalRegisterBtn = $("#modalRegisterBtn");
	
	$("#addReplyBtn").on("click", function(e){

		modalInputReply.val('');
		modalInputReplyer.val(replyer);
		modalInputReplyDate.val('');		
		
		modalInputReplyDate.closest("div").hide();
		modal.find("button[id != 'modalCloseBtn']").hide();
		
		modalRegisterBtn.show();
		
		modal.modal("show");
	});
	
	modalRegisterBtn.on("click",function(){
		var reply = {
				reply:modalInputReply.val(),
				replyer:modalInputReplyer.val(),
				bno:bnoValue
		};
		
		replyService.add(
				reply,
				function(result){

					modalInputReply.val('');
					modalInputReplyer.val('');
					modalInputReplyDate.val('');	
					
					modal.modal("hide");
					
					showList(-1);
				});
	});
	
	//목록을 클릭하면
	$(".chat").on("click", "li", function(){
		var rno = $(this).data("rno");
		replyService.get(rno, function(reply){
			
			modalInputReplyDate.closest("div").show();
			
			modalInputReply.val(reply.reply);
			modalInputReplyer.val(reply.replyer);
			modalInputReplyDate.val(replyService.displayTime(reply.replyDate));
			
			modal.data("rno", reply.rno);
			
			modal.find("button[id != 'modalCloseBtn']").hide();
			
			modalModBtn.show();
			modalRemoveBtn.show();
			
			modal.modal("show");
		});
	});
	
	modalModBtn.on("click", function(){
		
		var rno = modal.data("rno");
		var originalReplyer = modalInputReplyer.val();
		
		var reply = {
				reply:modalInputReply.val(),
				replyer:originalReplyer,
				rno:rno
		};
		
		if(!replyer){
			alert("로그인후 삭제가 가능합니다.");
			modal.modal("hide");
			return;
		}
		
		if(replyer != originalReplyer){
			alert("자신이 작성한 댓글만 삭제가 가능합니다.");
			modal.modal("hide");
			return;
		}
		
		replyService.update(
				reply,
				function(result){

					modalInputReply.val('');
					modalInputReplyer.val('');
					modalInputReplyDate.val('');	
					
					modal.modal("hide");
					
					showList(pageNum);
				});
	});
	
	modalRemoveBtn.on("click", function(){
		
		var rno = modal.data("rno");

		console.log("RNO: " + rno);
		console.log("REPLYER: " + replyer);
		
		if(!replyer){
			alert("로그인후 삭제가 가능합니다.");
			modal.modal("hide");
			return;
		}
		
		var originalReplyer = modalInputReplyer.val();
		
		if(replyer != originalReplyer){
			alert("자신이 작성한 댓글만 삭제가 가능합니다.");
			modal.modal("hide");
			return;
		}
		
		var endNum = Math.ceil(pageNum / 10.0) *10;
		
		replyCnt2 = replyCnt2 -1;
		
		if(endNum * 10 >= replyCnt2){
			endNum = Math.ceil(replyCnt2/10.0);
		}
		
		replyService.remove(rno, originalReplyer, function(result){
			alert(result);

			modalInputReply.val('');
			modalInputReplyer.val('');
			modalInputReplyDate.val('');	
			
			modal.modal("hide");
			
			if(pageNum > endNum){
				pageNum = pageNum-1;
			} 
			
			showList(pageNum);
		});
		
	});
	
	
	function showReplyPage(replyCnt){
		var endNum = Math.ceil(pageNum / 10.0) *10;
		var startNum = endNum -9;
		
		var prev = startNum != 1;
		var next = false;

		if(endNum * 10 >= replyCnt){
			endNum = Math.ceil(replyCnt/10.0);
		}
		
		if(endNum * 10 < replyCnt){
			next = true;
		}

		var str = "<div class='text-right'><ul class='pagination'>";
		if(prev){
			
			str += "<li class='page-item'><a class='page-link' href='"+(startNum - 1) + "'>Previous</a></li>";
		}

		console.log("startNum:" + startNum);
		console.log("endNum:" + endNum);
		
		for(var i = startNum ; i <= endNum; i++){
			var active = pageNum == i?"active":"";
			str += "<li class='page-item "+active+"'><a class='page-link' href='"+i + "'>"+i+"</a></li>";	
		}

		if(next){
			
			str += "<li class='page-item'><a class='page-link' href='"+(endNum + 1) + "'>Next</a></li>";
		}
		str += "</ul></div>";
		//console.log(str);
		replyPageFooter.html(str);
	}
	
	replyPageFooter.on("click", "li a", function(e){
		e.preventDefault();
		
		var targetPageNum = $(this).attr("href");
		
		pageNum = targetPageNum;
		
		showList(pageNum);
	});
	
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	let uploadResult = $(".uploadResult ul");
	
	(function () {
		
		
		$.getJSON("/board/getAttachList", {bno : bnoValue}, function (uploadResultArr) {
			
			let str = "";
			
			$(uploadResultArr).each(function (i, obj) {
				
				let fileDownPath = obj.uploadPath + "/" + obj.uuid + "_" + encodeURIComponent(obj.fileName);
				
				// 일반 파일
				if(obj.fileType != '1'){
					str += "<li class='list-inline-item' data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-fileName='" + obj.fileName + "' data-type='" + obj.fileType + "'>";
					str += "<div>";
					str += "<span>" + obj.fileName + "</span>"
					str += "<img src='/resources/img/attach.png'>"
					str += "</div>"
					str += "</li>";
					
				// 이미지 파일
				}else {
					let fileCallPath = encodeURIComponent(obj.uploadPath + "/thum_" + obj.uuid + "_" + obj.fileName);
					//console.log(fileCallPath);
					fileDownPath = fileDownPath.replace(new RegExp(/\\/g), "/");
					
					str += "<li class='list-inline-item' data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-fileName='" + obj.fileName + "' data-type='" + obj.fileType + "'>";
					str += "<div>";
					str += "<span>" + obj.fileName + "</span>"
					str += "<img src='/display?fileName=" + fileCallPath + "'>";
					str += "</div>"
					str += "</li>";
				}
			});
			
			uploadResult.append(str);
			
		});
	})();
	
	
	
	$(".uploadResult").on("click", "li", function () {
		
		let liObj = $(this);
		
		let path = encodeURIComponent(liObj.data('path') + "/" + liObj.data('uuid') + "_" + liObj.data('filename'));
		
		
		if(liObj.data('type')){
			showImage(path.replace(new RegExp(/\\/g), "/"));
		} else {
			self.location = "/download?fileName=" + path;
		}
		
	});
	
	
	
	$(".bigPictureWrapper").on("click", function () {
		$(".bigPicture").animate({width: '0%', height: '0%'}, 1000);
		setTimeout(()=>{
			$(this).hide();
		}, 1000);
	});
	
	
	
	
	
	
});//$(document).ready(function(){
	
function showImage(fileCallPath) {
	$(".bigPictureWrapper").css("display", "flex").show();
	
	$(".bigPicture").html("<img src='/display?fileName=" + fileCallPath + "'>").animate({width: '100%', height: '100%'}, 1000);
	
}

</script>

<%@ include file="../../includes/footer.jsp"%>
           