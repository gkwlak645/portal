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
                            <h1 class="m-0 text-dark">디바이스관리</h1>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">자원관리 / 디바이스관리</li>
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
				<div class="container-fluid wrap">
				    <div class="row"  alt="자원>디바이스관리">
				        <div class="col-md-12">
				            <div class="card card-default">
				                <div class="card-header">
				                    <form class="form-inline" onSubmit="return false;">
                                        <div class="form-group row  col-sm-6">
                                             <label for="name" class="col-sm-3 col-form-label">회사</label>
                                             <select class="form-control col-sm-9" id="schCmpny" style="width:60%;max-width:200px;" >
                                                 <option value=""></option>
                                             </select>
                                         </div>
                                    
                                    
                                        <div class="form-group row  col-sm-6">
                                            <label for="name" class="col-sm-3 col-form-label">디바이스 명</label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control float-left" id="name" style="width:60%;">
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
				                    <c:choose>
				                        <c:when test="${txScreenAuthor != null}">
				                            <c:choose>
					                            <c:when test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
					                                <button type="button" id="btnReg" class="btn btn-primary float-right">등록</button>
					                            </c:when>
					                            <c:otherwise>
					                            </c:otherwise>
				                            </c:choose>
				                        </c:when>
				                        <c:otherwise>
				                        </c:otherwise>
				                    </c:choose>
				                    <div id="deviceGrid"></div>
				                    <div id="deviceGridPager" class="portal-pager"></div>
				                </div>
				            </div>
				        </div>
				    </div>
				</div>
				
				<script>
				
				
				var nowPage;
				
				    /*
				     * 페이지 초기화
				     * @param
				     * @return
				     */
				    function pageInit() {
				    	
				    	var params = [];
				//         if("${txScreenAuthor.untenantAuthor}" == 'Y'){
				//             params.push({"id" : "schCmpny", "clsCd" : "0024"});    //회사
				//         }else{
				//             params.push({"id" : "schCmpny", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
				//         }
				        params.push({"id" : "schCmpny", "clsCd" : "0024"});    //회사
				        requestCmmnCd(params);
				    	
				        drawGrid();
				        searchDeviceList();
				        $(document).on("keydown", "#nonProductionSlots, #unattendedSlots, #headlessSlots, #testAutomationSlots",  function(e){
				            if(!((e.keyCode > 95 && e.keyCode < 106) || (e.keyCode > 47 && e.keyCode < 58) || e.keyCode == 8) || e.keyCode == 13) {
				                return false;
				            }
				        });
				    };
				    
				    /*
				     * 이벤트 바인딩
				     * @param
				     * @return
				     */
				    function bindEvent(){
				    	
				    	//엔터 검색 이벤트
				    	$("#name").keyup(function(e){
				    		if(e.keyCode == 13){
				    			searchDeviceList();
				    		}
				    	});
				    	
				    	//조회버튼 클릭 이벤트 처리
				        $("#btnSearch").on("click",function(){
				        	searchDeviceList();
				        });
				        
				        //등록페이지로 pop
				        $("#btnReg").on("click",function(){
				        	var url = "/resrce/device/deviceRegisterPagePop"
				        	appendDivReg(url);
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
					    		console.log(data.result.paginationInfo);
					    		drawPager("deviceGridPager", data.result.paginationInfo, "searchDeviceList");
				    		}
				    	}
				        $("#deviceGrid").jsGrid({
				              height : "auto"
				            , width : "100%"
				            , autoload: true
				            , sorting : true
				            , align : "center"
				            , data : params
				            , rowClick: function(arg){
				                detailPageMove(arg.item.id);
				              }
				            , fields : [
				                  {name: "id"               , title : "아이디"         , type : "text"  , visible : false}
				                , {name: "cmpnyName"        , title : "회사명"         , type : "text"   , width : 60, align : "center"}
				                , {name: "name"             , title : "디바이스명"      , type : "text"   , width : 60, align : "center"}
				                , {name: "description"      , title : "설명"          , type : "text"   }
				                , {name: "typeName"         , title : "형식"          , type : "text"   , width : 40, align : "center"}
				                , {name: "version"          , title : "설치된 버전"     , type : "text"   , width : 50, align : "center"}
				            ]
				        });
				        
				    }
				    
				    /*
				     * 검색
				     * @param 페이지번호
				     * @return
				     */
				    function searchDeviceList(pageNo) {
				        var url = '/resrce/device/getDeviceList';
				        var currentPageNo = 1;
				        if (pageNo != null && pageNo != undefined && pageNo != "") {
				        	currentPageNo = pageNo;
				        }
				        var param = {
				        	cmpnyCd : $("#schCmpny").val(),
				            name: $("#name").val(),
				            currentPageNo:currentPageNo,
				            recordCountPerPage:10,
				            pageSize:10
				        };
				        callAsyncAjax(url, param, "drawGrid");
				    }
				    
				    /*
				     * 등록페이지 pop
				     * @param 등록페이지 URL
				     * @return
				     */
				    function appendDivReg(url){
				    	
				    	nowPage = 1;
				    	
				        var html = "";
				        html += '<div id="overPage" class="over"></div>';
				        $(".wrap").append(html);
				        
				        $.ajax({
				            url : url,
				            dataType : "html",
				            type : "get",
				            success : function(result){
				                $("#overPage").html(result);
				            }
				        });
				    }
				    
				    function detailPageMove(value){
				    	
				    	nowPage = $(".current_page").text();
				    	
				        var url = "/resrce/device/deviceDetailPagePop";
				        var id = value;
				        appendDivDetailGet(url);
				        appendDivDetailPost(url,id);
				    };
				    
				    function appendDivDetailGet(url){
				        var html = "";
				        html += '<div id="overPage2" class="over"></div>';
				        $(".wrap").append(html);
				        $.ajax({
				            url : url,
				            dataType : "html",
				            type : "GET",
				            async : false,
				            success : function(result){
				                console.log("appendDivDetailGet");
				                $("#overPage2").html(result);
				            }
				        });
				    }
				    
				    function appendDivDetailPost(url,id){
				        console.log(url+"--"+id);
				        var param = {"id" : id};
				        callAsyncAjax(url, param, "drawValue");
				    }
				    
				    function drawValue(data){
				        console.log(data);
				        var deviceValue = data.result;
				
				        var resultDeviceId            = deviceValue.id;
				        var resultLicenseKey          = deviceValue.licenseKey;
				        var resultDescription         = deviceValue.description;
				        var resultName                = deviceValue.name;
				        var resultNonProductionSlots  = deviceValue.nonProductionSlots;
				        var resultUnattendedSlots     = deviceValue.unattendedSlots;
				        var resultHeadlessSlots       = deviceValue.headlessSlots;
				        var resultTestAutomationSlots = deviceValue.testAutomationSlots;
				        var resultCmpnyCd             = deviceValue.cmpnyCd;
				        
				        $("#deviceId").val(resultDeviceId);
				        $("#deviceKey").val(resultLicenseKey);
				        $("#deviceDescription").val(resultDescription);
				        $("#deviceName").val(resultName);
				        $("#nonProductionSlots").val(resultNonProductionSlots);
				        $("#unattendedSlots").val(resultUnattendedSlots);
				        $("#headlessSlots").val(resultHeadlessSlots);
				        $("#testAutomationSlots").val(resultTestAutomationSlots);
				        $("#cmpnyCd").val(resultCmpnyCd).prop("selected", true);
				    }
				    
				    /*
				     * popup창 닫기
				     * @param
				     * @return
				     */
				    function closePOP(){
				        $(".over").remove();
				    }
				    
				    /*
				     * popup창 닫고 리로딩
				     * @param
				     * @return
				     */
				    function closePopReload(){
				        $(".over").remove();
				        nowPage = Number(nowPage);
				        searchDeviceList(nowPage);
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


