<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="card card-primary card-tabs" alt="자원>프로세스관리 상세" id="procsRegDiv">
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
                             <label class="col-sm-3 col-form-label">회사</label>
                             <div class="col-sm-9">
                                 <input type="text" id="versionCmpny" name="versionCmpny" class="form-control" style="width:100%;max-width:220px;margin-right: 3px;" disabled>
                             </div>
                        </div>
                        <div class="form-group col-md-6 py-sm-2">
                            <label class="col-sm-3 col-form-label">과제프로세스</label>
                             <div class="col-sm-9">
                                 <input type="text" id="versionProcess" name="versionProcess" class="form-control" style="width:100%;max-width:220px;margin-right: 3px;" disabled>
                             </div>
                        </div>
					    <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
					        <label for="usr" class="col-sm-3 col-form-label">패키지</label>
							<div class="col-sm-9">
		                        <input type="hidden" id="id" name="id" value="" />
		                        <input type="hidden" id="versionProcessKey" name="versionProcessKey" value="" />
		                        <input type="text" id="versionName" name="versionName" class="form-control" style="width:100%;max-width:220px;margin-right: 3px;" disabled />
							</div>
	                    </div>
	                    <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
	                        <label for="usr" class="col-sm-3 col-form-label">환경</label>
	                        <div class="col-sm-9">
	                            <input type="text" id="versionEnvironmentsName" name="versionEnvironmentsName" class="form-control" style="width:100%;max-width:220px;margin-right: 3px;" disabled>
	                        </div>
	                    </div>                        
	                </form>
	            </div>
	            <div class="col-md-12" style="margin: 15px 0 0 0;" >
                    <div class="form-group col-md-4 float-left">
                        <button type="button"  id="btnLatest" class="btn btn-outline-secondary">최신</button>
                        <button type="button"  id="btnRollback" class="btn btn-outline-secondary">롤백</button>
                    </div>
                   <!-- <div class="col-md-6 float-right"></div>         -->        
                    <div id="versionGrid"></div>
                    <div id="versionGridPager" class="portal-pager"></div>
                    
                   <div class="float-right" style="margin:15px 0 15px 2px;">
		                <c:if test="${txScreenAuthor != null}">
		                    <c:if test="${txScreenAuthor.wrtngAuthor eq 'N'}">
		                        <button type="button" class="btn btn-primary float-right" id="verCancel">목록으로</button><br><br>
		                    </c:if>
		                    <c:if test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
		                        <button type="button" class="btn btn-primary" id="processDel1" data-toggle="modal" data-target="#modal-lg3">삭제</button>
		                        &nbsp;
		                        <button type="button" class="btn btn-primary" id="btnClose1">취소</button>
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
                             <label class="col-sm-3 col-form-label">회사</label>
                             <div class="col-sm-9">
                                  <input type="text" id="parameterCmpny" name="parameterCmpny" class="form-control" style="width:100%;max-width:220px;margin-right: 3px;" disabled>
                             </div>
                        </div>
                        <div class="form-group col-md-6 py-sm-2">
                            <label class="col-sm-3 col-form-label">과제프로세스</label>
                             <div class="col-sm-9">
                                 <input type="text" id="parameterProcess" name="parameterProcess" class="form-control" style="width:100%;max-width:220px;margin-right: 3px;" disabled>
                             </div>
                        </div>
                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label for="usr" class="col-sm-3 col-form-label">패키지</label>
                            <div class="col-sm-9">
                                <input type="hidden" id="parameterId" name="parameterId" value="" />
                                <input type="hidden" id="parameterProcessKey" name="parameterProcessKey" value="" />
                                <input type="text" id="parameterName" name="parameterName" class="form-control" style="width:100%;max-width:220px;margin-right: 3px;" disabled>
                            </div>
                        </div>
                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label for="usr" class="col-sm-3 col-form-label">환경</label>
                            <div class="col-sm-9">
                                <input type="text" id="parameterEnvironmentName" name="parameterEnvironmentName" class="form-control" style="width:100%;max-width:220px;margin-right: 3px;" disabled>
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
                     <c:if test="${txScreenAuthor != null}">
                         <c:if test="${txScreenAuthor.wrtngAuthor eq 'N'}">
                             <button type="button" class="btn btn-primary float-right" id="paramCancel">목록으로</button><br><br>
                         </c:if>
                         <c:if test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
                             <button type="button" class="btn btn-primary" id="processDel2" data-toggle="modal" data-target="#modal-lg3">삭제</button>
                             &nbsp;
	                        <button type="button" class="btn btn-primary" id="btnUpdate">수정</button>
                             &nbsp;
                             <button type="button" class="btn btn-primary" id="btnClose2">취소</button>
                         </c:if>
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

