<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!--  템플릿 바디 -->        
 <div class="card card-primary" id="unmanagtErrorRegDiv">                   
    <div class="card-header" alt="과제 >과제운영">
        <h3 class="card-title">정기실행</h3>
    </div>
    <div class="card-body">
        <div class="row"  style="min-height:616px;">
            <div class="col-md-12">
                <form class="form-inline" id="Routineform"> 
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">과제코드</label>
                        <div class="col-sm-8">
                            <input type="text" id="taskCd" class="form-control" style="width:70%;margin-right: 3px;" value="H001" readonly>
                         </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">과제명</label>
                        <div class="col-sm-8">
                            <input type="text" id="taskNm" class="form-control" style="width:70%;margin-right: 3px;" readonly>
                        </div>
                    </div>
                    
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">프로세스코드</label>
                        <div class="col-sm-8">
                            <input type="text" id="processCd" class="form-control" style="width:70%;margin-right: 3px;" value="H00100" readonly>
                            <input type="hidden" id="botNoList" value="">
                         </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">프로세스명</label>
                        <div class="col-sm-8">
                            <input type="text" id="processNm" class="form-control" style="width:70%;margin-right: 3px;" readonly>
                        </div>
                    </div>                                      
                     
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">프로세스아이디</label>
                        <div class="col-sm-8">
                            <input type="text" id="processNo" class="form-control" style="width:70%;margin-right: 3px;" value="" readonly>
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">예상소요시간</label>
                        <div class="col-sm-8 float-left">
                            <input type="text" id="executTm" class="form-control float-left" style="width:30%;margin-right: 3px;" value="" readonly>시간
                         </div>
                    </div>

                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">InputArguments</label>
                        <div class="col-sm-8">
                            <input type="text" id="inputArguments" class="form-control" style="width:70%;margin-right: 3px;" value=""  maxlength="4000">
                        </div>
                    </div>
	          	    
                    <div class="form-group col-md-6"  id="schtextDivText">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">정기실행계획</label>
                        <div class="col-sm-8">
                            <input type="text" id="schduleText" class="form-control" style="width:70%;margin-right: 3px;" value="" readonly>
                        </div>
                    </div>

                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">실행예약로봇</label>
                        <div class="col-sm-8 float-left">
                            <select id="botNo" class="form-control float-left" style="width:90%;margin-right: 10px;"></select>
                        </div>
                    </div>
                    
                    <div class="form-group col-md-6">
	          	        <label for="" class="col-sm-4 col-form-label"></label>
                        <div class="col-sm-8 float-right" >
                           <button type="button" class="btn btn-primary float-right" id="popCloseBtn">닫기</button>
<c:if test="${txScreenAuthor.wrtngAuthor eq 'Y'}">                               
                           <button type="button" id="savePlanBtn"class="btn btn-outline-primary float-right" style="margin-left: 5px">정기실행저장</button>
	                       <button type="button" id="planPop"class="btn btn-outline-primary float-right" style="margin-left: 1px;">정기실행POP</button>
</c:if>
	                    </div>
	                </div>
	                
                    <div class="col-md-12 m-3"></div>
	                <div class="form-group col-md-12">
		                <div class="col-sm-9"><h5 class="text-success float-left">⊙ 로봇예약정보</h5></div>
	                        <div class="col-sm-3 float-right"> 
	                              <div class="input-group date  float-right" id="startDeDiv" data-target-input="nearest"style="width:50%; min-width:130px;margin: 0 0 2px 0;">
	                                  <input type="text" id="startDe" name="startDe" class="form-control datetimepicker-input" data-target="#startDeDiv"value=""/>
	                                  <div class="input-group-append" data-target="#startDeDiv" data-toggle="datetimepicker">
	                                      <div class="input-group-text"><i class="fa fa-calendar"></i></div>
	                                  </div>
	                              </div>
	                          </div>
	                    </div>  
                    </div>                
	               
                    <div class="form-group col-md-12  table-wrap">
	                    <table class="table-borderless table-light" id="schduleList"  >
                            <colgroup></colgroup>
                            <thead></thead>
                            <tbody></tbody>
                        </table>
                  </div>
                </form>
                <div id="divSearchUser" class="modal fade" tabindex="-1" role="dialog"></div>
                <div id="divModal" class="modal fade jq_inModal" tabindex="-1" role="dialog"></div>
                
            </div>
           
        </div>
    </div>
</div>
<script>

var LC_SCHDULE_DATA = null;   //정기 실행 계획

$(document).ready(function() {
    //이벤트 바인딩
    pageInit();
    bindEvent();
});


function pageInit(){
	
};

/*
 * 이벤트 바인딩
 * @param
 * @return
 */
