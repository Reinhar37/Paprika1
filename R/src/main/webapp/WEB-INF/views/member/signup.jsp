<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<script src="/resources/vendor/jquery/jquery.min.js"></script>

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Register</title>

    <!-- Custom fonts for this template-->
    <link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body class="bg-gradient-primary">

    <div class="container">

        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <div class="row">
                    <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
                    <div class="col-lg-7">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">Create an Account!</h1>
                            </div>
                            <form id="frm" class="user" method="post" action="/member/signup">
								<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
                                <div class="form-group row">
                                	<div class="col-sm-6">
                                    	<input type="text" name="userId" class="form-control form-control-user" id="userId"
                                        	placeholder="ID">
                                    </div>
                                    <div class="col-sm-6">
                                    	<input type="button" id="idChk" class="btn btn-secondary btn-user btn-block" value="중복 확인">
                                    </div>
                                    <small id="msg"></small>
                                </div>
                                <div class="form-group">
                                    <input type="password" name="userPassword" class="form-control form-control-user" id="userPassword"
                                        placeholder="Password">
                                    <small id="msg2"></small>
                                </div>
                                <div class="form-group">
                                    <input type="text" name="userName" class="form-control form-control-user" id="userName"
                                        placeholder="Name">
                                </div>
                                <div class="form-group row">
                                	<div class="col-sm-6">
                                    	<input type="text" name="postCode" class="form-control form-control-user" id="sample2_postcode"
                                        placeholder="우편번호">
                                	</div>
                                    <div class="col-sm-6">
                                    	<input type="button" class="btn btn-secondary btn-user btn-block" onclick="sample2_execDaumPostcode()" value="우편번호 찾기">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <input type="text" name="address" class="form-control form-control-user" id="sample2_address"
                                        placeholder="주소">
                                </div>
                                <div class="form-group">
                                    <input type="text" name="detailAddress" class="form-control form-control-user" id="sample2_detailAddress"
                                        placeholder="상세주소">
                                </div>
                                <div class="form-group">
                                    <input type="text" name="extraAddress" class="form-control form-control-user" id="sample2_extraAddress"
                                        placeholder="참고항목">
                                </div>
                                <div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
									<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
								</div>
									<Button type="submit" class="btn btn-primary btn-user btn-block">SING UP</Button>
                                <hr>
                                <a href="index.html" class="btn btn-google btn-user btn-block">
                                    <i class="fab fa-google fa-fw"></i> Register with Google
                                </a>
                                <a href="index.html" class="btn btn-facebook btn-user btn-block">
                                    <i class="fab fa-facebook-f fa-fw"></i> Register with Facebook
                                </a>
                            </form>
                            <hr>
                            <div class="text-center">
                                <a class="small" href="forgot-password.html">Forgot Password?</a>
                            </div>
                            <div class="text-center">
                                <a class="small" href="login.html">Already have an account? Login!</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/resources/js/sb-admin-2.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
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
    $(document).ready(function(){
    	
    	/* var csrfHeaderName="${_csrf.headerName}";
    	var csrfTokenValue="${_csrf.token}";
    	
    	$(document).ajaxSend(function (e, xhr, options) {
    		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
    	}); */
    	
		let isId = true;
		let isPassword = true;
		let idChk = true;

		$("#userPassword").on("keyup",function(){
			if($(this).val().length < 6){
				$("#msg2").html("6~12글자를 입력해주세요.");
				$("#msg2").css("color", "#f00");

				isPassword = false;
			} else{
				let regPass = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{6,12}$/;

				isPassword = true;
				if(!regPass.test($(this).val())){ //영문, 숫자, 특수문자 입력했다면
					$("#msg2").html("영문, 숫자 특수문자를 포함하세요");
					$("#msg2").css("color", "#f00");

					isPassword = false;
				} else {
					$("#msg2").html("");
				}
			}
			
			
		})


		$("#idChk").on("click",function(){
				
				if($("#userId").val().length < 6 || $("#userId").val().length > 12){
					$("#msg").html("6~12글자를 입력해주세요.");
					$("#msg").css("color", "#f00");

					isId = false;
				} else{
					$("#msg").html("");
					let userId = $("#userId").val();
					$.ajax ({
						// URL은 필수 요소이므로 반드시 구현해야 하는 Property입니다.
						url	: "/ajax/idChk", // 요청이 전송될 URL 주소
						type	: "GET", // http 요청 방식 (default: ‘GET’)
						async : true,  // 요청 시 동기화 여부. 기본은 비동기(asynchronous) 요청 (default: true)
						cache : true,  // 캐시 여부
						timeout : 3000, // 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백을 호출.(단위: ms)
						data : {userId : userId},
						processData : true, // 데이터를 컨텐트 타입에 맞게 변환 여부
						contentType : "application/json; charset=utf-8", // 요청 컨텐트 타입 
						dataType    : "json", // json 응답 데이터 형식 (명시하지 않을 경우 자동으로 추측)
						beforeSend  : function () {
							// XHR Header를 포함해서 HTTP Request를 하기전에 호출됩니다.
						},
						success : function(cnt) {
							// 정상적으로 응답 받았을 경우에는 success 콜백이 호출되게 됩니다.
							// 이 콜백 함수의 파라미터에서는 응답 바디, 응답 코드 그리고 XHR 헤더를 확인할 수 있습니다.
							if(cnt == "1"){ //1이면 중복아이디
								
								alert("중복된 아이디 입니다.");
								
								console.log("아이디 중복체크 1이면 중복" + cnt);

							} else {
								alert("사용 가능한 아이디 입니다.");
								
								console.log("아이디 중복체크 1이면 중복" + cnt);

								idChk = false;
							}
						},
						error	: function(xhr, status, error) {
								// 응답을 받지 못하였다거나 정상적인 응답이지만 데이터 형식을 확인할 수 없기 때문에 
								// error 콜백이 호출될 수 있습니다.
								// 예를 들어, dataType을 지정해서 응답 받을 데이터 형식을 지정하였지만,
								// 서버에서는 다른 데이터형식으로 응답하면  error 콜백이 호출되게 됩니다.
						},
						complete : function(xhr, status) {
							// success와 error 콜백이 호출된 후에 반드시 호출됩니다.
							// try - catch - finally의 finally 구문과 동일합니다.
						}
					});
				}
			});
		$("button[type=submit]").on("click", function(event){

			event.preventDefault();
			
			
			if($("#userId").val() == '' || $("#userId").val().length < 6){
				alert("아이디를 양식에 맞게 입력하세요.");
				$("#userId").focus();
				return;
			}
			if($("#userPassword").val() == '' || $("#userPassword").val().length < 6){
				alert("비밀번호를 양식에 맞게 입력하세요.");
				$("#userPassword").focus();
				return;
			}
			if($("#userName").val() == ''){
				alert("이름을 입력하세요.");
				$("#userName").focus();
				return;
			}
			if(idChk){
				alert("아이디 중복체크를 해주세요.")
				$("#idChk").focus();
				return;
			}
			if(isId && isPassword){
				$("#frm").submit();
			}else{
				alert("양식에 맞게 입력해주세요.")
			}
			
		})
	});
</script>
</body>

</html>