<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!--  템플릿 바디 -->
					<div class="card card-primary card-tabs">
                        <div class="card-header">
					        <h3 class="card-title">큐상세</h3>
					    </div>                      
                        <div class="card-body" >
                            <div class="tab-content" id="">  
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="card card-default">
                                            <form class="form-inline" onSubmit="return false;">
                                                <div class="card-body" >
                                                    <div class="form-group col-sm-12">
                                                        <label for="queueName" class="col-sm-2 col-form-label">이름<b style="color:red;padding-left:10px;">*</b></label>
                                                         <div class="col-sm-10">
                                                            <input type="text" id="queueName" name="queueName" class="form-control float-left" style="width:97%;">
                                                        </div>
                                                     </div>
                                                    <div class="form-group col-sm-12">
                                                        <label for="queueReleases" class="col-sm-2 col-form-label">프로세스<b style="color:red;padding-left:10px;">*</b></label>
                                                        <div class="col-sm-10">
                                                            <input type="text" class="form-control float-left col-sm-9" id="releasesSearchKwrd2" name="searchKwrd" style="width:60%;min-width:75px;" value="" /><button type="button" id="btnReleasesSearch2" class="btn btn-info float-left ">조회</button>
		                                                    <select class="form-control" id="queueReleases" style="width:97%;" >
                                                             <option value=""></option>
                                                            </select>
			                                             </div>
                                                     </div>
                                                  </div>
                                              </form> 
                                                
                                              <form class="form-inline" onSubmit="return false;">     
                                                <div class="card-body2" style="overflow:auto;">  
                                                   <!-- 파라미터 -->
                                                   <div style="display:block;">                                                       
                                                        <div class="form-group col-md-12">
                                                             <div class="triggertableDiv_wrap" style="height: 238px;">                                                             
                                                                <table id="queueParametaList" class="table">
                                                                    <colgroup>
                                                                      <col width="50%">
                                                                      <col width="*">
                                                                    </colgroup>
                                                                    <thead>
                                                                        <tr>
                                                                            <th>파라미터</th>
                                                                            <th>값</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>                                                                     
                                                                    </tbody>                                               
                                                                </table>
                                                            </div>
                                                        </div>
                                                   </div>
                                                   <!-- 파라미터 END -->
                                                </div>
                                             </form>
                                        </div>
                                    </div>
                                 
                                    <!-- 우측영역 -->
                                    <div class="col-md-6" >
                                        <div class="card card-default">
                                            <form class="form-inline" onSubmit="return false;">
                                                <div class="card-body2">                                                    
                                                  <div class="form-group col-sm-12">
                                                      <label for="schCmpny" class="col-sm-4 col-form-label">큐</label>
                                                       <div class="col-sm-8">
                                                          <select class="form-control" id="queueDefinitions" style="width:90%;" >
                                                           <option value=""></option>
                                                          </select>
                                                      </div>
                                                   </div>
                                                            
                                                   <!-- 구분점선 -->
                                                   <div class="form-group col-md-12 py-sm-1"></div>                                                   
                                                   <div class="form-group col-md-12 line-top"></div> 
                                                   <p style="color:red;font-size:12px;margin: 15px 0 0 15px;">※  큐 트리거가 선택된 프로세스에 연결된 환경에서 실행됩니다.</p>                                                         
                                                    
                                                   <div for="" class="col-sm-7 float-left">· 첫 번째 작업을 트리거할 최소 항목 수</div>                                                  
                                                   <div class="col-sm-5 float-left"><input type="text" class="form-control" id="itemsActivationThreshold"  value="1" style="width:20%;margin-right: 5px;" maxlength="5" numberonly>항목</div>    
                                                   
                                                   <div for="" class="col-sm-7 float-left">· 동시에 허용되는 최대 보류 및 실행 작업 수</div>                                                  
                                                   <div class="col-sm-5 float-left"><input type="text" class="form-control" id="maxJobsForActivation" value="1" style="width:20%;margin-right: 5px;" maxlength="5" numberonly>작업</div> 
                                                   
                                                   <div for="" class="col-sm-7 float-left">· 각각 다른 작업이 트리거되는 항목</div>                                                  
                                                   <div class="col-sm-5 float-left"><input type="text" class="form-control" id="itemsPerJobActivationTarget" value="1" style="width:20%;margin-right: 5px;" maxlength="5" numberonly readonly>새항목</div> 
                                                   
                                                                                                      
                                                   <!-- 구분점선 -->                                                   
                                                   <div class="form-group col-md-12 line-top"></div> 
                                                   <div class="form-group col-md-12 py-sm-1"></div> 
                                                   <div class="form-group col-sm-12">
                                                        <label for="schCmpny" class="col-sm-4 col-form-label">표준시간대</label>
                                                         <div class="col-sm-8">
                                                            <select class="form-control" id="timezones2" style="width:90%;" >
                                                             <option value=""></option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    
                                                    <!-- 구분점선 --> 
                                                   <div class="form-group col-md-12 py-sm-1"></div>                                                  
                                                   <div class="form-group col-md-12 line-top"></div> 
                                                   <div class="form-group col-md-12 py-sm-1"></div> 
                                                   <div class="form-group col-sm-12">
                                                        <label for="schCmpny" class="col-sm-4 col-form-label">휴무일 제한사항</label>
                                                         <div class="col-sm-8">
                                                            <select class="form-control" id="queueCalendars" style="width:90%;" >
                                                             <option value=""></option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    
                                                    <!-- 구분점선 -->
                                                     <div class="form-group col-md-12 py-sm-1"></div> 
                                                     <div class="form-group col-md-12 line-top"></div>          
                                                     
                                                     <!-- 다음트리거 -->
                                                     <div class="form-group col-md-12 py-sm-1"></div>
                                                     <div class="col-sm-12 custom-control custom-switch float-right">
                                                        <input type="checkbox" id="customSwitch3" class="custom-control-input float-right">
                                                        <label id="customSwitch3-label" class="custom-control-label  float-right" for="customSwitch3">다음 트리거 사용안함</label>
                                                    </div>
                                                    <!-- 다음트리거 사용안함체크시 -->
                                                    <div id="customSwitch3-div" style="display:none">
                                                         <div class="col-sm-9 float-left">
                                                             <div for="" class="col-sm-2 float-left">시점</div>                                                  
                                                             <div class="col-sm-10 float-left"> 
                                                                  <div class="input-group date float-left" id="customSwitch3_de_div" data-target-input="nearest"style="min-width:140px;width:40%;margin-right:5px;">
									                                  <input type="text" id="customSwitch3_de" name="customSwitch3_de" class="form-control datetimepicker-input" data-target="#customSwitch3_de_div"/>
									                                  <div class="input-group-append" data-target="#customSwitch3_de_div" data-toggle="datetimepicker">
									                                      <div class="input-group-text"><i class="fa fa-calendar"></i></div>
									                                  </div>
									                              </div>
									                              <div class="float-left">
				                                                      <select id="customSwitch3_hour" class="form-control float-left"  style="min-width: 60px;width:70%;">
				                                                      </select>시
				                                                  </div>
				                                                  <div class="float-left">
				                                                      <select id="customSwitch3_Minute" class="form-control float-left"  style="min-width: 60px;width:70%;">
				                                                          <option value='00'>00</option>
				                                                          <option value='15'>15</option>
				                                                          <option value='30'>30</option>
				                                                          <option value='45'>45</option>
				                                                      </select>분
				                                                  </div>
                                                             </div> 
                                                          </div>                                                     
                                                     </div>  
                                                    <!-- 작업중지 실행시 END-->                                                 
                                                </div>
                                             </form>
                                         </div>
                                         
                                         <div class="form-group float-right">
                                              <button type="button" class="btn btn-primary float-right" id="btnClose"  style="margin:5px 0 15px 1px;">닫기</button>
                                              <button type="button" class="btn btn-primary float-right" id="btnUpdate"  style="margin:5px 0 15px 4px;">업데이트</button>
                                          </div>
                                     </div>
                                     <!-- 우측영역 End -->
                                   </div>
                                </div>                  
                            </div>
                        </div>
                   </div>
                <!--  템플릿 바디 끝 -->
