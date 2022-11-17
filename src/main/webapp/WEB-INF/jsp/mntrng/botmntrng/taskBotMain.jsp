<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


                    
<!--  템플릿 바디 -->        
                    
<div id="BotMntrngMainDiv" class="container-fluid wrap">
  
    <div class="row">
        <div class="form-group col-md-12">
        
        
            <div class="card">
                <div class="card-header">
                    <form class="form-inline">
                        <div class="form-group col-md-6">
                            <label for="searchCmpnyCd" class="col-sm-2 col-form-label">회사</label>
                             <div class="col-sm-4 float-left">
                                <select id="searchCmpnyCd" class="form-control float-left"  style="min-width: 80px;width:100%;">
                                   <option value=""></option>
                               </select>                              
                            </div>   
                            <div class="col-sm-3 float-right">
                               <button type="button" id="btnSearch" class="btn btn-info float-center">조회</button> 
                            </div>
                        </div>
                        
                        
                        
                        
                    </form> 
                </div>
            </div>
            
            <div class="card">
                <div class="card-body2">
                <form class="form-inline">                     
                    <div class="form-group col-md-12">
                    
                        <div class="col-sm-6 float-left" style="min-width:430px">
                            <img src="/resources/images/dist/color_green.gif" alt="color_green" style="margin-right:5px;">성공 &nbsp;
                            <img src="/resources/images/dist/twinkle.gif" alt="twinkle"  style="margin-right:5px;">실행중 &nbsp;
                            <img src="/resources/images/dist/color_red.gif" alt="color_red" style="margin-right:5px;">실패 &nbsp;
                            <img src="/resources/images/dist/color_gray.gif" alt="color_gray"  style="margin-right:5px;">기타 &nbsp;
                            <img src="/resources/images/dist/color_blue.gif" alt="color_blue"  style="margin-right:5px;">예정 &nbsp;
                            <img src="/resources/images/dist/bg_gray.gif" alt="bg_gray" style="margin-right:5px;">오프라인  &nbsp;
                            <img src="/resources/images/dist/bg_white.gif" alt="bg_white" style="margin-right:5px;">온라인
                         </div>
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                        <div class="col-sm-4">
                            <!-- <h2 id="todayTitle" style="text-align:left;"></h2> -->                  
                            <div class="input-group date float-left" id="searhcStartDeDiv" data-target-input="nearest"style="min-width:150px;width:40%;margin-right:5px;text-align:left;">
                                <input type="text" id="searchStartDe" name="searchStartDe" class="form-control datetimepicker-input" data-target="#searhcStartDeDiv"/>
	                                <div class="input-group-append" data-target="#searhcStartDeDiv" data-toggle="datetimepicker">
	                                     <div class="input-group-text"><i class="fa fa-calendar"></i></div>
	                                </div>
                            </div>       
                        </div>
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        <div class="col-sm-2">
                        </div>
                    </div>

                    <div class="col-md-12">     
                         <div class="col-md-12 col-sm-6">       
                            <font id="textTime" class="float-left text-warning"  style="margin-right:50px;"></font>
                            <!-- <font class="float-right text-warning"  style="margin-right:50px;">※ 1분 단위로 정보가 갱신됩니다.</font> -->  
                            <button type="button" id="btnRenewal" class="btn btn-primary float-left" style="margin-right:50px;">재갱신</button>        
                            <button type="button" id="btnTodaySearch" class="btn btn-primary float-left">오늘 날짜</button>                                                                                                
                        </div>
                        
                        <div class="col-md-12 col-sm-6">       
                        </div>  
                    </div>
 
                        <div id="showSchdTable"  class="col-md-12 table-borderless2-wrap2" style="position:relative;top:0px"> 
                            <div class="p-0" style="text-overflow:ellipsis; overflow:hidden;display:block;">
                                <table id="botMntrngTable" class="table-borderless2 table-light2"  style="width:1440px;">                            
                                    <%-- <colgroup>
                                      <col width="100%">
                                    </colgroup> --%>
                                    
                                    <thead>                             
                                        <tr>
                                            <th style="text-align:left;">로봇명</th>
                                        </tr>
                                    </thead>
                                                           
                                    <tbody id='robotList'></tbody>
                                </table>
                            </div>

                            <!-- calc(100% - 148.5px) -->
                            <div class="table-borderless2-wrap" style="position:absolute;height:auto;top: 0px;left:160px;">
                            <!-- <div class="hline" style="top: 31px;left: calc(1.925% + 146px);"><img src="/resources/images/dist/hline.png" border=0 style="position:absolute;top: -4px;left:-4px;"></div> -->  

                                 <!-- 현재시간 표시부분 left값을 계산식으로 넣어주세요 calc(1.925% + 100px) 보라색 시간바-->
                                 <div class="hline" style="top: 31px;"><img src="/resources/images/dist/hline.png" border=0 style="position:absolute;top: -4px;left: -4px;"></div>     
                                     
                   
                                 <table id="timeTableGraph" class="table-borderless2  table-light2" style="width:1440px;height:20px;min-width:1440px;max-width:1440px;" >
                                      <thead>                             
                                          <tr>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">00</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">01</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">02</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">03</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">04</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">05</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">06</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">07</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">08</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">09</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">10</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">11</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">12</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">13</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">14</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">15</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">16</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">17</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">18</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">19</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">20</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">21</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">22</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">23</th>
                                          </tr>
                                      </thead>     
                                          
                                      <tbody id="tbodyList">                                                
                                      </tbody>
                                  </table>                       
     
                                <!-- TR오버시 레이어로 나올부분 -->
                                <div id="timeline24" class="timeline24" style="visibility:hidden;opacity: 0.9;position:relative;height:100%;bottom:calc(32px * 4);left: -1px;">                               
                                     <table class="table-light3" style="width:1440px;height:20px;min-width:1440px;max-width:1440px;" >
                                       <thead>                             
                                          <tr>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">00</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">01</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">02</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">03</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">04</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">05</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">06</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">07</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">08</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">09</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">10</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">11</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">12</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">13</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">14</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">15</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">16</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">17</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">18</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">19</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">20</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">21</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">22</th>
                                              <th colspan="2" style="width:60px;min-width:60px;max-width:60px;">23</th>
                                          </tr>
                                      </thead>
                                    </table>                            
                                </div>
                            </div> 
                        </div>          
                    </form>
                <div id="divSearchUser" class="modal fade" tabindex="-1" role="dialog"></div>
            </div>
        </div>
    </div>
