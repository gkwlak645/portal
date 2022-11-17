<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!--  템플릿 바디 -->
 <div class="card card-primary" id="unmanagtErrorRegDiv">
    <div class="card-header" alt="과제 >과제운영">
        <h3 class="card-title">예약실행</h3>
    </div>
    <div class="card-body">
        <div class="row" style="min-height:616px;">
            <div class="col-md-12">
                <form class="form-inline" id="Reserveform"> 
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">과제코드</label>
                        <div class="col-sm-8">
                            <input type="text" id="taskCd" class="form-control" style="width:70%;margin-right: 3px;" value="" readonly>
                            <input type="hidden" id="botcnt">
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
                            <input type="text" id="processCd" class="form-control" style="width:70%;margin-right: 3px;" value="" readonly>
                         </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">프로세스명</label>
                        <div class="col-sm-8">
                            <input type="text" id="processNm" class="form-control" style="width:70%;margin-right: 3px;" readonly>
                        </div>
                    </div>                                      
                     
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">실행예약시간</label>
                        <div class="col-sm-8">
                            <input type="text" id="schduleText" class="form-control" style="width:70%;margin-right: 3px;" value="" readonly>
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">예상소요시간</label>
                        <div class="col-sm-8 float-left">
                            <input type="text" id="executTm" class="form-control float-left" style="width:30%;margin-right: 3px;" value="" readonly>시간                            
                         </div>
                    </div>
                    
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">실행예약로봇</label>
                        
                        <div class="col-sm-8 float-left">
                            <select id="botNo" class="form-control float-left" style="width:90%;margin-right: 10px;"></select>
                        </div>
                    </div>
                    
                    <div class="form-group col-md-6">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">InputArguments</label>
                        <div class="col-sm-8">
                            <input type="text" id="inputArguments" class="form-control" style="width:60%;margin-right: 3px;" value=""  maxlength="4000">
                            <button type="button" class="btn btn-primary float-right" id="popCloseBtn">닫기</button>
<c:if test="${txScreenAuthor.wrtngAuthor eq 'Y'}">                                
                            <button type="button" id="immediateExecutBtn"class="btn btn-outline-primary float-right" style="margin: 0;">즉시실행</button>
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
                    
                    <div class="form-group col-md-12 table-wrap ">
                        <table class="table-borderless table-light" id="schduleList" >
                            <colgroup></colgroup>
                            <thead></thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </form>
                <div class="float-right py-sm-2"></div>
                <div id="divSearchUser" class="modal fade" tabindex="-1" role="dialog"></div>
                <div id="divModal" class="modal fade jq_inModal" tabindex="-1" role="dialog"></div>
            </div>
        </div>
    </div>

