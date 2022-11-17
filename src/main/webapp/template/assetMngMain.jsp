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
                            <h1 class="m-0 text-dark">Asset관리</h1>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">기준정보 / Asset관리</li>
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
				<div id="assetMainDiv" class="container-fluid wrap">
				    <div class="row">
				        <div class="col-md-12">
				            <div class="card">
				                <div class="card-header">
				                    <form class="form-inline">
                                        <div class="form-group row  col-sm-6">
                                             <label for="schCmpny" class="col-sm-2 col-form-label">회사</label>
                                             <select class="form-control col-sm-10" id="schCmpny" style="width:60%;max-width:200px;" >
                                                 <option value=""></option>
                                             </select>
                                         </div>
                                    
                                    
                                        <div class="form-group row  col-sm-6">
                                            <label for="scAssetName" class="col-sm-2 col-form-label">Asset명</label>
                                            <div class="col-sm-10">
                                                <input type="text" name="scAssetName" class="form-control float-left" id="scAssetName" style="width:60%;">
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
				                    <div id="assetGrid"></div>
				                    <div id="assetGridPager" class="portal-pager"></div>
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
				        /* if("${txScreenAuthor.untenantAuthor}" == 'Y'){
				            params.push({"id" : "schCmpny", "clsCd" : "0024"});    //회사
				        }else{
				            params.push({"id" : "schCmpny", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
				        } */
				        params.push({"id" : "schCmpny", "clsCd" : "0024"});    //회사
				        requestCmmnCd(params);
				        
				        drawGrid();
				        searchAssetList();
				    };
				    
				    /*
				     * 이벤트 바인딩
				     * @param
				     * @return
				     */
				    function bindEvent(){
				    	
				    	$("#scAssetName").keyup(function(e){
				            if(e.keyCode == 13){
				            	searchAssetList();
				            }
				        });
				        
				        //조회버튼 클릭 이벤트 처리
				        $("#btnSearch").on("click",function(){
				            searchAssetList();
				        });
				        
				        //등록버튼 클릭 이벤트 처리
				        $("#btnReg").on("click", function(){
				        	assetId = "";
				        	appendDetailPopup("assetMainDiv", "/stdrinfo/asset/assetRegistPop");
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
				            drawPager("assetGridPager", data.result.paginationInfo, "searchAssetList");
				        }
				        
				        $("#assetGrid").jsGrid({
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
				                , {name: "cmpnyName"        , title : "회사"          , type : "text"   , width : 100, align : "center" }
				                , {name: "name"             , title : "Asset명"      , type : "text"   , width : 100, align : "center" }
				                , {name: "description"      , title : "설명"          , type : "text"   , width : 200}
				                , {name: "valueTypeName"    , title : "형식"          , type : "text"   , width : 100, align : "center" }
				                , {name: "value"            , title : "값"            , type : "text"   , width : 200}
				            ]
				        });
				        
				    }
				    
				    /*
				     * 검색
				     * @param 페이지번호
				     * @return
				     */
				    function searchAssetList(pageNo) {
				        var url = '/stdrinfo/asset/getAssetList';
				        var currentPageNo = 1;
				        if (pageNo != null && pageNo != undefined && pageNo != "") {
				            currentPageNo = pageNo;
				        }
				        var param = {
				            cmpny: $("#schCmpny").val(),
				            name: $("#scAssetName").val(),
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
				        appendDetailPopup("assetMainDiv", "/stdrinfo/asset/assetRegistPop");
				
				        //상세 페이지 데이터 조회
				        assetId = id;
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
                <footer class="main-footer">Copyright &copy; 2020 <a href="http://www.echoit.co.kr">에코아이티</a>&nbsp;.&nbsp;All rights reserved.</footer>
            </div>
            
        </div>
    </body>
</html>
