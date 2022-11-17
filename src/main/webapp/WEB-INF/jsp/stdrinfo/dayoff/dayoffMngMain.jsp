<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>



<div id="dayoffMainDiv" class="container-fluid wrap">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <form name="searchForm" class="form-inline">
                        <div class="form-group row  col-sm-6">
                            <label for="licenseKey" class="col-sm-2 col-form-label">회사</label>
                            <div class="col-sm-10">
                                <select class="form-control" id="cmpnyCd" style="width:37%;min-width:120px;"></select>
                            </div>
                        </div>
                        <!-- <div class="form-group row  col-sm-6">
                            <label for="activeId" class="col-sm-2 col-form-label">날짜</label>
                            <div class="col-sm-10 float-left">
                                <select class="form-control float-left" id="year" style="width:37%;min-width:120px;"></select>
                                <input type="button" id="btnSearch" class="btn btn-info  float-left" value="조회" /> 
                            </div>
                        </div> -->
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-body wrapper">
                        <div class="col-sm-12">
                            <!-- Main content -->
                            <section class="content">
                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-md-3" style="padding:15px 15px 15px 0;">
                                            <button type="button" id="btnAdd" class="btn btn-secondary float-right">+ 추가</button> 
                                             <div id="scNameDiv" class="scNameDiv_wrap">
                                                  <div>
                                                      <select class="form-control" id="" ></select>
                                                      <input type="text" class="form-control" placeholder="내용입력"/>
                                                  </div>
                                             </div>
                                        </div>
                                        <div class="col-md-9">
                                            <div id="calendar"></div>
                                        </div>
                                    </div>
                                </div>
                            </section>
                        </div>                                  
                        <div class="float-right p-2">
                            <button type="button" class="btn btn-primary" id="scDel" data-toggle="modal" data-target="#modal-lg3">삭제</button>
                            <button type="button" class="btn btn-primary" id="btnSave">저장</button>
                            &nbsp;
                        </div>
                    </div>
                <aside class="control-sidebar control-sidebar-dark"></aside>
            </div>
        </div>
    </div>
</div>

<div class="modal fade-dept" id="modal-lg3">
   <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header"></div>
            <div class="modal-body">
                <span id="deleteSj">해당 휴일을 삭제하시겠습니까?</span>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" id="btnDelete">삭제</button>
            </div>
        </div>
    </div>
</div>



<script>

//저장 될 휴무일 날짜
var ExcludedDates = [];
//달력 표시 될 휴무일 날짜
var showDates = [];

//선택한 cmpnyCd
var cmpnyCd;
//선택한 휴일 id
var selectId = 0;
//선택한 휴일 명
var selectNm;

