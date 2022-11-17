<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
                    <!--  템플릿 바디 -->
                    <div class="card card-primary" id = "cardDiv">
					    <div class="card-header">
					        <h3 class="card-title">예약실행 등록</h3>
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
                                                    <select class="form-control" id="botNo" style="width:60%;margin-right: 3px;">
                                                    </select>
                                                </div>
                                            </div> 
                                            <div class="form-group col-md-12 py-sm-2">
                                                <label for="name" class="col-sm-1 col-form-label">예약시간</label>
                                                <div class="col-sm-11 py-sm-2 float-left"> 
                                                   
                                                   <div class="input-group date" id="startDeDiv" data-target-input="nearest" style="width:23.5%;min-width:160px;margin-right:10px;">
					                                  <input type="text" id="startDe" name="startDe" class="form-control datetimepicker-input" data-target="#startDeDiv"/>
					                                  <div class="input-group-append" data-target="#startDeDiv" data-toggle="datetimepicker">
					                                      <div class="input-group-text"><i class="fa fa-calendar"></i></div>
					                                  </div>
					                              </div>
                                                   <input type="text" id="startHour" class="form-control" style="width:50px;margin-right: 5px;" maxlength="2" numberonly>시 &nbsp; &nbsp; 
                                                   <input type="text" id="startMinute" class="form-control" style="width:50px;margin-right: 5px;" maxlength="2" numberonly>분
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
					
<script type="text/javascript">
$(document).ready(function() {
    //페이지 초기화
    pageInit();

    //이벤트 바인딩
    bindEvent();
});
					
					    
function triggerArInstantSearchReleasesCallback(data){
	//console.log("function triggerArInstantSearchReleasesCallback");
	GBL_createSearchResultComboBox({id: "targetReleases", resultList: data.result.resultList, viewType:2, optVal: "processCd", optNm: "processNm"});
	GBL_createSearchResultComboBox({id: "botNo", resultList: []});
}

function triggerArInstantSearchRobotCallback(data){
	//console.log("function triggerArInstantSearchRobotCallback");
	lc_robot_data = data.result.resultList;
	GBL_createSearchResultComboBox({id: "botNo", resultList: data.result.resultList, optVal: "botNo", optNm: "botNm", addNm: "state"});
}
					       
/*
 * 이벤트 바인딩
 * @param
 * @return
 */
function bindEvent() {
	$('#startDeDiv').datetimepicker({
        format: 'YYYY-MM-DD'
      , defaultDate: (new Date()).setDate((new Date()).getDate())
    });
	
	$("#btnClose").on("click", function(e){
		closePop();
	});
	
	$("#btnReleasesSearch").on("click", function(e){
		const oReleasesSearchKwrd = $("#releasesSearchKwrd")
/*		
		if($.trim(oReleasesSearchKwrd.val()) == ""){
			alert("검색할 프로세스 코드를 입력해 주십시오.");
			oReleasesSearchKwrd.focus();
			return false;
		}
*/		
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
		const oStartDe = $("#startDe");
		const oStartHour = $("#startHour");
		const oStartMinute = $("#startMinute");
		
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
		
		if($.trim(oStartDe.val()) == ""){
			alert("예약날자를 입력해 주십시오.");
			oStartDe.focus();
			return false;
		}
		
		if(oStartHour.val() == ""){
			alert("시간을 입력해 주십시오.");
			oStartHour.focus();
			return false;
		}
		else{
			const iTmpStr =  parseInt(oStartHour.val().replace(/,/gi, ""));
			if(iTmpStr > 23){
				alert("시간은  0 ~ 23 사이여야 합니다.");
				oStartHour.focus();
				return false;
			}
		}
		
		if(oStartMinute.val() == ""){
			alert("분을 입력해 주십시오.");
			oStartMinute.focus();
			return false;
		}
		else{
			const iTmpStr =  parseInt(oStartMinute.val().replace(/,/gi, ""));
			if(iTmpStr > 59){
				alert("분은  0 ~ 59 사이여야 합니다.");
				oStartMinute.focus();
				return false;
			}
		}
		
		const sHour = oStartHour.val().length == 1 ? "0" + oStartHour.val() : oStartHour.val();   
		const sMinute = oStartMinute.val().length == 1 ? "0" + oStartMinute.val() : oStartMinute.val();
		let selectRobot = GBL_array_find(lc_robot_data, "botNo", oBotNo.val());
		
		//let selectRobot = lc_robot_data.find(function(oRobot) {
		//	  return oRobot.botNo === parseInt(oBotNo.val());
		//	});
		
		/*모든 상태의 로봇으로 처리
		// 사용 가능한 로봇인지 여부
		if(selectRobot.state != 0){
			alert("사용가능한 실행로봇을 선택해 주십시오.");
			oBotNo.focus();
			return false;
		}
		*/
		
		//시간 비교
		const aoStartDe = oStartDe.val().split("-");
		var dCurrentTime = new Date(aoStartDe[0], (parseInt(aoStartDe[1]) - 1), aoStartDe[2], sHour, sMinute, 0, 0);
		if(dCurrentTime.getTime() <= (new Date()).getTime()){
			alert("예약 시간은 현재 시간보다 최소 1분 이후여야 합니다.");
			return false;
		}
	    
		let params = {
				cmpnyCd: selectRobot.cmpnyCd
				, processCd: selectRobot.processCd
				, botNo: selectRobot.botNo
				, inputarguments: selectRobot.inputarguments
				, releasesName: selectRobot.releasesName
				, processKey: selectRobot.processKey
				, releasesId: selectRobot.releasesId
				, releasesKey: selectRobot.releasesKey
				, releasesName: selectRobot.releasesName
				, botType: selectRobot.botType
				, dateYmd: oStartDe.val().replace(/-/gi, "")
				, dateYmshm: oStartDe.val() + " " + sHour + ":" + sMinute + ":00"
				, timeSet: sHour
				, minutSet: sMinute.substring(0,1) + "0"
		};
		
		callAsyncAjax("/resrce/triggerAr/insertResveStart", params, "insertResveStartCallback");
	});
	
	let initParams = {searchKwrd: ""}
	callAsyncAjax("/resrce/triggerAr/triggerArInstantSearchReleases", initParams, "triggerArInstantSearchReleasesCallback");
}

function insertResveStartCallback(data){
	closePop();
}
					    
					          
</script>
<!--  템플릿 바디 끝 -->