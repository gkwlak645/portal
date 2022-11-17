<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div id="unmanagtErrorMainDiv" class="container-fluid wrap">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <form class="form-inline">
                        <div class="form-group col-md-6">
                            <label class="col-sm-2 col-form-label">회사</label>
                            <div class="col-sm-10">
                               <select class="form-control" id="searchCmpnyCd" style="width:60%;">
                                    <option></option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-md-6">
                             <label class="col-sm-2 col-form-label">날짜</label>
                             <div class="col-sm-10">
                                <select class="form-control cus_dataing-year" id="searchYear" style="margin-right:5px;min-width:74px;width:25%"></select>년 &nbsp; 
                                 <!-- <select class="form-control cus_dataing-month" id="searchMonth" style="margin-right:5px;min-width:58px;width:20%">
                                     <option value="">선택</option>
                                 </select>월  -->
                                 <button type="button" id="btnSearch" class="btn btn-info">조회</button>
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
                    <div class="cus_table-wrap">
                        <table class="cus_table2" id="preforPlanInputTable"></table>
                    </div>
                    <div class="float-right">
                    <c:if test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
                        <button type="button" class="btn btn-primary" id="btnSave">저장</button>
                    </c:if>
                    </div>
                </div>               
            </div>            
        </div>        
    </div>
</div>
<script type="text/javascript">