<script type="text/javascript">
var lc_oProcessSchedule = undefined;
var lc_queue_data = undefined;
var lc_releases_data = undefined;
var lc_calendars_data = undefined;
var lc_robot_data = undefined;
var lc_insert_params = undefined;

var lc_select_releases_id = 0;
var lc_select_certain_releases_id = 0;

$(document).ready(function() {
	
	pageInit();
    bindEvent();
});

function pageInit(){
	let customSwitch2_hour_html = "";
	for(let i = 0; i < 24; i++){
		const sTmp = i < 10 ? "0" + i : "" + i; 
		customSwitch2_hour_html += '<option value="'+ sTmp +'">'+sTmp+'</option>';
	}
	$("#customSwitch3_hour").html(customSwitch2_hour_html);
}

function getProcessSchedulesCallback(data){
	lc_oProcessSchedule =  data.result;
	lc_select_releases_id = lc_oProcessSchedule.ReleaseId;
	
	//프로세스 정보
	initSearchReleases(lc_oProcessSchedule.ReleaseName)
	//이름
	$("#queueName").val(lc_oProcessSchedule.Name)
	//선택된 프로세스 조회
	
	//실행타겟정보
	if(lc_oProcessSchedule.StartStrategy < 0){
		$("input[name='reg_target_checkRadio'][value=All]").click();
	}
	else if(lc_oProcessSchedule.StartStrategy == 0){
		$("input[name='reg_target_checkRadio'][value=Specific]").click();
		//로봇 정보 자동 처리됨
	}
	else{
		$("input[name='reg_target_checkRadio'][value=JobsCount]").click();
		$("#startStrategy").val(lc_oProcessSchedule.StartStrategy);
	}
	
	//파라미터 정보
	let selectObj = lc_releases_data.find(function(releases) {
				  return releases.Id === parseInt(lc_select_releases_id);
				});
	//프로세스의 파라미터 정보
	drawParameterList(selectObj);
	
	//트리거의 파라미터 정보
	if(lc_oProcessSchedule.InputArguments != null){
		const oInputArguments = JSON.parse(lc_oProcessSchedule.InputArguments);
		for (const sKey in oInputArguments) {
			$("input[name=inputArgumentsItem][item-data-name="+ sKey +"]").val(oInputArguments[sKey])
		}
	}
	
	
	
	
	
	//큐
	searchQueueDefinitions();
	
	//첫 번째 작업을 트리거할 최소 항목 수
	$("#itemsActivationThreshold").val(lc_oProcessSchedule.ItemsActivationThreshold)
	//동시에 허용되는 최대 보류 및 실행 작업 수
	
	$("#maxJobsForActivation").val(lc_oProcessSchedule.MaxJobsForActivation)
	
	//각각 다른 작업이 트리거되는 항목
	$("#itemsPerJobActivationTarget").val(lc_oProcessSchedule.ItemsPerJobActivationTarget)
	if(lc_oProcessSchedule.ItemsPerJobActivationTarget != 1){
		$("#itemsPerJobActivationTarget").prop("readonly", false);
	}

	//표준 시간대
	searchTimezones()
	
	//휴무일 제한사항
	searchCalendars();
	
	//다음 트리거 사용않함
	if(lc_oProcessSchedule.StopProcessDate != null){
		$("#customSwitch3-label").click();
		
		const sStopProcessDate = lc_oProcessSchedule.StopProcessDate;
		const asStopProcessDate = sStopProcessDate.split("T")
		const asStopProcessTime = asStopProcessDate[1].split(":")
		
		$("#customSwitch3_de").val(asStopProcessDate[0]);
		$("#customSwitch3_hour").val(asStopProcessTime[0]);
		$("#customSwitch3_Minute").val(asStopProcessTime[1]);
	}
	
	
	//특정 로봇 여부
	if(lc_oProcessSchedule.StartStrategy == 0){
		initRobotIdsForProcessSchedules();
	}
}

