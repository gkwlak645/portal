<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!--  템플릿 바디 -->
					<div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title">즉시 시작</h4>
                             <button type="button" class="close jq_modal_close" aria-label="Close">
                                 <span aria-hidden="true">×</span>
                             </button>
                            </div>
                            <div class="modal-body" >
                                <form class="form-inline" onSubmit="return false;">
                                    <!--  
                                    <div class="form-group col-sm-12">
                                        <label for="schCmpny" class="col-sm-2 col-form-label">이름</label>
                                         <div class="col-sm-10">trig_time_police</div>
                                     </div>
                                     -->
                                    <div class="form-group col-sm-12">
                                        <label for="schCmpny" class="col-sm-2 col-form-label">프로세스</label>
                                        <div class="col-sm-10">
                                                            <input type="text" class="form-control float-left col-sm-9" id="releasesSearchKwrd" name="searchKwrd" style="width:60%;min-width:75px;" value="" /><button type="button" id="btnReleasesSearch" class="btn btn-info float-left ">조회</button>
		                                                    <select class="form-control" id="targetReleases" style="width:97%;" >
                                                            </select>
			                                             </div>
                                     </div>
                                  </div>
                              </form> 
                                
                              <form class="form-inline" onSubmit="return false;">     
                                <div class="card-body2" style="overflow:auto;">
                                  <!-- 실행타겟 -->
                                  <div style="display:block;">
                                    <div class="form-group col-md-12"> 
                                        <div class="tabmenu_area">
                                            <a href="javascript:void(0);" id="reg_target" class="target active">실행타겟</a>
                                            <a href="javascript:void(0);" id="reg_parameter" class="parameter">파라미터</a>
                                         </div>
                                    </div>
                                  
                                    <div class="form-group row col-md-10 py-sm-3 jq-time-target">
                                        <!-- <input type="radio" name="checkRadio" id="target" value="robot_all" class="custom-radio" style="width:18px;height:18px;"> 모든 로봇 &nbsp; &nbsp; &nbsp; -->
                                        <input type="radio" name="reg_target_checkRadio" value="Specific" class="custom-radio" style="width:18px;height:18px;" checked>특정 로봇 &nbsp; &nbsp; &nbsp;
                                        <input type="radio" name="reg_target_checkRadio" value="JobsCount"class="custom-radio" style="width:18px;height:18px;" >동적으로 할당
                                     </div>
                                     
                                     <!-- 구분점선 -->
                                     <div class="form-group col-md-12 py-sm-2 line-top jq-time-target jq-time-target_sub2 jq-time-target_sub3"></div>
                                     
                                     <!-- 동적할당 DIV -->
                                     <div class="form-group row col-md-12 jq-time-target jq-time-target_sub3" name="" style="display:none;">
                                        <label for="schCmpny" class="col-sm-4 col-form-label">프로세스 실행</label>
                                         <div class="col-sm-8">
                                            <input type="text" id="startStrategy" name="startStrategy" class="form-control float-left" style="width:20%;margin-right:5px;" value="1" maxlength="5" numberonly> 회
                                         </div>
                                     </div>
                                     <!-- 특정로봇 DIV -->
                                     <div class="form-group row col-md-12 jq-time-target jq-time-target_sub2" name="" style="display:block;">
                                       <label id=""class="col-sm-2 col-form-label float-left" >검색</label>
                                       <div class="col-sm-5 float-left">
                                            <input type="text" class="form-control float-left" id="robotSearchKwrd" name="robotSearchKwrd" style="width:60%;min-width:75px;" value="" /><button type="button" id="btnSearchRobot" class="btn btn-info float-left">조회</button>
                                       </div>
