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
                            <h1 class="m-0 text-dark">프로세스 메인</h1>
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">자원관리 / 프로세스관리</li>
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
					<div id="processMainDiv" class="container-fluid wrap">
					    <div class="row" alt="자원>프로세스관리">
					        <div class="col-md-12">
					            <div class="card card-default">
					                <div class="card-body" style="height:auto;">
					                    <div class="col-md-7"  style="margin: 0.3rem 0 0.3rem 0;">                   
					                    <form id="searchForm" name="searchForm" class="form-inline">
					                       <div class="col-md-3">
					                            <label for="name" class="col-form-label">프로세스 명</label>
					                       </div>
					                       <div class="col-md-8">
					                            <input type="text" class="form-control float-left;" id="searchName"style="width:57%; display:inline-block;">
					                            <button type="button" id="btnSearch" class="btn btn-info float-left;">조회</button>
					                       </div>
					                    </form>
					                    </div> 
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
					                                    <button type="button" id="btnReg" class="btn btn-primary float-right" style="margin:5px 0 15px 2px;">등록</button>
					                                </c:when>
					                                <c:otherwise>
					                                </c:otherwise>
					                            </c:choose>
					                        </c:when>
					                        <c:otherwise>
					                        </c:otherwise>
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
					        drawGrid();
					    };
					    
					    /*
					     * 이벤트 바인딩
					     * @param
					     * @return
					     */
					    function bindEvent(){
					        //조횝버튼 클릭 이벤트 처리
					        $("#btnSearch").on("click",function(){
					            searchProcessList();
					        });
					        
					        $("#btnReg").on("click", function(){
					            
					        });
					    }
					    
					    /*
					     * 그리드 초기화
					     * @param
					     * @return
					     */
					    function drawGrid(data){
					
					        var params = {};
					        if (data != null && data != undefined) {
					            if(data.result.paginationInfo != null) {
					                params = data.result.resultList;
					                drawPager("processGridPager", data.result.paginationInfo, "searchProcessList");
					            }
					        }
					        
					        $("#processGrid").jsGrid({
					              height : "auto"
					            , width : "100%"
					            , autoload: true
					            , sorting : true
					            , align : "center"
					            , data : params
					            , rowClick: function(arg){
					                  popupDetail(arg.item.id);
					              }
					            , fields : [
					                  {name: "id"               , title : "아이디"         , type : "text"   , width : 0 , visible : false}
					                , {name: "name"             , title : "프로세스명"      , type : "text"   , width : 100}
					                , {name: "version"          , title : "버전"          , type : "text"   , width : 80}
					                , {name: "environmentName"  , title : "환경"          , type : "text"   , width : 100}
					                , {name: "jobPriorityName"  , title : "작업우선순위"    , type : "text"   , width : 80}
					                , {name: "processTypeName"  , title : "형식"          , type : "text"   , width : 80}
					                , {name: "description"      , title : "설명"          , type : "text"   , width : 250}
					            ]
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
					            name: $("#searchName").val(),
					            currentPageNo:currentPageNo,
					            recordCountPerPage:10,
					            pageSize:10
					        };
					        callAsyncAjax(url, param, "drawGrid");
					    }
					    
					    /*
					     * 상세페이지 팝업
					     * @param 
					     * @return
					     */
					    function popupDetail(id) {
					
					        //상세 페이지 div 생성
					        appendDetailPopup("processMainDiv", "/resrce/process/processDetailPagePop");
					
					        //상세 페이지 데이터 조회
					        getDetailData(id);
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
