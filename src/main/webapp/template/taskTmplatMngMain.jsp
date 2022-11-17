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
				 <div id="taskTmplatMngMain" class="container-fluid wrap">
				    <div class="row" alt="기준정보 >과제템플릿관리">
				        <div class="col-md-12">
				            <div class="card">
				                <div class="card-body">
				                    <form class="form-inline">
				                        <div class="form-group col-md-6 py-sm-1">
				                            <label for="searchCombo" class="col-form-label col-sm-3">템플릿코드</label>
				                            <div class="col-sm-9">
				                                <input type="text" class="form-control" id="tmplatCd" placeholder="템플릿코드" style="" value="" />
				                            </div>                              
				                        </div>
				                        <div class="form-group col-md-6 py-sm-1">
				                            <label for="searchCombo" class="col-form-label col-sm-3">템플릿명</label>
				                            <div class="col-sm-9">
                                            <input type="text" class="form-control" id="tmplatNm" placeholder="템플릿명" style="" value="" />  
				                            </div>                              
                                        </div>
                                        
				                        <div class="form-group col-md-6 py-sm-1">
				                          <label for="" class="col-form-label col-sm-3">등록일&nbsp; <input type = "checkbox" id = "check" checked></label>                                            
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
				                           <label for="searchCombo" class="col-form-label col-sm-3">프로세스코드</label>
                                           <div class="col-sm-9 float-left">
                                             <select class="form-control float-left" id="processCd" style="width: 54%;min-width:130px;">
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
				                    <c:if test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
						            <button type="button" id="regBtn" class="btn btn-primary float-right" style="margin:5px 0 15px 2px;">등록</button>
						             </c:if> 
                                        <div id="taskTmplatGrid"></div>
					                    <div id="paging" class="portal-pager"></div>
					                </div>
					            </div>
					        </div>
					    </div>
					</div>
					<script>
				    var cudPage = 1;
				    //자동시작 함수
				    function pageInit() {
				    	
				    	        
    getTaskTmplatList(cudPage);
				    };
				   
				    function bindEvent(){
				    	/* 시작날짜 내보내기 */
				    	$('#startDeDiv').datetimepicker({
				            format: 'YYYY-MM-DD'
				          , defaultDate: getMonthGapDate(-3)
				        });
				    	
				    	/* 마지막날짜 내보내기 */
				        $("#endDeDiv").datetimepicker({
				            format: 'YYYY-MM-DD'
				          , defaultDate: (new Date())
				        });
				        
				        /* 검색버튼 누를 시 검색 및 그리드 작성 */
				        $("#searchBtn").on("click",function(){
				            $(".pagingClass").remove();
				            getTaskTmplatList(cudPage);
				        });
				        
				       /*  엔터 키 누를시 검색 및 그리드 작성 */
				        $("#tmplatCd").keyup(function(e){
				            if(e.keyCode == 13){
				                $(".pagingClass").remove();
				                getTaskTmplatList(cudPage); 
				            }
				        });
				       
				        //등록페이지로 pop
				        $("#regBtn").on("click",function(){
				        	popupRegist();
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
				    
				    // 리스트 부르기
				    function getTaskTmplatList(cudPage){
				        var url = "/stdrinfo/tmplat/getTaskTmplatMng";
				        var processCd = $("#processCd").val();
				        var tmplatNm = $("#tmplatNm").val();
				        var tmplatCd = $("#tmplatCd").val();
				        var startDt = unhyphenationPhoneNum($("#startDe").val());
				        var lastDt = unhyphenationPhoneNum($("#endDe").val());
				        var param = new Object();
				        var currentPageNo = 1;
				        
				        if (cudPage != null && cudPage != undefined && cudPage != "") {
				            currentPageNo = cudPage;
				        }
				        
				        param.pageInfo = {currentPageNo : currentPageNo};
				        
				        if ($("input:checkbox[id='check']").is(":checked") == false){
				            startDt = "all";
				        }
				        
				        param.tmplatCd = tmplatCd;
				        param.tmplatNm = tmplatNm;
				        param.processCd = processCd;
				        param.startDt = startDt;
				        param.lastDt = lastDt;
				        
				        callAsyncAjax(url, param, "drawGrid");
				    }
				    
				    // 테이블 그리기
				    function drawGrid(data){    	
				    	
				        var pageSize = 10;
				        
				        if(data != ""){
				        	taskTmplatMngList = data.result.taskTmplatMngList;
				        	drawPager("paging", taskTmplatMngList.pageInfo, "getTaskTmplatList");
				        }
				        $("#taskTmplatGrid").jsGrid({
				            height : "auto",
				            width : "100%",
				            autoload: true,
				            sorting : true,
				            align : "center",
				            data: data.result.taskTmplatMngList.items,
				            rowClick: function(arg){
				            	console.log(arg.item);
				            	taskTmplatDetail(arg.item.tmplatCd);
				            }, 
				            fields : [ 
				            	{name: "processCd" ,title : "프로세스코드", width : 40, align:"center"},  
				            	{name: "tmplatCd" ,title : "템플릿코드", width : 40, align:"center"},
				            	{name: "oriFileNm" ,title : "템플릿 파일명", width : 70, align:"center"}, 
				                {name: "regDt" ,title : "등록일",type : "text", 
				                	itemTemplate:function(value){
				                    return moment(value).format('YYYY-MM-DD');
				                    }, width : 40, align:"center"}, 
				                {name: "updtDt" ,title : "수정일",type : "text", 
				                    itemTemplate:function(value){
				                    if(value != null) {
				                    	return moment(value).format('YYYY-MM-DD');
				                    }
				                    }, width : 40, align:"center"},
				                {name: "dwldUrl" ,title : "다운로드 URL", align:"center"}, 
				                {name: ""            , title : "다운로드"   , type : "text" , width : 35, align : "center",
				                    itemTemplate: function(_, item) {
				                        return $("<button class='btn btn-outline-primary' style='padding:2px;min-width:74px;'>").text("다운로드").on("click", function() {
				                        	var url = "http://localhost:8080"
				                        	window.location.href = url + '/file/downloadUrlAtchmnfl?fileGrpNo=' + item.fileGrpNo + '&fileNo=1';
				                        	return false;
				                        });
				                    }
				                }
				            ]
				        });
				    }
				    
				    /*
				     * 등록페이지 팝업
				     * @param 
				     * @return
				     */
				    function popupRegist() {
				        appendDetailPopup("taskTmplatMngMain", "/stdrinfo/tmplat/taskTmplatMngRegPop");
				    }
				    
				    /*
				     * 상세페이지 pop
				     * @param
				     * @return
				     */
				    function taskTmplatDetail(tmplatCd) {
				   		appendDetailPopup("taskTmplatMngMain", "/stdrinfo/tmplat/taskTmplatDetailPop");
				        detlTmplatCd = tmplatCd;
				    };
				    
				    /*
				     * popup창 닫기
				     * @param
				     * @return
				     */
				    function closePop() {
				        $(".over").remove();
				        getTaskTmplatList(cudPage);
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
