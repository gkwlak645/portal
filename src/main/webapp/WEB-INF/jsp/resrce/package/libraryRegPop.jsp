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
                            <h1 class="m-0 text-dark">패키지관리</h1>
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">자원관리 / 패키지관리</li>
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
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title">패키지 등록</h4>
                             <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                 <span aria-hidden="true">×</span>
                             </button>
                            </div>
                            <div class="modal-body" >
                                <div class="form-group col-md-12 row">
                                     <label for="managtChargerId" class="col-sm-2 col-form-label">첨부파일 </label>
                                     <div class="col-sm-10">
                                         <div class="form-check2 row" id="fileUpload"><input type="hidden" id="fileGrpNo" name="fileGrpNo" value=""><table id="tblUpload"><tbody><tr id="trUpload0"><td><input type="hidden" id="fileNo0" name="fileNo" value="0"><input type="hidden" id="fileSz0" name="fileSz" value="0"><input type="file" id="file0" name="file" style="width:100%;min-width:260px;line-height:120%"></td><td><input type="button" class="btn btn-outline-secondary float-left" style="margin:0 15px 0 5px;" id="btnDelFile0" name="delFile" value="삭제"></td></tr></tbody></table><table><tbody><tr><td colspan="2"><input type="button" class="btn btn-secondary float-left" id="btnAdd" style="padding:3px 15px;" name="add" value="추가"></td></tr></tbody></table></div>
                                     </div>
                                </div>
                                <p style="color: #4b5eb5; font-size: 12px; margin: 0 0 6px 14px;">※ 업로드가 전파되기 전에 몇 분 정도 걸릴 수 있습니다.</p>
                                <div class="form-check" style="padding-left: 22px; margin-left: 12px;">
                                    <input class="form-check-input" type="checkbox" id="checkbox_confirm" style="top: 6px; left: 0; width: 18px; height: 18px; margin: 0;">
                                    <label class="form-check-label" for="checkbox_confirm">업그레이드 할 수 있는 프로세스를 확인하려고 합니다.</label>
                               </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                                <button type="button" class="btn btn-primary">업로드</button>
                            </div>
                        </div>
                    </div>
                    
                    <script>
                        
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
                                
                                //그리드 초기화
                                drawGwpwrGrid();
                            }
                            
                            /*
                             * 이벤트 바인딩
                             * @param
                             * @return
                             */
                            function bindEvent(){
                                
                                //조회버튼 클릭 이벤트 처리
                                $("#btnSearchGwpwrUser").on("click",function(){
                                    searchGwpwrUserList();
                                });
                            }
                            
                            /*
                             * 그리드 초기화
                             * @param
                             * @return
                             */
                            function drawGwpwrGrid(data){
                        
                                var params = {};
                                if (data != null && data != undefined) {
                                    if (data.result != null && data.result.resultList != null) {
                                        params = data.result.resultList;
                                    }
                                    drawPager("gwpwrGridPager", data.result.paginationInfo, "searchGwpwrUserList");
                                }
                                
                                $("#gwpwrGrid").jsGrid({
                                      height : "auto"
                                    , width : "100%"
                                    , autoload: true
                                    , sorting : true
                                    , align : "center"
                                    , data : params
                                    , selectData : null
                                    , rowClick : function(args) {
                                        $(".jsgrid-row, .jsgrid-alt-row").removeClass("highlight");
                                        var gRow = this.rowByItem(args.item);
                                        gRow.addClass("highlight");
                                        this.selectData = args.item;
                                    }
                                    , fields : [
                                          {name: "gwpwrId"          , title : "아이디"         , type : "text"   , width : 80}
                                        , {name: "userNm"           , title : "성명"          , type : "text"   , width : 80}
                                        , {name: "cmpnyNm"          , title : "회사"          , type : "text"   , width : 100}
                                        , {name: "deptNm"           , title : "부서"          , type : "text"   , width : 150}
                                        , {name: "mbtlnum"          , title : "전화번호"       , type : "text"   , width : 120}
                                        , {name: "email"            , title : "이메일"         , type : "text"   , width : 200}
                                    ]
                                });
                                
                            }
                            
                            /*
                             * 검색
                             * @param 페이지번호
                             * @return
                             */
                            function searchGwpwrUserList(pageNo) {
                        
                                var url = '/gwpwr/user/getGwpwrUserList';
                                var currentPageNo = 1;
                                if (pageNo != null && pageNo != undefined && pageNo != "") {
                                    currentPageNo = pageNo;
                                }
                        
                                var param = {
                                    gwpwrId: $("#gwpwrUserId").val(),
                                    userNm: $("#gwpwrUserNm").val(),
                                    currentPageNo:currentPageNo,
                                    recordCountPerPage:5,
                                    pageSize:10
                                };
                                callAsyncAjax(url, param, "drawGwpwrGrid");
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