function initSearchReleases(keyWord){
	var url = '/resrce/triggerUr/searchReleases';
    var param = {
   		searchKwrd: keyWord	
    };
    callSyncAjax(url, param, "initSearchReleasesCallback");
}

function initSearchReleasesCallback(data){
	lc_releases_data = data.result.resultList;
	GBL_createSearchResultComboBox({id: "queueReleases", resultList: lc_releases_data, optVal: "Id", optNm: "Name", emptyOption: "Y", selectValue: lc_select_releases_id});
}

function searchReleases(keyWord){
	var url = '/resrce/triggerUr/searchReleases';
    var param = {
   		searchKwrd: keyWord	
    };
    callAsyncAjax(url, param, "searchReleasesCallback");
}

function searchReleasesCallback(data){
	lc_releases_data = data.result.resultList;
	GBL_createSearchResultComboBox({id: "queueReleases", resultList: lc_releases_data, optVal: "Id", optNm: "Name"});
	lc_select_releases_id = "";
	
	//특정로봇 초기화
}

function searchQueueDefinitions(){
	console.log("function searchQueueDefinitions()");
	var url = '/resrce/triggerUr/searchQueueDefinitions';
	var param = {ProcessScheduleId: lc_oProcessSchedule.Id};
	callAsyncAjax(url, param, "searchQueueDefinitionsCallback");
}

