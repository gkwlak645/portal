<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>템플릿화면</title>
<!-- Tell the browser to be responsive to screen width -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<jsp:include page="/template/script.jsp"></jsp:include>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
	<div class="wrapper">
		<div id="header">
			<!-- Navbar -->
			<nav
				class="main-header navbar navbar-expand border-bottom-0 navbar-dark navbar-primary text-sm">
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link"
						data-widget="pushmenu" href="#" role="button"><i
							class="fas fa-bars"></i></a></li>
				</ul>
				<ul class="navbar-nav ml-auto">
					<!-- Messages Dropdown Menu -->
					<li class="nav-item"></a></li>
				</ul>
			</nav>
			<!-- /.navbar -->
		</div>

		<jsp:include page="/template/menu.jsp"></jsp:include>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<div class="content-header">
				<div class="container-fluid">
					<div class="row mb-0">
						<div class="col-sm-6">
							<h1 class="m-0 text-dark">과제개발</h1>
						</div>
						<!-- /.col -->
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
								<li class="breadcrumb-item">과제 / 과제개발</li>
							</ol>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- /.content-header -->


			<!-- Main content -->
			<section class="content">
				<div id="content">



					<!--  템플릿 바디 -->

					<div id="unmanagtErrorMainDiv" class="container-fluid wrap">
						<div class="row" alt="과제 >과제아이디어메인">
							<div class="col-md-12">
								<div class="card">
									<div class="card-header">
										<form id="searchForm" name="searchForm" class="form-inline">
											<div class="form-group col-sm-6">
												<label for="usr" class="col-sm-3 col-form-label">회사</label>
												<div class="col-sm-9">
													<select class="form-control" id="searchCmpny"
														style="width: 60%; max-width: 196px;">
														<option value="">동원</option>
													</select>
												</div>
											</div>

											<div class="form-group col-sm-6">
												<label for="usr" class="col-sm-3 col-form-label">과제코드</label>
												<div class="col-sm-9">
													<input type="text" name="assetName"
														class="form-control" value="A001"
														id="searchAssetName" style="width: 60%; max-width: 196px;">
												</div>
											</div>

											<div class="form-group  col-sm-6">
												<label for="usr" class="col-sm-3 col-form-label">과제명</label>
												<div class="col-sm-9 float-left">
													<input type="text" name="assetName"
														class="form-control float-left" id="searchAssetName"
														style="width: 63%; max-width: 196px;">
													<button type="button" id="btnSearch" class="btn btn-info float-left">조회</button>
												</div>
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
										<button type="button" id="btnSave"
											class="btn btn-primary float-right"
											style="margin: 5px 0 15px 2px;">등록</button>
										<div id="unmanagtErrorGrid"></div>
										<div id="unmanagtErrorGridPager" class="portal-pager"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<script>
						//일일미조치_오류_일련번호

						$(document.body).ready(function() {
						});

						/*
						 * 페이지 초기화
						 * @param
						 * @return
						 */
						function pageInit() {
							//그리드 초기화
							drawGrid();

							var gridRow = $("#unmanagtErrorGrid div.jsgrid-grid-body table.jsgrid-table tr");
							gridRow.eq(0).find("td").eq(0).attr("rowspan", "2");
							gridRow.eq(0).find("td").eq(1).attr("rowspan", "2");
							gridRow.eq(0).find("td").eq(2).attr("rowspan", "2");
							gridRow.eq(1).find("td.jsgrid-cell").eq(0).remove();
							gridRow.eq(1).find("td.jsgrid-cell").eq(1).remove();
							gridRow.eq(1).find("td.jsgrid-cell").eq(0).remove();

							$("#btnSave").on('click', function() {
								unManagtErrorReg();
							});

						};

						/*
						 * 그리드 초기화
						 * @param
						 * @return
						 */
						function drawGrid(data) {

							var params = new Array();

							for (var i = 0; i < 2; i++) {
								params[i] = {
									'unmanagtSn' : 'A001',
									'errorCn' : '법인카드 매출전표 정산<input type="button" class="btn btn-outline-primary icon" style="padding:1px 2.8px;margin:0 0 4px 6px;line-height: 0.9;" value="+">',
									'cmpnyNm' : '동원',
									'occrrncSeNm' : 'A00100',
									'tyNm' : '법인카드 매출전표 정산1',
									'managtTyNm' : '개발중'
								};
							}

							$("#unmanagtErrorGrid").jsGrid({
								height : "407",
								width : "100%",								
								autoload : true,
								sorting : true,
								align : "center",
								data : params,
								rowClick : function(arg) {
									unManagtErrorDetail();
								},
								fields : [ {
									name : "unmanagtSn",
									title : "과제코드",
									type : "text",
									width : 90,
									align : "center"
								}, {
									name : "errorCn",
									title : "과제명",
									type : "text",
									width : 200
								}, {
									name : "cmpnyNm",
									title : "회사",
									type : "text",
									width : 120,
									align : "center"
								}, {
									name : "occrrncSeNm",
									title : "프로세스코드",
									type : "text",
									width : 100,
									align : "center"
								}, {
									name : "tyNm",
									title : "프로세스명",
									type : "text",
									width : 200
								}, {
									name : "managtTyNm",
									title : "상태",
									type : "text",
									width : 80,
									align : "center"
								} ]
							});

						}

						/*
						 * 상세페이지 pop
						 * @param
						 * @return
						 */
						function unManagtErrorDetail() {
							appendDetailPopup("unmanagtErrorMainDiv",
									"/task/idea/taskideaDetailPop");
						};

						/*
						 * 등록페이지 pop
						 * @param
						 * @return
						 */
						function unManagtErrorReg() {
							appendDetailPopup("unmanagtErrorMainDiv",
									"/task/idea/taskideaRegPop");
						};

						/*
						 * popup창 닫기
						 * @param
						 * @return
						 */
						function closePop() {
							$(".over").remove();
						}
					</script>

					<!--  템플릿 바디 끝 -->





				</div>
			</section>
			<!-- /.Main content -->
		</div>
		<div id="footer">
			<footer class="main-footer">
				Copyright &copy; 2020 <a href="http://www.echoit.co.kr">에코아이티</a>&nbsp;.&nbsp;All
				rights reserved. >
			</footer>
		</div>
	</div>