</div>

<!--  템플릿 바디 끝 -->    

<!-- 로딩바  -->
<div class="dimmed" style="display:none"></div>
<div class="loading" style="display:none">
    <div class="loading-bar"><div></div><div></div><div></div><div></div></div>
    <span class="loading-text">데이터 로딩 중...</span>
</div>

<script>

    var processInfo = {};
    var triggerUrFutureSchd = {};
    var realFutureSchd = {};
    var triggerArFutureSchd = {};
    var detailProcessArray = {};
    var isToday = true;

    // 해당 페이지(Bot별 동작현황)를 최초로 Open하였을 때
    $(document.body).ready(function () {       
        var params = [];

        if("${txScreenAuthor.untenantAuthor}" == 'Y'){
            params.push({"id" : "searchCmpnyCd", "clsCd" : "0024", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
        }else{
            params.push({"id" : "searchCmpnyCd", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
        }
                
        requestCmmnCd(params);
        
        searchBotMntrngList();
    });
    
    

    
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent() {
        // 회사 조회
        $("#btnSearch").on("click",function(){
            $("#robotList").empty(); // 기존 내용 삭제  
            $("#tbodyList").empty(); // 기존 내용 삭제      
            searchBotMntrngList();
        });
        
        // 재갱신
        $("#btnRenewal").on("click",function(){
            $("#robotList").empty(); // 기존 내용 삭제  
            $("#tbodyList").empty(); // 기존 내용 삭제      
            searchBotMntrngList();
        });       
        
        // 오늘 날짜 검색
        $("#btnTodaySearch").on("click",function(){
            $("#searchStartDe").val(getFormYMD(new Date()));
            $("#robotList").empty(); // 기존 내용 삭제  
            $("#tbodyList").empty(); // 기존 내용 삭제      
            searchBotMntrngList();
        });       
        
        
       $(window).resize(function () {
        	setBarPositionFunc($('#timeTableGraph').innerWidth());       
        }); 
       
       $('#searhcStartDeDiv').datetimepicker({
           format: 'YYYY-MM-DD'
         , defaultDate: (new Date()).setDate((new Date()).getDate())
       });

       /* $("#searchStartDe").on("propertychange change", function() {
    	   var getDateForSearch = $("#searchStartDe").val().replace(/-/g, "");
           alert(getDateForSearch);
       }); */
       
       $('#searhcStartDeDiv').on('change.datetimepicker', function(e){ 
    	   var getDateForSearch = $("#searchStartDe").val().replace(/-/g, "");
    	   searchBotMntrngList(); 
    	});
       
       $('#searhcStartDeDiv').on('mouseover.datetimepicker', function(e){ 
    	   if(isToday) {
               $(".hline").hide(); // 보라색 바 숨기기
    	   }
        });
       
       $('#searhcStartDeDiv').on('mouseout.datetimepicker', function(e){ 
  	 
    	   if(isToday) {
               $(".hline").show(); // 보라색 바 보이기
           }
        });
    }
    
    function setBarPositionFunc(w) {
        var len = w / 24;
        var today = new Date();   
        today.setMinutes(today.getMinutes() - 1);
        
        // 총 24칸(=w)에서 1칸의 길이는 len이고, 60에서 len으로 길이가 변화되므로 그에 따라 '비율' 적용
        var pos = (today.getHours() * 60 + today.getMinutes()) * (len/60);
        $(".hline").css("left", pos + "px");  
    }
    
    // 시간 클릭
    function detailBotProcess(pivotTime, envrnId, botId) {
        // 로딩 시작
        $('.dimmed').css({ display: 'block' });
        $('.loading').css({ display: 'block' });
        $('.loading').addClass('show');

        appendDetailPopup("BotMntrngMainDiv", "/mntrng/botmntrng/taskBotProcess"); // 해당 시간대의 프로세스 모두 출력하는 PopUp 창
        $(".hline").hide(); // 보라색 바 숨기기
        
        var idx = 0;
        detailProcessArray = {};
        
        var processInfoLen = Object.keys(processInfo).length;
        for(var i=0; i<processInfoLen; i++) {
            if(processInfo[i].startLc <= pivotTime && pivotTime <= processInfo[i].endLc && botId == processInfo[i].botId) {
                detailProcessArray[idx++] = processInfo[i];
            }
        }
        
        var realFutureSchdLen = Object.keys(realFutureSchd).length;
        for(var i=0; i<realFutureSchdLen; i++) {
            if(isEqualBotIdOrEnvrnId(realFutureSchd[i].botId, botId, realFutureSchd[i].envrnId, envrnId) && Number(realFutureSchd[i].startLc) == Number(pivotTime)) {
                detailProcessArray[idx++] = realFutureSchd[i];
            }   
        } 
    }
    
    // 시간 클릭
    function detailFutureBotProcess(pivotTime, envrnId, botId) {

        $('.dimmed').css({ display: 'block' });
        $('.loading').css({ display: 'block' });
        $('.loading').addClass('show');

        appendDetailPopup("BotMntrngMainDiv", "/mntrng/botmntrng/taskBotProcess"); // 해당 시간대의 프로세스 모두 출력하는 PopUp 창
        $(".hline").hide(); // 보라색 바 숨기기
        
        var idx = 0;
        detailProcessArray = {};
        
        for(var i=0; i<Object.keys(realFutureSchd).length; i++) {
            if(isEqualBotIdOrEnvrnId(realFutureSchd[i].botId, botId, realFutureSchd[i].envrnId, envrnId) && Number(realFutureSchd[i].startLc) == Number(pivotTime)) {
                detailProcessArray[idx++] = realFutureSchd[i];
            }   
        }
    }

    // 시간막대 표시 bottom:calc(32px * 4);
    function showLayer(layerID, h) {
        document.all[layerID].style.visibility = "visible";
        document.all[layerID].style.bottom = "calc(26.5px *" + h +")";
        /* document.all[layerID].style.bottom = "calc(25px *" + (h+1) +")"; */
    }
    
    // 시간막대 숨기기 bottom:calc(32px * 4);
    function hideLayer(layerID) {
        document.all[layerID].style.visibility = "hidden";
    }
    
    // 날짜를 yyyy-MM-dd로 변환
    function getFormYMD(date) {
        
        var year = date.getFullYear();
        var month = (1 + date.getMonth());
        month = month >= 10 ? month :'0' + month;
        var day = date.getDate();
        day = day >= 10 ? day : '0' + day;

        return year + '-' + month + '-' + day;
    }
    
    // 날짜를 yyyy-MM-dd hh:mm:ss로 변환
    function getFormYMDHMS(date) {
        date = new Date(date);
        var year = date.getFullYear();
        var month = (1 + date.getMonth());
        month = month >= 10 ? month :'0' + month;
        var day = date.getDate();
        day = day >= 10 ? day : '0' + day;
        var hours = date.getHours();
        hours = hours >= 10 ? hours : '0' + hours;
        var minutes = date.getMinutes();
        minutes = minutes >= 10 ? minutes : '0' + minutes;
        var second = date.getSeconds();
        second = second >= 10 ? second : '0' + second;

        return year + '-' + month + '-' + day + ' ' + hours + ':' + minutes + ':' + second;
    }
    
    function barPosition() {
        var today = new Date();   
        today.setMinutes(today.getMinutes() - 1);
        // 지우지 말 것. Test 용
        //today = new Date(today.getFullYear(), today.getMonth(), today.getDate(), 20, 30, 00);     
        return today.getHours() * 60 + today.getMinutes();
    }
    
    function getNowMS() {
        // 현재 시간 return
        const today = new Date();   
        today.setMinutes(today.getMinutes() - 1);
 
        var H = today.getHours() >= 10 ? today.getHours() : "0" + today.getHours();
        var M = today.getMinutes() >= 10 ? today.getMinutes() : "0" + String(today.getMinutes());
        var S = today.getSeconds() >= 10? today.getSeconds() : "0" + today.getSeconds();
        
        H += "시 ";
        M += "분 ";
        
        return H + M + "기준(1분 단위로 갱신)";
    }

    function isEqualBotIdOrEnvrnId(futureBotId, BotId, futureEnvrnId, EnvrnId) {
        return (Number(futureBotId) == Number(BotId) || Number(futureEnvrnId) == Number(EnvrnId));
    }
    
    // 예정 스케줄 표시
    function makeBodyFutureTemplate(org, robotState, botId, envrnId, varTime) {        
        var templateBody = org;    
        var len = Object.keys(realFutureSchd).length;
        for(var i=0; i<len; i++) {
            if(isEqualBotIdOrEnvrnId(realFutureSchd[i].botId, botId, realFutureSchd[i].envrnId, envrnId) && Number(realFutureSchd[i].startLc) == Number(varTime)) {
                if(robotState == 2 || robotState == 3) templateBody = '<td style="width:30px;min-width:30px;max-width:30px;" class="color-blue off fill" onClick="detailFutureBotProcess(' + varTime + ', ' + envrnId + ', ' + botId + ')\"><div class="color-top"></div></a></td>';
                else templateBody = '<td style="width:30px;min-width:30px;max-width:30px;" class="color-blue fill" onClick="detailFutureBotProcess(' + varTime + ', ' + envrnId + ', ' + botId + ')\"><div class="color-top"></div></a></td>';
                break;
            }   
        }
        
        return templateBody;
    }
    
    // 실행, 실행중, 성공, 기타 막대기 표시 Return
    function makeBodyTemplate(processState, robotState, botId, envrnId, pivotTime) {        
        var templateBody = "";      

        if(processState == 1) {
            // 실패
            if(robotState == 2 || robotState == 3) templateBody = '<td style="width:30px;min-width:30px;max-width:30px;" class="color-red off fill" onClick="detailBotProcess(' + pivotTime + ', ' + envrnId + ', ' + botId + ')\"><a href="#"><div class="color-top"></div></a></td>';
            else templateBody = '<td style="width:30px;min-width:30px;max-width:30px;" class="color-red fill" onClick="detailBotProcess(' + pivotTime + ', ' + envrnId + ', ' + botId + ')\"><a href="#"><div class="color-top"></div></a></td>';                             
        }
        else if(processState == 2) {
            // 실행중
            if(robotState == 2 || robotState == 3) templateBody = '<td style="width:30px;min-width:30px;max-width:30px;" class="twinkle off fill" onClick="detailBotProcess(' + pivotTime + ', ' + envrnId + ', ' + botId + ')\"><a href="#"><div class="color-top"></div></a></td>';
            else templateBody = '<td style="width:30px;min-width:30px;max-width:30px;" class="twinkle fill" onClick="detailBotProcess(' + pivotTime + ', '+ envrnId + ', ' + botId + ')\"><a href="#"><div class="color-top"></div></a></td>';
        }
        else if(processState == 3) {
            // 성공                               
            if(robotState == 2 || robotState == 3) templateBody = '<td style="width:30px;min-width:30px;max-width:30px;" class="color-green off fill" onClick="detailBotProcess(' + pivotTime + ', '+ envrnId + ', ' + botId + ')\"><a href="#"><div class="color-top"></div></a></td>';
            else templateBody = '<td style="width:30px;min-width:30px;max-width:30px;" class="color-green fill" onClick="detailBotProcess(' + pivotTime + ', '+ envrnId + ', ' + botId + ')\"><a href="#"><div class="color-top"></div></a></td>';
        }
        else if(processState == 4) {
            // 기타
            if(robotState == 2 || robotState == 3) templateBody = '<td style="width:30px;min-width:30px;max-width:30px;" class="color-gray off fill" onClick="detailBotProcess(' + pivotTime + ', '+ envrnId + ', ' + botId + ')\"><a href="#"><div class="color-top"></div></a></td>';
            else templateBody = '<td style="width:30px;min-width:30px;max-width:30px;" class="color-gray fill" onClick="detailBotProcess(' + pivotTime + ', '+ envrnId + ', ' + botId + ')\"><a href="#"><div class="color-top"></div></a></td>';
        }
        return templateBody;
    }
    
    /*
     * 테이블 초기화
     * @param
     * @return
     */
    function drawTable(data){
        var params = {}; // 오늘 날짜에 수행된 모든 프로세스들
        var robotStateList = {}; // 로봇 리스트

        // 데이터 존재 여부에 따른 조건 처리 
        if (data != null && data != undefined) {      
            if (data.result != null && data.result.countCmpny != null) {
                if(!data.result.countCmpny) {
                    alert("Portal 미등록 회사이므로, 접근할 수 없습니다.");
                    window.history.back();
                    return false;
                }
            }  
            
            if (data.result != null && data.result.robotList != null) {
                robotStateList = data.result.robotList;
            }   
            
            if (data.result != null && data.result.resultList != null) {
                params = data.result.resultList;
                processInfo = data.result.resultList;
            }
            
            if (data.result != null && data.result.processSchedulesList != null) {
                triggerUrFutureSchd = data.result.processSchedulesList;
            }
            
            if (data.result != null && data.result.selectTriggerArScheduleList != null) {
                triggerArFutureSchd = data.result.selectTriggerArScheduleList;
            }
            
            if(data.result.processSchedulesList != null && data.result.selectTriggerArScheduleList != null) {
                realFutureSchd = triggerUrFutureSchd.concat(triggerArFutureSchd);
            }
            else if (data.result.processSchedulesList == null && data.result.selectTriggerArScheduleList != null) {
                realFutureSchd = triggerArFutureSchd;
            }
            else if (data.result.processSchedulesList != null && data.result.selectTriggerArScheduleList == null) {
                realFutureSchd = triggerUrFutureSchd;
            }
        }        

        //$("#todayTitle").html(getFormYMD(new Date()));

        // calc(1.925% + 146px)
        //$(".hline").css("left", "calc(1.925% + " + elapsedTimeSeconds() + "px)");
        $(".hline").css("left", barPosition() + "px"); // 현재 시간을 보라색 바로 표시(위치 설정)
        
        var todayYMD = getFormYMD(new Date()).replace(/-/g, "");
        var searchDateYMD = $("#searchStartDe").val().replace(/-/g, "");
        
        if(todayYMD == searchDateYMD) {
        	// 오늘 날짜라면
        	// 시간 표시      
            $("#textTime").html(getNowMS());
            $(".hline").show(); // 오늘 날짜라면 보라색 바 보이게
            isToday = true;
        }
        else {
        	$("#textTime").html('오늘 날짜가 아닙니다.');
        	$(".hline").hide(); // 오늘 날짜가 아니면 보라색 바 숨김
        	isToday = false;
        }
        
        var robotListTemplate = "";
        var tbody = "";

        var robotListLen = Object.keys(robotStateList).length;
        for(var i=0; i<robotListLen; i++) {         
            // 로봇 이름
            robotListTemplate += '<tr><th style="border-right:none;width:100%;height:26px;font-size:small;align:left;font-weight:bold;display:block;text-decoration:none;text-overflow:ellipsis;white-space:nowrap;overflow:hidden;" title="' + robotStateList[i].name + '">' + robotStateList[i].name + '</th></tr>';

            tbody += "<tr>"; // 막대 표시 또는 빈 칸 표시
            
            //tbody += '<td> style="width:100px;height:20px;font-size:small;align:left;font-weight:bold;display: block;text-decoration:none;text-overflow:ellipsis;white-space: nowrap;    overflow: hidden;" title="' + robotStateList[i].name + '">' + robotStateList[i].name + '</td>';
            
            if(i >= 3) {
                tbody += '<tr onmouseout="javascript:hideLayer(\'timeline24\');" onmouseover="javascript:showLayer(\'timeline24\', ' + (robotStateList.length - i + 1) + ')">';
            }
            
            // 한 칸 씩 탐색
            // 00 ~ 23을 각 시간 당 2칸씩 분리하여 총 1 ~ 48로 표시
            // 예 : 00 -> 1 2, 01 -> 3, 4, ..., 23 -> 47, 48
            for(var varTime=1; varTime<=48; varTime++) {    
                var template = "";
                
                // Disconnected 또는 Unresponsive
                if(robotStateList[i].robotState == 2 || robotStateList[i].robotState == 3) template = "<td style='width:30px;min-width:30px;max-width:30px;' class='off'></td>";    
                else template = "<td style='width:30px;min-width:30px;max-width:30px;'></td>";  
                
                var isExistUrSchd = false;

                var paramsLen = Object.keys(params).length;
                for(var j=0; j<paramsLen; j++) {
                    if(robotStateList[i].robotId == params[j].botId) {
                    	isExistUrSchd = true;
                        template = makeBodyFutureTemplate(template, robotStateList[i].robotState, params[j].botId, params[j].envrnId, varTime);                       
                        if(params[j].startLc <= varTime && varTime <= params[j].endLc) {   
                        	template = makeBodyTemplate(params[j].sttus, robotStateList[i].robotState, params[j].botId, params[j].envrnId, varTime);
                            break;
                        }
                    }     
                }
                
                if(!isExistUrSchd) {
                	var realFutureSchdLen = Object.keys(realFutureSchd).length;
                    for(var j=0; j<realFutureSchdLen; j++) {
                        if(robotStateList[i].robotId == realFutureSchd[j].botId) { // || robotStateList[i].envrnId == realFutureSchd[j].envrnId) {
                            template = makeBodyFutureTemplate(template, robotStateList[i].robotState, realFutureSchd[j].botId, realFutureSchd[j].envrnId, varTime); 
                            break;
                        }     
                    }
                }   

               tbody += template;
            }
    
            var tempParams = {};
            var paramsLen = Object.keys(params).length;
            for(var j=0, idx=0; j<paramsLen; j++) {
                if(robotStateList[i].robotId != params[j].botId) {
                    tempParams[idx++] = params[j];
                }     
            }
            
            params = tempParams;
            
            // IE에서는 Object.values()) 지원 X
            /* params = Object.values(params).filter(function(item, index) { 
                return item.botId != robotStateList[i].robotId;
            }); */
                        
            tbody += "</tr>";
        }
        
        $("#robotList").html(robotListTemplate); 
        $("#tbodyList").html(tbody);

        // 로딩 끝
        $('.dimmed').css({ display: 'none' });
        $('.loading').css({ display: 'none' });
        $('.loading').removeClass('show');
    }
    
    function searchBotMntrngList() {
        $("#robotList").empty(); // 기존 내용 삭제  
        $("#tbodyList").empty(); // 기존 내용 삭제
        processInfo = {};
        detailProcessArray = {};
        triggerUrFutureSchd = {};
        triggerArFutureSchd = {};
        realFutureSchd = {};
        
        var url = '/mntrng/botmntrng/getBotMntrngList';
        
        var param = { 
                  cmpnycd    : $("#searchCmpnyCd").val()     
                , searchDate : $("#searchStartDe").val().replace(/-/g, "")
                , searchYMD  : $("#searchStartDe").val() + ' 00:00:00'
        };
        
        callAsyncAjax(url, param, "drawTable");

        // 로딩 시작
        $('.dimmed').css({ display: 'block' });
        $('.loading').css({ display: 'block' });
        $('.loading').addClass('show');
    }
    
    // 팝업창 닫기
    function closePOP() {
        $(".over").remove();
        //searchBotMntrngList();
        $(".hline").show(); // 보라색바 보이기
    }

</script>