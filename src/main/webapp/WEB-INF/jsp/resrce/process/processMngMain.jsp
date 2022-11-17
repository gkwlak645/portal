<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<div id="processMainDiv" class="container-fluid wrap">
	<div class="row" alt="자원>프로세스관리">
		<div class="col-md-12">
			<div class="card card-default">
				<div class="card-header">
					<form id="searchForm" name="searchForm" class="form-inline"
						onsubmit="return false">
						<div class="form-group col-md-5 py-sm-2">
							<label for="schCmpny" class="col-sm-3 col-form-label">회사</label>
							<div class="col-sm-8">
								<select id="schCmpny" class="form-control" style="width: 80%;">
									<option value="">선택</option>
								</select>
							</div>
						</div>
						<div class="form-group col-md-5 py-sm-2">
							<label for="searchName" class="col-sm-3 col-form-label">프로세스 명</label>
							<div class="col-sm-8">
								<input type="text" name="searchName"
									class="form-control float-left" id="searchName"
									style="width: 80%;">
							</div>
						</div>
						<div class="form-group col-md-2">
							<button type="button" id="btnSearch"
								class="btn btn-info float-right">조회</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<div class="card">
				<div class="card-body">
					<c:choose>
						<c:when test="${txScreenAuthor != null}">
							<c:choose>
								<c:when test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
									<button type="button" id="btnReg"
										class="btn btn-primary float-right"
										style="margin: 5px 0 15px 2px;">등록</button>
								</c:when>
								<c:otherwise></c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise></c:otherwise>
					</c:choose>
					<div id="processGrid"></div>
					<div id="processGridPager" class="portal-pager"></div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	/*
	 * 페이지 초기화
	 * @param
	 * @return
	 */
	function pageInit() {

		var params = [];
		
		if("${txScreenAuthor.untenantAuthor}" == 'Y'){
		    params.push({"id" : "schCmpny", "clsCd" : "0024"});    //회사
		}else{
		    params.push({"id" : "schCmpny", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
		}
		
		/* params.push({
			"id" : "schCmpny",
			"clsCd" : "0024"
		}); */ //회사
		
		requestCmmnCd(params);

		drawGrid();
		searchProcessList();
	};

	/*
	 * 이벤트 바인딩
	 * @param
	 * @return
	 */
	function bindEvent() {

		$("#searchName").keyup(function(e) {
			if (e.keyCode == 13) {
				searchProcessList();
			}
		});

		//조횝버튼 클릭 이벤트 처리
		$("#btnSearch").on("click", function() {
			searchProcessList();
		});

		$("#btnReg").on(
				"click",
				function() {
					processId = "";
					appendDetailPopup("processMainDiv",
							"/resrce/process/processRegistPop");
				});
	}

	/*
	 * 그리드 초기화
	 * @param
	 * @return
	 */
	function drawGrid(data) {

		var params = {};
		if (data != null && data != undefined) {
			if (data.result.paginationInfo != null) {
				params = data.result.resultList;
				drawPager("processGridPager", data.result.paginationInfo,
						"searchProcessList");
			}
		}

		$("#processGrid").jsGrid({
			height : "auto",
			width : "100%",
			autoload : true,
			sorting : true,
			align : "center",
			data : params,
			rowClick : function(arg) {
				popupDetail(arg.item.cmpnyCd,arg.item.id);
			},
			fields : [ {
				name : "id",
				title : "아이디",
				type : "text",
				width : 0,
				visible : false
			}, {
				name : "cmpnyName",
				title : "회사",
				type : "text",
				width : 100
			}, {
				name : "name",
				title : "프로세스명",
				type : "text",
				width : 150
			}, {
				name : "version",
				title : "버전",
				type : "text",
				width : 80
			}, {
				name : "environmentName",
				title : "환경",
				type : "text",
				width : 100
			}, /* {
				name : "jobPriorityName",
				title : "작업우선순위",
				type : "text",
				width : 80
			}, */ /* {
				name : "processTypeName",
				title : "형식",
				type : "text",
				width : 80
			}, */ {
				name : "description",
				title : "설명",
				type : "text",
				width : 250,
				align : "left"
			} ]
		});

	}

	/*
	 * 검색
	 * @param 페이지번호
	 * @return
	 */
	function searchProcessList(pageNo) {
		var url = '/resrce/process/getProcessList';
		var currentPageNo = 1;
		if (pageNo != null && pageNo != undefined && pageNo != "") {
			currentPageNo = pageNo;
		}
		var param = {
			cmpny : $("#schCmpny").val(),
			name : $("#searchName").val(),
			currentPageNo : currentPageNo,
			recordCountPerPage : 10,
			pageSize : 10
		};
		callAsyncAjax(url, param, "drawGrid");
	}

	/*
	 * 상세페이지 팝업
	 * @param 
	 * @return
	 */
	function popupDetail(cmpny,id) {

		//상세 페이지 div 생성
		appendDetailPopup("processMainDiv",
				"/resrce/process/processDetailPagePop");

		//상세 페이지 데이터 조회
		//getDetailData(id);
		cmpnyCd = cmpny;
		processId = id;
	};

	/*
	 * popup창 닫기
	 * @param
	 * @return
	 */
	function closePOP() {
		$(".over").remove();
	}
</script>
