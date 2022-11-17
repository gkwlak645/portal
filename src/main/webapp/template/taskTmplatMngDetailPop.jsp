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
            <nav class="main-header navbar navbar-expand border-bottom-0 navbar-dark navbar-primary text-sm">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" data-widget="pushmenu" href="#" role="button">
                            <i class="fas fa-bars"></i>
                        </a>
                    </li>
                </ul>
                <ul class="navbar-nav ml-auto">
                    <!-- Messages Dropdown Menu -->
                    <li class="nav-item">
                        <a></a>
                    </li>  
                </ul>
            </nav>
            <!-- / Navbar -->
        </div>

        <jsp:include page="/template/menu.jsp"></jsp:include>

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Content Header (Page header) -->
            <div class="content-header">
                <!-- .container-fluid -->
                <div class="container-fluid">
                    <div class="row mb-0">
                        <div class="col-sm-6">
                            <h1 class="m-0 text-dark">과제템플릿관리</h1>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">기준정보 > 과제템플릿관리</li>
                            </ol>
                        </div>
                    </div>
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
							        <h3 class="card-title">과제템플릿 상세</h3>
							    </div>
							    <div class="card-body" style="min-height: 654px; overflow:auto;">
							            <div class="row">
							                <div class="col-md-12">
							                    <div class="form-inline">
							                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
							                            <label class="col-sm-3 col-form-label">프로세스코드<b style="color:red;padding-left:10px;">*</b></label>
							                          <div> 
							                            <div class="col-sm-4 float-left" style="width: 74%;margin: 0 0 2px 0;">
							                                <select class="form-control" id="processCdDetl" style="width: 54%;min-width:130px;">
							                                </select>
							                            </div>
							                          </div>                          
							                        </div>
							                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
							                            <label class="col-sm-3 col-form-label">프로세스명</label>
							                            <div class="col-sm-9">
							                                <input type="text" id="processNmDetl" class="form-control" style="width:80%;margin-right: 3px;">
							                            </div>
							                        </div>   
							                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
							                            <label class="col-sm-3 col-form-label">템플릿코드</label>
							                            <div class="col-sm-9">
							                                <input type="text" id="tmplatCdDetl" class="form-control" style="width:80%;margin-right: 3px;" readOnly>
							                            </div>
							                        </div>
							                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
							                            <label class="col-sm-3 col-form-label">템플릿명<b style="color:red;padding-left:10px;">*</b></label>
							                            <div class="col-sm-9">
							                                <input type="text" id="tmplatNmDetl" class="form-control" style="width:80%;margin-right: 3px;" required>
							                            </div>
							                        </div>   
							                        <div class="form-group col-md-9 py-sm-2" style="margin: 0.25rem 0 0.1rem 0;">
							                             <label  class="col-sm-2 col-form-label">첨부파일<b style="color:red;padding-left:10px;">*</b></label>
							                             <div class="col-sm-10"style="padding-left: 4px;" id="fileUploadDetl"></div>
							                        </div>
							                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
							                            <label class="col-sm-3 col-form-label">다운로드 URL</label>
							                            <div class="col-sm-9">
							                                <input type="text" id="downloadURLDetl" class="form-control" style="width:80%;margin-right: 3px;" readonly>
							                            </div>
							                        </div>
							                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
							                        </div>
							                        <div>
							                            <input type="hidden" id="fileGrpNoDetl">
							                            <input type="hidden" id="fileGrpNmDetl">
							                        </div>   
							                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
							                            <label class="col-sm-3 col-form-label">최초등록일</label>
							                            <div class="col-sm-9">
							                                <input type="text" id="regDtDetl" class="form-control" style="width:80%;margin-right: 3px;" readonly>
							                            </div>
							                        </div>  
							                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
							                            <label class="col-sm-3 col-form-label">최종수정일</label>
							                            <div class="col-sm-9">
							                                <input type="text" id="updtDtDetl" class="form-control" style="width:80%;margin-right: 3px;" readonly>
							                            </div>
							                        </div>  
							                    </div>
							                </form>
							                    <div class="float-right">
							                        <button type="button" class="btn btn-primary" id="saveBtn">저장</button>
							                        <button type="button" class="btn btn-primary" id="deleteBtn">삭제</button>
							                        <button type="button" class="btn btn-primary" id="closeBtn">닫기</button>
							                    </div>
							                </div>
							            </div>
							        </div>
							    </div>
							</div>
							    
							<script>
							
							    var fileGrpNo =0;
							    var detlTmplatCd;
							    tmplatUploadDetl = new RpaUpload("fileUploadDetl");
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
							    	getProcessCdListByClsCd('processCdDetl');
							    	getTaskTmplatDetail(detlTmplatCd);
							    }
							    
							    /*
							     * 이벤트 바인딩
							     * @param
							     * @return
							     */
							    function bindEvent() {
							
							        $("#saveBtn").on("click", function() {
							        	if($("#tblUpload tbody tr").length != 1) {
							                alert("첨부파일을 1개만 선택하세요.");
							                return false;
							            }
							        	updateTmplat();
							        });
							        
							        $("#deleteBtn").on("click", function() {
							            deleteTmplat();
							        });
							        
							        $("#closeBtn").on("click", function() {
							            closePop();
							        });
							
							    }
							    
							    function changeNo() {
							    	var fileNo = $("#fileGrpNoDetl").val();
							        tmplatUploadDetl.draw(Number(fileNo), true);
							//         $("#btnAdd").hide();        
							//         $("input[name=delFile]").off();
							    }
							    
							    /*
							     * 과제템플릿 정보 상세 조회
							     * @param
							     * @return
							     */
							    function getTaskTmplatDetail(tmplatCd) {
							        var param = {"tmplatCd" : tmplatCd};
							        callAsyncAjax("/stdrinfo/tmplat/getTaskTmplatDetail", param, "taskTmplatDetailPop");
							    }
							    
							    /*
							     * 상세 페이지 데이터 출력
							     * @param
							     * @return
							     */
							    function taskTmplatDetailPop(data) {
							        console.log(data);
							        var taskTmplatDetail    = data.result.taskTmplatMng;
							        
							        var resultProcessCd     = taskTmplatDetail.processCd;
							        var resultProcessNm     = taskTmplatDetail.processNm;
							        var resultTmplatCd      = taskTmplatDetail.tmplatCd;
							        var resultTmplatNm      = taskTmplatDetail.tmplatNm;
							        var resultDwldUrl       = taskTmplatDetail.dwldUrl;
							        var resultRegDt         = taskTmplatDetail.regDt;
							        var resultUpdtDt        = taskTmplatDetail.updtDt;
							        var resultFileGrpNo     = taskTmplatDetail.fileGrpNo;
							        var resultOriFileNm     = taskTmplatDetail.oriFileNm;
							        
							        $("#processCdDetl").val(resultProcessCd);
							        $("#processNmDetl").val(resultProcessNm);
							        $("#tmplatCdDetl").val(resultTmplatCd);
							        $("#tmplatNmDetl").val (resultTmplatNm);
							        $("#downloadURLDetl").val(resultDwldUrl);
							        $("#regDtDetl").val(resultRegDt);
							        $("#updtDtDetl").val(resultUpdtDt);
							        $("#fileGrpNoDetl").val(resultFileGrpNo);
							        $("#fileGrpNmDetl").val(resultOriFileNm);
							        changeNo();
							    }
							    
							    /*
							     * 과제템플릿 수정
							     * @param
							     * @return
							     */
							    function updateTmplat() {
							        var processCd = $('#processCdDetl').val();
							        var processNm = $('#processNmDetl').val();
							        var tmplatCd = $('#tmplatCdDetl').val();
							        var tmplatNm = $('#tmplatNmDetl').val();
							        var downloadURL = $('#downloadURLDetl').val();
							        if(processCd == "") {
							            alert("프로세스코드를 선택하세요.");
							            $("#processCd").focus();
							            return false;
							        } else if(tmplatNm == "") {
							            alert("템플릿명을 입력하세요.");
							            $("#tmplatNm").focus();
							            return false;
							        } else if(tmplatUploadDetl.upload() == 0) {
							            /* 파일 유무 체크 없으면 0, 있으면 1 */
							            alert("첨부파일을 선택하세요.");
							            return false;
							        }
							        fileGrpNo = tmplatUploadDetl.upload();
							        var url = "/stdrinfo/tmplat/updateTaskTmplat";
							        var param = {
							                tmplatCd   : tmplatCd
							              , tmplatNm   : tmplatNm
							              , processCd  : processCd
							              , processNm  : processNm
							              , fileGrpNo  : fileGrpNo
							              , dwldUrl    : downloadURL
							              , registerId : 'testuser1' //하드코딩 로그인 세션 처리 필요 (9/4 고명건)
							        };
							        callAsyncAjax(url, param, backPage());
							    }
							    
							    function deleteTmplat() {
							    	if ( window.confirm('정말로 삭제하시겠습니까?') ) {
							    		var url = "/stdrinfo/tmplat/deleteTaskTmplat";
							            var param = {
							                    tmplatCd   : $("#tmplatCdDetl").val()
							            };
							            callAsyncAjax(url, param, backPage());
							        }
							        else {
							            return false
							        }
							    }
							    
							    /* 되돌아 가기 */ 
							    function backPage(){
							        closePop();
							    }
							
							</script>
							<!--  템플릿 바디 끝 -->  


                    </div>
            </section>
            <!-- /.Main content -->
        </div>
        
        <div id="footer">
            <footer class="main-footer">Copyright &copy; 2020 <a href="http://www.echoit.co.kr">에코아이티</a>&nbsp;.&nbsp;All rights reserved.</footer>
        </div>
        
    </div>
</body>
</html>
							