<script>

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
    
    $("#immediateExecutBtn").on("click", function() { // 즉시실행 Start
        
        // 프로세스 정보 취합 후 send ajax
        var botInfo = $("#botNo").val();
        var arr = botInfo.split(",,");
        
        if(botInfo == "" || botInfo == null){
            alert("Bot을 선택 하세요.");
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
            var url = '/task/manage/taskManageReserveImmediateExecution';
            var param = { 
                    processCd:processCd
                  , inputArguments:inputArguments
                  , cmpnyCd:cmpnyCd
                  , botNo:botNo
                  , releasesId:releasesId
                  , releasesKey:releasesKey
                  , botType:botType
                  , releasesName:releasesName
                  , processKey:processKey
                  }; 
            callAsyncAjax(url, param, "immExeSend");
        }
    });
    
    $("#botNo").change( function() {
    	 var botNo = $("#botNo").val();
    	 var arr = botNo.split(",,");
    	 $("#inputArguments").val(arr[4]);
    });
    
    $("#schduleList").click(function(){
    	var botInfo = $("#botNo").val();
    	if(botInfo == "" || botInfo == null){
    		alert("실행 로봇을 선택 하세요.");
    	}else{
	        var e = window.event,
	        btn = e.target || e.srcElement;
	        var tdVal = btn.id;
	        var gbn = "";
	        var ckPrc = $("#"+tdVal).html()
	        if ($("#"+tdVal).attr( 'class' ) == 'color small'){
	        	gbn = "D"
	        }else{
	        	gbn = "I"
	        }
	        if (ckPrc != $("#processCd").val() && gbn == "D"){
	            alert("다른 Process에서 등록 한 일정은 삭제 할 수 없습니다.:"+ckPrc+":"+$("#processCd").val());
	            return false;
	        }
	        var brr = tdVal.split("_");
	        var botNo =  brr[0];
	        var timeNo =  brr[1];
	        var processCd = $("#processCd").val();
	        var executTm = $("#executTm").val();
		    var startDe = $("#startDe").val();
		    startDe = startDe.substr(0,10);
		    startDe = startDe.replaceAll('.', '');
		    startDe = startDe.replaceAll('-', '');
		    var url = '/task/manage/getTaskManageReserveCheck';
		    var param = { startDe:startDe, processCd:processCd, botNo:botNo, timeNo:timeNo, executTm:executTm, gbn:gbn}; 
		    callAsyncAjax(url, param, "popTaskReserveChk");
    	}
	    
    });


    //  function bindEvent()에 아래의 내용 입력해 주세요.
    $('#startDeDiv').datetimepicker({
        format: 'YYYY-MM-DD',
        defaultDate: (new Date())
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
}



function searchList() {
    var url = '/task/manage/getTaskManageReserve';
    var startDe = $("#startDe").val();
    startDe = startDe.substr(0,10);
    startDe = startDe.replaceAll('.', '');
    startDe = startDe.replaceAll('-', '');
    var param = { startDe : startDe, processCd : $("#processCd").val()}; 
    callAsyncAjax(url, param, "popTaskReserveDrawData2");
}


function popTaskReserveChk(data){

    var botInfo = $("#botNo").val();
    var arr = botInfo.split(",,");
    
    var processCd = $("#processCd").val();
    var inputArguments = $("#inputArguments").val();    
    var cmpnyCd = arr[0];
    var botNo = arr[1];
    var releasesId = arr[2];
    var releasesKey = arr[3];
    var botType = arr[5];  // TEST시 ATTENDED 1, Unattended 2, Studio 3
    var releasesName = arr[6];
    var processKey = arr[7];
	if(data.result.cnt != 0 && data.result.params.gbn == "I"){
        if(confirm('실행 시간과 일정이  중복됩니다. 그래도 등록 하시겠습니까?')) {
            var url = '/task/manage/taskManageReserveSave';
            var par = data.result.params
            var param = {
            		       startDe:par.startDe
            		     , processCd:processCd
            		     , botNo:botNo
            		     , timeNo:par.timeNo
            		     , executTm:par.executTm
            		     , gbn:par.gbn
            		     , cmpnyCd:cmpnyCd
            		     , releasesId:releasesId
            		     , releasesKey:releasesKey
            		     , botType:botType
            		     , releasesName:releasesName
            		     , processKey:processKey
            		     , inputArguments:inputArguments
                         }; 
            callAsyncAjax(url, param, "popTaskReserveSave");
        }
	}else{
		
		var gbn = data.result.params.gbn;
		if(gbn == "D"){
		     if(confirm('삭제 하시겠습니까?')) {
		            var url = '/task/manage/taskManageReserveSave';
		            var par = data.result.params
		            var param = { startDe:par.startDe, processCd:par.processCd, botNo:par.botNo, timeNo:par.timeNo, executTm:par.executTm,gbn:gbn}; 
		            callAsyncAjax(url, param, "popTaskReserveSave");
		        }
		}else{
		     if(confirm('등록 하시겠습니까?')) {
		            var url = '/task/manage/taskManageReserveSave';
		            var par = data.result.params
		            var param = {
	                           startDe:par.startDe
	                         , processCd:processCd
	                         , botNo:botNo
	                         , timeNo:par.timeNo
	                         , executTm:par.executTm
	                         , gbn:par.gbn
	                         , cmpnyCd:cmpnyCd
	                         , releasesId:releasesId
	                         , releasesKey:releasesKey
	                         , botType:botType
	                         , releasesName:releasesName
	                         , processKey:processKey
	                         , inputArguments:inputArguments
	                         }; 
		            callAsyncAjax(url, param, "popTaskReserveSave");
	         }
		}
	}
}

function popTaskReserveSave(data){
	alert(data.result.msg);
	searchList()
}



/*
 * 과제운영 > 예약실행 : Data표시
 * @param
 * @return
 */
function popTaskReserveDrawData2(data){
    //데이터 화면에 출력
    var aResult = data.result
    var params = [];
    var tmp = ''; // Bot list select box
    var bott = aResult.botcountlist;
    
    tmp = '<option value="">선택</option>';
    for(var i=0; i < aResult.botcountlist.length; i++){
    	tmp += '<option value="'+bott[i].cmpnyCd+',,'+bott[i].botNo+',,'+bott[i].releasesId+',,'+bott[i].releasesKey+',,'+bott[i].inputarguments+',,'+bott[i].botType+',,'+bott[i].releasesName+',,'+bott[i].processKey+'">'+bott[i].botNo+' : '+bott[i].releasesName+'</option>"';
    }
    $("#botNo").html(tmp);
    
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
           strr += '<tr>';
           strr += '<th>Time</th>';
           for(var l=0; l < aResult.botcountlist.length; l++){
               strr += '<th>BOT '+aResult.botcountlist[l].botNo+'</th>';
           }
           strr += '<tr>';
           $("#schduleList thead").append(strr);
           
           // 시간별 / 봇 별 항목 ID 설정 그리기
           var str = "";
           for(var i = 0; i < aResult.timelistcnt ; i++){  //144
               str += '<tr>';
               str += '    <td>'+ aResult.timelist[i].timeLine +'</td>';
               for(var z=0; z < aResult.botcountlist.length; z++ ){ //11
                   str += '    <td id="'+aResult.botcountlist[z].botNo+'_'+(i+1)+'" value="'+aResult.botcountlist[z].botNo+'_'+(i+1)+'">';
                   str += '    </td>';
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

function immExeSend(data){
    alert(data.result.msg);
}






    
    
    
</script>
