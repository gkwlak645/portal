<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!--  템플릿 바디 -->
<div class="modal-dialog modal-lg">
    <div class="modal-content">
        <div class="modal-header">
            <h4 class="modal-title">정기실행 계획</h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="modal-body" >
            <div class="row" style="min-height:560px;">
            <div class="col-md-12">
                <form class="form-inline" id="unmanagtErrorDetail">
                    <input type="hidden" id="schduleNo" value="1">                    
                    <div class="form-group col-md-12">
                        <div class="col-sm-2 py-sm-1  float-left"><h5 class="text-success float-left">⊙ 실행기간</h5></div>
                        <div class="col-sm-10  float-left">                            
                           <div class="input-group date float-left" id="startDeDiv1" data-target-input="nearest"style="width:32%; max-width:220px;min-width:150px;margin: 0 5px 2px 0;"> 
                                <input type="text" id="startDe1" name="startDe1" class="form-control datetimepicker-input" data-target="#startDeDiv1" value="" maxlength="10"/>
                                <div class="input-group-append" data-target="#startDeDiv1" data-toggle="datetimepicker">
                                    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                </div>
                           </div>
                           <div class="input-group date float-left" id="endDeDiv" data-target-input="nearest"style="width:32%; max-width:220px;min-width:150px;margin: 0 5px 2px 0;"> 
                                &nbsp;~ &nbsp; <input type="text" id="endDe" name="endDe" class="form-control datetimepicker-input" data-target="#endDeDiv" value="" maxlength="10"/>
                                <div class="input-group-append" data-target="#endDeDiv" data-toggle="datetimepicker">
                                    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                </div>
                           </div>
                         <div class="col-sm-2 float-left"></div>
                     </div>                  
                    
                     <div class="form-group col-md-12" style="display:inline;">                        
                        <div class="col-sm-2 py-sm-1  float-left"><label for="sourcUpdtNm" class="col-form-label"><input type="radio" name="schduleType1" class="custom-radio" style="width:18px;height:18px;" value="1">  분</label></div>
                        <div class="col-sm-10 py-sm-2 float-left">
                            <div class="input-group">
                                                    매<input type="text" id="everyMinute" class="form-control float-left" style="max-width:90px;margin-right: 3px;" maxlength="2" numberOnly>분 간격
                                                    
<!--                                                     <select class="form-control" id="everyMinute" style="width: 60%; max-width: 90px;"> -->
<!--                                                     <option value="">선택</option> -->
<!--                                                     <option value="00">00</option> -->
<!--                                                     <option value="10">10</option> -->
<!--                                                     <option value="20">20</option> -->
<!--                                                     <option value="30">30</option> -->
<!--                                                     <option value="40">40</option> -->
<!--                                                     <option value="50">50</option> -->
<!--                                                     </select>분 간격 -->
                            </div>
                                                
                        </div>
                        
                        <div class="col-md-12 line-top py-sm-2 float-left"></div> <!-- 사이점선 -->
                        <div class="col-sm-2 py-sm-1  float-left"><label for="sourcUpdtNm" class="col-form-label"><input type="radio" name="schduleType1" class="custom-radio" style="width:18px;height:18px;" value="2">  시간</label></div>
                        <div class="col-sm-10 py-sm-2 float-left">
                            <div class="input-group">
	                                                 매 <input type="text" id="everyHour" class="form-control float-left" style="max-width:90px;margin-right: 3px;" maxlength="2" numberOnly>시간 간격                        
	                            &nbsp;<input type="text" id="everyHourMinute" class="form-control float-left" style="max-width:90px;margin-right: 3px;" maxlength="2" numberOnly>분