<!--                                        
                                       <label id=""class="col-sm-2 col-form-label float-left" >상태</label>
                                       <div class="col-sm-3 float-left">
                                            <select class="form-control float-left" id="schCmpny" style="width:90%;" >
                                                <option value=""></option>
                                            </select>
                                       </div>
 -->
                                       <div class="form-group col-md-12 triggertableDiv_wrap" style="height: 130px;" >
                                           <table id="targetRobotList" class="table">
                                               <colgroup>
                                                  <col width="15%">
									              <col width="45%">
									              <col width="*">
                                                </colgroup>
                                               <thead>
                                                   <tr>
                                                       <th><input type="checkbox" class="custom-checkbox" style="width:18px;height:18px;" id="targetRobotListChkAll"></th>
                                                       <th>로봇</th>
                                                       <th>머신</th>
                                                       
                                                   </tr>
                                               </thead>
                                               <tbody>
                                               </tbody>
                                            </table>
                                          </div>
                                          <div class="form-group col-md-12">
                                           <!--  <p style="color:#4b5eb5;font-size:12px;">※  O행이 선택되었습니다.</p>-->
                                          </div> 
                                     </div>
                                   </div>
                                   <!-- 실행타겟 END -->
                                    
                                   <!-- 파라미터 -->
                                   <div class="jq-time-parameter" style="display:none;">
                                        <div class="form-group col-md-12 py-sm-2">
                                            <div class="card-body p-10">
                                                <!-- <p style="color:#4b5eb5;font-size:12px;">※  이 버전에 대한 입력 파라미터가 정의되지 않았습니다.</p> -->
                                                <table id="timeParametaList" class="table">
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
					                                                <tbody></tbody>					                                                    
					                                            </table>
                                            </div>
                                        </div>
                                   </div>
                                   <!-- 파라미터 END -->
                                </div>
                             </form>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary" id="btnStart">시작</button>
                                <button type="button" class="btn btn-default jq_modal_close">닫기</button>
                            </div>
                        </div>
                    </div>					
                <!--  템플릿 바디 끝 -->
<script>
var lc_releases_data = undefined;
var lc_select_certain_releases_id = "";
$(document.body).ready(function () {
	pageInit()
	bindEvent()
});

function pageInit(){
	lc_releases_data = undefined;
	lc_select_certain_releases_id = "";
	searchReleases('');
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
	GBL_createSearchResultComboBox({id: "targetReleases", resultList: lc_releases_data, optVal: "Id", optNm: "Name"});
	GBL_createSearchResultComboBox({id: "queueReleases", resultList: lc_releases_data, optVal: "Id", optNm: "Name"});
	
	lc_select_releases_id = "";
	drawTargetRobotList([]);	//시간 > 특정로봇 초기화
	//특정로봇 초기화
}

function searchEnvironmentRobots(searchKeyword){
	const sSearchKeyword = searchKeyword == undefined ? "" : searchKeyword;
	const sReleases = $("#targetReleases").val();
	if(sReleases == ""){
		//초기화 drawTargetRobotList()
	}
	else{
		var url = '/resrce/triggerUr/searchInstantStartEnvironmentRobots';
		const iReleases = parseInt(sReleases);
		let selectObj = lc_releases_data.find(function(releases) {
			  return releases.Id === iReleases;
			});
		
		var param = {
		   		searchKwrd: sSearchKeyword
		   		, searchEnvironmentId: selectObj.EnvironmentId
		    };
		callAsyncAjax(url, param, "searchEnvironmentRobotsCallback");
	}
}

function searchEnvironmentRobotsCallback(data){
	drawTargetRobotList(data.result.resultList);
}

function triggerUrInsertInstantStartCallback(data){
	mainModalCloseReload("divModal");
}


