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

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
	                        <div class="row">
	                            <h6 class="m-0 font-weight-bold text-primary col-sm-1">글 목록</h6>
	                            <div class="col-sm-11">
	                            	<a href="/board/register" class="btn btn-success btn-sm float-right" role="button">Register New Board</a>
	                            </div>
	                        </div>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
										<colgroup>
										<col style="width:70px;"/>
										<col style="width:auto;"/>
										<col style="width:120px;"/>
										<col style="width:230px;"/>
										<col style="width:230px;"/>
										<col style="width:100px;"/>
										</colgroup>
										
										<thead>
											<tr class="info text-color">
												<th>#번호</th>
												<th>제목</th>
												<th>작성자</th>
												<th>작성일</th>
												<th>수정일</th>
												<th>조회수</th>
											</tr>
										</thead>
										<tfoot>
	                                        <tr>
	                                            <th>#번호</th>
												<th>제목</th>
												<th>작성자</th>
												<th>작성일</th>
												<th>수정일</th>
												<th>조회수</th>
	                                        </tr>
	                                    	</tfoot>
										
										<tbody>
										<c:if test="${list != null }">
										<c:forEach items="${list }" var="board">
											<tr>
												<td>${board.bno }</td>
												<td><a href="${board.bno }" class="move">${board.title }</a><span class="badge badge-primary">${board.replyCnt }</span></td>
												<td>${board.writer }</td>
												<td><fmt:formatDate pattern="yyyy-MM-dd a hh:mm:ss" value="${board.regDate }"/> </td>
												<td><fmt:formatDate pattern="yyyy-MM-dd a hh:mm:ss" value="${board.updateDate }"/></td>
												<td>${board.hit }</td>
											</tr>
										</c:forEach>
										</c:if>
										<c:if test="${list == null || list == '[]'}">
											<tr>
												<td colspan="6">등록된 글이 없습니다.</td>
											</tr>
										</c:if>
										</tbody>
                                   
                                </table>
                            </div>
                            <div class="row">
                            	<div class="col-sm-12 col-md-5">
									<div class="dataTables_info">
									Showing ${pageMaker.startPage } to ${pageMaker.endPage } of ${pageMaker.total } entries</div>
								</div>
								<div class="col-sm-12 col-md-7">
									<div class="dataTables_paginate paging_simple_numbers">
										<!-- search results navigation -->
										<ul class="pagination justify-content-end">
											<c:if test="${pageMaker.prev }">
												<li class="paginate_button page-item previous">
													<a href="${pageMaker.startPage - 1 }" class="page-link">
													Previous
													</a>
												</li>
											</c:if> 
											<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
												<li class= "paginate_button page-item ${pageMaker.cri.pageNum == num?'active':'' }">
													<a href="${num }" class="page-link">${num }</a></li>
											</c:forEach>
											<c:if test="${pageMaker.next }">
												<li class="paginate_button page-item next">
													<a href="${pageMaker.endPage + 1 }" class="page-link">
													Next
													</a>
												</li>
											</c:if> 
										</ul>
									</div>
								</div>
							</div>
							<div class="row">
								<form id="searchForm" class="form-inline">
									<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
									<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
									<div class="form-group">
										<select class="form-control m-1" name="type">
											<option value="">전체</option>
											<option value="T" ${pageMaker.cri.type == 'T'?"selected":"" }>제목</option>
											<option value="C" ${pageMaker.cri.type == 'C'?"selected":"" }>내용</option>
											<option value="W" ${pageMaker.cri.type == 'W'?"selected":"" }>작성자</option>
											<option value="TC" ${pageMaker.cri.type == 'TC'?"selected":"" }>제목 or 내용</option>
											<option value="TW" ${pageMaker.cri.type == 'TW'?"selected":"" }>제목 or 작성자</option>
											<option value="TWC" ${pageMaker.cri.type == 'TWC'?"selected":"" }>제목 or 내용 or 작성자</option>
										</select>
										<input class="form-control" name="keyword" value="${pageMaker.cri.keyword}">
									</div>
									<div class="form-group m-2">
										<button class="btn btn-primary">Search</button>
									</div>
								</form>
							</div>
                        </div>
                    </div>

                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->
<form id="actionForm">
	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
	<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
	<input type="hidden" name="type" value="${pageMaker.cri.type }">
	<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
</form>


<script>
	$(document).ready(function () {
		var result = '<c:out value="${result}"/>';
		
		checkModal(result);
		
		function checkModal(result) {
			if (result === ''){
				return;
			}
			if(parseInt(result) > 0){
				$(".modal-body").html("게시글 " + parseInt(result) + " 번이 등록되었습니다.");
			}
			
			$("#myModal").modal("show");
		}
		
		
		
		$(".pagination a").on("click", function (event) {
			event.preventDefault();
			
			$("input[name=pageNum]").val( $(this).attr("href"));
			$("#actionForm").attr("action", "/board/list");
			$("#actionForm input[name=bno]").remove();
			
			$("#actionForm").submit();
			
			
		});
		
		$(".move").on("click", function (event) {
			event.preventDefault();
			
			$("#actionForm input[name=bno]").remove();
			$("#actionForm").append("<input type='hidden' name='bno' value='" + $(this).attr('href') + "'>");
			$("#actionForm").attr("action", "/board/get");
			
			$("#actionForm").submit();
			
		});
		
		
		$("#searchForm button").on("click", function (event) {
			
			if($("#searchForm").find("option:selected").val() == ''){
				return true;
			}
			
			event.preventDefault();
			
			if(!$("#searchForm").find("input[name='keyword']").val()){
				alert("키워드를 입력하세요.");
				return false;
			}
			
			if(!$("#searchForm").find("option:selected").val()){
				alert("검색종류를 선택하세요.");
				return false;
			}
			
			$("#searchForm").find("input[name=pageNum]").val(1);
			
			$("#searchForm").submit();
			
		});
		
		
		
		
	});
</script>


<%@ include file="../../includes/footer.jsp"%>