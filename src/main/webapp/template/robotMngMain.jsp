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
                            <h1 class="m-0 text-dark">로봇관리</h1>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">자원관리 / 로봇관리</li>
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
				<div id="robotMainDiv" class="container-fluid wrap">
				    <div class="row">
				        <div class="col-md-12">
				            <div class="card">
				                <div class="card-header">
				                    <form id="searchForm" name="searchForm" class="form-inline" onsubmit="return false">
				                        
				                         <div class="form-group col-md-5 py-sm-2">
				                         <label for="name" class="col-sm-3 col-form-label float-right">회사</label>
					                         <select class="col-sm-8" id="schCmpny">
					                         </select>
				                         </div>
				                    
				                    
				                        <div class="form-group col-md-5 py-sm-2">
				                          <label for="name" class="col-sm-3 col-form-label float-right">로봇명</label>
				                          <div class="col-sm-8">
				                              <input type="text" class="form-control" id="name">
				                          </div>
				                        </div>
				                        <div class="form-group col-md-2">
				                            <button type="button" id="btnSearch" class="btn btn-info float-right">조회</button>
				                        </div>
				                    </form> 
				                </div>
				            </div>
				        </div>
				    </div>
				    <div class="row">
				        <div class="col-md-12">
				            <div class="card">
				                <div class="card-header">
				                    <c:choose>
				                        <c:when test="${txScreenAuthor != null}">
				                            <c:choose>
				                                <c:when test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
				                                    <button type="button" id="btnReg" class="btn btn-info float-right">등록</button>
				                                </c:when>
				                                <c:otherwise>
				                                    <div style="height:30px;"></div>
				                                </c:otherwise>
				                            </c:choose>
				                        </c:when>
				                        <c:otherwise>
				                            <div style="height:30px;"></div>
				                        </c:otherwise>
				                    </c:choose>
				                </div>
				                <div class="card-body">
				                    <div id="robotGrid"></div>
				                    <div id="robotGridPager" class="portal-pager"></div>
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
				//         if("${txScreenAuthor.untenantAuthor}" == 'Y'){
				//             params.push({"id" : "schCmpny", "clsCd" : "0024"});    //회사
				//         }else{
				//             params.push({"id" : "schCmpny", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
				//         }
				        params.push({"id" : "schCmpny", "clsCd" : "0024"});    //회사
				        requestCmmnCd(params);
				    	
				        drawGrid();
				        searchRobotList();
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
				            	searchRobotList();
				            }
				        });
				    	
				    	//조회버튼 클릭 이벤트
				        $("#btnSearch").on("click",function(){
				            searchRobotList();
				        });
				        
				        //등록버튼 클릭 이벤트
				        $("#btnReg").on("click",function(){
				        	appendDetailPopup("robotMainDiv", "/resrce/robot/robotRegisterPagePop");
				        });
				        
				    }
				    
				    /*
				     * 그리드 초기화
				     * @param
				     * @return
				     */
				    function drawGrid(data){
				    	
				        console.log("#####################data#############################" +JSON.stringify(data));
				    	
				        var params = {};
				        if (data != null && data != undefined) {
				        	if(data.result.paginationInfo != null) {
				                params = data.result.resultList;
				                drawPager("robotGridPager", data.result.paginationInfo, "searchRobotList");
				        	}
				        }
				       	$("#robotGrid").jsGrid({
				               height : "auto"
				               , width : "100%"
				               , autoload: true
				               , sorting : true
				               , align : "center"
				               , data : params
				               , rowClick: function(arg){
				                   popupRobotDetail(arg.item.id);
				
				                   console.log("arg.item.id" + arg.item.id);
				                   console.log("arg" + JSON.stringify(arg.item));
				                   
				                   
				               } 
				               , fields : [
				                     {name: "id"                  , title : "아이디"           , type : "text"   , width : 0 , visible : false}
				                   , {name: "cmpnyName"           , title : "회사명"           , type : "text"   , width : 100, align : "center"}
				                   , {name: "name"                , title : "로봇명"           , type : "text"   , width : 80, align : "center"}
				                   , {name: "machineName"         , title : "디바이스명"        , type : "text"   , width : 80, align : "center"}
				                   , {name: "userName"            , title : "사용자"           , type : "text"   , width : 100, align : "center"}
				                   , {name: "typeName"            , title : "로봇유형"         , type : "text"   , width : 80, align : "center"}
				                   , {name: "environmentNames"    , title : "환경"            , type : "text"   , width : 200}
				                   , {name: "stateName"           , title : "상태"            , type : "text"   , width : 60, align : "center"}
				                   //, {name: "ip"                  , title : "아이피"           , type : "text"   , width : 0 , visible : false}
				                  
				                   
				               ]
				           });
				    }
				    
				    /*
				     * 검색
				     * @param
				     * @return
				     */
				    function searchRobotList(pageNo) {
				        var url = '/resrce/robot/getRobotList';
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
				        console.log(param);
				        callAsyncAjax(url, param, "drawGrid");
				    }
				
				    /*
				     * 상세페이지 pop
				     * @param
				     * @return
				     */
				    function popupRobotDetail(id) {
				    	appendDetailPopup("robotMainDiv", "/resrce/robot/robotDetailPagePop");
				        getRobotDetail("/resrce/robot/getRobotDetail", id);      
				    };
				    
				    /*
				     * 로봇 정보 상세 조회
				     * @param
				     * @return
				     */
				    function getRobotDetail(url, id) {
				        var param = {"robotId" : id};
				        console.log("1111111111111111param11111111111"+JSON.stringify(param));
				        callAsyncAjax(url, param, "printRobotDetail");
				        
				    }
				    
				    /*
				     * 상세 페이지 데이터 출력
				     * @param
				     * @return
				     */
				    function printRobotDetail(data) {
				    	
				    	console.log("11111111111111111data11111111111"+JSON.stringify(data));
				    	
				    	console.log("data.result"+JSON.stringify(data.result));
				
						var robotValue = data.result;
						var resultDeviceId          = robotValue.deviceId;
						var resultDeviceName        = robotValue.deviceName;
						var resultName              = robotValue.name;
						var resultRobotDescription  = robotValue.robotDescription;
						var resultRobotId           = robotValue.robotId;
						var resultType              = robotValue.type;
						var resultUserName          = robotValue.userName;
						var resultIp                = robotValue.robotIp; 		
						var resultRobotPassword     = robotValue.robotPassword; 		
						var resultTenantId          = robotValue.tenantId;
						var resultCmpnyCd           = robotValue.cmpnyCd;
						
						$("#deviceId").val(resultDeviceId);
						$("#deviceName").val(resultDeviceName);
						$("#robotName").val(resultName);
						$("#robotDescription").val (resultRobotDescription);
						$("#robotId").val(resultRobotId);
						$("#robotType").val(resultType);
						$("#userName").val(resultUserName);
						$("#ip").val(resultIp);
						$("#robotPW").val(resultRobotPassword);
						$("#tenant").val(resultTenantId);
						$("#detailCmpny1").val(resultCmpnyCd).prop("selected", true);
								
				    }
				
				    /*
				     * popup창 닫기
				     * @param
				     * @return
				     */
					function closePOP(){
				        $(".over").remove();
				        searchRobotList();
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