<!-- 	                            <select class="form-control" id="everyHourMinute" style="width: 60%; max-width: 90px;"> -->
<!--                                                     <option value="">선택</option> -->
<!--                                                     <option value="00">00</option> -->
<!--                                                     <option value="10">10</option> -->
<!--                                                     <option value="20">20</option> -->
<!--                                                     <option value="30">30</option> -->
<!--                                                     <option value="40">40</option> -->
<!--                                                     <option value="50">50</option> -->
<!--                                                     </select>분 -->
                            </div> 
                        </div>
                        
                        <div class="col-md-12 line-top py-sm-2 float-left"></div> <!-- 사이점선 -->
                        <div class="col-sm-2 py-sm-1 float-left"><label for="sourcUpdtNm" class="col-form-label"><input type="radio" name="schduleType1" class="custom-radio" style="width:18px;height:18px;" value="3">  매일</label></div>
                        <div class="col-sm-10 py-sm-2 float-left">
                            <div class="input-group">
	                            <input type="text" id="everyDayHour" class="form-control float-left" style="max-width:90px;margin-right: 3px;" maxlength="2" numberOnly>시&nbsp;
	                            <input type="text" id="everyDayMinute" class="form-control float-left" style="max-width:90px;margin-right: 3px;" maxlength="2" numberOnly>분
<!-- 	                            <select class="form-control" id="everyDayMinute" style="width: 60%; max-width: 90px;"> -->
<!--                                                     <option value="">선택</option> -->
<!--                                                     <option value="00">00</option> -->
<!--                                                     <option value="10">10</option> -->
<!--                                                     <option value="20">20</option> -->
<!--                                                     <option value="30">30</option> -->
<!--                                                     <option value="40">40</option> -->
<!--                                                     <option value="50">50</option> -->
<!--                                                     </select>분 -->
                            </div>
                        </div>
                        
                        <div class="col-md-12 line-top float-left"></div> <!-- 사이점선 -->
                        <div class="col-sm-2 py-sm-2 float-left"><label for="sourcUpdtNm" class="col-form-label float-left"  style="padding-top:10px;"><input type="radio" name="schduleType1" class="custom-radio" style="width:18px;height:18px;" value="4">  매주</label></div>
                        <div class="col-sm-10 py-sm-3 float-left">
                            <input type="checkbox" id="everyWeekMonAt" class="custom-checkbox jq_everyWeek" style="width:18px;height:18px;margin-left:8px;" value="Y">월
                            <input type="checkbox" id="everyWeekTueAt" class="custom-checkbox jq_everyWeek" style="width:18px;height:18px;margin-left:8px;" value="Y">화
                            <input type="checkbox" id="everyWeekWedAt" class="custom-checkbox jq_everyWeek" style="width:18px;height:18px;margin-left:8px;" value="Y">수
                            <input type="checkbox" id="everyWeekThuAt" class="custom-checkbox jq_everyWeek" style="width:18px;height:18px;margin-left:8px;" value="Y">목
                            <input type="checkbox" id="everyWeekFriAt" class="custom-checkbox jq_everyWeek" style="width:18px;height:18px;margin-left:8px;" value="Y">금
                            <input type="checkbox" id="everyWeekSatAt" class="custom-checkbox jq_everyWeek" style="width:18px;height:18px;margin-left:8px;" value="Y">토
                            <input type="checkbox" id="everyWeekSunAt" class="custom-checkbox jq_everyWeek" style="width:18px;height:18px;margin-left:8px;" value="Y">일
                            <div class="m-2"></div><!-- 사이간격 -->
                            <div class="input-group">
	                            <input type="text" id="everyWeekHour" class="form-control float-left" style="max-width:90px;margin-right: 3px;" maxlength="2" numberOnly>시&nbsp;
	                            <input type="text" id="everyWeekMinute" class="form-control float-left" style="max-width:90px;margin-right: 3px;" maxlength="2" numberOnly>분
	                            