function searchQueueDefinitionsCallback(data){
	lc_queue_data = data.result.resultList;
	GBL_createSearchResultComboBox({id: "queueDefinitions", resultList: data.result.resultList, optVal: "Id", optNm: "Name", selectValue: lc_oProcessSchedule.QueueDefinitionId, emptyOption: "Y"} );
}

function searchTimezones(){
	var url = '/resrce/triggerUr/searchTimezones';
	var param = {};
	callAsyncAjax(url, param, "searchTimezonesCallback");
	
}

function searchTimezonesCallback(data){
	GBL_createSearchResultComboBox({id: "timezones2", resultList: data.result.resultList, optVal: "Value", optNm: "Name", selectValue: lc_oProcessSchedule.TimeZoneId, emptyOption: "Y"} );
	$('#timezones2').attr('disabled', 'true');
}

function searchCalendars(){
	var url = '/resrce/triggerUr/searchCalendars';
    var param = {};
    callAsyncAjax(url, param, "searchCalendarsCallback");
}

function searchCalendarsCallback(data){
	lc_calendars_data = data.result.resultList;
	GBL_createSearchResultComboBox({id: "queueCalendars", resultList: lc_calendars_data, optVal: "Id", optNm: "Name", emptyText: "일정이 선택되지 않았습니다."});
	if(lc_oProcessSchedule.CalendarId != null ){
		$("#queueCalendars").val("" + lc_oProcessSchedule.CalendarId);
	}
}

function updateProcessSchedulesCallback(data){
	mainPopCloseReload();
}

