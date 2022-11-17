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
                <div id="executDscntcImgMain" class="container-fluid wrap">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <form class="form-inline">  
                                         <div class="form-group col-md-6">
                                               <label for="" class="col-form-label col-sm-4">실행중단일</label>
                                               <div class="col-sm-8 float-left">
                                                   <div class="input-group date float-left" id="startDeDiv" data-target-input="nearest"style="min-width:140px;width:30%;margin-right:5px;">
                                                       <input type="text" id="startDe" name="startDe" class="form-control datetimepicker-input" data-target="#startDeDiv"/>
                                                       <div class="input-group-append" data-target="#startDeDiv" data-toggle="datetimepicker">
                                                           <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                                       </div>
                                                   </div>
                                                   <div class="input-group date  float-left" id="endDeDiv" data-target-input="nearest"style="min-width:140px;width:30%;">
                                                       <input type="text" id="endDe" name="endDe" class="form-control datetimepicker-input" data-target="#endDeDiv"/>
                                                       <div class="input-group-append" data-target="#endDeDiv" data-toggle="datetimepicker">
                                                           <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                                       </div>
                                                   </div>
                                              </div>
                                          </div>
                                          <div class="form-group col-md-6">
                                           <label for="searchCombo" class="col-form-label col-sm-4" >회사코드</label>
                                           <div class="col-sm-8">
                                               <select id="cmpnyCd" class="form-control"  style="min-width: 160px;width:70%;">
                                                   <option value=""></option>
                                               </select>
                                           </div>
                                         </div>
                                         
                                         <div class="form-group col-md-6 py-sm-1">
                                             <label for="searchCombo" class="col-sm-4 col-form-label">프로세스코드</label>
                                             <div class="col-sm-8">
                                                 <div class="form-group row">
                                                     <select id="processCd" class="form-control"class="form-control"  style="min-width: 160px;width:70%;">
                                                       <option value=""></option>
                                                     </select>
                                                 </div>
                                             </div>
                                         </div>                                         
                                         <div class="form-group col-md-6 py-sm-1">
                                              <label for="searchCombo" class="col-form-label col-sm-4" >로봇</label>
                                              <div class="col-sm-8" style="width: 70%;">
                                                   <select class="form-control float-left" id="robotId" style="width: 54%;min-width:130px;"></select>
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
                                    <button type="button" id="btnSave" class="btn btn-primary float-right" style="margin:5px 0 15px 2px;">등록</button>
                                    <div id="executDscntcImgGrid"></div>
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
        var params = [];
        
        if("${txScreenAuthor.untenantAuthor}" == "Y") {
            params.push({"id" : "cmpnyCd", "clsCd" : "0024"});
        } else {
            params.push({"id" : "cmpnyCd", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});
        }
        requestCmmnCd(params);
        
        getProcessCdListByClsCd('processCd');
        getRobotList();
        getExecutDscntcImgList(cudPage);
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
            getExecutDscntcImgList(cudPage);
        });
        
       /*  엔터 키 누를시 검색 및 그리드 작성 */
        $("#tmplatCd").keyup(function(e){
            if(e.keyCode == 13){
                $(".pagingClass").remove();
                getExecutDscntcImgList(cudPage); 
            }
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
    }
    
    function getRobotList(){
        var url = "/mntrng/executdscntc/getSelectRobotList";
        var param = new Object();
        
        callAsyncAjax(url, param, "setRobotList");
    }
    
    function setRobotList(data){
        if(data != ""){
            robotList = data.result.resultList;
            $('#robotId').append("<option value=''>선택</option>");
            for(var i=0; i< robotList.length; i++){
                $("#robotId").append('<option value="' + robotList[i].robotId + '">' + robotList[i].robotId + '</option');
            }
        }
    }
    
    // 리스트 부르기
    function getExecutDscntcImgList(cudPage){
        var url = "/mntrng/executdscntc/getExecutDscntcImgList";
        var processCd = $("#processCd").val();
        var cmpnyCd = $("#cmpnyCd").val();
        var robotId = $("#robotId").val();
        var startDt = unhyphenationPhoneNum($("#startDe").val());
        var lastDt = unhyphenationPhoneNum($("#endDe").val());
        var param = new Object();
        var currentPageNo = 1;
        
        if (cudPage != null && cudPage != undefined && cudPage != "") {
            currentPageNo = cudPage;
        }
        
        param.pageInfo = {currentPageNo : currentPageNo};
        param.cmpnyCd = cmpnyCd;
        param.robotId = robotId;
        param.processCd = processCd;
        param.startDt = startDt;
        param.lastDt = lastDt;
        
        callAsyncAjax(url, param, "drawGrid");
    }
    
    // 테이블 그리기
    function drawGrid(data){        
        
        var pageSize = 10;
        
        if(data != ""){
            executDscntcImgList = data.result.executDscntcImgList;
            drawPager("paging", executDscntcImgList.pageInfo, "getExecutDscntcImgList");
        }
        $("#executDscntcImgGrid").jsGrid({
            height : "399",
            width : "100%",
            autoload: true,
            sorting : true,
            align : "center",
            data: data.result.executDscntcImgList.items,
            rowClick: function(arg){
                executDscntcImgDetail(arg.item.executDscntcImageSn);
            },
            fields : [ 
                {name: "cmpnyCd" ,title : "회사", width : 40, align:"center",
                    itemTemplate:function(value){
                        if(value == "A"){
                            return value = "동원건설사업";
                        } else if(value == 'C'){
                            return value = "동원시스템즈";
                        } else if(value == 'E'){
                            return value = "동원엔터프라이즈";
                        } else if(value == 'F'){
                            return value = "동원F&B";
                        } else if(value == 'H'){
                            return value = "동원홈푸드";
                        } else if(value == 'I'){
                            return value = "동원산업";
                        } else if(value == 'T'){
                            return value = "테크팩솔루션";
                        } else if(value == 'X'){
                            return value = "동원로엑스";
                        }
                }}, 
                {name: "executDscntcDt" ,title : "실행중단일",type : "text", 
                    itemTemplate:function(value){
                    return moment(value).format('YYYY-MM-DD');
                    }, width : 70, align:"center"},
                {name: "processCd" ,title : "프로세스코드", width : 35, align:"center"},
                {name: "fileNm" ,title : "파일명", width : 100, align:"left"}
            ]
        });
    }
    
    /*
     * 상세페이지 pop
     * @param
     * @return
     */
    function executDscntcImgDetail(executDscntcImageSn) {
        appendDetailPopup("executDscntcImgMain", "/mntrng/executdscntc/executDscntcDetailPop");
        executSn = executDscntcImageSn;
    };
    
    /*
     * popup창 닫기
     * @param
     * @return
     */
    function closePop() {
        $(".over").remove();
        getExecutDscntcImgList(cudPage);
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