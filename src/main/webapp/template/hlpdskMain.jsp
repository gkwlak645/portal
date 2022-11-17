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
                            <h1 class="m-0 text-dark">처리요청</h1>
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">HelpDesk /처리요청</li>
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
					 <div id="hlpdskMainPage" class="container-fluid wrap">
					    <div class="row" alt="커뮤니티 >공지사항">
					        <div class="col-md-12">
					            <div class="card">
					                <div class="card-header" id="insert">
					                    <form class="form-inline">
                                        <div class="form-group col-md-6 py-sm-1">
                                            <label class="col-form-label col-sm-3">제목</label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" id="hlpdskSearch" placeholder="검색어"  style="" value="" />
                                            </div>                              
                                        </div>
                                        <div class="form-group col-md-6 py-sm-1">
                                            <label for="searchCombo2" class="col-form-label col-sm-3">요청구분</label>
                                            <div class="col-sm-9">
                                                <select class="form-control" id="searchCombo2" style="width: 54%;min-width:130px;">
                                                </select>  
                                            </div>                              
                                        </div>
                                        
                                        <div class="form-group col-md-6 py-sm-1">
                                          <label for="" class="col-form-label col-sm-3">요청일&nbsp; <input type = "checkbox" id = "check" checked></label>                                            
                                            <div class="col-sm-9 float-left">
                                                  <div class="input-group date float-left" id="startDeDiv" data-target-input="nearest"style="min-width:130px;width:30%;margin-right:5px;">
                                                      <input type="text" id="startDe" name="startDe" class="form-control datetimepicker-input" data-target="#startDeDiv"/>
                                                      <div class="input-group-append" data-target="#startDeDiv" data-toggle="datetimepicker">
                                                          <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                                      </div>
                                                  </div>
                                                  <div class="input-group date  float-left" id="endDeDiv" data-target-input="nearest"style="min-width:130px;width:30%;">
                                                      <input type="text" id="endDe" name="endDe" class="form-control datetimepicker-input" data-target="#endDeDiv"/>
                                                      <div class="input-group-append" data-target="#endDeDiv" data-toggle="datetimepicker">
                                                          <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                                      </div>
                                                  </div>
                                             </div>                      
                                        </div>
                                        <div class="form-group col-md-6 py-sm-1">                                       
                                           <label for="" class="col-form-label col-sm-3">상태</label>
                                           <div class="col-sm-9 float-left">
                                             <select class="form-control  float-left" id="searchCombo" style="width: 54%;min-width:130px;">
                                             </select>
                                             <button type="button" id="searchBtn" class="btn btn-info  float-left">조회</button>
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
                                         <div id="answerSearchGrid"></div>
							             <div id="paging" class="portal-pager">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>    
                        
					          
					<script>
					
					    var cudPage = 1;    
					    
					    //자동시작 함수
					    function pageInit() {
					    	
					        var params = [];        
					        params.push({"id" : "searchCombo", "clsCd" : "0041"});
					        params.push({"id" : "searchCombo2", "clsCd" : "0036"});
					        requestCmmnCd(params);
					        
					        getHlpdskList(cudPage);        
					    };
					   
					    function bindEvent(){
					    	/* 시작날짜 */
					    	$('#startDeDiv').datetimepicker({
					            format: 'YYYY-MM-DD'
					          , defaultDate: getMonthGapDate(-3)
					        });
					    	
					    	/* 마지막날짜 */
					        $("#endDeDiv").datetimepicker({
					            format: 'YYYY-MM-DD'
					          , defaultDate: (new Date())
					        });
					        
					        /* 검색버튼 누를 시 검색 및 그리드 작성 */
					        $("#searchBtn").on("click",function(){
					            $(".pagingClass").remove();
					            getHlpdskList(cudPage);
					        });
					        
					       /*  엔터 키 누를시 검색 및 그리드 작성 */
					        $("#hlpdskSearch").keyup(function(e){
					            if(e.keyCode == 13){
					                $(".pagingClass").remove();
					                getHlpdskList(cudPage); 
					            }
					        });
					       
					        /* 등록페이지 이동 */
					        $("#regBtn").on("click", function(){
					        	$('.card-header').hide();
					        	$('.card-body').hide();
					            var url = "/hlpdsk/requst/hlpdskCreate";
					            appendDivDetailGet(url);
					        });
					        
					        /*시작 일자가 마지막일자보다 클 시*/
					        $("#startDe").on("propertychange change paste input", function(){
					        	if(unhyphenationPhoneNum($("#startDe").val()) > unhyphenationPhoneNum($("#endDe").val())){
					                alert("시작일자가 마지막 일자보다 과거일 수 없습니다.");
					                return $("#startDe").val(getMonthGapDate(-3));
					            }
					        });
					        
					        /*마지막 일자가 시작 일자보다 작을 시*/
					        $("#endDe").on("propertychange change paste input", function(){
					            if(unhyphenationPhoneNum($("#startDe").val()) > unhyphenationPhoneNum($("#endDe").val())){
					                alert("마지막 일자가  시작일자보다 과거일 수 없습니다.");
					                return $("#endDe").val(getMonthGapDate(0)-1); //"-"추가 필요 
					            }
					        });
					        
					        //체크박스 클릭시
					        $("#check").on("click", function(){        	
					        	if ($("input:checkbox[id='check']").is(":checked") == true){
					        		$("#startDe").attr("disabled", false);
					        		$("#endDe").attr("disabled", false);
					        	} else {
					                $("#startDe").attr("disabled", true);
					                $("#endDe").attr("disabled", true);
					        	}   
					        });        
					    }
					    
					    // 헬프데스크
					    function getHlpdskList(cudPage){        
					        var url = "/hlpdsk/requst/getHlpdsk";
					        var searchCombo = $("#searchCombo").val();
					        var searchCombo2 = $("#searchCombo2").val();        
					        var hlpdskSearch = $("#hlpdskSearch").val();
					        var startDt = unhyphenationPhoneNum($("#startDe").val());
					        var lastDt = unhyphenationPhoneNum($("#endDe").val());
					        var param = new Object();
					        var currentPageNo = 1;
					        
					        if (cudPage != null && cudPage != undefined && cudPage != "") {
					            currentPageNo = cudPage;
					        }
					        param.processSttusCd = searchCombo;
					        param.requstSe = searchCombo2;
					        param.pageInfo = {currentPageNo : currentPageNo};
					        param.requstSj = hlpdskSearch;
					        
					        if ($("input:checkbox[id='check']").is(":checked") == false){
					            startDt = "all";
					        }
					        
					        param.startDt = startDt;
					        param.lastDt = lastDt;
					        
					        callAsyncAjax(url, param, "drawGrid");
					    }
					    
					    // 헬프데스크 콜백
					    function drawGrid(data){
					        var pageSize = 10;
					        
					        if(data != ""){
					        	hlpdskList = data.result.hlpdskList;
					        	drawPager("paging", hlpdskList.pageInfo, "getHlpdskList");
					        }
					        $("#answerSearchGrid").jsGrid({
					            height : "auto",
					            width : "100%",
					            autoload: true,
					            sorting : true,
					            rowClick: function(arg){
					                detailPageMove(arg.item.requstSn);
					            },
					            data: data.result.hlpdskList.items,    
					            fields : [ 
					                {name: "regDt" ,title : "요청일",type : "text", 
					                	    itemTemplate:function(value){
					                	    return moment(value).format('YYYY-MM-DD HH:mm');
					                    }, width : 70, align:"center"}, 
					                {name: "requstSe" ,title : "요청구분",
					                    	itemTemplate:function(value){
					                    	if (value == "01") {
					                    		return value = "장애처리요청";
					                    	} else if (value == "02"){
					                    		return value = "RPA변경요청";
					                    	}}, width : 80, align:"center"}, 
					                {name: "requstSj" ,title : "제목", type : "text", width : 200, align:"center"}, 
					                {name: "processSttusCd" ,title : "상태",
						                	itemTemplate:function(value){
						                    if (value == '01') {                    	
					                    	   return value = "요청";
					                        } else if (value == '02') {
					                        	return value = "접수";
					                        } else if (value == '03') {
					                            return value = "반려";
					                        } else {
					                        	return value = "처리완료";
					                        }}, width : 40, align:"center"}, 
					                {name: "processDe" ,title : "처리일", type : "text", width : 70, align:"center"}                      
					            ]
					        });
					    }
					    
					    // 상세페이지 이동    
					    function detailPageMove(requstSn){
					    	$('.card-header').hide();
					        $('.card-body').hide();
					        var url = "/hlpdsk/requst/hlpdskDetail";
					        appendDivDetailGet(url);
					        var id = requstSn;
					        var url_2 = "/hlpdsk/requst/detailHlpdsk";
					        var param = {
					            requstSn : id
					        };
					        callAsyncAjax(url_2, param, "getProper");
					    }
					    
					    // 상세보기 값 셋팅
					    function getProper(data){
					    	var stCd = data.result.helpdskDetail.processSttusCd;    	
					        $("#searchCombo3").val(data.result.helpdskDetail.requstSe); 
					        $("#requstSj2").val(data.result.helpdskDetail.requstSj);
					        $("#requstCn2").val(data.result.helpdskDetail.requstCn);
					        $("#requstSn2").val(data.result.helpdskDetail.requstSn);
					        $("#processSttusCd").val(data.result.helpdskDetail.processSttusCd);
					        fileGrpNoVal = data.result.helpdskDetail.requstFileGrpNo;
					        
					        //처리결과
					        $("#requstCn3").val(data.result.helpdskDetail.processCn);
					        $("#processDe").val(data.result.helpdskDetail.processDe);
					        $("#userNm").val(data.result.helpdskDetail.processUserId);
					        
					        if (stCd == '01') {
					        	stCd = '요청';       	       
					        } else if (stCd == '02') {
					        	stCd = '접수';
					        } else if (stCd == '03') {
					            stCd = '반려';
					        } else {
					        	stCd = '처리완료';
					        }
					        $("#sttusCd").val(stCd);
					        
					        if(fileGrpNoVal == undefined || fileGrpNoVal == ""){
					        	fileGrpNoVal = 0;
					        } else {
					        	fileGrpNoVal = data.result.helpdskDetail.requstFileGrpNo;
					        }
					        hlpUpload.draw(fileGrpNoVal, true);
					        
					        var processSttusCd = $("#processSttusCd").val();
					        if (processSttusCd == "04") {
					            $("#updateBtn").hide();
					            $("#deleteBtn").hide();
					        }
					        
					        fileGrpNoVal2 = data.result.helpdskDetail.processFileGrpNo;
					        
					        if(fileGrpNoVal2 == undefined || fileGrpNoVal2 == ""){
					            fileGrpNoVal2 = 0;
					        } else {
					            fileGrpNoVal2 = data.result.helpdskDetail.processFileGrpNo;
					        }        
					        hlpUpload2.draw(Number(fileGrpNoVal2), true);
					    }
					        
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
					                $("#overPage2").html(result);
					            }
					        });
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