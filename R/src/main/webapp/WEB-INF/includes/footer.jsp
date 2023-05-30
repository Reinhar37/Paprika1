<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <div class="container my-auto">
                    <div class="copyright text-center my-auto">
                        <span>Copyright &copy; Your Website 2021</span>
                    </div>
                </div>
            </footer>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>
    
    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-primary" href="/customLogout">Logout</a>
                </div>
            </div>
        </div>
    </div>
    <script>
    	
    	
    	$(document).ready(function () {
    		
    		var csrfHeaderName="${_csrf.headerName}";
    		var csrfTokenValue="${_csrf.token}";
    		
    		$(document).ajaxSend(function (e, xhr, options) {
    			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
    		});
    		
			let boardTitle = $("#boardTitle").html();
			
			if(boardTitle == "Main"){
				$("#activeMain").addClass('active');
			}
			
			if(boardTitle == "자유 게시판"){
				$("#activeBoard").addClass('active');
			}
			
			let alarmUL = $("#alarmUL");
			
			let hUserId = $("#hUserId").html();
			
			if(hUserId != null && hUserId != ""){
			
				$.ajax ({
					
					// URL은 필수 요소이므로 반드시 구현해야 하는 Property입니다.
					url	: "/alarm/list", // 요청이 전송될 URL 주소
					type	: "GET", // http 요청 방식 (default: ‘GET’)
					async : true,  // 요청 시 동기화 여부. 기본은 비동기(asynchronous) 요청 (default: true)
					cache : true,  // 캐시 여부
					timeout : 3000, // 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백을 호출.(단위: ms)
					data : {userId : hUserId},
					processData : true, // 데이터를 컨텐트 타입에 맞게 변환 여부
					contentType : "application/json; charset=utf-8", // 요청 컨텐트 타입 
					dataType    : "json", // json 응답 데이터 형식 (명시하지 않을 경우 자동으로 추측)
					beforeSend  : function () {
						// XHR Header를 포함해서 HTTP Request를 하기전에 호출됩니다.
					},
					success : function (list) {
						// 정상적으로 응답 받았을 경우에는 success 콜백이 호출되게 됩니다.
						// 이 콜백 함수의 파라미터에서는 응답 바디, 응답 코드 그리고 XHR 헤더를 확인할 수 있습니다.
						
						$.each(list, function(i, list){
							
							let str = "";
							
							let alarmCnt = 0;
							
							let alarmChk = 0;
							
							if(list.length != 0){
								$("#alarmCnt").html(list.length + "+");
							}
							
							
							if(list == null || list.length == 0){
								
								alarmUL.html("");
								
								return;
							} else {
								for(var i = 0; i < list.length; i++){
									str += '<div class="d-flex">';
									str += '<a style="border: 0px" class="dropdown-item d-flex align-items-center col-sm-10" href=board/get?pageNum=1&amount=10&type=&keyword=&bno=' + list[i].bno +'>';
									str += '<div class="mr-3">';
									str += '<div class="icon-circle bg-primary">';
									str += '<i class="fas fa-file-alt text-white"></i>';
									str += '</div>';
									str += '</div>';
									str += '<div>';
									str += '<div class="small text-gray-500">' + list[i].regDate + '</div>';
									str += '<span class="font-weight-bold">' + list[i].sourceTitle + '</span>';
									str += '</div>';
									str += '</a>';
									str += '<div class="col-sm-2 justify-content-center mb-2 mt-3">';
									str += '<button class="btn btn-sm btn-alarm-del" href="' + list[i].ano + '" type="button">X</button>';
									str += '</div>';
									str += '</div>';
									str += '<hr class="m-0">';
									
									
									alarmChk = alarmChk + (list[i].checked * 1);
									
									
									/* str += '<a class="dropdown-item d-flex align-items-center" href=get?pageNum=1&amount=10&type=&keyword=&bno=' + list[i].bno +'>';
									str += '<div class="mr-3">';
									str += '<div class="icon-circle bg-primary">';
									str += '<i class="fas fa-file-alt text-white"></i>';
									str += '</div>';
									str += '</div>';
									str += '<div class="col-sm-8">';
									str += '<div class="small text-gray-500">' + list[i].regDate + '</div>';
									str += '<span class="font-weight-bold">' + list[i].sourceTitle + '</span>';
									str += '</div>';
									str += '<button class="btn btn-sm float-right col-sm-2" href="' + list[i].ano + '" type="button">X</button>';
									str += '</a>'; */
									
								}
							}

							alarmUL.html(str);
							
							alarmCnt = list.length - alarmChk;
							
							if(alarmCnt != 0){
								$("#alarmCnt").html(alarmCnt + "+");
							} else {
								$("#alarmCnt").html("");
							}
							
						});
						
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
				
				$("#alertsDropdown").on("click", function () {
					
					$.ajax ({
						
						// URL은 필수 요소이므로 반드시 구현해야 하는 Property입니다.
						url	: "/alarm/chkmodify", // 요청이 전송될 URL 주소
						type	: "GET", // http 요청 방식 (default: ‘GET’)
						async : true,  // 요청 시 동기화 여부. 기본은 비동기(asynchronous) 요청 (default: true)
						cache : true,  // 캐시 여부
						timeout : 3000, // 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백을 호출.(단위: ms)
						data : {userId : hUserId},
						processData : true, // 데이터를 컨텐트 타입에 맞게 변환 여부
						contentType : "application/json; charset=utf-8", // 요청 컨텐트 타입 
						dataType    : "json" // json 응답 데이터 형식 (명시하지 않을 경우 자동으로 추측)
						
					});
					
				});
				
				
				$("#alarmUL").on("click", ".btn-alarm-del", function () {
					
					let ano = null;
					
					ano = $(this).attr("name");
					
					$.ajax ({
						
						// URL은 필수 요소이므로 반드시 구현해야 하는 Property입니다.
						url	: "/alarm/remove", // 요청이 전송될 URL 주소
						type	: "GET", // http 요청 방식 (default: ‘GET’)
						async : true,  // 요청 시 동기화 여부. 기본은 비동기(asynchronous) 요청 (default: true)
						cache : true,  // 캐시 여부
						timeout : 3000, // 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백을 호출.(단위: ms)
						data : {ano : ano},
						processData : true, // 데이터를 컨텐트 타입에 맞게 변환 여부
						contentType : "application/json; charset=utf-8", // 요청 컨텐트 타입 
						dataType    : "json", // json 응답 데이터 형식 (명시하지 않을 경우 자동으로 추측)
						success : function (result) {
							// 정상적으로 응답 받았을 경우에는 success 콜백이 호출되게 됩니다.
							// 이 콜백 함수의 파라미터에서는 응답 바디, 응답 코드 그리고 XHR 헤더를 확인할 수 있습니다.
							if(result == 1){
								$(".btn-alarm name").attr("hidden","true")
							} else {
								
							}
							
							
						}
					});
					
				});
				
				
			}
		});
    </script>

    <!-- Bootstrap core JavaScript-->
    <script src="../resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="../resources/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="../resources/js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="../resources/vendor/chart.js/Chart.min.js"></script>

    <!-- Page level custom scripts -->
    <!-- <script src="../resources/js/demo/chart-area-demo.js"></script>
    <script src="../resources/js/demo/chart-pie-demo.js"></script> -->

</body>

</html>