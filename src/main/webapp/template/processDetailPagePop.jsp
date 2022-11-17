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
                            <h1 class="m-0 text-dark">프로세스 상세</h1>
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
					<div class="card card-primary card-tabs" alt="자원>프로세스관리 상세">
					    <div class="card-header p-0 pt-1">
					        <ul class="nav nav-tabs" id="custom-tabs-one-tab" role="tablist">
					            <li class="nav-item">
					                <a class="nav-link active" id="tabVersion" data-toggle="pill" href="#versionTab" role="tab" aria-controls="versionTab" aria-selected="true">버전 관리</a>
					            </li>
					            <li class="nav-item">
					                <a class="nav-link" id="tabParameter" data-toggle="pill" href="#parameterTab" role="tab" aria-controls="parameterTab" aria-selected="false">파라미터</a>
					            </li>
					        </ul>
					    </div>
					    <div class="card-body" style="height:540px; overflow:auto;">
					        <div class="tab-content" id="version-tabContent">
					        
					            <!-- 첫번째 탭  버전 관리 -->
					            <div class="tab-pane fade show active" id="versionTab" role="tabpanel" aria-labelledby="tabVersion">
					                <div class="col-md-12">
							            <form id="version" class="form-inline">
										    <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
										        <label for="usr" class="col-sm-3 col-form-label">패키지</label>
												<div class="col-sm-8">
							                        <input type="hidden" id="id" name="id" value="" />
							                        <input type="hidden" id="versionProcessKey" name="versionProcessKey" value="" />
							                        <input type="text" id="versionName" name="versionName" class="form-control" disabled />
												</div>
						                    </div>
						                    <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
						                        <label for="usr" class="col-sm-3 col-form-label">환경</label>
						                        <div class="col-sm-8">
						                            <input type="text" id="versionEnvironmentsName" name="versionEnvironmentsName" class="form-control" disabled>
						                        </div>
						                    </div>                        
						                </form>
						            </div>
						            <div class="col-md-12" style="margin: 15px 0 0 0;" >
					                    <div class="form-group col-md-4 float-left">
					                        <button type="button"  id="btnLatest" class="btn btn-outline-secondary">최신</button>
					                        <button type="button"  id="btnRollback" class="btn btn-outline-secondary">롤백</button>
					                    </div>
					                   <div class="col-md-6 float-right"></div>                
					                    <div id="versionGrid"></div>
					                    <div id="versionGridPager" class="portal-pager"></div>
					                   <div class="col-md-6 float-right" style="margin:15px 0 15px 2px;">
						                <button type="button" class="btn btn-primary float-right" id="verCancel" style="margin-left:2px;">목록으로</button>
						                <c:if test="${txScreenAuthor != null}">
						                    <c:if test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
						                        <button type="button" class="btn btn-primary float-right" id="updateProcess" style="margin-left:2px;">저장</button>
						                        <button type="button" class="btn btn-primary float-right" data-toggle="modal" data-target="#modal-lg3" style="margin-left:2px;">삭제</button>
						                    </c:if>
						                </c:if>
						               </div>
						            </div>
						        </div>
						        <!-- 첫번째 탭  버전 관리 -->
						        
					            <!-- 두번째 탭 파라미터 -->
					            <div class="tab-pane fade" id="parameterTab" role="tabpanel" aria-labelledby="tabParameter">
					                <div class="col-md-12">
					                    <form id="version" class="form-inline">
					                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
					                            <label for="usr" class="col-sm-4 col-form-label">패키지</label>
					                            <div class="col-sm-8">
					                                <input type="hidden" id="parameterId" name="parameterId" value="" />
					                                <input type="hidden" id="parameterProcessKey" name="parameterProcessKey" value="" />
					                                <input type="text" id="parameterName" name="parameterName" class="form-control" disabled>
					                            </div>
					                        </div>
					                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
					                            <label for="usr" class="col-sm-4 col-form-label">환경</label>
					                            <div class="col-sm-8">
					                                <input type="text" id="parameterEnvironmentName" name="parameterEnvironmentName" class="form-control" disabled>
					                            </div>
					                        </div> 
					                        <div class="form-group col-md-6 py-sm-2">
					                            <div class="card-body p-10">
					                                <table id="tblInput" class="table table-sm" style="height:60px;">
					                                    <thead>
						                                    <tr>
						                                        <th style="text-align:center; height:20px;" colspan="2">입력 값</th>
						                                    </tr>
					                                    </thead>
					                                    <tr>
					                                        <td>파라미터</td>
					                                        <td>값</td>
					                                    </tr>
					                                </table>
					                            </div>
					                        </div>
					                        <div class="form-group col-md-6 py-sm-2">
					                            <div class="card-body p-0">
					                                <table id="tblOutput" class="table table-sm"  style="height:60px;">
					                                    <thead>
					                                        <tr>
					                                            <th style="text-align:center; height:20px;">출력 값</th>
					                                        </tr>
					                                    </thead>
					                                    <tr>
					                                        <td>파라미터</td>
					                                    </tr>
					                                </table>
					                            </div>
					                        </div>
					                    </form>
					                </div>
					                <div class="col-md-12">
					                    <div id="parameterGrid"></div>
					                </div>
						            <div class="float-right" style="margin:15px 0 15px 2px;">
						                <button type="button" class="btn btn-primary" id="paramCancel">목록으로</button>
						                <c:if test="${txScreenAuthor != null}">
						                        <button type="button" class="btn btn-primary" id="updateProcess">저장</button>
						                        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-lg3">삭제</button>
						                    </c:if>
						            </div>
					            </div>
					            <!-- 두번째 탭 파라미터 -->
					
					        </div>
					    </div>
					</div>
					
					<div class="modal fade-dept" id="modal-lg3">
					    <div class="modal-dialog modal-lg">
					        <div class="modal-content">
					            <div class="modal-header" style="background-color: #007bff;color: white;"><h5>삭제</h5>
					            </div>
					            <div class="modal-body" >
					                <h5>해당 프로세스를 삭제하시겠습니까?</h5>
					            </div>
					            <div class="modal-footer justify-content-between">
					                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
					                <button type="button" class="btn btn-primary" id="deleteProess" data-dismiss="modal">삭제</button>
					            </div>
					        </div>
					    </div>
					</div>
					    
					<script>
					
						$(function() {
						
							//페이지 초기화
							pageInit();
							
							//이벤트 바인딩
							bindEvent();
						});
						
						/*
						 * 페이지 초기화
						 * @param
						 * @return
						 */
						function pageInit() {
							
							//버전 그리드 초기화
							drawVersionGrid();
							
							//입력 파라미터 그리드 초기화
					// 		drawInputParameterGrid();
						}
						
						/*
						 * 이벤트 바인딩
						 * @param
						 * @return
						 */
						function bindEvent() {
					        $("#verCancel").on("click", function() {
					        	closePOP();
					        });
					        
					        $("#paramCancel").on("click", function() {
					        	closePOP();
					        });
						
						}
						
					    /*
					     * 버전 정보 그리드 초기화
					     * @param
					     * @return
					     */
					    function drawVersionGrid(data){
					
					        var params = {};
					        if (data != null && data != undefined) {
					            params = data.result.resultList;
					            drawPager("versionGridPager", data.result.paginationInfo, "searchVersionList");
					        }
					        
					        var headerIcon = '<svg class="bi bi-arrow-clockwise" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">';
					        headerIcon += '<path fill-rule="evenodd" d="M3.17 6.706a5 5 0 0 1 7.103-3.16.5.5 0 1 0 .454-.892A6 6 0 1 0 13.455 5.5a.5.5 0 0 0-.91.417 5 5 0 1 1-9.375.789z"/>';
					        headerIcon += '<path fill-rule="evenodd" d="M8.147.146a.5.5 0 0 1 .707 0l2.5 2.5a.5.5 0 0 1 0 .708l-2.5 2.5a.5.5 0 1 1-.707-.708L10.293 3 8.147.854a.5.5 0 0 1 0-.708z"/>';
					        headerIcon += '</svg>';
					
					        $("#versionGrid").jsGrid({
					              height : "auto"
					            , width : "100%"
					            , autoload: true
					            , sorting : true
					            , align : "center"
					            , data : params
					            , rowClick: function(arg){
					                  
					              }
					            , fields : [
					            	  {name: "currentVersionYn" , title : "현재버전여부"     , type : "text"   , width : 0 , visible : false}
					                , {name: "versionDc"        , title : "버전"          , type : "text"   , width : 100}
					                , {name: "openTimeDc"       , title : "게시됨"         , type : "text"   , width : 100}
					                , {name: "useTimeDc"        , title : "사용됨"         , type : "text"   , width : 100}
					                , {   
					                    headerTemplate: function() {
					                        return $(headerIcon).on("click", function(){getProcessVersionList()});
					                    }
					                  , itemTemplate: function(value, item) {
					                	    console.log("item.currentVersionYn : " + item.currentVersionYn);
					                	    var itemIcon = "";
					                	    if (item.currentVersionYn != "Y") {
						                        itemIcon = '<svg class="bi bi-box-arrow-up" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">';
						                        itemIcon += '<path fill-rule="evenodd" d="M4.646 4.354a.5.5 0 0 0 .708 0L8 1.707l2.646 2.647a.5.5 0 0 0 .708-.708l-3-3a.5.5 0 0 0-.708 0l-3 3a.5.5 0 0 0 0 .708z"/>';
						                        itemIcon += '<path fill-rule="evenodd" d="M8 11.5a.5.5 0 0 0 .5-.5V2a.5.5 0 0 0-1 0v9a.5.5 0 0 0 .5.5z"/>';
						                        itemIcon += '<path fill-rule="evenodd" d="M2.5 14A1.5 1.5 0 0 0 4 15.5h8a1.5 1.5 0 0 0 1.5-1.5V7A1.5 1.5 0 0 0 12 5.5h-1.5a.5.5 0 0 0 0 1H12a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-.5.5H4a.5.5 0 0 1-.5-.5V7a.5.5 0 0 1 .5-.5h1.5a.5.5 0 0 0 0-1H4A1.5 1.5 0 0 0 2.5 7v7z"/>';
						                        itemIcon += '</svg>';
					                	    }
					                        return $(itemIcon).on("click", function(){changeProcessVersion(item.id, item.version)});
					                    }
					                  , align : 'center'
					                  , width: 50
					                  , sorting : false
					                  }
					            ]
					        });
					
					    }
					    
					
						/*
						 * 데이터 조회
						 * @param
						 * @return
						 */
						function getDetailData(processId) {
							var param = {"id" : processId};
							callSyncAjax("/resrce/process/getProcessDetail", param, "printDetailData");
						}
						
					    /*
					     * 데이터 출력
					     * @param
					     * @return
					     */
						function printDetailData(data) {
					    	
					    	if (data != null &&  data.result != null) {
					    		
					    		$("#id").val(data.result.id);
					    		$("#versionProcessKey").val(data.result.processKey);
					    		$("#versionName").val(data.result.processKey + " v" + data.result.version);
					    		$("#versionEnvironmentsName").val(data.result.environmentsName);
					    		
					            $("#paramterId").val(data.result.id);
					            $("#paramterProcessKey").val(data.result.processKey);
					            $("#parameterName").val(data.result.processKey + " v" + data.result.version);
					            $("#parameterEnvironmentName").val(data.result.environmentsName);
					
					            //버전정보 조회
					    		getProcessVersionList();
					    		
					            //파라미터 정보 조회
					    		getProcessParamterList();
					    	}
							
						}
					    
					    /*
					     * 버전리스트 조회
					     * @param
					     * @return
					     */
					    function getProcessVersionList(pageNo) {
					
					        var url = '/resrce/process/getProcessVersionList';
					        var currentPageNo = 1;
					        if (pageNo != null && pageNo != undefined && pageNo != "") {
					            currentPageNo = pageNo;
					        }
					        var param = {
					            processKey: $("#versionProcessKey").val(),
					            currentPageNo:currentPageNo,
					            recordCountPerPage:10,
					            pageSize:10
					        };
					        callAsyncAjax(url, param, "drawVersionGrid");
					    }
					    
					    /*
					     * 버전변경
					     * @param
					     * @return
					     */
					    function changeProcessVersion(id, version) {
					    	
					    	if (confirm($("#versionProcessKey").val() + "을(를) 버전 " + version + "(으)로 업데이트하시겠습니까?")) {
					    	
						    	var url = "/resrce/process/changeProcessVersion";
						        var param = {
						        		id: id,
						        		version : version
						            };
						        callAsyncAjax(url, param, "getProcessVersionList");
					        
					    	}
					    }
					    
					    /*
					     * 파라미터 리스트 조회
					     * @param
					     * @return
					     */
					    function getProcessParamterList() {
					    	
					        var url = '/resrce/process/getProcessParamterList';
					        var param = {
					            id : $("#id").val()
					        };
					        callAsyncAjax(url, param, "printParameterInfo");
					    	
					    }
					    
					    /*
					     * 파라미터 정보 출력
					     * @param
					     * @return
					     */
					    function printParameterInfo(data) {
					    	
					    	if (data != null &&  data.result != null) {
					    		if (data.result.input != null) {
					    			for (var i = 0; i < data.result.input.length; i++) {
						    			var input = data.result.input[i];
						    			$("#tblInput").append("<tr><td>"+ input.type + "<br/>" +  input.name + "</td><td><input type='text' id='input_" + input.name + "' value='" + input.value +"'/></td></tr>");
					    			}
					    		}
					    		
					            if (data.result.output != null) {
					                for (var i = 0; i < data.result.output.length; i++) {
					                    var output = data.result.output[i];
					                    $("#tblOutput").append("<tr><td>"+ input.type + "<br/>" +  input.name + "</td></tr>");
					                }
					            }
					    	}
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