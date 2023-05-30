<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<%@ include file="../../includes/header.jsp"%>

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">마이 페이지</h1>
                    <form role="form" id="actionForm" action="/member/modify" method="post">
						<input type="hidden" name="pageNum" value="${cri.pageNum }">
						<input type="hidden" name="amount" value="${cri.amount }">
						<input type="hidden" name="type" value="${cri.type }">
						<input type="hidden" name="keyword" value="${cri.keyword }">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
						<input type="hidden" id="userId" name="userId" value="${member.userId }">
	                    <div class="card shadow p-3">
	                        <div class="card-header py-3">
								<h4 class="widget-title pull-left">${member.userId } 님의 개인정보</h4>
	                        </div>
                        	<div class="card-body">
                        		<div class="mb-3 row">
			                    	<div class="col-sm-12">
										<label class="form-label">이름</label>
			                    	</div>
									<div class="col-sm-12">
										<div class="input-group">
											<input type="text" class="form-control" name="userName" id="userName" readonly="readonly" value="${member.userName }">
											<span class="input-group-btn">
												<button class="btn btn-secondary" data-oper="userName" type="button">수정</button>
											</span>
										</div><!-- /input-group -->
									</div>
								</div>
								<div class="mb-3 row">
			                    	<div class="col-sm-12">
										<label class="form-label">등급</label>
										<input type="text" class="form-control" name="auth" id="auth" readonly="readonly" value="${member.authList[0].auth }">
			                    	</div>
								</div>
								<div class="mb-3 row">
			                    	<div class="col-sm-12">
										<label class="form-label">회원가입일</label>
										<input type="text" class="form-control" name="regDate" id="regDate" disabled="disabled"
											value="<fmt:formatDate value="${member.regDate }" pattern="yyyy년 MM월 dd일 hh시 mm분 ss초"
										/>">
			                    	</div>
								</div>
								<div class="mb-3 row">
			                    	<div class="col-sm-12">
										<label class="form-label">회원정보 수정일</label>
										<input type="text" class="form-control" name="updateDate" id="updateDate" disabled="disabled"
											value="<fmt:formatDate value="${member.updateDate }" pattern="yyyy년 MM월 dd일 hh시 mm분 ss초"
										/>">
			                    	</div>
								</div>
								<div class="mb-3 row">
									<div class="col-sm-12">
										<label class="form-label">우편번호</label>
			                    	</div>
									<div class="col-sm-12">
										<div class="input-group">
											<input type="text" class="form-control" name="postCode" id="sample2_postcode" readonly="readonly" value="${member.postCode }">
											<span class="input-group-btn">
												<button type="button" class="form-control btn btn-secondary" id="postCode" onclick="sample2_execDaumPostcode()" hidden="hidden">주소 찾기</button>
											</span>
											<span class="input-group-btn">
												<button type="button" data-oper="postCode" class="form-control btn btn-secondary">수정</button>
											</span>
										</div><!-- /input-group -->
									</div>
								</div>
								<div class="mb-3 row">
			                    	<div class="col-sm-12">
										<label class="form-label">주소</label>
										<input type="text" class="form-control" name="address" id="sample2_address" readonly="readonly" value="${member.address }">
			                    	</div>
								</div>
								<div class="mb-3 row">
			                    	<div class="col-sm-12">
										<label class="form-label">상세주소</label>
										<input type="text" class="form-control" name="detailAddress" id="sample2_detailAddress" readonly="readonly" value="${member.detailAddress }">
			                    	</div>
								</div>
								<div class="mb-3 row">
			                    	<div class="col-sm-12">
										<label class="form-label">참고항목</label>
										<input type="email" class="form-control" name="extraAddress" id="sample2_extraAddress" readonly="readonly" value="${member.extraAddress }">
			                    	</div>
								</div>
	                            <div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
									<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
								</div>
			                    <div class="row">
									<div class="col-sm-offset-3 col-sm-12">
										<button type="submit" data-oper="authUp" class="btn btn-secondary m-1">등급 갱신 신청</button>
										<button type="submit" data-oper="home" class="btn btn-secondary float-right m-1">Home</button>
										<sec:authentication property="principal" var="pinfo"/>
										<sec:authorize access="isAuthenticated()">
											<c:if test="${pinfo.username eq member.userId}">
												<button type="submit" data-oper="remove" class="btn btn-danger float-right m-1">회원탈퇴</button>	
												<button type="submit" data-oper="modify" class="btn btn-success float-right m-1">수정 완료</button>									
											</c:if>
										</sec:authorize>
									</div>
								</div>
							</div>
	                    </div>
                    </form>

                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	$(document).ready(function(){
		
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
		var formObj = $("form[role=form]");
		
		let isChange = false;
		
		$("button[type=submit]").on("click", function(event){
			event.preventDefault();
			
			let operation = $(this).data('oper');
			
			if(operation === 'modify'){
				
				if(isChange){
					alert("수정작업을 완료해주시고 눌러주세요.")
					return;
				}
				
				var str = "";
				
				formObj.append(str);
							
			} else if(operation === 'remove'){
				if(isChange){
					if(confirm("수정 작업중입니다. 정말로 탈퇴 하시겠습니까?")){
						$("#actionForm").attr("action", "/member/remove");
					} else {
						return false;
					}
				} else if(confirm("정말로 탈퇴 하시겠습니까?")){
					$("#actionForm").attr("action", "/member/remove");
				} else {
					return false;
				}
				
			} else if(operation === 'home'){
				$("#actionForm").attr("action", "/");
				$("#actionForm").attr("method", "get");
				
				let pageNumTag = $("input[name=pageNum]").clone();
				let amountTag = $("input[name=amount]").clone();
				let typeTag = $("input[name=type]").clone();
				let keywordTag = $("input[name=keyword]").clone();
				
				$("#actionForm").empty();
				$("#actionForm").append(pageNumTag);
				$("#actionForm").append(amountTag);
				$("#actionForm").append(typeTag);
				$("#actionForm").append(keywordTag);
				
				if(isChange){
					if(!confirm("변경한 내용이 저장되지 않을 수 있습니다. 괜찮으십니까?")){
						return;
					}
				}
				
			} else if(operation === 'authUp'){
				
				$("#actionForm").attr("action", "/member/authup");
				
			}
			
			formObj.submit();
		});
		
		$("button[type=button]").on("click", function(event){
			event.preventDefault();
			
			let operation = $(this).data('oper');
			
			
			if(operation === 'userName' && $(this).html() == "완료"){
				$("#userName").attr("readonly", "readonly")
				$(this).text("수정");
				isChange = false;
				return;
			}
			if(operation === 'userName'){
				$("#userName").removeAttr("readonly")
				$(this).text("완료");
				isChange = true;
			}
			
			if(operation === 'postCode' && $(this).html() == "완료"){
				$("#sample2_detailAddress").attr("readonly", "readonly")
				$(this).text("수정");
				$("#postCode").attr("hidden", "hidden");
				isChange = false;
				return;
			}
			if(operation === 'postCode'){
				$("#sample2_detailAddress").removeAttr("readonly")
				$(this).text("완료");
				$("#postCode").removeAttr("hidden")
				isChange = true;
			}
			
			
		});
		
	});//$(document).ready(function(){
	
	//우편번호 찾기 화면을 넣을 element
	var element_layer = document.getElementById('layer');
	
	function closeDaumPostcode() {
	    // iframe을 넣은 element를 안보이게 한다.
	    element_layer.style.display = 'none';
	}
	
	function sample2_execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var addr = ''; // 주소 변수
	            var extraAddr = ''; // 참고항목 변수
	
	            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                addr = data.roadAddress;
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                addr = data.jibunAddress;
	            }
	
	            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	            if(data.userSelectedType === 'R'){
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraAddr !== ''){
	                    extraAddr = ' (' + extraAddr + ')';
	                }
	                // 조합된 참고항목을 해당 필드에 넣는다.
	                document.getElementById("sample2_extraAddress").value = extraAddr;
	            
	            } else {
	                document.getElementById("sample2_extraAddress").value = '';
	            }
	
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('sample2_postcode').value = data.zonecode;
	            document.getElementById("sample2_address").value = addr;
	            // 커서를 상세주소 필드로 이동한다.
	            document.getElementById("sample2_detailAddress").focus();
	
	            // iframe을 넣은 element를 안보이게 한다.
	            // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
	            element_layer.style.display = 'none';
	        },
	        width : '100%',
	        height : '100%',
	        maxSuggestItems : 5
	    }).embed(element_layer);
	
	    // iframe을 넣은 element를 보이게 한다.
	    element_layer.style.display = 'block';
	
	    // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
	    initLayerPosition();
	}
	
	// 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
	// resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
	// 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
	function initLayerPosition(){
	    var width = 300; //우편번호서비스가 들어갈 element의 width
	    var height = 400; //우편번호서비스가 들어갈 element의 height
	    var borderWidth = 5; //샘플에서 사용하는 border의 두께
	
	    // 위에서 선언한 값들을 실제 element에 넣는다.
	    element_layer.style.width = width + 'px';
	    element_layer.style.height = height + 'px';
	    element_layer.style.border = borderWidth + 'px solid';
	    // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
	    element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
	    element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
	}
</script>

<%@ include file="../../includes/footer.jsp"%>
           