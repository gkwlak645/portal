<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div id="jobMainDiv" class="container-fluid wrap">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <form class="form-inline">
                        
                        <div class="form-group col-md-5 py-sm-2">
                          <label for="schCmpny" class="col-sm-2 col-form-label">회사</label>
                          <div class="col-sm-10">
                              <select id="schCmpny" class="form-control" style="width:60%;max-width:200px;">
                                  <option value=""></option>
                              </select>
                          </div>
                        </div>
                        <div class="form-group col-md-5 py-sm-2" style="margin: 0.3rem 0 0.3rem 0;">
                          <label for="usr" class="col-sm-2 col-form-label">생성일</label>
                          <div class="col-sm-4">
                              <div class="input-group date" id="startDeDiv" data-target-input="nearest" style="min-width:130px;margin: 0 0 2px 0;">
                                  <input type="text" id="startDe" name="startDe" class="form-control datetimepicker-input" data-target="#startDeDiv"/>
                                  <div class="input-group-append" data-target="#startDeDiv" data-toggle="datetimepicker">
                                      <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                  </div>
                              </div>
                          </div>
                          <div class="col-sm-4">
                              <div class="input-group date" id="endDeDiv" data-target-input="nearest" style="min-width:130px;margin: 0 0 2px 0;">
                                  <input type="text" id="endDe" name="endDe" class="form-control datetimepicker-input" data-target="#endDeDiv"/>
                                  <div class="input-group-append" data-target="#endDeDiv" data-toggle="datetimepicker">
                                      <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                  </div>
                              </div>
                          </div>
                        </div>
                        
                        
                        
                        
                        <!-- <div class="form-group col-md-5 py-sm-2" style="margin: 0.3rem 0 0.3rem 0;">
                          <label for="usr" class="col-sm-2 col-form-label">상태</label>
                          <div class="col-sm-10">
                              <select id="cmbState" class="form-control float-left" style="width:60%;max-width:200px;">
                                  <option value="">- 선택 -</option>
                              </select><button type="button" id="btnSearch" class="btn btn-info float-left">조회</button>
                              
                          </div>
                        </div> -->
                        
                        <div class="form-group col-md-5 py-sm-2" style="margin: 0.3rem 0 0.3rem 0;">
                          <label for="usr" class="col-sm-2 col-form-label">상태</label>
                          <div class="col-sm-10">
                              <select id="cmbState" class="form-control float-left" style="width:60%;max-width:200px;">
                                  <option value="">- 선택 -</option>
                              </select>                             
                          </div>
                        </div> 
                        
                        <div class="form-group col-md-5 py-sm-2">
                            <label for="usr" class="col-sm-2 col-form-label">로봇명</label>
                                <div class="col-sm-10">
                                    <select class="form-control float-left" id="searchRobotName"style="width:100%;" >
                                    <option value=""></option>
                                </select>
                            </div>
                        </div>
                        
                        <button type="button" id="btnSearch" class="btn btn-info float-left">조회</button>
                        
                    </form> 
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-body">
                    <div id="jobGrid"></div>
                    <div id="jobGridPager" class="portal-pager"style="text-align:center"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 로딩바  -->
<div class="dimmed" style="display:none"></div>
<div class="loading" style="display:none">
    <div class="loading-bar"><div></div><div></div><div></div><div></div></div>
    <span class="loading-text">로딩 중...</span>
</div>

<script>