function bindEvent(){
	$(".jq_modal_close").on("click", function(e){
		mainModalClose("divModal");
	});
	
	$("#btnReleasesSearch").on("click", function(e){
		drawTargetRobotList([]);	//시간 > 특정로봇 초기화
		$("#timeParametaList tbody").html("");
		searchReleases($("#releasesSearchKwrd").val());
		
	});
	
	$("#targetReleases").on("change", function(e){
		const oThis = $(e.target);
		const selectVal = oThis.val();
		$("#queueReleases").val(selectVal);;
		
		
		lc_select_releases_id = selectVal;
			
		if(lc_select_certain_releases_id != selectVal){
			lc_select_certain_releases_id = selectVal;
			//로봇 검색
			searchEnvironmentRobots();
		}

		

		if(selectVal == ""){
			drawTargetRobotList([]);
			$("#timeParametaList tbody").html("<tr><td colspan='2'>이 버전에 대한 입력 파라미터가 정의되지 않았습니다.</td></tr>");
			$("#queueParametaList tbody").html("<tr><td colspan='2'>이 버전에 대한 입력 파라미터가 정의되지 않았습니다.</td></tr>");
			
		}
		else{
			let sTmp =  "";
			let selectObj = lc_releases_data.find(function(releases) {
				  return releases.Id === parseInt(selectVal);
				});
			
			
			const aInput = JSON.parse(selectObj.Arguments.Input);
			const iaInput = aInput == null  ? 0 : aInput.length;
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
			
			$("#timeParametaList tbody").html(sTmp);
			
			//Arguments 항목 정의
			//InputArguments: 항목별 입력 내역
			//InputArguments
			//let selectObj.InputArguments
			
		}
	});
	
	//시간 > 실행타겟 > 특정로봇 > 조회
	$("#btnSearchRobot").on("click", function(e){
		searchEnvironmentRobots($("#robotSearchKwrd").val());
	});
	
	$("#targetRobotListChkAll").on("click", function(e){
		const oThis = $(e.target);
		const bChk = oThis.is(":checked");

		$("input:checkbox[name=targetRobotId]").each(function() {
			this.checked  = bChk; //checked 처리
		});
	});
	
	$("#reg_target").on("click", function(e) {
		const oThis = $(e.target);
		if(oThis.hasClass("active")){
			return false;
		}
		const oParameter =  $("#reg_parameter");
		const sRegTargetCheckRadioVal = $("input[name='reg_target_checkRadio']:checked").val();
		oParameter.removeClass("active");
		$(".jq-time-parameter").hide();
		
		oThis.addClass("active");
		
		$(".jq-time-target").show()
		if(sRegTargetCheckRadioVal == "All"){
			$(".jq-time-target_sub2").hide();
			$(".jq-time-target_sub3").hide();
		}
		else if(sRegTargetCheckRadioVal == "Specific"){
			$(".jq-time-target_sub2").show();
			$(".jq-time-target_sub3").hide();
		}
		else if(sRegTargetCheckRadioVal == "JobsCount"){
			$(".jq-time-target_sub2").hide();
			$(".jq-time-target_sub3").show();
		}
		
	});
	
	$("input[name=reg_target_checkRadio]").on("click", function(e){
		const oThis = $(e.target);
		const sRegTargetCheckRadioVal = oThis.val();
		
		if(sRegTargetCheckRadioVal == "Specific"){
			const selectVal = $("#releasesSearchKwrd").val();
			$(".jq-time-target_sub2").show();
			$(".jq-time-target_sub3").hide();
			
			if(("" + lc_select_certain_releases_id) != ("" + lc_select_releases_id)){
				lc_select_certain_releases_id = lc_select_releases_id;
				if(sRegTargetCheckRadioVal == "Specific"){
					//로봇 검색
					console.log("로봇검색");
					searchEnvironmentRobots();
					
				}
			}
			console.log("lc_select_releases_id: " + lc_select_releases_id);
			console.log("lc_select_certain_releases_id: " + lc_select_certain_releases_id);
		}
		else if(sRegTargetCheckRadioVal == "JobsCount"){
			$(".jq-time-target_sub2").hide();
			$(".jq-time-target_sub3").show();
		}
	});
	
	$("#reg_parameter").on("click", function(e) {
		const oThis = $(e.target);
		if(oThis.hasClass("active")){
			return false;
		}
		
		const oTarget =  $("#reg_target");
		oTarget.removeClass("active");
		$(".jq-time-target").hide()
		$(".jq-time-target_sub2").hide();
		$(".jq-time-target_sub3").hide();
			
		oThis.addClass("active");
		
		$(".jq-time-parameter").show();
		
	});
	
	$("#startStrategy").on("focusout", function(e){
		console.log("processExecutCnt focusout")
		const oThis = $(e.target);
		const sThisVal = oThis.val();
		if(sThisVal == "" || parseInt(sThisVal.replace(/,/ ,"")) < 1 || parseInt(sThisVal.replace(/,/ ,"")) > 10000 ){
			e.stopPropagation();
			e.preventDefault();
			alert("값은 1~10000 사이여야 합니다.");
			oThis.focus();
		}
		return false;
	});
	
	$("#btnStart").on("click", function(e) {
		const oTargetReleases = $("#targetReleases");
		
		//프로세스 확인
		if($.trim(oTargetReleases.val()) == ""){
	        alert("프로세스를 선택해 주십시오.");
	        oTargetReleases.focus();
	        return false;
	    }
		
		//실행타겟 확인
		var aExecutorRobots = [];
		const sRegTargetCheckRadioVal = $("input[name='reg_target_checkRadio']:checked").val();
		if(sRegTargetCheckRadioVal == "Specific"){
			const aRargetRobotId =  $("input:checkbox[name=targetRobotId]:checked")
			if(aRargetRobotId.length < 1 ){
				alert("로봇이 선택되지 않았습니다.");
				return false;
			}
			else{
				aRargetRobotId.each(function() {
					aExecutorRobots.push(parseInt(this.value));
				});
			}
			iStartStrategy = 0;
		}
		else if(sRegTargetCheckRadioVal == "JobsCount"){
			const oStartStrategy = $("#startStrategy");
			const sTmpStr = oStartStrategy.val();
			iStartStrategy =  parseInt(sTmpStr.replace(/,/, ""));
		}
		else{
			alert("잘못된 접근");
		}
		
		//선택한 파라미터 시작
		const aInputArgumentsItem = $("#timeParametaList input:text[name=inputArgumentsItem]");
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
		//선택한 파라미터 종료
		
		//Release 정보 시작
		let oSelectReleases = lc_releases_data.find(function(releases) {
		  return releases.Id === parseInt(oTargetReleases.val());
		});
		
		//Release정보
		
		let oParams = {startInfo: {
				InputArguments: sInputArgumentsItemTmp
				, JobsCount: iStartStrategy
				, ReleaseKey: oSelectReleases.Key
				, RobotIds: aExecutorRobots
				, Strategy: sRegTargetCheckRadioVal
			}}
		callAsyncAjax("/resrce/triggerUr/triggerUrInsertInstantStart", oParams, "triggerUrInsertInstantStartCallback");
		
		//https://dwrpadev.dongwon.com/odata/Jobs/UiPath.Server.Configuration.OData.StartJobs
	});
}

function drawTargetRobotList(aData){
	console.log("function drawTargetRobotList")
	const iaData = aData.length;
	
	let sTmp = "";
	if(iaData > 0){
		for(let i = 0; i < iaData; i++){
			const oaData = aData[i];
			let sState = "";
			if(oaData.State == "Available"){
				sState = "(사용가능)";
			}
			else if(oaData.State == "Busy"){
				sState = "(사용중)";
			}
			else if(oaData.State == "Disconnected"){
				sState = "(연결끊김)";
			}
			else if(oaData.State == "Unresponsive"){
				sState = "(응답없음)";
			}
			
			sTmp += '<tr>';
			sTmp += '<td><input type="checkbox" name="targetRobotId" class="custom-checkbox" style="width:18px;height:18px;" value="'+ oaData.Robot.Id+'"></td>';
			sTmp += '<td>' + sState + oaData.Robot.Name + '</td>';
			sTmp += '<td>' + oaData.MachineName +'</td>';
			sTmp += '</tr>';
		}
	}
	else{
		sTmp = '<tr><td colspan="3">표시할 데이터가 없습니다.</td></tr>';
	}
	
	$("#targetRobotList tbody").html(sTmp);
}
</script>