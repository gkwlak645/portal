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
                            <h1 class="m-0 text-dark">시스템작업공지</h1>
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">커뮤니티 / 시스템작업공지</li>
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
                        <div class="row" alt="커뮤니티 >시스템작업공지메인">
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-header">
                                        <form id="searchForm" name="searchForm" class="form-inline">
                                            <div class="form-group col-md-12">
						                          <div class="form-group col-md-8">						                          
						                          <label for="usr" class="col-form-label col-sm-2">등록일</label>						                          
						                          <div class="col-sm-3"> 
						                              <div class="input-group date" id="startDeDiv" data-target-input="nearest" style="min-width:124px;margin: 0 0 0 3px;">
						                                  <input type="text" id="startDe" name="startDe" class="form-control datetimepicker-input" data-target="#startDeDiv"/>
					                                      <div class="input-group-append" data-target="#startDeDiv" data-toggle="datetimepicker">
					                                          <div class="input-group-text"><i class="fa fa-calendar"></i></div>
					                                      </div>
						                              </div>
						                          </div>
						                          
						                          <div class="col-sm-3">
						                              <div class="input-group date" id="endDeDiv" data-target-input="nearest" style="min-width:124px;margin: 0 0 0 3px;">
						                                  <input type="text" id="endDe" name="endDe" class="form-control datetimepicker-input"  data-target="#endDeDiv"/>
						                                  <div class="input-group-append" data-target="#endDeDiv" data-toggle="datetimepicker">
						                                      <div class="input-group-text"><i class="fa fa-calendar"></i></div>
						                                  </div>
						                              </div>
						                          </div>
						                          
							                      <div class="form-group col-sm-2 float-right">
							                          <button type="button" id="btnSearch" class="btn btn-info float-right">조회</button>
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
	                                        <button type="button" id="btnSave"class="btn btn-primary float-right"style="margin: 5px 0 15px 2px;">등록</button>
	                                        <div id="unmanagtErrorGrid"></div>
	                                        <div id="unmanagtErrorGridPager" class="portal-pager"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <script>

//일일미조치_오류_일련번호

$(document.body).ready(function () { 
});

    /*
     * 페이지 초기화
     * @param
     * @return
     */
    function pageInit() {
        //그리드 초기화
        drawGrid();
        
        $("#btnSave").on('click', function(){
            unManagtErrorReg();
        });

    };
    
    /*
     * 그리드 초기화
     * @param
     * @return
     */
    function drawGrid(data){

        var params = new Array();

        for(var i = 0 ; i < 10 ; i++){
            params[i] = {
                    'unmanagtSn' : 'SCM,SAP작업',
                    'errorCn' : '제품 추가로 인한 작업 9월1일 24시부터 3시간 작업예정',
                    'cmpnyNm' : 'SCM, SAP',
                    'unmanagtDe' : '2020-08-27'
            };
        }
        
        $("#unmanagtErrorGrid").jsGrid({
              height : "auto"
            , width : "100%"
            , autoload: true
            , sorting : true
            , align : "center"
            , data : params
            , rowClick: function(arg){
                unManagtErrorDetail();
            }
            , fields : [
                  {name: "unmanagtSn"         , title : "공지제목"       , type : "text"  , width : 50, align : "center"} 
                , {name: "errorCn"            , title : "공지내용"          , type : "text" }
                , {name: "cmpnyNm"         , title : "대상시스템"    , type : "text"    , width : 50, align : "center"}
                , {name: "unmanagtDe"          , title : "등록일"    , type : "text"    , width : 30, align : "center"}
            ]
        });
        
    }
    
    /*
     * 상세페이지 pop
     * @param
     * @return
     */
    function unManagtErrorDetail() {
        appendDetailPopup("unmanagtErrorMainDiv", "/task/idea/taskideaDetailPop");
    };
    
    /*
     * 등록페이지 pop
     * @param
     * @return
     */
    function unManagtErrorReg() {
        appendDetailPopup("unmanagtErrorMainDiv", "/task/idea/taskideaRegPop");
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