//회사코드
var cmpnyCd;
//프로세스id
var processId;
//프로세스명
var processNm;
//프로세스 파일명
var identifier;
//프로세스 버전
var version; 
//과제 프로세스 코드
var taskProcessCd;
// 최신 버젼
var maxVersion;

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
		
		/* var params = [];
        if("${txScreenAuthor.untenantAuthor}" == 'Y'){
            params.push({"id" : "versionCmpny", "clsCd" : "0024"});
            params.push({"id" : "parameterCmpny", "clsCd" : "0024"});
        }else{
            params.push({"id" : "versionCmpny", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
            params.push({"id" : "parameterCmpny", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
        }
        requestCmmnCd(params); */
        

      if(processId != null && processId != ""){ 
    	
    	  //상세 페이지 데이터 조회 
    	  getDetailData(processId);
    	  
    	  //버전 그리드 초기화
          //drawVersionGrid();
    	  drawVersionGridAPI();
          //입력 파라미터 그리드 초기화
//        drawInputParameterGrid();
      }
		
	}
	
	/*
	 * 이벤트 바인딩
	 * @param
	 * @return
	 */
	function bindEvent() {
		
		//팝업닫기 event
		$("#verCancel, #paramCancel, #btnClose1, #btnClose2").on("click", function() {		
        	closePOP();
            drawGrid();
            searchProcessList();
        });
        
		//최신 버전 업데이트
		$("#btnLatest").on("click", function() {
            updateLatest();
        });
		
		
		//롤백 버전 업데이트
		$("#btnRollback").on("click", function() {
			updateRollback();
			//페이지 초기화
	        pageInit();
	        
	        
        });
		
		
		//파라미터 수정
        $("#btnUpdate").on("click", function() {
            updateProcess();
        });
		
		
		//삭제
        $("#deleteProess").on("click", function() {
            deleteProcess();
        });
	
	}
	
    /*
     * 버전 정보 그리드 초기화
     * @param
     * @return
     */
    function drawVersionGridAPI(data){
    	
        var params = {};
        if (data != null && data != undefined) {
            params = data.result;
            //drawPager("versionGridPager", data.result.paginationInfo, "searchVersionList");

            if(params == null || params == "" || 2 > params.length){
                $("#btnLatest ,#btnRollback").attr("disabled",true);
            }else{
                maxVersion = version; 
                
                $.each(params, function(idx, item) { 
                    /* if(!item.IsActive){
                        item.Version > maxVersion ? maxVersion = item.Version : "";
                        identifier = item.Id;
                    } */
                    
                    item.Version > maxVersion ? maxVersion = item.Version : "";
                    identifier = item.Id;
                }); 
             
                
                if(maxVersion == version){
                    $("#btnLatest").attr("disabled",true);
                }
                else {
                	$("#btnLatest").attr("disabled",false);
                }
                
            }
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
            , rowClick: function(arg){}
            , fields : [
                  {name: "Version"          , title : "버전"          , type : "text"   , width : 100
                	  , itemTemplate: function(value, item) {
                		  var Version = item.Version;
                		  
                          if (item.IsActive && Version == version) {
                        	  Version =   item.Version + "현재";
                          }
                          return Version;
                      }}
                , {name: "openTimeDc"       , title : "게시됨"         , type : "text"   , width : 100}
                , {name: "useTimeDc"        , title : "사용됨"         , type : "text"   , width : 100}
                , {   
                    headerTemplate: function() {
                        return $(headerIcon).on("click", function(){getProcessVersionAPIList()});
                    }
                  , itemTemplate: function(value, item) {
                        //console.log("item.currentVersionYn : " + item.currentVersionYn);
                        var itemIcon = "";
                        var Version = item.Version;
                        if (!item.IsActive || Version != version) {
                            itemIcon = '<svg class="bi bi-box-arrow-up" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">';
                            itemIcon += '<path fill-rule="evenodd" d="M4.646 4.354a.5.5 0 0 0 .708 0L8 1.707l2.646 2.647a.5.5 0 0 0 .708-.708l-3-3a.5.5 0 0 0-.708 0l-3 3a.5.5 0 0 0 0 .708z"/>';
                            itemIcon += '<path fill-rule="evenodd" d="M8 11.5a.5.5 0 0 0 .5-.5V2a.5.5 0 0 0-1 0v9a.5.5 0 0 0 .5.5z"/>';
                            itemIcon += '<path fill-rule="evenodd" d="M2.5 14A1.5 1.5 0 0 0 4 15.5h8a1.5 1.5 0 0 0 1.5-1.5V7A1.5 1.5 0 0 0 12 5.5h-1.5a.5.5 0 0 0 0 1H12a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-.5.5H4a.5.5 0 0 1-.5-.5V7a.5.5 0 0 1 .5-.5h1.5a.5.5 0 0 0 0-1H4A1.5 1.5 0 0 0 2.5 7v7z"/>';
                            itemIcon += '</svg>';
                        }
                        return $(itemIcon).on("click", function(){changeProcessVersion(item.Version)});
                    }
                  , align : 'center'
                  , width: 50
                  , sorting : false
                  }
            ]
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
            //drawPager("versionGridPager", data.result.paginationInfo, "searchVersionList");

            if(params == null || params == "" || 2 > params.length){
            	$("#btnLatest ,#btnRollback").attr("disabled",true);
            }else{
            	var maxVersion = version; 
            	
            	$.each(params, function(idx, item) { 
            		
            		if(item.currentVersionYn != "Y"){

            			item.version > maxVersion ? maxVersion = item.version : "";
            			identifier = item.identifier;
            		}
                });
            	            	
            	if(maxVersion == version){
            		$("#btnLatest").attr("disabled",true);
            	}
            }
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
            , rowClick: function(arg){}
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
                	    //console.log("item.currentVersionYn : " + item.currentVersionYn);
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
	function getDetailData() {
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
    		
    		cmpnyCd = data.result.cmpnyCd;
    		version = data.result.version;
    		processNm = data.result.name;
    		//과제 프로세스 코드
    		taskProcessCd = data.result.taskProcessCd;
    		
    		//버전
    		$("#id").val(data.result.id);
    		$("#versionCmpny").val(data.result.cmpnyName);
    		$("#versionProcess").val(data.result.taskProcessNm);
    		$("#versionProcessKey").val(data.result.processKey);
    		$("#versionName").val(data.result.processKey + " v" + data.result.version);
    		$("#versionEnvironmentsName").val(data.result.environmentsName); 
    		
    		//파라미터
            $("#paramterId").val(data.result.id);
            $("#parameterCmpny").val(data.result.cmpnyName);
            $("#parameterProcess").val(data.result.taskProcessNm);
            $("#paramterProcessKey").val(data.result.processKey);
            $("#parameterName").val(data.result.processKey + " v" + data.result.version);
            $("#parameterEnvironmentName").val(data.result.environmentsName);

            //버전정보 조회
    		//getProcessVersionList();
            getProcessVersionAPIList();
    		
            //파라미터 정보 조회
    		getProcessParamterList();
    	}
		
	}
    
    
	/*
     * 패키지(프로세스,릴리즈) 버전 조회
     * @param 페이지번호
     * @return
     */
    function getProcessVersionAPIList() {
        var url = '/resrce/process/getProcessVersionAPIList';
        
        var param = {
            cmpnyCd   : cmpnyCd
           ,processId : $("#versionProcessKey").val()
           ,Id : processId
        };

        callAsyncAjax(url, param, "drawVersionGridAPI");
    }
    
    /*
     * 버전리스트 조회
     * @param
     * @return
     */
    function getProcessVersionList(pageNo) {

        var url = '/resrce/process/getProcessVersionList';
        var currentPageNo = 1;
        if (pageNo != null && pageNo != undefined && pageNo != "" && !isNaN(Number(pageNo))) {
            currentPageNo = pageNo;
        } 

        var param = {
        	cmpnyCd : cmpnyCd,
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
    function changeProcessVersion(chgVersion) {
    	
    	if (confirm($("#versionProcessKey").val() + "을(를) 버전 " + chgVersion + "(으)로 업데이트하시겠습니까?")) {
    	
	    	var url = "/resrce/process/changeProcessVersion";
	        var param = {
	        		cmpnyCd : cmpnyCd,
	        		id: processId,
	        		version : chgVersion
	            };

	        callAsyncAjax(url, param, "getDetailData");
        
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
        	  cmpnyCd   : cmpnyCd
            , id        : $("#id").val()
            , version   : version
        };
        callAsyncAjax(url, param, "printParameterInfo");
    	
    }
    
    /*
     * 파라미터 정보 출력
     * @param
     * @return
     */
    function printParameterInfo(data) {
    	
    	$("#tblInput").html("<thead><tr><th style='text-align:center; height:20px;' colspan='2'>입력 값</th></tr><tr><td>파라미터</td><td>값</td></tr></thead>");
        $("#tblOutput").html("<thead><tr><th style='text-align:center; height:20px;'>출력 값</th></tr><tr><td>파라미터</td></tr></thead>");
    	
    	if (data != null &&  data.result != null) {
    		
    		if (data.result.input != null) {
    			for (var i = 0; i < data.result.input.length; i++) {
	    			var input = data.result.input[i];
	    			$("#tblInput").append("<tr><td>"+ input.type + "<br/>" +  input.name + "</td><td><input type='text' name = 'inputParam' id='" + input.name + "' value='" + input.value +"'/></td></tr>");
	    			//$("#tblInput").append("<tr><td>"+ input.type + "<br/>" +  input.name + "</td><td><input type='text' name = 'inputParam' id='test' value='" + input.value +"'/></td></tr>");
    			}
    		}else{
    			$("#tblInput").append("<tr><td colspan='2'>이 버전에 대한 입력 파라미터가 정의되지 않았습니다.</td></tr>");
    			$("#btnUpdate").hide();
    		}
    		
            if (data.result.output != null) {
                for (var i = 0; i < data.result.output.length; i++) {
                    var output = data.result.output[i];
                    $("#tblOutput").append("<tr><td>"+ input.type + "<br/>" +  input.name + "</td></tr>");
                }
            }else{
            	$("#tblOutput").append("<tr><td>이 버전에 대한 출력 파라미터가 정의되지 않았습니다.</td></tr>");
            }
         
    	}else{
    		$("#tblInput").append("<tr><td colspan='2'>이 버전에 대한 입력 파라미터가 정의되지 않았습니다.</td></tr>");
    		$("#tblOutput").append("<tr><td>이 버전에 대한 출력 파라미터가 정의되지 않았습니다.</td></tr>");
    		$("#btnUpdate").hide();
    	}
    }
    
    
    /*
     * 최신 버전 업데이트
     * @param
     * @return
     */
     function updateLatest(){
    	 if(confirm(processNm + '을(를) 최신 버전의 프로세스 '+identifier + " " + maxVersion +'(으)로 업데이트하시겠습니까?')){
    		 var url = "/resrce/process/updateToLatestPackageVersion";
             var param = {
            		   cmpnyCd : cmpnyCd
                     , id      : processId
             }; 
             callAsyncAjax(url, param, "getDetailData");
         } 
     }
    
    
    
     /*
      * 롤백 버전 업데이트
      * @param
      * @return
      */
      function updateRollback(){
         if(confirm(processNm + '을(를) 마지막으로 사용된 프로세스 버전으로 업데이트하시겠습니까?')){
        	 var url = "/resrce/process/changeProcessVersionRollBack";
             var param = {
            		  cmpnyCd : cmpnyCd
            		 ,id      : processId
                 };
             callAsyncAjax(url, param, "getDetailData");
         }
      }
     
     
      /*
       * 파라미터 수정
       * @param
       * @return
       */
       function updateProcess(){
    	   //{ InputArguments : "{OrchestratorQueueName:null}"}
    	   
    	   var param = {};
    	   param.cmpnyCd = cmpnyCd;
    	   param.Id = processId;
    	   
    	   var inputParamValue = $("input[name='inputParam']").length;
	       var inputName = new Array(inputParamValue);
	       var inputValue = new Array(inputParamValue);
	       
	       var InputData = {};
	       var InputArguments = {};
	       
	   	   for(var i=0; i<inputParamValue; i++){                          
	   		  inputName[i] = $('input[name="inputParam"]').eq(i).attr("id");
	   		  inputValue[i] = $('input[name="inputParam"]').eq(i).val()  == "" ? null : $('input[name="inputParam"]').eq(i).val();
	   	   }
	   	   
		   for (idx in inputName) {
			   InputData[inputName[idx]] = inputValue[idx];
		   } 
		   
		   InputArguments.InputArguments = JSON.stringify(InputData);
		   param.InputArguments = InputArguments;
		   
		   callSyncAjax("/resrce/process/updateProcess", param, "callBackUpdateProcess");
    	   
       }
      
       /*
        * 프로세스 삭제
        * @param
        * @return
        */
        function deleteProcess(){
        	var param = {
        			cmpnyCd   : cmpnyCd
        		   ,id        :  processId
                   ,processCd :  taskProcessCd
              };
             callSyncAjax("/resrce/process/deleteProcess", param, "callBackDeleteProcess");
        }
       
       
        function callBackUpdateProcess(){
            alert('저장되었습니다.');
            searchProcessList();
            closePOP();
        }
        
        function callBackDeleteProcess(){
            alert('삭제되었습니다.');
            searchProcessList();
            $("#modal-lg3").modal("toggle");
            closePOP();
        }
    


</script>