//검색조건 - 시작일자
var startFmtDate;
var nowPage = 1;

    /*
     * 페이지 초기화
     * @param
     * @return
     */
    function pageInit() {
    	

        var params = [];
        if("${txScreenAuthor.untenantAuthor}" == 'Y'){
            params.push({"id" : "schCmpny", "clsCd" : "0024"});    //회사
        }else{
            params.push({"id" : "schCmpny", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
        }
        
        params.push({"id" : "cmbState", "clsCd" : "0053"});
        //params.push({"id" : "cmbJobPriority", "clsCd" : "0010"});
        requestCmmnCd(params);
        
        
        if("${mainInitAt}" != null && "${mainInitAt}" != ""){
        	startFmtDate = (new Date()).getDate()
        }else{
        	startFmtDate = (new Date()).getDate() -7
        }
        
        searchArRobotList();

        //그리드 초기화
        drawGrid();
    };
    
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent(){

        //조회버튼 클릭 이벤트 처리
        $("#btnSearch").on("click",function(){
        	searchJobArList();
        });
        
        $('#startDeDiv').datetimepicker({
            format: 'YYYY-MM-DD'
          , defaultDate: (new Date()).setDate(startFmtDate)
        });
        
        
        $("#endDeDiv").datetimepicker({
            format: 'YYYY-MM-DD'
          , defaultDate: (new Date())
        });
        
        $("#schCmpny").on("change",function(){
        	searchArRobotList();      
        });
        
        searchJobArList();
    }
    
    /*
     * 검색
     * @param 페이지번호
     * @return
     */
    function searchArRobotList() {
        var url = '/mntrng/jobAr/getArRobotList';

        var param = {
            cmpnyCd: $("#schCmpny").val()
        }; 
        
        callAsyncAjax(url, param, "makeSelectBoxRobot");
    }
    
    function makeSelectBoxRobot(data) {
    	var robotList = {};
        var saveRobotName = $("#searchRobotName").val().length == 0 ? "null" : $("#searchRobotName").val();
        var template = '<option value="전체">전체</option>';

    	if (data.result != null && data.result.robotList != null) {
    		robotList = data.result.robotList;  
    		//<option value=""></option>
            var len = robotList.length;
            for(var i=0; i<len; i++) {             
                template += '<option value=' + robotList[i].name + '>' + robotList[i].name + '</option>';
            }

            $("#searchRobotName").html(template);  

            var isExists = 0 != $('#searchRobotName option[value='+saveRobotName+']').length;
            
            if(isExists) {
                $("#searchRobotName").val(saveRobotName).attr("selected", "selected");
            }
            else {
                $("#searchRobotName").val("전체").attr("selected", "selected");
            }
            
    		return false;
        }

        $("#searchRobotName").html(template); 
        $("#searchRobotName").val("전체").attr("selected", "selected");
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

            drawPager("jobGridPager", data.result.paginationInfo, "searchJobArList");
        }
        
        var headerIcon = '<svg class="bi bi-arrow-clockwise" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">';
        headerIcon += '<path fill-rule="evenodd" d="M3.17 6.706a5 5 0 0 1 7.103-3.16.5.5 0 1 0 .454-.892A6 6 0 1 0 13.455 5.5a.5.5 0 0 0-.91.417 5 5 0 1 1-9.375.789z"/>';
        headerIcon += '<path fill-rule="evenodd" d="M8.147.146a.5.5 0 0 1 .707 0l2.5 2.5a.5.5 0 0 1 0 .708l-2.5 2.5a.5.5 0 1 1-.707-.708L10.293 3 8.147.854a.5.5 0 0 1 0-.708z"/>';
        headerIcon += '</svg>';

        $("#jobGrid").jsGrid({
              height : "auto"
            , width : "100%"
            , autoload: true
            , sorting : true
            , align : "left"
            , data : params
            , rowClick: function(arg){
                //popupDetail(arg.item.id);
            }
            , fields : [
                  {name: "cmpnyNm"        , title : "회사"         , type : "text"   , width : 50}
                , {name: "robotName"      , title : "로봇명"       , type : "text"   , width : 70 ,align : "left"}
                , {name: "processCd"      , title : "프로세스코드"   , type : "text"   , width : 40 ,align : "left"}
                , {name: "viewProcessName"    , title : "프로세스명"     , type : "text"   , width : 150}
                , {name: "creatDt"    , title : "생성일"     , type : "text"   , width : 80 ,align : "left"}
                , {name: "sttusName"      , title : "상태"         , type : "text"   , width : 45  ,align : "left"}
                , {name: "startDt"        , title : "시작됨"        , type : "text"   , width : 80  ,align : "left"}
                , {name: "endDt"          , title : "종료됨"        , type : "text"   , width : 80  ,align : "left"}
                , {title: "중지"   
                , itemTemplate: function(value, item) {
                        var itemIcon = '';
                        if(item.sttus == 'WAIT'){
                        	itemIcon += '<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-x-circle" fill="currentColor" xmlns="http://www.w3.org/2000/svg">';
                            itemIcon += '<path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>';
                            itemIcon += '<path fill-rule="evenodd" d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>';     
                            itemIcon += '</svg>';	
                        } else if(item.sttus == 'START'){
                            itemIcon += '<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-x-circle" fill="currentColor" xmlns="http://www.w3.org/2000/svg">';
                            itemIcon += '<path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>';
                            itemIcon += '<path fill-rule="evenodd" d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>';     
                            itemIcon += '</svg>';   
                        }
                        
                        return $(itemIcon).on("click", function(){
                        	if(confirm('선택한 작업을 중지하시겠습니까?')){
                        		stopJobAr(item.sn);
                        	}
                        });
                    }
                  , align : 'center'
                  , width: 50
                  , sorting : false
                  }
                
                
                , {name: "ETC___"       , title : "중지중 상태 변경"      , type : "text"   , width : 45, align : "center", 
                	itemTemplate: function(value, item) { 
                		if(String(item.sttus) == "STOP") {
                            return '<span onclick ="convertToStopped(\'' + item.sn + '\', \'' + item.cmpnyCd + '\', \'' + item.processCd + '\', \'' + item.sttus + '\')">변경</span>'
                		}
                	}
                }

                    
            ]
        });
        
    }
    
    function isNullString(str) {
        if(str.length == 0 || str == null || str == "") {
            return true;
        }
        return false;
    }
    
    function convertToStopped(sn, cmpnyCd, processCd, sttus) {
    	if(sttus != "STOP") {
    		alert("선택하신 JOB의 상태가 '중지중'이 아닙니다.\n페이지를 새로고침(CTRL + F5)하시거나 '중지중' 상태의 JOB을 클릭하세요.");
    		return false;
    	}
    	
    	if(isNullString(sn) || isNullString(cmpnyCd) || isNullString(processCd) || isNullString(sttus)) {
    	     alert("'중지중' 상태값을 수정할 수 없습니다.\n담당자에게 DESK로 문의하세요.\n원인 : NULL 값 존재");
    	     return false;
    	}
    	
    	if(confirm("'중지중'에서 '중지됨'으로 상태를 변경하시겠습니까?\n이 버튼은 '중지중'에서 상태가 변경되지 않을 때만 클릭하세요.")) {
    		// 로딩 시작
            $('.dimmed').css({ display: 'block' });
            $('.loading').css({ display: 'block' });
            $('.loading').addClass('show');  
            
            var param = {
                    sn : sn
                    , cmpnyCd : cmpnyCd
                    , processCd : processCd
                    , sttus : sttus
            }; 

            $.ajax({
                type: "post",
                url: "/mntrng/jobAr/convertToStopped",
                async: false,
                dataType: "json",
                contentType : "application/json;charset=UTF-8",
                data: JSON.stringify(param),
                success : function(data){
                    if (data.responseCode != null && data.responseCode != undefined && data.responseCode.substr(0, 1) == "E") {
                        alert(data.responseMessage);
                    } else {
                    	searchJobArList(nowPage);
                        alert("'중지됨'으로 상태 변경되었습니다.");
                    }
                },
                error: function(request, status, err) {
                    alert("오류가 발생하였습니다.\n" + request.responseText);
                    console.log(err);
                },
                complete:function() {
                    $('.dimmed').css({ display: 'none' });
                    $('.loading').css({ display: 'none' });
                    $('.loading').removeClass('show');   
                }
            });
    	}
    }
    
    /*
     * 검색
     * @param 페이지번호
     * @return
     */
    function searchJobArList(pageNo) {
    	
        var url = '/mntrng/jobAr/getJobArList';
        var currentPageNo = 1;
        if (pageNo != null && pageNo != undefined && pageNo != "" && $.isNumeric(pageNo)) {
            currentPageNo = pageNo; 
        }
        
        nowPage = currentPageNo;

        var param = {
        	cmpnyCd: $("#schCmpny").val(),
        	searchRobotName     : $("#searchRobotName").val(),
            startDe: $("#startDe").val().replace(/-/g, ""),
            endDe: $("#endDe").val().replace(/-/g, ""),
            state: $("#cmbState").val(),
            currentPageNo:currentPageNo,
            recordCountPerPage:10,
            pageSize:10
        }; 
        
        callAsyncAjax(url, param, "drawGrid");
    }
    
    
    /*
     * job 실행중지
     * @param 
     * @return
     */
    function stopJobAr(sn) {
    	 var url = '/mntrng/jobAr/stopJobAr';
	       
	       var param = {};
	       param.sn            =   sn
	       callSyncAjax(url, param, "searchJobArList");
    };
    
    
    
    /*
     * 상세페이지 팝업
     * @param 
     * @return
     */
    function popupDetail(id) {

        //상세 페이지 div 생성
        appendDetailPopup("jobMainDiv", "/mntrng/jobmntrng/jobDetailPop");

        //상세 페이지 데이터 조회
        getDetailData(id);

    };
    

</script>
