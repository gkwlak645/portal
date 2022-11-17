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
                    <div id="packageLibraryMainDiv" class="container-fluid wrap">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <form class="form-inline">
                        <div class="form-group col-md-12 py-sm-2">
	                        <input type="radio" name="checkRadio" id="package" value="package" checked>패키지 &nbsp;&nbsp;&nbsp;
	                        <input type="radio" name="checkRadio" id="library" value="library">라이브러리
                        </div>
                        <div class="form-group col-md-6">
                             <label id="checkPackage" class="col-sm-2">패키지 명</label>
                             <label id="checkLibrary"class="col-sm-2">라이브러리 명</label>
                             <div class="col-sm-10">
                               <input type="text" class="form-control  float-left" id="txtSearchKwrd" name="searchKwrd" style="width:200px;" value="" />
                             </div>
                        </div>
                        <div class="form-group col-md-6">
                             <label id="name" class="col-sm-2">회사</label>
                             <div class="col-sm-10 float-left">
                              <select class="form-control float-left" id="cmpnyCd" style="width:60%;max-width:200px;">
                              </select>
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
                    <button type="button" id="btnReg" class="btn btn-primary float-right" style="margin:5px 0 15px 2px;">등록</button>
                    <div id="packageLibraryRequstGrid"></div>
                    <div id="packageLibraryRequstGridPager" class="portal-pager"></div>
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

        //그리드 초기화
        drawGrid();
        
        //그리드 조회
        searchPackageLibraryList();
        
        $("#checkLibrary").hide();
    };
    
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent(){

        //조회버튼 클릭 이벤트 처리
        $("#btnSearch").on("click",function(e){
            searchPackageLibraryList();
        });
        
        //등록버튼 클릭 이벤트
        $("#btnReg").on("click",function(){
            appendDetailPopup("taskRequstMainDiv", "/task/requst/taskRequstRegisterPop");
        });
        
        $('input:radio[name="checkRadio"]').on("change" , function(){
            radioVal = $('input:radio[name="checkRadio"]:checked').val();
            if(radioVal == "package"){
                $("#checkLibrary").hide();
                $("#checkPackage").show();
            }else{
                $("#checkLibrary").show();
                $("#checkPackage").hide();
            }
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
            if (data.result != null && data.result.resultList != null) {
                params = data.result.resultList;
            }
            drawPager("packageLibraryRequstGridPager", data.result.paginationInfo, "searchPackageLibraryList");
        }
        
        $("#packageLibraryRequstGrid").jsGrid({
              height : "auto"
            , width : "100%"
            , autoload: true
            , sorting : true
            , align : "center"
            , data : params
            , fields : [
                  {name: ""            , title : " " , type : "text" , width : 0 , visible : false}
                , {name: "identifier"  , title : "패키지명"   , type : "text" , width : 100}
                , {name: "description" , title : "설명"  , type : "text" , width : 200, align : "center" }
                , {name: "lastupdated" , title : "게시일"   , type : "text" , width : 80, align : "center"}
                , {name: ""            , title : "버전정보"   , type : "text" , width : 80, align : "center",
                    itemTemplate: function(_, item) {
                        return $("<button class='btn btn-outline-primary'style='padding:2px;min-width:74px;'>").text("버전정보").on("click", function() {
                            appendDetailPopup("packageLibraryMainDiv", "/resrce/package/packageVerMng");
                            packageLibrayVerList(item.identifier);
                        });}}
                , {name: ""            , title : "이력보기"  , type : "text" , width : 80, align : "center", 
                    itemTemplate: function(_, item) {
                        return $("<button class='btn btn-outline-secondary' style='padding:2px;min-width:74px;'>").text("이력보기").on("click", function() {
                            appendDetailPopup("packageLibraryMainDiv", "/resrce/package/packageHistInqire");
                            packageLibrayList(item.identifier);
                        });}}
            ]
        });
        
    }
    
    /*
     * 검색
     * @param 페이지번호
     * @return
     */
    function searchPackageLibraryList(pageNo) {
        //조회조건 유효성 검사

        var url = '/resrce/package/getPackageLibraryList';
        var currentPageNo = 1;
        if (pageNo != null && pageNo != undefined && pageNo != "") {
            currentPageNo = pageNo;
        }

        var param = {
            checked : $('input:radio[name="checkRadio"]:checked').val(),
            searchKwrd: $("#txtSearchKwrd").val(),
            currentPageNo:currentPageNo,
            recordCountPerPage:10,
            pageSize:10
        };
        
        callAsyncAjax(url, param, "drawGrid");
    }
    
    
    /*
     * 로봇 정보 상세 조회
     * @param
     * @return
     */
    function getTaskRequstDetail(url, taskNo) {
        var param = {"taskNo" : taskNo};
        callAsyncAjax(url, param, "printTaskRequstDetail");
    }
    
    /*
     * popup창 닫기
     * @param
     * @return
     */
    function closePOP(){
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