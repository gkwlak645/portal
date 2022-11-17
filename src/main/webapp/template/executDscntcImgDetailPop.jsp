<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
                            <h1 class="m-0 text-dark">실행중단이미지</h1>
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">모니터링/ 실행중단이미지</li>
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
                <div class="card card-primary" id="cardDivDetl">
				    <div class="card-header">
				        <h3 class="card-title">실행중단 이미지 상세</h3>
				    </div>
				    <div class="card-body"style="height:704px; overflow:auto;">
				            <div class="row">
				                <div class="col-md-12">
				                    <div class="form-inline">
				                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
				                            <label class="col-sm-3 col-form-label">회사</label>
				                            <div class="col-sm-9">
				                                <input type="text" id="cmpnyCdDetl" class="form-control" style="width:80%;margin-right: 3px;" readOnly>
				                            </div>
				                            
				                        </div>
				                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
				                            <label class="col-sm-3 col-form-label">실행중단일시</label>
				                            <div class="col-sm-9">
				                                <input type="text" id="executDscntcDtDetl" class="form-control" style="width:80%;margin-right: 3px;" readonly>
				                            </div>
				                        </div>   
				                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
				                            <label class="col-sm-3 col-form-label">프로세스코드</label>
				                          <div> 
				                            <div class="col-sm-9">
				                                <input type="text" id="processCdDetl" class="form-control" style="width:80%;margin-right: 3px;" readonly>
				                            </div>
				                          </div>                          
				                        </div>
				                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
				                            <label class="col-sm-3 col-form-label">프로세스명</label>
				                            <div class="col-sm-9">
				                                <input type="text" id="processNmDetl" class="form-control" style="width:80%;margin-right: 3px;" readonly>
				                            </div>
				                        </div>   
				                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
				                            <label class="col-sm-3 col-form-label">로봇명</label>
				                            <div class="col-sm-9">
				                                <input type="text" id="robotNmDetl" class="form-control" style="width:80%;margin-right: 3px;" readonly>
				                            </div>
				                        </div>
				                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
				                            <label class="col-sm-3 col-form-label">파일명</label>
				                            <div class="col-sm-9">
				                                <input type="text" id="fileNmDetl" class="form-control" style="width:80%;margin-right: 3px;" readonly>
				                            </div>
				                        </div>
				                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
				                            <label class="col-sm-3 col-form-label">스크린샷</label>
				                            <div class="col-sm-9" id="screenImg">
				                                <image id="screenShotDetl" src="" style="width:350px;height:350px;"></image>
				<!--                                 <input type="image" id="screenShotDetl" class="form-control" style="width:80%;margin-right: 3px;" readonly> -->
				                            </div>
				                        </div>
				                    </div>
				                </form>
				                    <div class="float-right">
				                        <button type="button" class="btn btn-primary" id="closeBtn">닫기</button>
				                    </div>
				                </div>
				            </div>
				        </div>
				    </div>
				</div>
				    
				<script>
				
				var executSn;
				
				    $(document).ready(function() {
				    
				        //페이지 초기화
				        pageInit();
				        
				        //이벤트 바인딩
				        bindEvent();
				    });
				    
				    /*
				     * 페이지 초기화
				     * @param
				     * @return
				     */
				    function pageInit() {
				    	var params = [];
				        params.push({"id" : "processCdDetl", "clsCd" : "0043"});
				        requestCmmnCd(params);
				        
				        getExecutDscntcImgDetail(executSn);
				    }
				    
				    /*
				     * 이벤트 바인딩
				     * @param
				     * @return
				     */
				    function bindEvent() {
				        $("#closeBtn").on("click", function() {
				            closePop();
				        });
				    }
				    
				    /*
				     * 과제템플릿 정보 상세 조회
				     * @param
				     * @return
				     */
				    function getExecutDscntcImgDetail(executDscntcImageSn) {
				        var param = {"executDscntcImageSn" : executDscntcImageSn};
				        callAsyncAjax("/mntrng/executdscntc/getExecutDscntcImgDetail", param, "executDscntcImgDetailPop");
				    }
				    
				    /*
				     * 상세 페이지 데이터 출력
				     * @param
				     * @return
				     */
				    function executDscntcImgDetailPop(data) {
				        console.log(data);
				        var executDetail    = data.result.executDscntcImg;
				        
				        var resultCmpnyCd            = executDetail.cmpnyCd;
				        var resultExecutDscntcDt     = executDetail.executDscntcDt;
				        var resultprocessCd          = executDetail.processCd;
				        var resultProcessNm          = executDetail.processNm;
				        var resultRobotId            = executDetail.robotId;
				        var resultFileNm             = executDetail.fileNm;
				        var resultFileCours          = executDetail.fileCours;
				        
				        $("#cmpnyCdDetl").val(resultCmpnyCd);
				        $("#executDscntcDtDetl").val(resultExecutDscntcDt);
				        $("#processNmDetl").val(resultProcessNm);
				        $("#robotNmDetl").val(resultRobotId);
				        $("#fileNmDetl").val(resultFileNm);
				        $("#processCdDetl").val(resultprocessCd);
				        $("#screenShotDetl").attr("src", "http://localhost:8080/file/getRobotImage?filePath=" + resultFileCours + "&fileName=" + resultFileNm);
				        
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
				rights reserved.    >
				</footer>
				</div>
				</div>