var getYear  = "";
    
    /*
     * 페이지 초기화
     * @param
     * @return
     */
    function pageInit() {
        
        var params = [];
        if("${txScreenAuthor.untenantAuthor}" == 'Y'){
             params.push({"id" : "cmpnyCd", "clsCd" : "0024"});    //회사
        }else{
            params.push({"id" : "cmpnyCd", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
            cmpnyCd = "${sessionUserInfo.txCmpnyCd}" == "W" ? "" : "${sessionUserInfo.txCmpnyCd}";
        }
        requestCmmnCd(params);
        
        //휴일조회
        searchDayOff();
    };
    

    function bindEvent() {
        
        //회사 변경시 휴일 select 호출
        $("#cmpnyCd").on("change", function(e){
            cmpnyCd = $("#cmpnyCd").val();
            searchDayOff();
        });
        
        //휴일 추가 버튼
        $("#btnAdd").on("click", function() {
            if($("#cmpnyCd").val() == null || $("#cmpnyCd").val() == ""){
               alert("회사를 선택해주세요.");
            }else{
            	
            	selectId = 0;
                selectNm = "";
            	
               var tmp = "";
               tmp += "<div id='dayOffNewDiv' class='active'>";
               tmp += "<input type='text' class='form-control' id='newDayOffCmpnyCd' value="+$("#cmpnyCd option:checked").text()+" maxlength='150' disabled/>";
               tmp += "<input type='text' class='form-control' id='newDayOffNm' maxlength='150' placeholder='이름은 최대 150자를 사용하며 고유해야 합니다.'/>";
               tmp += "</div>";
                
               $('#scNameDiv').prepend(tmp);
               
               //추가 외에 활성화된 class remove
               $("div[id^=dayOffDiv]").removeClass('active');
                
               //+추가 버튼 disabled,true
               $('#btnAdd').attr("disabled",true);
               calendarReset();
            }
            
        });

        //삭제 버튼 이벤트
        $("#btnDelete").on("click", function() {
        	if($('#dayOffNewDiv').length > 0){
        		$("#modal-lg3").modal("toggle");
                if(confirm('일정에 저장되지 않은 변경 내용이 있습니다. 취소하시겠습니까?')){
                	$('#dayOffNewDiv').remove();
                    $('#btnAdd').attr("disabled",false);
                    calendarReset();
                }
            }else if(Number(selectId) == 0) {
                alert("휴일을 선택하세요.");
                $("#modal-lg3").modal("toggle");
            }else {
                deleteDayoff();
            }
        });
        
        //저장 버튼 이벤트
        $("#btnSave").on("click", function() {
            if($("#cmpnyCd").val() == null || $("#cmpnyCd").val() == ""){
                alert("회사를 선택해주세요.");
            }else if($('#dayOffNewDiv').length > 0 && Number(selectId) == 0 && ($('#newDayOffNm').val() == null || $('#newDayOffNm').val() == "") ){
                alert("등록할 휴일명을 입력해주세요.");
                $('#newDayOffNm').focus();
            }else{
                if(Number(selectId) != 0) {
                    //선택한 ID 있는 경우 -> 수정
                     editDayoff();
                } else { 
                    //선택한 ID 없는 경우 -> 등록
                    registDayoff();
                }
            }
        });
        

    }
    
    //검색
    function searchDayOff(){
        var url="/stdrinfo/dayoff/getoffDayList"
        var param = {
              "cmpnyCd" : cmpnyCd 
            //, "year"    : $("#year").val()
        }
        callSyncAjax(url, param, "callBackGetoffDayList");
    }
    
    function callBackGetoffDayList(data){
        var dayOffList = data.result.resultList;
        
        var tmp = "";
        
        $.each(dayOffList, function(idx, item) {
            tmp += "<div id='dayOffDiv"+idx+"'>";
            tmp += "<input type='text' class='form-control' id='"+item.cmpnyCd+"' name='dayOffCmpny' value="+item.cmpnyName+" disabled/>";
            tmp += "<input type='text' class='form-control' id='"+item.Id+"' name='dayOffName' value='"+item.Name+"' maxlength='150' placeholder='이름은 최대 150자를 사용하며 고유해야 합니다.'/>";
            tmp += "</div>";
        }); 
        
        $('#scNameDiv').html(tmp);
        
        //휴일 선택시 일자 불러오기
        $("div[id^=dayOffDiv]").on("click", function(e){
            if($('#dayOffNewDiv').length > 0){
                if(confirm('일정에 저장되지 않은 변경 내용이 있습니다. 취소하시겠습니까?')){
                    $('#dayOffNewDiv').remove();
                    $('#btnAdd').attr("disabled",false);
                    calendarReset();
                }
            }else{
                cmpnyCd  = $(this).find('input[name=dayOffCmpny]').attr('id');

                if(cmpnyCd == null || cmpnyCd == "" || cmpnyCd == "undefined"){
                	alert('휴일 조회가 되지 않습니다.');
                }else{
                	 selectId = $(this).find('input[name=dayOffName]').attr('id');
                     selectNm = $(this).find('input[name=dayOffName]').val();
                     
                     //활성화 
                     $("div[id^=dayOffDiv]").removeClass('active');
                     $(this).addClass('active');
                     
                     getoffDay(cmpnyCd,selectId);
                     $('#deleteSj').html(selectNm+'을(를) 삭제하시겠습니까?');
                }
            }
        });
        
        //달력 초기화
        calendarReset();
    }
    

    // 휴무일 생성
    function registDayoff() {
        
        //+추가 버튼 disabled,false
        $('#btnAdd').attr("disabled",false);
        
        var url = "/stdrinfo/dayoff/registDayoff";
        
        //{"Name":"test1111","TimeZoneId":"Korea Standard Time","ExcludedDates":["2020-10-30T00:00:00Z","2020-10-31T00:00:00Z"]}
        var param = {"Name":"","TimeZoneId":"Korea Standard Time","ExcludedDates":[]};
        
        param.cmpnyCd         =   $("#cmpnyCd").val()
        param.Name            =   $('#newDayOffNm').val() 
        param.ExcludedDates   =   ExcludedDates
        
        callAsyncAjax(url, param, "callBackDayOff");
    } 

    
    
    // 휴무일 수정
    function editDayoff() {
        var url = "/stdrinfo/dayoff/editDayoff";
        
        var param = {"Id":0,"Name":"","TimeZoneId":"Korea Standard Time","ExcludedDates":[]};
        
        param.cmpnyCd         =   cmpnyCd
        param.Id              =   Number(selectId)
        param.Name            =   selectNm
        param.ExcludedDates   =   ExcludedDates

        callSyncAjax(url, param, "callBackDayOff");
    }
    
   
    // 휴무일 불러오기
    function getoffDay(dayOffCmpnyCd,dayOffId) {
        var url = "/stdrinfo/dayoff/getoffDay";
        var param = {
                 cmpnyCd : dayOffCmpnyCd    
                ,Id      : dayOffId
        };

        callSyncAjax(url, param, "callBackGetoffDay");
    }
    
    
    function callBackGetoffDay(data){
        
        ExcludedDates = [];
        showDates = [];
        
        ExcludedDates = data.result.resultList.ExcludedDates;
        
        $.each(ExcludedDates, function(idx, item) {
            var data = {};
            var date = item.split("T00:00:00Z");
            data.title = date[0]
            data.start = date[0]
            data.end = date[0]
            showDates.push(data);
        });
        
        $('#calendar').html("");    
        calendar15();
        
    }
    
     
    // 휴무일 삭제
    function deleteDayoff(){
        var url = "/stdrinfo/dayoff/deleteDayOff";
        var param = {
              "cmpnyCd" : cmpnyCd
            , "Id"      : Number(selectId)
        }

        callSyncAjax(url, param, "callBackDeleteDayOff");
    }
    
    
    //휴일 등록/수정 후 콜백
    function callBackDayOff(data){
        alert('저장되었습니다.');
        searchDayOff();
        var dayOffData = data.result;
        selectId = dayOffData.Id;
        getoffDay(cmpnyCd,selectId);
    }
    
    
    //휴일 삭제후 콜백
    function callBackDeleteDayOff(data){
        alert('삭제되었습니다.');
        $("#modal-lg3").modal("toggle");
        searchDayOff();   
    }
    
    
    //휴일 초기화
    function calendarReset(){
        //선택 값 전부 reset
        selectId = 0;
        selectNm = "";
        ExcludedDates = [];
        showDates = [];
        $('#calendar').html("");
        calendar15();
    }
    
    
    
  //full calendar setting
     function  calendar15() {
         
         var Calendar = FullCalendar.Calendar;
    
         var containerEl = document.getElementById('external-events');
         var checkbox = document.getElementById('drop-remove');
         var calendarEl = document.getElementById('calendar');
         
    
          var calendar = new Calendar(calendarEl, {
              dayRender: function() {},
              selectable: true,
              dateClick: function(info) {
                  
                  if(cmpnyCd == null || cmpnyCd == ""){
                      alert('회사를 선택하세요.');
                  }else if(0 >= $('#dayOffNewDiv').length && (selectId == null || Number(selectId) == 0)){
                      alert('휴일을 추가 또는 선택하세요.');
                  }else{
                      
                      if(ExcludedDates.includes(info.dateStr + "T00:00:00Z")){     
                          
                          var removeIdx;
                          removeIdx = ExcludedDates. indexOf(info.dateStr + "T00:00:00Z");
                          ExcludedDates.splice(removeIdx, 1);

                          var removeIdx;
                           $.each(showDates, function(idx, item) { 
                               if(item.start.includes(info.dateStr)){
                                   removeIdx = idx;
                               }
                           });
                           
                           showDates.splice(removeIdx, 1);
                           
                      }else{ 
                          ExcludedDates.push(info.dateStr + "T00:00:00Z");    
                          var data = {};
                          data.title = info.dateStr
                          data.start = info.dateStr
                          data.end = info.dateStr
                          showDates.push(data); 
                      }
                      
                      console.log(ExcludedDates);
                      console.log(showDates);
                      
                      $('#calendar').html("");            
                      calendar15(); 
                      
                  }
                  
               },
               select: function(info) {},
               plugins: [ 'bootstrap', 'interaction', 'dayGrid', 'timeGrid' ],
               header    : {
                   left  : 'prev,next',
                   center: 'title',
                   right :''
               },
               'themeSystem': 'bootstrap',
              events    : showDates,
              editable  : false
              
         }); 
          
         calendar.render();
     } 

</script>