function bindEvent(){
	$('#customSwitch3_de_div').datetimepicker({
        format: 'YYYY-MM-DD'
      //, defaultDate: (new Date())
    });
	
	//닫기
	$("#btnClose").on("click", function() {
		mainPopClose();
	});
	
	
	$("#btnReleasesSearch2").on("click", function(e){
		drawTargetRobotList([]);	//시간 > 특정로봇 초기화
		$("#timeParametaList tbody").html("");
		searchReleases($("#releasesSearchKwrd2").val());
	});
	
	//다음 트리거 사용안함
	$("#customSwitch3-label").on("click", function(e){
		//console.log("#customSwitch1:" + $("input:checkbox[id=customSwitch1]").is(":checked"));
		const bChecked = !($("input:checkbox[id=customSwitch3]").is(":checked"));
		if(bChecked){
			$("#customSwitch3-div").show()
		}
		else{
			$("#customSwitch3-div").hide()
		}
		//$("input:checkbox[id=customSwitch1]").prop("checked", false)
	});
	
	//입력값 체크
	$("#itemsActivationThreshold, #maxJobsForActivation, #itemsPerJobActivationTarget").on("focusout", function(e){
		console.log("processExecutCnt focusout")
		const oThis = $(e.target);
		const sThisVal = oThis.val();
		 
		if(sThisVal == "" || parseInt(sThisVal.replace(/,/ ,"")) < 1 || parseInt(sThisVal.replace(/,/ ,"")) > 10000 ){
			e.stopPropagation();
			e.preventDefault();
			alert("값은 1~10000 사이여야 합니다.");
			oThis.focus();
			return false;
		}
		if(sThisId == "maxJobsForActivation"){
			if(sThisVal == "1"){
				$("#itemsPerJobActivationTarget").prop("readonly", true).val(1);
			}
			else{
				$("#itemsPerJobActivationTarget").prop("readonly", false);
			}
		}
	});
	
	
	$("#btnUpdate").on("click", function(){
		const oTargetNm = $("#queueName");
		const oTargetReleases = $("#queueReleases");
		const oQueueDefinitions = $("#queueDefinitions");
		const oItemsActivationThreshold = $("#itemsActivationThreshold");
		const oMaxJobsForActivation = $("#maxJobsForActivation");
		const oItemsPerJobActivationTarget = $("#itemsPerJobActivationTarget");
		
		
		
		
		//이름확인
		if($.trim(oTargetNm.val()) == ""){
	        alert("이를을 입력해 주십시오.");
	        oTargetNm.focus();
	        return false;
	    }
		
		//포로세스 확인
		if($.trim(oTargetReleases.val()) == ""){
	        alert("프로세스를 선택해 주십시오.");
	        oTargetReleases.focus();
	        return false;
	    }
		
		//파라미터 확인
		const aInputArgumentsItem = $("#queueParametaList input:text[name=inputArgumentsItem]");
		const iaInputArgumentsItem = aInputArgumentsItem.length;
		let sInputArgumentsItemTmp = "";
		
		if(iaInputArgumentsItem > 0){
			for(let i = 0; i < iaInputArgumentsItem; i++){
				const oTmp = $(aInputArgumentsItem[i]);
				console.log("oTmp.val(): " + oTmp.val());
				if(oTmp.val() != ""){
					if(sInputArgumentsItemTmp != ""){
						sInputArgumentsItemTmp += ",";
					}
					
					if(oTmp.attr("item-data-type").indexOf("String") >= 0){
						sInputArgumentsItemTmp += "\"" + oTmp.attr("item-data-name") + "\":\"" + oTmp.val() + "\"" 
					}else{
						try {
							  JSON.parse(oTmp.val());
						} catch (error) {
							alert("파라미터 \"" + oTmp.attr("item-data-name") + "\"에 잘못된 값이 입력되었습니다.");
							oTmp.focus("")
							return false;
						}
						sInputArgumentsItemTmp += "\"" + oTmp.attr("item-data-name") + "\":" + oTmp.val()  
					}
				}
			}
		}
		sInputArgumentsItemTmp = "{" + sInputArgumentsItemTmp + "}";
		
		//큐확인
		if($.trim(oQueueDefinitions.val()) == ""){
	        alert("큐를 선택해 주십시오.");
	        oQueueDefinitions.focus();
	        return false;
	    }
		
		//표준 시간대
		const sTimeZoneId = $("#timezones1").val();
		
		//휴무일 제한사항 시작
		let bUseCalendar = false;
		let iCalendarId = 0;
		const sTargetCalendarsVal = $("#queueCalendars").val();
		if(sTargetCalendarsVal != ""){
			bUseCalendar = true;
			iCalendarId = parseInt(sTargetCalendarsVal);
		}
		//휴무일 제한사항 종료
		
		//다음 트리거 사용안함 시작
		let sStopProcessDate = null
		const bCustomSwitch3Checked = $("input:checkbox[id=customSwitch3]").is(":checked");
		if(bCustomSwitch3Checked){
			const oCustomSwitch3_de = $("#customSwitch3_de")
			if(oCustomSwitch3_de.val() == ""){
				alert("시점 날짜를 입력해 주십시오.");
				return false
			}
			sStopProcessDate = oCustomSwitch3_de.val() + "T" + $("#customSwitch3_hour").val() + ":" + $("#customSwitch3_Minute").val() + ":00Z"
		}
		//다음 트리거 사용안함 종료
		
		
		// 큐 관련 정보 획득
		let oSelectQueue = lc_queue_data.find(function(queue) {
		  return queue.Id === parseInt(oQueueDefinitions.val());
		});
		
		//일부함수 초기화
		let oParams = {};
		$.extend( oParams, lc_oProcessSchedule );
		
		//큐 관련 함수 입력
		oParams.QueueDefinitionId = oSelectQueue.Id;
		oParams.QueueDefinitionName =  oSelectQueue.Name;
		oParams.ItemsActivationThreshold = parseInt(oItemsActivationThreshold.val());
		oParams.ItemsPerJobActivationTarget = parseInt(oItemsPerJobActivationTarget.val());
		oParams.MaxJobsForActivation = parseInt(oMaxJobsForActivation.val());
		
		//이름  입력
		oParams.Name = oTargetNm.val()
		
		//프로세스 정보 입력
		let oSelectReleases = lc_releases_data.find(function(releases) {
		  return releases.Id === parseInt(oTargetReleases.val());
		});
		
		oParams.ReleaseId =  oSelectReleases.Id
		oParams.ReleaseName = oSelectReleases.Name
		
		//파마미터 입력
		oParams.InputArguments = sInputArgumentsItemTmp
		
		//휴무일 제한사항 입력1
		oParams.UseCalendar = bUseCalendar
		
		//다음 트리거 사용안함 입력
		oParams.StopProcessDate =  sStopProcessDate
		
		//휴무일 제한사항 입력2
		if(bUseCalendar){
			oParams.CalendarId = iCalendarId;
		}else{
			delete oParams.CalendarId
		}
		
		callAsyncAjax("/resrce/triggerUr/updateProcessSchedules", oParams, "updateProcessSchedulesCallback");
	});
	
	
	let oParams = {schduleId: lc_select_schdule_id, loading_id: (lc_loading_id++)}
	///odata/ProcessSchedules(128)
	callSyncAjax("/resrce/triggerUr/getProcessSchedules", oParams, "getProcessSchedulesCallback");
}