<!-- 	                            <select class="form-control" id="everyWeekMinute" style="width: 60%; max-width: 90px;"> -->
<!--                                                     <option value="">선택</option> -->
<!--                                                     <option value="00">00</option> -->
<!--                                                     <option value="10">10</option> -->
<!--                                                     <option value="20">20</option> -->
<!--                                                     <option value="30">30</option> -->
<!--                                                     <option value="40">40</option> -->
<!--                                                     <option value="50">50</option> -->
<!--                                                     </select>분 -->
                            </div>
                        </div>
                        
                        <div class="col-md-12 py-sm-1 line-top float-left" ></div> <!-- 사이점선 -->
                        <div class="col-sm-2 py-sm-2 float-left"><label for="sourcUpdtNm" class="col-form-label float-left"  style="padding-top:9px;"><input type="radio" name="schduleType1" class="custom-radio" style="width:18px;height:18px;" value="5">  매월</label></div>
                        <div class="col-sm-10 py-sm-1 float-left">
                            <div class="col-sm-2 float-left py-sm-2  text-success"><input type="radio" name="schduleType2" class="custom-radio" style="width:16px;height:16px;margin:0 3px 2px 0;" value="1">일   </div> 
                            <div class="col-sm-10 py-sm-2 float-left">
                               <div class="input-group">        
                                   <select id="everyMonthDay" class="form-control float-left" style="max-width:90px; margin-right:3px; ">
                                   <option value="">선택</option>
                                    <option value="1">01</option>
                                    <option value="2">02</option>
                                    <option value="3">03</option>
                                    <option value="4">04</option>
                                    <option value="5">05</option>
                                    <option value="6">06</option>
                                    <option value="7">07</option>
                                    <option value="8">08</option>
                                    <option value="9">09</option>
                                    <option value="10">10</option>
                                    <option value="11">11</option>
                                    <option value="12">12</option>
                                    <option value="13">13</option>
                                    <option value="14">14</option>
                                    <option value="15">15</option>
                                    <option value="16">16</option>
                                    <option value="17">17</option>
                                    <option value="18">18</option>
                                    <option value="19">19</option>
                                    <option value="20">20</option>
                                    <option value="21">21</option>
                                    <option value="22">22</option>
                                    <option value="23">23</option>
                                    <option value="24">24</option>
                                    <option value="25">25</option>
                                    <option value="26">26</option>
                                    <option value="27">27</option>
                                    <option value="28">28</option>
                                    <option value="29">29</option>
                                    <option value="30">30</option>
                                    <option value="31">31</option>
                                    <option value="0">마지막날</option>
                                    
                                   </select>일&nbsp;
	                               <input type="text" id="everyMonthHour" class="form-control float-left" style="max-width:90px;margin-left: 3px;" maxlength="2" numberOnly>시&nbsp;
	                               <input type="text" id="everyMonthMinute" class="form-control float-left" style="max-width:90px;margin-right: 3px;" maxlength="2" numberOnly>분
<!-- 	                               <select class="form-control" id="everyMonthMinute" style="width: 60%; max-width: 90px;"> -->
<!--                                                     <option value="">선택</option> -->
<!--                                                     <option value="00">00</option> -->
<!--                                                     <option value="10">10</option> -->
<!--                                                     <option value="20">20</option> -->
<!--                                                     <option value="30">30</option> -->
<!--                                                     <option value="40">40</option> -->
<!--                                                     <option value="50">50</option> -->
<!--                                                     </select>분 -->
                               </div>
                            </div>
                            
                            <div class="col-sm-2 float-left py-sm-1 text-success"><input type="radio" name="schduleType2" class="custom-radio" style="width:16px;height:16px;margin:0 3px 2px 0;" value="2">주차</div> 
                            <div class="col-sm-10 py-sm-1 float-left">   
                                <input type="radio" name="everyMonthWeekOrder" class="custom-checkbox" style="width:14px;height:14px;margin:0 0 0 10px;" value="1"> 첫째주
                                <input type="radio" name="everyMonthWeekOrder" class="custom-checkbox" style="width:14px;height:14px;margin:0 0 0 10px;" value="2"> 둘째주
                                <input type="radio" name="everyMonthWeekOrder" class="custom-checkbox" style="width:14px;height:14px;margin:0 0 0 10px;" value="3"> 셋째주
                                <input type="radio" name="everyMonthWeekOrder" class="custom-checkbox" style="width:14px;height:14px;margin:0 0 0 10px;" value="4"> 넷째주
                                <input type="radio" name="everyMonthWeekOrder" class="custom-checkbox" style="width:14px;height:14px;margin:0 0 0 10px;" value="0"> 마지막주
                                <div class="m-2"></div><!-- 사이간격 -->
                                <input type="radio" name="everyMonthDow" class="custom-checkbox" style="width:14px;height:14px;margin:0 0 0 10px;" value="2">월
                                <input type="radio" name="everyMonthDow" class="custom-checkbox" style="width:14px;height:14px;margin:0 0 0 10px;" value="3">화
                                <input type="radio" name="everyMonthDow" class="custom-checkbox" style="width:14px;height:14px;margin:0 0 0 10px;" value="4">수
                                <input type="radio" name="everyMonthDow" class="custom-checkbox" style="width:14px;height:14px;margin:0 0 0 10px;" value="5">목
                                <input type="radio" name="everyMonthDow" class="custom-checkbox" style="width:14px;height:14px;margin:0 0 0 10px;" value="6">금
                                <input type="radio" name="everyMonthDow" class="custom-checkbox" style="width:14px;height:14px;margin:0 0 0 10px;" value="7">토
                                <input type="radio" name="everyMonthDow" class="custom-checkbox" style="width:14px;height:14px;margin:0 0 0 10px;" value="1">일
                                <div class="m-2"></div><!-- 사이간격 -->
                                
                                <div class="input-group">
                                    <input type="text" id="everyMonthHour2" class="form-control float-left" style="max-width:90px;margin-right: 3px;" maxlength="2" numberOnly>시&nbsp;
                                    <input type="text" id="everyMonthMinute" class="form-control float-left" style="max-width:90px;margin-right: 3px;" maxlength="2" numberOnly>분