function bindEvent() {
    
    $("#popCloseBtn").on("click", function() {
        closePop();
    });
    
    //정기실행계획 Popup
    $("#planPop").on("click", function() {
       // var params = {cronType1 : $('#cronType1').val(), cronType2 : $('#cronType2').val(), cronStartDe : $('#cronStartDe').val(), cronEndDe : $('#cronEndDe').val(), cronData : $('#cronData').val()};
        appendDetailPopupType2("divModal", "/task/manage/taskManageRoutineExecutplanPop", "popTaskManageRoutineExecutplanCallback", LC_SCHDULE_DATA);
    });
        
    //정기실행계획 저장
    $("#savePlanBtn").on("click", function() {
        var botInfo = $("#botNo").val();
        var arr = botInfo.split(",,");
        if(botInfo == "" || botInfo == null){
            alert("실행 로봇을 선택 하세요.");
        }else{
            var processCd = $("#processCd").val();
            var inputArguments = $("#inputArguments").val();    
            var cmpnyCd = arr[0];
            var botNo = arr[1];
            var releasesId = arr[2];
            var releasesKey = arr[3];
            var botType = arr[5];  // TEST시 ATTENDED 1, Unattended 2, Studio 3
            var releasesName = arr[6];
            var processKey = arr[7];        
            var params = { 
                           processCd : processCd
                         , botNo : botNo
                         , cmpnyCd : cmpnyCd
                         , releasesId : releasesId
                         , releasesKey : releasesKey
                         , botType : botType
                         , releasesName : releasesName
                         , processKey : processKey
                         , inputArguments : inputArguments
                         , schduleData : LC_SCHDULE_DATA
                         }
            callAsyncAjax("/task/manage/saveRoutinePlan", params, "saveRoutinePlanCallback");
        }
    });
        
    function saveRoutinePlanCallback(data){
    	alert("저장 하였습니다.");
    	searchList()
    }
    
    $('#startDeDiv').datetimepicker({
        format: 'YYYY-MM-DD', defaultDate: (new Date())
    });
    
    var oldVal = $("#startDe").val();
    $("#startDe").on("propertychange change keyup paste input", function() {
        var currentVal = $(this).val();
        if(currentVal == oldVal) {
            return;
        }
        oldVal = currentVal;
        searchList()
    });   
   
    $("#botNo").change( function() {
        var botNo = $("#botNo").val();
        var arr = botNo.split(",,");
        $("#inputArguments").val(arr[4]);
   });
   
}
    
    
//-- 정기실행계획 관련 START
function popTaskManageRoutineExecutplanCallback(data){
    drawExecutplan(data);
}

function returnDrawExecutplan(data){
    $("#routineExecutPlan").val(data["schduleText"]);
    LC_SCHDULE_DATA = data;
}
    

function searchList() {
    var url = '/task/manage/getTaskManageRoutine';
    var startDe = $("#startDe").val();
    startDe = startDe.substr(0,10);
    startDe = startDe.replaceAll('.', '')
    startDe = startDe.replaceAll('-', '')
    var param = { startDe : startDe, processCd : $("#processCd").val()}; 
    callAsyncAjax(url, param, "popTaskRoutineDrawData2");
}


/*
 * 과제운영 > 정기실행 : Data표시
 * @param
 * @return
 */
function popTaskRoutineDrawData2(data){
    //데이터 화면에 출력
    var aResult = data.result
    var params = [];
    var bott = aResult.botcountlist;
    
    for (var sKey in aResult) {
        if(sKey == "cmpnyCd"){
            params.push({"id" : "cmpnyCd", "clsCd" : "0024", "disable" : "N", "selectValue": aResult[sKey]} );
        }
        else if(sKey == "fqCd"){
            params.push({"id" : "fqCd", "clsCd" : "0017", "selectValue": aResult[sKey]});    //빈도
        }
        else if(sKey == "jobClsCd"){
            params.push({"id" : "jobClsCd", "clsCd" : "0040", "selectValue": aResult[sKey]}); // 업무분류
        }
        else if(sKey == "processCnt"){
            //프로세스가 등록 되어 있으면 삭제 불가
            if(parseInt(aResult[sKey]) > 0 ){
                $("#deleteBtn").hide();
            }
        }
        else if(sKey == "botcountlist"){
        	
            tmp = '<option value="">선택</option>';
            for(var i=0; i < aResult.botcountlist.length; i++){
                tmp += '<option value="'+bott[i].cmpnyCd+',,'+bott[i].botNo+',,'+bott[i].releasesId+',,'+bott[i].releasesKey+',,'+bott[i].inputarguments+',,'+bott[i].botType+',,'+bott[i].releasesName+',,'+bott[i].processKey+'">'+bott[i].botNo+' : '+bott[i].releasesName+'</option>"';
            }
            $("#botNo").html(tmp);
            
        	$("#schduleList colgroup col").remove();
        	$("#schduleList thead tr").remove();
        	$("#schduleList tbody tr").remove();
           // col group 비율 설정
           var strrr = "";
           strrr += '<col width="10%">';
           for(var m=0; m < aResult.botcountlist.length; m++){
                   strrr += '<col width="*"></th>';
           }
           $("#schduleList colgroup").append(strrr);
           
           // thead 숫자에 따른 컬럼 설정
           var strr = "";
           var botNoList = "";
           strr += '<tr>';
           strr += '<th>Time</th>';
           for(var l=0; l < aResult.botcountlist.length; l++){
               strr += '<th>BOT '+aResult.botcountlist[l].botNo+'</th>';
               botNoList += aResult.botcountlist[l].botNo+",,";
           }
           strr += '<tr>';
           $("#botNoList").val(botNoList);
           $("#schduleList thead").append(strr);
           
           // 시간별 / 봇 별 항목 ID 설정 그리기
           var str = "";
           for(var i = 0; i < aResult.timelistcnt ; i++){  //144
               str += '<tr>';
               str += '    <td>'+ aResult.timelist[i].timeLine +'</td>';
               for(var z=0; z < aResult.botcountlist.length; z++ ){ //11
                   str += '    <td id="'+aResult.botcountlist[z].botNo+'_'+(i+1)+'"></td>';
               }
               str += '</tr>';
           }    
           $("#schduleList tbody").append(str);
       }
       else{
           $("#" + sKey).val(aResult[sKey])
       }
    }
    
    // 봇의 스케쥴 시간을 불러와 봇+시간값 입력과 class 변경
    for(var i = 0; i < aResult.timelistcnt ; i++){
        var ida = aResult.reservlist[i].botNo+"_"+aResult.reservlist[i].timeNo;
        $("#"+ida).attr('class', 'color small');
        $("#"+ida).html(aResult.reservlist[i].processCd);
    }
    requestCmmnCd(params);
}





</script>


            

