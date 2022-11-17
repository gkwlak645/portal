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
                            <h1 class="m-0 text-dark">환경관리</h1>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">자원관리 / 환경관리</li>
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
				<div id="envrnMainDiv" class="container-fluid wrap">
				    <div class="row" >
				        <div class="col-md-12">
				            <div class="card">
				                <div class="card-header">
				                    <form id="searchForm" name="searchForm" class="form-inline" onsubmit="return false">                                        
                                       <div class="form-group row  col-sm-6">
                                              <label for="name" class="col-sm-2 col-form-label">회사</label>
                                              <select class="form-control col-sm-10" id="schCmpny"style="width:60%;max-width:200px;" >
                                                  <option value=""></option>
                                              </select>
                                          </div>
                                     
                                     
                                         <div class="form-group row  col-sm-6">
                                             <label for="name" class="col-sm-2 col-form-label">환경명</label>
                                             <div class="col-sm-10">
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
                                         <button type="button" id="btnReg" class="btn btn-primary float-right" style="margin:5px 0 15px 2px;">등록</button>
                                        <div id="envrnGrid"></div>
				                        <div id="envrnGridPager" class="portal-pager"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>    
                        
				
					<script>
					var currentPageNo = 1;
					$(document.body).ready(function() {
						searchEnvrnList();
					});
					
					    //등록 환경 아이디
					    var registerEnvrnId = '';
					    
					    /*
					     * 페이지 초기화
					     * @param
					     * @return
					     */
					    function pageInit() {
					    	var params = [];
						//      if("${txScreenAuthor.untenantAuthor}" == 'Y'){
						//          params.push({"id" : "schCmpny", "clsCd" : "0024"});    //회사
						//      }else{
						//          params.push({"id" : "schCmpny", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
						//      }
						    params.push({"id" : "schCmpny", "clsCd" : "0024"});    //회사
						    requestCmmnCd(params);
						     
					        drawGrid();
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
					            	searchEnvrnList();
					            }
					        });
					    	
					    	//조회버튼 클릭 이벤트 처리
					        $("#btnSearch").on("click",function(){
					        	searchEnvrnList();
					        });
					        
					        //등록페이지로 pop
					        $("#btnReg").on("click",function(){
					        	appendDetailPopup("envrnMainDiv", "/resrce/envrn/envrnRegisterPagePop");
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
							   		drawPager("envrnGridPager", data.result.paginationInfo, "searchEnvrnList");
					    		}
					    	}
					        $("#envrnGrid").jsGrid({
					              height : "auto"
					            , width : "100%"
					            , autoload: true
					            , sorting : true
					            , align : "center"
					            , data : params
					            , rowClick: function(arg){
					                  popupEnvrnDetail(arg.item.id);
					              }
					            , fields : [
					                  {name: "id"                  , title : "아이디"           , type : "text"   , width : 0 , visible : false}
					                , {name: "cmpnyName"           , title : "회사명"           , type : "text"   , width : 100, align : "center"}
					                , {name: "name"                , title : "환경명"           , type : "text"   , width : 80, align : "center"}
					                , {name: "description"         , title : "설명"            , type : "text"   , width : 250}
					            ]
					        });
					        
					    }
					    
					    /*
					     * 검색
					     * @param 페이지번호
					     * @return
					     */
					    function searchEnvrnList(pageNo) {
					        var url = '/resrce/envrn/getEnvrnList';
					        var currentPageNo = 1;
					        if (pageNo != null && pageNo != undefined && pageNo != "") {
					        	currentPageNo = pageNo;
					        }
					        var param = {
					        	cmpny : $("#schCmpny").val(),
					        	name: $("#name").val(),
					            currentPageNo:currentPageNo,
					            recordCountPerPage:10,
					            pageSize:10
					        };
					        callAsyncAjax(url, param, "drawGrid");
					    }
					    
					    /*
					     * 상세페이지 pop
					     * @param
					     * @return
					     */
					    function popupEnvrnDetail(id) {
					        appendDetailPopup("envrnMainDiv", "/resrce/envrn/envrnDetailPop");
					        getEnvrnDetail("/resrce/envrn/getEnvrnDetail", id); 
					    };
					
					    /*
					     * 환경  정보 상세 조회
					     * @param
					     * @return
					     */
					    function getEnvrnDetail(url, id) {
					        var param = {id : id};
					        callSyncAjax(url, param, 'drawValue');
					    }
					    
					    
					    /*
					     * 환경  정보 상세 출력
					     * @param
					     * @return
					     */
					    function drawValue(data){
					        console.log(data);
					        var envrnValue = data.result;
					
					        registerEnvrnId            = envrnValue.id;
					        var resultEnvrnId            = envrnValue.id;
					        var resultEnvrnName          = envrnValue.name;
					        var resultEnvrnDescription   = envrnValue.description;
					        var resultCmpnyCd           = envrnValue.cmpnyCd;
					        
					        $("#detailEnvrnId").val(resultEnvrnId);
					        $("#detailEnvrnName").val(resultEnvrnName);
					        $("#detailEnvrnDescription").val(resultEnvrnDescription);
					        $("#cmpnyCd").val(resultCmpnyCd).prop("selected", true);
					    }
					
					    /*
					     * 환경 등록 후 로봇 리스트 화면 POP
					     * @param
					     * @return
					     */
					    function getRobotList(data) {
					
					        if (data.responseCode == 'I101') {
					
					        	//기존 팝업 닫기
					            closePOP('');
					
					        	//로봇리스트 팝업 열기
						        popupEnvrnRobotEnvrn();
					
						        if (data.result.value !== undefined) {
						            registerEnvrnId = data.result.value[0].Id;
						            console.log('id   '+registerEnvrnId);
						        } else {
					 	        	checkEnvrnRobotList(data);
						        }
					        }
					    }
					    
					    /*
					     * 로봇리스트 팝업 생성
					     * @param
					     * @return
					     */
					    function popupEnvrnRobotEnvrn() {
					    	appendDetailPopup("envrnMainDiv", "/resrce/envrn/envrnRobotRegisterPagePop");
					    	getEnvrnRobotList();
					    }
					    
					    /*
					     * 환경 로봇 정보 리스트 조회
					     * @param
					     * @return
					     */
					    function getEnvrnRobotList() {
					        var param = {};
					        callSyncAjax("/resrce/envrn/getRobotList", param, "drawRobotTable");
					    }
					    
					    /*
					     * 로봇 리스트에 해당 환경이 매핑되어 있는 경우 체크표시
					     * @param
					     * @return
					     */
					    function checkEnvrnRobotList(data) {
					    	
					        var robotId = [];
					
					   		$.each(data.result,function(index,item){
					   			robotId.push(item.RobotId);
					   		});
					
					        $('input[name=gridCheckbox]').each(function(){
					        	
					     	    var rid = parseInt($(this).val());
					     		var index = robotId.indexOf(rid);
					     		
					     	    if (index > -1) {
					                $(this).prop("checked",true);
					            }
					        });
					   		
					    }
					
					    /*
					     * 로봇 환경 정보 상세 출력
					     * @param
					     * @return
					     */
						function drawRobotTable(data) {
					    	
							var params = {};
							if (data != null && data != undefined) {
						        params = data.result.resultList;
							}
							   
							$("#envrnRobotGrid").jsGrid({
							    height : "auto"
							  , width : "100%"
							  , autoload: true
							  , sorting : true
							  , align : "center"
							  , data : params
							  , fields : [
							        {   
							        	headerTemplate: function() {
					                        return $("<input id='allCheck' style='width:18px;height:18px;'>").attr("type", "checkbox").on("click", function () {allSelect();});
					                    }
					                  , itemTemplate: function(_, data) {
					                        var id = data.id;
					                        return $("<input name='gridCheckbox' class='gridCheckbox' style='width:18px;height:18px;'>").attr("type", "checkbox").val(id);
					                    }
					                  , align : 'center'
							          , width: 50
							          , sorting : false
							        }  
							      , {name: "name"                , title : "로봇명"           , type : "text"       , width : 80, align : "center"}
							      , {name: "type"                , title : "로봇유형"            , type : "text"       , width : 80, align : "center"}
							      , {name: "robotDescription"    , title : "설명"            , type : "text"        , width : 200}
							    ]
							});
						
						}
					
					    /*
					     * checkbox 전체 선택
					     * @param
					     * @return
					     */
					    function allSelect() {
					    	if ($("#allCheck").prop("checked")) {
					    		  $('input[name=gridCheckbox]').prop("checked",true);
					    	} else {
					    		  $('input[name=gridCheckbox]').prop("checked",false);
					    	}
					    }
					
					    /*
					     * popup창 닫기
					     * @param
					     * @return
					     */
					    function closePOP(data) {
					        console.log('close    '+data);
					        $(".over").remove();
					        searchEnvrnList();
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

