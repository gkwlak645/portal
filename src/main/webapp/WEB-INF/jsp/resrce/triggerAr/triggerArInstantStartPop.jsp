<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"     uri="http://java.sun.com/jsp/jstl/fmt" %>
<!--  템플릿 바디 -->
                    <div class="card card-primary" id = "cardDiv">
                        <div class="card-header">
                            <h3 class="card-title">즉시실행 등록</h3>
                        </div>
                        <div class="card-body" style="min-height:654px; overflow:auto;">
                                <div class="row">
                                    <div class="col-md-12">
                                    <form>
                                        <div class="form-inline">
                                             <div class="form-group col-md-6 py-sm-2" >
                                                <label class="col-sm-2 col-form-label" for="targetReleases">프로세스</label>
                                                <div class="col-sm-10">
                                                	<input type="text" class="form-control float-left col-sm-12" id="releasesSearchKwrd" name="releasesSearchKwrd" style="width:75%;min-width:75px;" placeholder="검색할 프로세스명 또는 코드 입력" maxlength="50" value="" /><button type="button" id="btnReleasesSearch" class="btn btn-info float-left ">조회</button>
		                                                    <select class="form-control" id="targetReleases" style="width:75%;" >
                                                             <option value="">프로세스 검색을 실행해 주세요.</option>
                                                            </select>
                                                </div>
                                            </div>
                                             
                                            <div class="form-group col-md-6 py-sm-2" >
                                                <label class="col-sm-2 col-form-label" for="inputName">실행로봇</label>
                                                <div class="col-sm-10">
                                                    <select class="form-control" id="botNo" style="width:75%;margin-right: 3px;">
                                                    </select>
                                                </div>
                                            </div>                    
                                        </div>
                                        <div class="float-right">
                                            <button type="button" class="btn btn-primary" id="btnSave">저장</button>
                                            <button type="button" class="btn btn-primary" id="btnClose">닫기</button>
                                        </div>                   
                                       
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
<!--  템플릿 바디 끝 -->    
<script type="text/javascript">
var lc_robot_data = undefined;
$(document.body).ready(function () {
	pageInit()
	bindEvent()
});

function pageInit(){
	lc_robot_data = undefined;
}

function triggerArInstantSearchReleasesCallback(data){
	console.log("function triggerArInstantSearchReleasesCallback");
	GBL_createSearchResultComboBox({id: "targetReleases", resultList: data.result.resultList, viewType:2, optVal: "processCd", optNm: "processNm"});
	GBL_createSearchResultComboBox({id: "botNo", resultList: []});
}

function triggerArInstantSearchRobotCallback(data){
	lc_robot_data = data.result.resultList;
	console.log("function triggerArInstantSearchRobotCallback");
	GBL_createSearchResultComboBox({id: "botNo", resultList: data.result.resultList, optVal: "botNo", optNm: "botNm", addNm: "state"});
}

function insertInstantStartCallback(data){
	alert("즉시 실행이 등록되었습니다.");
	closePop();
}

function bindEvent(){
	$("#btnClose").on("click", function(e){
		closePop()
	});
	
	$("#btnReleasesSearch").on("click", function(e){
		const oReleasesSearchKwrd = $("#releasesSearchKwrd")
		if($.trim(oReleasesSearchKwrd.val()) == ""){
			alert("검색할 프로세스 코드를 입력해 주십시오.");
			oReleasesSearchKwrd.focus();
			return false;
		}
		
		let params = {searchKwrd: oReleasesSearchKwrd.val()}
		callAsyncAjax("/resrce/triggerAr/triggerArInstantSearchReleases", params, "triggerArInstantSearchReleasesCallback");
	});
	
	$("#targetReleases").on("change", function(e){
		const oThis = $("#targetReleases");
		if(oThis.val() == ""){
			//초기화
			GBL_createSearchResultComboBox({id: "botNo", resultList: []});
		}
		else{
			let params = {processCd: oThis.val()}
			callAsyncAjax("/resrce/triggerAr/triggerArInstantSearchRobot", params, "triggerArInstantSearchRobotCallback");
			//실행로봇 검색
		}
	});
	
	$("#btnSave").on("click", function(e){
		const oTargetReleases = $("#targetReleases");
		const oBotNo = $("#botNo");
		
		
		if($.trim(oTargetReleases.val()) == ""){
			alert("프로세스를 선택해 주십시오.");
			oTargetReleases.focus();
			return false;
		}
		
		if($.trim(oBotNo.val()) == ""){
			alert("실행로봇을 선택해 주십시오.");
			oBotNo.focus();
			return false;
		}
		
		let selectRobot = lc_robot_data.find(function(oRobot) {
			  return oRobot.botNo === parseInt(oBotNo.val());
			});
		
		if(selectRobot.state != 0 && selectRobot.state != 1){
			alert("사용가능한 실행로봇을 선택해 주십시오.");
			oBotNo.focus();
			return false;
		}
		
		let params = {
				cmpnyCd: selectRobot.cmpnyCd
				, processCd: selectRobot.processCd
				, botNo: selectRobot.botNo
				, inputarguments: selectRobot.inputarguments
				, releasesName: selectRobot.releasesName
				, processKey: selectRobot.processKey
		};
		
		callAsyncAjax("/resrce/triggerAr/insertInstantStart", params, "insertInstantStartCallback");
	});
	
	let initParams = {searchKwrd: ""}
	callAsyncAjax("/resrce/triggerAr/triggerArInstantSearchReleases", initParams, "triggerArInstantSearchReleasesCallback");
}


</script>