function pageInit() {
	
    //년도 정보 추가
    getToYear();
    //cmmn_makeYear("searchYear", getToYear());
    //월 정보 추가
    //cmmn_makeMonth("searchMonth");
    
    var params = [];
    if("${txScreenAuthor.untenantAuthor}" == 'Y'){
        params.push({"id" : "searchCmpnyCd", "clsCd" : "0024"});    //회사
    }else{
        params.push({"id" : "searchCmpnyCd", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
    }

    requestCmmnCd(params);
    
    seachPreforPlan();
};

function bindEvent(){
	//검색
    $('#btnSearch').on('click', function() {
    	seachPreforPlan();
    });
	
    //저장
    $('#btnSave').on('click', function() {
    	updatePreforPlan();
    });
    
}


//현재 년도 가져오기
/* function getToYear(){
	//시작 기준 년도
    var stdYear = 1999;
	//올해 년도
	var date = new Date()
    var year = date.getFullYear();
	var nextYear = date.getFullYear();
	//return (올해년도 - 시작 기준 년도) +1
    return (year - stdYear)+1;
} */


//현재 년도 가져오기
function getToYear(){
    var date = new Date()
    var getYear = date.getFullYear();
    $('#searchYear').html("<option value="+getYear+">"+getYear+"</option><option value="+(getYear+1)+">"+(getYear+1)+"</option>")
}




//실적게획입력 list 검색
function seachPreforPlan(){
	   var url = "/stats/perforPlanInput/getPreforPlanList";
	   var param = {
		     yyyy      : $('#searchYear').val() 
		  // , mm        : $('#searchMonth').val() > 9 ? $('#searchMonth').val() : "0"+$('#searchMonth').val()
		   , cmpnyCd   : $('#searchCmpnyCd').val()
	   }
	   
	   callSyncAjax(url, param, "callBackSeachPreforPlan");   
}

function callBackSeachPreforPlan(data){

	var tableTmp = "";
	
	var cmpnyCdList    = data.result.cmpnyCdList;
	var preforPlan     = data.result.preforPlanList;
	
	var cmpnyCnt = cmpnyCdList.length;
	var month = 12;

	tableTmp += '<colgroup>';
	tableTmp += '<col style="width: 15%">';
	tableTmp += '<col style="width: *">';
	tableTmp += '<col style="width: 20%">';
	tableTmp += '<col style="width: 20%">';
	tableTmp += '<col style="width: 20%">';
	tableTmp += '</colgroup>';
	tableTmp += '<thead>';
	tableTmp += '<tr>';
	tableTmp += '<th scope="col" rowspan="2" colspan="2" style="min-width:400px;">구분</th>';
	tableTmp += '<th scope="col" rowspan="2">'+$('#searchYear').val()+'년 연간목표</th>';

	//thead
	for(var j=0; j < month; j++){
        tableTmp += '<th scope="col" id="month1" colspan="2">'+(j+1)+'월</th>';
    }
	
	tableTmp += '</tr>';
	tableTmp += '<tr>';
	
	for(var j=0; j < month; j++){
        tableTmp += '<th scope="col">과제계획</th>';
        tableTmp += '<th scope="col">PI</th>';
    }
	
	tableTmp += '</tr>';
	tableTmp += '</thead>';
	
	tableTmp += '<tbody>';
	
    for(var i=0; i< cmpnyCnt; i++){
    	
    	//회사 db 등록여부
    	var isCmpny = false;
    	var cmpnyCd = cmpnyCdList[i].cmpnyCd;
    	var cmpnyNm = cmpnyCdList[i].cmpnyNm;
    	var preforPlanList = preforPlan[cmpnyCd];
    	var preforPlanInputList
    	//연간목표  과제개수 tot
        var tcTot = 0;
        //연간목표  절감시간 tot
        var timeTot = 0;
        //연간목표  과제당 절감시간 tot
        var tcTimeTot =0;
    	
    	if(preforPlanList != null && preforPlanList.length > 0){ 
    		isCmpny = true;
    		preforPlanInputList = preforPlanList;
    	}
    	
        //회사 db에 등록 되어있을 경우    	
    	if(isCmpny){
    		for(var j=0; j < month; j++){
    			var tcPlan     = preforPlanInputList[j].tcPlan;
                var tcPi       = preforPlanInputList[j].tcPi;
                var timePlan   = preforPlanInputList[j].timePlan;
                var timePi     = preforPlanInputList[j].timePi;
    			
                //연간목표  과제개수 tot
    			tcTot   = tcTot + (tcPlan + tcPi);
    			//연간목표  절감시간 tot
    			timeTot = timeTot + (timePlan + timePi);
    		}
    		
    		tcTimeTot = tcTot / timeTot;
            isFinite(tcTimeTot) ? tcTimeTot = tcTimeTot.toFixed(2) : tcTimeTot = 0
    		
            tcTimeTot       == 0  ? tcTimeTot = ""    : tcTimeTot = addCommas(tcTimeTot);
    		tcTot           == 0  ? tcTot     = ""    : tcTot     = addCommas(tcTot);
    		timeTot         == 0  ? timeTot   = ""    : timeTot   = addCommas(timeTot);
    	}
    	
    	var tcTmp = "";
    	tcTmp += '<tr>';
    	tcTmp += '<th scope="row" rowspan="3" name="cmpnyCd'+i+'" id="'+cmpnyCd+'">'+cmpnyNm+'</th>';
    	tcTmp += '<th>과제개수</th>';
	    	if(isCmpny){
	    		tcTmp += '<td><input type="text" name="tcTot" class="form-control" style="min-width:120px;" value="'+tcTot+'" disabled numberOnly></td>';
	    	}else{
	    		tcTmp += '<td><input type="text" name="tcTot" class="form-control" style="min-width:120px;" disabled numberOnly></td>';
	    	}
	    	
	    	for(var j=0; j < month; j++){
	    		if(isCmpny){
                    var tcPlan     = 0; preforPlanInputList[j].tcPlan == 0  ? tcPlan = "" : tcPlan = addCommas(preforPlanInputList[j].tcPlan);
                    var tcPi       = 0; preforPlanInputList[j].tcPi   == 0  ? tcPi   = "" : tcPi   = addCommas(preforPlanInputList[j].tcPi);
	    			
	    			tcTmp += '<td><input type="text" name="tcPlan" class="form-control" style="min-width:120px;" value="'+tcPlan+'" numberOnly></td>';
	                tcTmp += '<td><input type="text" name="tcPi" class="form-control" style="min-width:120px;" value="'+tcPi+'" numberOnly></td>';
	            }else{
	            	tcTmp += '<td><input type="text" name="tcPlan" class="form-control" style="min-width:120px;" numberOnly></td>';
	                tcTmp += '<td><input type="text" name="tcPi" class="form-control" style="min-width:120px;" numberOnly></td>';
	            }
	    	}
	    tcTmp += '</tr>';
	    
	    tableTmp += tcTmp;
	    
	    var timeTmp = "";
	    timeTmp += '<tr>';
	    timeTmp += '<th scope="row">절감시간</th>';
	    
            if(isCmpny){
            	timeTmp += '<td><input type="text" name="timeTot" class="form-control" style="min-width:120px;" value="'+timeTot+'" disabled numberOnly></td>';
            }else{
            	timeTmp += '<td><input type="text" name="timeTot" class="form-control" style="min-width:120px;" disabled numberOnly></td>';
            }
            
            for(var j=0; j < month; j++){
                if(isCmpny){
                	var timePlan   = 0; preforPlanInputList[j].timePlan == 0 ? timePlan = "" : timePlan = addCommas(preforPlanInputList[j].timePlan);
                	var timePi     = 0; preforPlanInputList[j].timePi   == 0 ? timePi   = "" : timePi   = addCommas(preforPlanInputList[j].timePi);
                	
                	timeTmp += '<td><input type="text" name="timePlan" class="form-control" style="min-width:120px;" value="'+timePlan+'" numberOnly></td>';
                    timeTmp += '<td><input type="text" name="timePi" class="form-control" style="min-width:120px;" value="'+timePi+'" numberOnly></td>';
                }else{
                	timeTmp += '<td><input type="text" name="timePlan" class="form-control" style="min-width:120px;" numberOnly></td>';
                    timeTmp += '<td><input type="text" name="timePi" class="form-control" style="min-width:120px;" numberOnly></td>';
                }
            }
            
       timeTmp += '</tr>';
       
       tableTmp += timeTmp;
       
       var totTmp = "";
       totTmp += '<tr>';
       totTmp += '<th scope="row">과제당 절감시간</th>';
           if(isCmpny){
        	   totTmp += '<td><input type="text" name="tcTimeTot" class="form-control" style="min-width:150px;" value="'+tcTimeTot+'" disabled numberOnly></td>';
           }else{
        	   totTmp += '<td><input type="text" name="tcTimeTot" class="form-control" style="min-width:150px;" disabled numberOnly></td>';
           }
           
           for(var j=0; j < month; j++){
               if(isCmpny){
            	   var planTcTime = 0, piTcTime = 0;
            	   var tcPlan     = preforPlanInputList[j].tcPlan;
                   var tcPi       = preforPlanInputList[j].tcPi;
                   var timePlan   = preforPlanInputList[j].timePlan;
                   var timePi     = preforPlanInputList[j].timePi;
                   
                   planTcTime = tcPlan / timePlan;
                   piTcTime   = tcPi / timePi;
                   
                   isFinite(planTcTime) ? planTcTime = planTcTime.toFixed(2) : planTcTime = 0
                   isFinite(piTcTime)   ? piTcTime   = piTcTime.toFixed(2)   : piTcTime = 0
                   
                   planTcTime == 0 ? planTcTime = "" : planTcTime = addCommas(planTcTime);
                   piTcTime   == 0 ? piTcTime   = "" : piTcTime   = addCommas(piTcTime);
            	   
            	   totTmp += '<td><input type="text" name="planTcTime" class="form-control" style="min-width:120px;" value="'+planTcTime+'" disabled numberOnly></td>';
                   totTmp += '<td><input type="text" name="piTcTime" class="form-control" style="min-width:120px;" value="'+piTcTime+'" disabled numberOnly></td>';
               }else{
            	   totTmp += '<td><input type="text" name="planTcTime" class="form-control" style="min-width:120px;" disabled numberOnly></td>';
                   totTmp += '<td><input type="text" name="piTcTime" class="form-control" style="min-width:120px;" disabled numberOnly></td>';
               }
           }
       totTmp += '</tr>';
       
       tableTmp += totTmp;
       
    }
	
    tableTmp += '</tbody>';
	
	
	$('#preforPlanInputTable').html(tableTmp);

	
	//과제개수 변경시 연간 목표 change
    $('input[name^=tc]').on('keyup blur', function() {
        //연간 목표-과제개수 change
        var tcTot       = 0;
        var timeTot     = 0;
        var tcTimeTot   = 0;
        
        var tctr = $(this).closest('tr').find('input[name^=tc]').not('input[name=tcTot]');
        
        tctr.each(function(){
            tcTot = tcTot + Number(removeCommas($(this).val()));
        });
        
        tcTot == 0 ? tcTot = "" : tcTot = addCommas(tcTot);
        
        $(this).closest('tr').find('input[name=tcTot]').val(tcTot);
        
        //연간 목표-과제당 절감시간 change
        timeTot = $(this).closest('tr').next().find('input[name=timeTot]').val();
        
        tcTimeTot = Number(removeCommas(tcTot)) / Number(removeCommas(timeTot));
        
        isFinite(tcTimeTot) ? tcTimeTot = tcTimeTot.toFixed(2) : tcTimeTot = 0
        
        tcTimeTot == 0 ? tcTimeTot = "" : tcTimeTot = addCommas(tcTimeTot);
        		
        $(this).closest('tr').next().next().find('input[name=tcTimeTot]').val(tcTimeTot);
        

        //과제당 절감시간 - 과제계획 change
        var tcTimePlanTot   = 0;
        var tc      = $(this).val();
        var tcName  = $(this).attr('name');
        var tcEq    = $(this).closest('td').prevAll().length-1; 
        
        var timeName, totName;
        if(tcName.indexOf("Plan") > 0){
            timeName = "timePlan"
            totName  = "planTcTime";
        }else if(tcName.indexOf("Pi") > 0){
            timeName = "timePi" 
            totName  = "piTcTime";
        }else{
            timeName = ""    
            totName  = "";
        }
        
        var time    = $(this).closest('tr').next().children(":eq("+tcEq+")").find('input[name='+timeName+']').val();
        
        tcTimePlanTot = Number(removeCommas(tc)) / Number(removeCommas(time)); 
        isFinite(tcTimePlanTot) ? tcTimePlanTot = tcTimePlanTot.toFixed(2) : tcTimePlanTot = 0
        tcTimePlanTot == 0 ? tcTimePlanTot = "" : tcTimePlanTot = addCommas(tcTimePlanTot);
        
        $(this).closest('tr').next().next().children(":eq("+tcEq+")").find('input[name='+totName+']').val(tcTimePlanTot);
    });
    
    
    //절감시간 변경시 연간 목표 change
    $('input[name^=time]').on('keyup blur', function() {
        //연간 목표-절감시간 change
        var tcTot = 0;
        var timeTot = 0;
        var tcTimeTot = 0;
        
        var timetr = $(this).closest('tr').find('input[name^=time]').not('input[name=timeTot]');

        timetr.each(function(){
            timeTot = timeTot + Number(removeCommas($(this).val()));
        });
        
        timeTot == 0 ? timeTot = "" : timeTot = addCommas(timeTot);

        $(this).closest('tr').find('input[name=timeTot]').val(timeTot);
        
        //연간 목표-과제당 절감시간 change
        tcTot = $(this).closest('tr').prev().find('input[name=tcTot]').val();
        
        tcTimeTot = Number(removeCommas(tcTot)) / Number(removeCommas(timeTot));
        
        isFinite(tcTimeTot) ? tcTimeTot = tcTimeTot.toFixed(2) : tcTimeTot = 0
        		
        tcTimeTot == 0 ? tcTimeTot = "" : tcTimeTot = addCommas(tcTimeTot);
        
        $(this).closest('tr').next().find('input[name=tcTimeTot]').val(tcTimeTot);
        
        
        //과제당 절감시간 - PI change
        var tcTimePiTot = 0;
        var time      = $(this).val();
        var timeName  = $(this).attr('name');
        var timeEq    = $(this).closest('td').prevAll().length;
        
        var tcName, totName;
        if(timeName.indexOf("Plan") > 0){
            tcName   = "tcPlan"
            totName  = "planTcTime";
        }else if(timeName.indexOf("Pi") > 0){
            tcName   = "tcPi" 
            totName  = "piTcTime";
        }else{
            tcName   = ""    
            totName  = "";
        }

        var tc    = $(this).closest('tr').prev().children(":eq("+(timeEq+1)+")").find('input[name='+tcName+']').val();
        
        tcTimePiTot = Number(removeCommas(tc)) / Number(removeCommas(time)); 
        
        isFinite(tcTimePiTot) ? tcTimePiTot = tcTimePiTot.toFixed(2) : tcTimePiTot = 0
        
        tcTimePiTot == 0 ? tcTimePiTot = "" : tcTimePiTot = addCommas(tcTimePiTot);
        
        $(this).closest('tr').next().children(":eq("+timeEq+")").find('input[name='+totName+']').val(tcTimePiTot);
    });
}


//실적계획 저장
function updatePreforPlan(){
	
	var cmpnyCnt     = $('th[name^=cmpnyCd]').length;
	var monthCnt     = $('th[id^=month]').length;
	var tcPlanList   = [];
    var tcPiList     = [];
    var timePlanList = [];
    var timePiList   = [];
    var cnt          = 0;
    var listCnt      = 0;
	var year         = $('#searchYear').val();
	
	listCnt = cmpnyCnt * monthCnt;
	
	for(var i =0; i < listCnt; i++){
		tcPlanList[i]    = $('input[name=tcPlan]')[i].value;
	    tcPiList[i]      = $('input[name=tcPi]')[i].value;
	    timePlanList[i]  = $('input[name=timePlan]')[i].value;
	    timePiList[i]    = $('input[name=timePi]')[i].value;
	}
	
	var preforPlanList = new Array();

	for(var i =0; i<cmpnyCnt; i++){
		
		var cmpnyCd = $('th[name=cmpnyCd'+i+']').attr('id');

		for(var j = 0; j<monthCnt; j++){
			
			var preforPlanData = {yyyymm : "" ,cmpnyCd : "" ,tcPlan : "" ,tcPi : "" ,timePlan : "" ,timePi : ""};
			var mm             = j+1 > 9 ? String(j+1) : "0"+String((j+1));
			
			preforPlanData.yyyymm    = year +  mm;
			preforPlanData.cmpnyCd   = cmpnyCd;
			preforPlanData.tcPlan    = removeCommas(tcPlanList[cnt]);
			preforPlanData.tcPi      = removeCommas(tcPiList[cnt]);
			preforPlanData.timePlan  = removeCommas(timePlanList[cnt]);
			preforPlanData.timePi    = removeCommas(timePiList[cnt]);
			
			cnt ++;
			preforPlanList.push(preforPlanData);
		}
	}
	
	var url = "";
	var param = {
		preforPlanList : preforPlanList	
	}
	callSyncAjax("/stats/perforPlanInput/updatePreforPlan", param, "callBackUpdatePreforPlan");
}


function callBackUpdatePreforPlan(){
	alert('저장되었습니다.');
	seachPreforPlan();
}


</script>