function drawParameterList(selectObj){
	const aInput = JSON.parse(selectObj.Arguments.Input);
	const iaInput = aInput == null  ? 0 : aInput.length;
	let sTmp = "";
	if(iaInput > 0){
		const aInputArguments = JSON.parse(selectObj.InputArguments);
		for (let i = 0; i < iaInput; i++) {
			const oaInput = aInput[i];
			
			let sViewType = oaInput.type.indexOf("System.Collections.Generic.Dictionary") >= 0 ? "Dictionary" : ""; 
			if(sViewType == ""){
				const aTypeTemp = oaInput.type.split(",");
				const aTypeTemp2 = aTypeTemp[0].split(".");
				sViewType = aTypeTemp2[aTypeTemp2.length -1];
			}
			
			const sInputArgumentsVal = aInputArguments == null ? undefined : aInputArguments[oaInput.name];
			const sPlaceholder = sInputArgumentsVal == undefined ? "값 없음" : "프로세스에서 상속됨";
			
			
			sTmp += '<tr>';
			sTmp += '	<td style="text-align: left;">'+ sViewType +'<br/>'+ oaInput.name+'</td>';
			sTmp += '	<td><input type="text" name="inputArgumentsItem" item-data-type="'+ sViewType +'" item-data-name="'+ oaInput.name+'" style="width:100%;" value="" placeholder="'+ sPlaceholder +'">';
			sTmp += '</tr>';
		}
	}
	else{
		sTmp =  "<tr><td colspan='2'>이 버전에 대한 입력 파라미터가 정의되지 않았습니다.</td></tr>";
	}
	$("#queueParametaList tbody").html(sTmp);
} 
</script>