<!--                                     <select class="form-control" id="everyMonthMinute" style="width: 60%; max-width: 90px;"> -->
<!--                                                     <option value="">선택</option> -->
<!--                                                     <option value="00">00</option> -->
<!--                                                     <option value="10">10</option> -->
<!--                                                     <option value="20">20</option> -->
<!--                                                     <option value="30">30</option> -->
<!--                                                     <option value="40">40</option> -->
<!--                                                     <option value="50">50</option> -->
<!--                                                     </select>분 -->
                                </div>
                                
                            </div>
                        </div>
                    </div>           
                </form>
                <div class="col-md-12">
	                <div class="float-right py-sm-12">
	                    <button type="button" class="btn btn-primary" id="updateBtn">적용</button>
	                    <button type="button" class="btn btn-primary" id="closeBtn">닫기</button>
	                </div>
                </div>
            </div>
        </div>
    </div>
</div>
        
 <script>
$(document).ready(function() {
    //이벤트 바인딩
    pageInit();
    bindEvent();
});
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent() {
        //감섹영역 > 등록일자 > 시작일 
        $('#startDeDiv1').datetimepicker(
            {
                format: 'YYYY-MM-DD'
                , defaultDate: (new Date())
            }
        );
        
        var currentDate = new Date();
        var date = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1);

        //감섹영역 > 등록일자 > 종료일
        $("#endDeDiv").datetimepicker(
            {
                format: 'YYYY-MM-DD'
                , defaultDate: (new Date(currentDate.getFullYear() + 1, 11, 31))
            }
        );
        
        $("#closeBtn").on("click", function() { 
            $(".jq_inModal").modal('hide');
        });
        
        $("#updateBtn").on("click", function() {
        	var schduleType1 = $('input:radio[name="schduleType1"]:checked').val();
        	var schduleType2 = $('input:radio[name="schduleType2"]:checked').val()
        	var oObj;
        	var sText;
        	var iNumber;
        	
        	
        	if(schduleType1 == undefined){
                alert("주기를  선택해 주십시오.");
                return false;
            }
        	
        	if(schduleType1 == "1"){
        		oObj = $("#everyMinute");
        		sText = oObj.val(); 
        		if(sText == ""){
                    alert("분을 입력해 주십시오.");
                    oObj.focus();
                    return false;
                }
        		
        		iNumber = parseInt(sText);
        		if(iNumber < 0 || iNumber > 59){
        			alert("0 ~ 59사이의 값을 입력해 주십시오.");
        			oObj.focus();
                    return false;
        		}
        	}
        	
        	else if(schduleType1 == "2"){
        		oObj = $("#everyHour");
                sText = oObj.val();
                if(sText == ""){
                    alert("시간을 입력해 주십시오.");
                    oObj.focus();
                    return false;
                }
                iNumber = parseInt(sText);
                if(iNumber < 0 || iNumber > 23){
                    alert("0 ~ 23사이의 값을 입력해 주십시오.");
                    oObj.focus();
                    return false;
                }
        		
                oObj = $("#everyHourMinute");
                sText = oObj.val(); 
                if(sText == ""){
                    alert("분을 입력해 주십시오.");
                    oObj.focus();
                    return false;
                }
                
                iNumber = parseInt(sText);
                if(iNumber < 0 || iNumber > 59){
                    alert("0 ~ 59사이의 값을 입력해 주십시오.");
                    oObj.focus();
                    return false;
                }
        	}
        	
        	else if(schduleType1 == "3"){
                oObj = $("#everyDayHour");
                sText = oObj.val();
                if(sText == ""){
                    alert("시간을 입력해 주십시오.");
                    oObj.focus();
                    return false;
                }
                iNumber = parseInt(sText);
                if(iNumber < 0 || iNumber > 23){
                    alert("0 ~ 23사이의 값을 입력해 주십시오.");
                    oObj.focus();
                    return false;
                }
                
                oObj = $("#everyDayMinute");
                sText = oObj.val(); 
                if(sText == ""){
                    alert("분을 입력해 주십시오.");
                    oObj.focus();
                    return false;
                }
                
                iNumber = parseInt(sText);
                if(iNumber < 0 || iNumber > 59){
                    alert("0 ~ 59사이의 값을 입력해 주십시오.");
                    oObj.focus();
                    return false;
                }
            }
        	
        	else if(schduleType1 == "4"){
        		if($('.jq_everyWeek:checked').length < 1){
        			alert("실행 요일을 선택해 주십시오.");
        			return false;
        		}
        		
                oObj = $("#everyWeekHour");
                sText = oObj.val();
                if(sText == ""){
                    alert("시간을 입력해 주십시오.");
                    oObj.focus();
                    return false;
                }
                iNumber = parseInt(sText);
                if(iNumber < 0 || iNumber > 23){
                    alert("0 ~ 23사이의 값을 입력해 주십시오.");
                    oObj.focus();
                    return false;
                }
                
                oObj = $("#everyWeekMinute");
                sText = oObj.val(); 
                if(sText == ""){
                    alert("분을 입력해 주십시오.");
                    oObj.focus();
                    return false;
                }
                
                iNumber = parseInt(sText);
                if(iNumber < 0 || iNumber > 59){
                    alert("0 ~ 59사이의 값을 입력해 주십시오.");
                    oObj.focus();
                    return false;
                }
            }
        	else if(schduleType1 == "5"){
        		if(schduleType2 == undefined){
                    alert("실행할 일 또는 주차를 선택해 주십시오.");
                    return false;
                }
        		
        		if(schduleType2 == "1"){
	       			oObj = $("#everyMonthDay");
					sText = oObj.val();
					if(sText == ""){
					    alert("일을 선택해 주십시오.");
					    oObj.focus();
					    return false;
					}
	                   
	                   
	       			oObj = $("#everyMonthHour");
	                sText = oObj.val();
	                if(sText == ""){
	                    alert("시간을 입력해 주십시오.");
	                    oObj.focus();
	                    return false;
	                }
	                iNumber = parseInt(sText);
	                if(iNumber < 0 || iNumber > 23){
	                    alert("0 ~ 23사이의 값을 입력해 주십시오.");
	                    oObj.focus();
	                    return false;
	                }
	                
	                oObj = $("#everyMonthMinute");
	                sText = oObj.val(); 
	                if(sText == ""){
	                    alert("분을 입력해 주십시오.");
	                    oObj.focus();
	                    return false;
	                }
	                
	                iNumber = parseInt(sText);
	                if(iNumber < 0 || iNumber > 59){
	                    alert("0 ~ 59사이의 값을 입력해 주십시오.");
	                    oObj.focus();
	                    return false;
	                }
	            }
        		else if(schduleType2 == "2"){
        			 var everyMonthWeekOrder = $('input:radio[name="everyMonthWeekOrder"]:checked').val();
		             if(everyMonthWeekOrder == undefined){
		                 alert("실행할 주차를 선택해 주십시오.");
		                 return false;
		             }
		       			
		       		 var everyMonthDow = $('input:radio[name="everyMonthDow"]:checked').val();
		             if(everyMonthDow == undefined){
		                 alert("실행할 요일을 선택해 주십시오.");
		                 return false;
		             }
		       			
		       		 oObj = $("#everyMonthHour2");
		             sText = oObj.val();
		             if(sText == ""){
		                 alert("시간을 입력해 주십시오.");
		                 oObj.focus();
		                 return false;
		             }
		             iNumber = parseInt(sText);
		             if(iNumber < 0 || iNumber > 23){
		                 alert("0 ~ 23사이의 값을 입력해 주십시오.");
		                 oObj.focus();
		                 return false;
		             }
		             
		             oObj = $("#everyMonthMinute2");
		             sText = oObj.val(); 
		             if(sText == ""){
		                 alert("분을 입력해 주십시오.");
		                 oObj.focus();
		                 return false;
		             }
		             
		             iNumber = parseInt(sText);
		             if(iNumber < 0 || iNumber > 59){
		                 alert("0 ~ 59사이의 값을 입력해 주십시오.");
		                 oObj.focus();
		                 return false;
		             }
		        }
        	}
        	
        	var returnParam = {
        			startDe1:$("#startDe1").val(), endDe:$("#endDe").val()
        			, schduleNo: $("#schduleNo").val()
                    , schduleType1: schduleType1, schduleType2: 1
                    , everyMinute: null
                    , everyHour: null, everyHourMinute: null
                    , everyWeekMonAt: "N", everyWeekTueAt: "N", everyWeekWedAt: "N", everyWeekThuAt: "N", everyWeekFriAt: "N", everyWeekSatAt: "N", everyWeekSunAt: "N"
                    , executDay: null, executHour: null, executMinute: null
                    , everyMonthWeekOrder: null, everyMonthDow:null
                    , schduleCrontab: ""
                    , schduleText: ""
                }
        	
        	var schduleText = $("#startDe1").val() + "~" + $("#endDe").val() + " ";
        	if(schduleType1 == "1"){
        		var everyMinute = $("#everyMinute").val();
        		returnParam["everyMinute"] = everyMinute;
        		schduleText += "매 " + everyMinute + "분 간격"
        		schduleCrontab =  "0 */"+ everyMinute +" * * * ? *"
        	}
        	else if(schduleType1 == "2"){
        		var everyHour = $("#everyHour").val();
        		var everyHourMinute = $("#everyHourMinute").val();
                returnParam["everyHour"] = everyHour;
                returnParam["executMinute"] = everyHourMinute;
                schduleText += "매 " + everyHour + "시간 간격 " +everyHourMinute + "분"
                
                schduleCrontab =  "0 "+ everyHourMinute +" */"+ everyHour +" * * ? *"
                
            }
        	else if(schduleType1 == "3"){
        		var everyDayHour = $("#everyDayHour").val();
        		var everyDayMinute  = $("#everyDayMinute").val();
                returnParam["executHour"] = everyDayHour;
                returnParam["executMinute"] = everyDayMinute;
                schduleText += "매일 " + everyDayHour + "시 " +  everyDayMinute + "분"
                
                schduleCrontab =  "0 "+ everyDayMinute +" "+ everyDayHour +" * * ? *"
            }
        	else if(schduleType1 == "4"){
        		var dayOfWeek = "";
        		var cronDayOfWeek = "";
        		var everyWeekHour = $("#everyWeekHour").val();
                var everyWeekMinute = $("#everyWeekMinute").val();
                
        		returnParam["everyWeekMonAt"] = $('#everyWeekMonAt:checked').val() != undefined ? "Y" : "N";
        		if(returnParam["everyWeekMonAt"] == "Y"){
        			dayOfWeek += (dayOfWeek == "" ? "" : ", ") + "월";
        			cronDayOfWeek += (cronDayOfWeek == "" ? "" : ", ") + "MON";
        		}
        		
        		returnParam["everyWeekTueAt"] = $('#everyWeekTueAt:checked').val() != undefined ? "Y" : "N";
        		if(returnParam["everyWeekTueAt"] == "Y"){
                    dayOfWeek += (dayOfWeek == "" ? "" : ", ") + "화";
                    cronDayOfWeek += (cronDayOfWeek == "" ? "" : ", ") + "TUE";
                }
        		
        		returnParam["everyWeekWedAt"] = $('#everyWeekWedAt:checked').val() != undefined ? "Y" : "N";
        		if(returnParam["everyWeekWedAt"] == "Y"){
                    dayOfWeek += (dayOfWeek == "" ? "" : ", ") + "수";
                    cronDayOfWeek += (cronDayOfWeek == "" ? "" : ", ") + "WEN";
                }
        		
        		returnParam["everyWeekThuAt"] = $('#everyWeekThuAt:checked').val() != undefined ? "Y" : "N";
        		if(returnParam["everyWeekThuAt"] == "Y"){
                    dayOfWeek += (dayOfWeek == "" ? "" : ", ") + "목";
                    cronDayOfWeek += (cronDayOfWeek == "" ? "" : ", ") + "THU";
                }
        		
        		returnParam["everyWeekFriAt"] = $('#everyWeekFriAt:checked').val() != undefined ? "Y" : "N";
        		if(returnParam["everyWeekFriAt"] == "Y"){
                    dayOfWeek += (dayOfWeek == "" ? "" : ", ") + "금";
                    cronDayOfWeek += (cronDayOfWeek == "" ? "" : ", ") + "FRI";
                }
        		
        		returnParam["everyWeekSatAt"] = $('#everyWeekSatAt:checked').val() != undefined ? "Y" : "N";
        		if(returnParam["everyWeekSatAt"] == "Y"){
                    dayOfWeek += (dayOfWeek == "" ? "" : ", ") + "토";
                    cronDayOfWeek += (cronDayOfWeek == "" ? "" : ", ") + "SAT";
                }
        		
        		returnParam["everyWeekSunAt"] = $('#everyWeekSunAt:checked').val() != undefined ? "Y" : "N";
        		if(returnParam["everyWeekSunAt"] == "Y"){
                    dayOfWeek += (dayOfWeek == "" ? "" : ", ") + "일";
                    cronDayOfWeek += (cronDayOfWeek == "" ? "" : ", ") + "SUN";
                }
        		
        		var everyWeekHour = $("#everyWeekHour").val();
                var everyWeekMinute = $("#everyWeekMinute").val();
                
                returnParam["executHour"] = everyWeekHour;
                returnParam["executMinute"] = everyWeekMinute;
                
                schduleText += "매주 " + dayOfWeek + " " + everyWeekHour + "시 " + everyWeekMinute + "분"
                
                schduleCrontab = "0 "+ everyWeekMinute +" "+ everyWeekHour +" ? * " + cronDayOfWeek + " *";
            }
        	else if(schduleType1 == "5"){
        		returnParam["schduleType2"] = schduleType2
        		
        		if(schduleType2 == "1"){
        			var everyMonthDay = $("#everyMonthDay").val();
                    var everyMonthHour = $("#everyMonthHour").val();
                    var everyMonthMinute = $("#everyMonthMinute").val();
                    
        			returnParam["executDay"] = everyMonthDay;
        			returnParam["executHour"] = everyMonthHour;
        			returnParam["executMinute"] = everyMonthMinute;
        			schduleText += "매월 " + (everyMonthDay == "0" ? "마지막날 " : everyMonthDay + "일 ") + everyMonthHour + "시 " + everyMonthMinute + "분"
        			schduleCrontab = "0 "+ everyMonthMinute +" "+ everyMonthHour +" "+ (everyMonthDay == "0" ? "L" : everyMonthDay) + " * ? *";
        		}
        		else if(schduleType2 == "2"){
        			var everyMonthWeekOrder = $('input:radio[name="everyMonthWeekOrder"]:checked').val();
                    var everyMonthDow = $('input:radio[name="everyMonthDow"]:checked').val();
                    var everyMonthHour2 = $("#everyMonthHour2").val();
                    var everyMonthMinute2 = $("#everyMonthMinute2").val();
                    
        			returnParam["everyMonthWeekOrder"] = everyMonthWeekOrder
        			returnParam["everyMonthDow"] = everyMonthDow
        			
        			returnParam["executHour"] = everyMonthHour2;
                    returnParam["executMinute"] = everyMonthMinute2;
                    
                    schduleText += "매월 ";
                    if(everyMonthWeekOrder == "1"){
                    	schduleText += "첫째주 ";
                    } 
                    else if(everyMonthWeekOrder == "2"){
                        schduleText += "두째주 ";
                    }
                    else if(everyMonthWeekOrder == "3"){
                        schduleText += "셋째주 ";
                    }
                    else if(everyMonthWeekOrder == "4"){
                        schduleText += "넷째주 ";
                    }
                    else if(everyMonthWeekOrder == "0"){
                        schduleText += "마지막주 ";
                    }
                    
                    if(everyMonthDow == "1"){
                        schduleText += "일 ";
                    } 
                    else if(everyMonthDow == "2"){
                        schduleText += "월  ";
                    }
                    else if(everyMonthDow == "3"){
                        schduleText += "화 ";
                    }
                    else if(everyMonthDow == "4"){
                        schduleText += "수 ";
                    }
                    else if(everyMonthDow == "5"){
                        schduleText += "목 ";
                    }
                    else if(everyMonthDow == "6"){
                        schduleText += "금 ";
                    }
                    else if(everyMonthDow == "7"){
                        schduleText += "토 ";
                    }
                    
                    schduleText += everyMonthHour2 + "시 " + everyMonthMinute2 + "분"
                    schduleCrontab = "0 "+ everyMonthMinute2 +" "+ everyMonthHour2 +" ? * "+ everyMonthDow + (everyMonthWeekOrder == "0" ? "L" : "#" + everyMonthWeekOrder) +" *";
                    
                }
        	}

        	//console.log("schduleText: " + schduleText);
        	//console.log("schduleCrontab: " + schduleCrontab);
        	returnParam["schduleText"] = schduleText;
        	returnParam["schduleCrontab"] = schduleCrontab;
        	
        	returnDrawExecutplan(returnParam);
            $(".jq_inModal").modal('hide');
            
        });
        
        
        
    }
    
    
    function drawExecutplan(data){
    	if(data == null){
    		return false;
    	}
    	$("#startDe1").val(data["startDe1"]);
    	$("#endDe").val(data["endDe"])

    	var schduleType1 = data["schduleType1"];
    	var schduleType2 = data["schduleType2"];
    	
    	$("input:radio[name='schduleType1']:radio[value='" + schduleType1 +"']").prop('checked', true);
    	
    	if(schduleType1 == "1"){
    		$("#everyMinute").val(data["everyMinute"]);
    	}
    	else if(schduleType1 == "2"){
    		$("#everyHour").val(data["everyHour"]);
            $("#everyHourMinute").val(data["executMinute"]);
    	}
    	else if(schduleType1 == "3"){
    		$("#everyDayHour").val(data["executHour"]);
            $("#everyDayMinute").val(data["executMinute"]);
    	}
        else if(schduleType1 == "4"){
        	if(data["everyWeekMonAt"] == "Y") $('#everyWeekMonAt').attr("checked", true);
        	if(data["everyWeekTueAt"] == "Y") $('#everyWeekTueAt').attr("checked", true);
        	if(data["everyWeekWedAt"] == "Y") $('#everyWeekWedAt').attr("checked", true);
        	if(data["everyWeekThuAt"] == "Y") $('#everyWeekThuAt').attr("checked", true);
        	if(data["everyWeekFriAt"] == "Y") $('#everyWeekFriAt').attr("checked", true);
        	if(data["everyWeekSatAt"] == "Y") $('#everyWeekSatAt').attr("checked", true);
        	if(data["everyWeekSunAt"] == "Y") $('#everyWeekSunAt').attr("checked", true);
        
        	$("#everyWeekHour").val(data["executHour"]);
            $("#everyWeekMinute").val(data["executMinute"]);
        }
        else if(schduleType1 == "5"){
        	$("input:radio[name='schduleType2']:radio[value='" + schduleType2 +"']").prop('checked', true);
        	if(schduleType2 == "1"){
        		if(data["executDay"] != null){
        			$("#everyMonthDay").val(data["executDay"]);
        		}
                $("#everyMonthHour").val(data["executHour"]);
                $("#everyMonthMinute").val(data["executMinute"]);
        	}
        	else if(schduleType2 == "2"){
        		var everyMonthWeekOrder = data["everyMonthWeekOrder"];
        		var everyMonthDow = data["everyMonthDow"];
        		
        		$("input:radio[name='everyMonthWeekOrder']:radio[value='" + everyMonthWeekOrder +"']").prop('checked', true);
        		$("input:radio[name='everyMonthDow']:radio[value='" + everyMonthDow +"']").prop('checked', true);
        		
        		$("#everyMonthHour2").val(data["executHour"]);
                $("#everyMonthMinute2").val(data["executMinute"]);
        	}
        }
    }
</script>
</div>

<!--  템플릿 바디 끝 -->