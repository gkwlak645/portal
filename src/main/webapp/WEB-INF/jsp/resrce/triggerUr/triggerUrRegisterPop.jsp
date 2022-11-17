<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
                    <!--  템플릿 바디 -->
					<div class="card card-primary card-tabs">
                        <div class="card-header p-0 pt-1">
                            <ul class="nav nav-tabs" id="custom-tabs-one-tab" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" id="tabTime" data-toggle="pill" href="#timeTab" role="tab" aria-controls="timeTab" aria-selected="true">시간</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="tabQueue" data-toggle="pill" href="#queueTab" role="tab" aria-controls="queueTab" aria-selected="false">큐</a>
                                </li>
                            </ul>
                        </div>                        
                        <div class="card-body" >
                            <div class="tab-content" id="version-tabContent">                                
                               <!-- 첫번째 탭  시간 -->
                               <div class="tab-pane fade show active" id="timeTab" role="tabpanel" aria-labelledby="tabTime">
                                   <div class="row">
			                        <div class="col-md-6">
			                            <div class="card card-default">
			                                <form class="form-inline" onSubmit="return false;">
				                                <div class="card-body" >
				                                    <div class="form-group col-sm-12">
                                                        <label for="targetNm" class="col-sm-2 col-form-label">이름<b style="color:red;padding-left:10px;">*</b></label>
                                                         <div class="col-sm-10">
                                                            <input type="text" id="targetNm" class="form-control float-left" id="timeName" style="width:97%;">
                                                        </div>
                                                     </div>
				                                    <div class="form-group col-sm-12">
	                                                    <label for="releases" class="col-sm-2 col-form-label">프로세스<b style="color:red;padding-left:10px;">*</b></label>
		                                                 <div class="col-sm-10">
                                                            <input type="text" class="form-control float-left col-sm-9" id="releasesSearchKwrd" name="searchKwrd" style="width:60%;min-width:75px;" value="" /><button type="button" id="btnReleasesSearch" class="btn btn-info float-left ">조회</button>
		                                                    <select class="form-control" id="targetReleases" style="width:97%;" >
                                                             <option value=""></option>
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
                                                        <input type="radio" name="reg_target_checkRadio" value="All" class="custom-radio" style="width:18px;height:18px;" checked> 모든 로봇 &nbsp; &nbsp; &nbsp;
                                                        <input type="radio" name="reg_target_checkRadio" value="Specific" class="custom-radio" style="width:18px;height:18px;">특정 로봇 &nbsp; &nbsp; &nbsp;
                                                        <input type="radio" name="reg_target_checkRadio" value="JobsCount"class="custom-radio" style="width:18px;height:18px;" >동적으로 할당
                                                     </div>
                                                     
                                                     <!-- 구분점선 -->
                                                     <div class="form-group col-md-12 py-sm-2 line-top jq-time-target"></div>
                                                     
                                                     <!-- 특정로봇 DIV -->
                                                     <div class="form-group row col-md-12 jq-time-target_sub2" name="" style="display:none;">
                                                       <label id=""class="col-sm-2 col-form-label float-left" >검색</label>
                                                       <div class="col-sm-5 float-left">
                                                            <input type="text" class="form-control float-left" id="robotSearchKwrd" name="searchKwrd" style="width:60%;min-width:75px;" value="" /><button type="button" id="btnSearchRobot" class="btn btn-info float-left">조회</button>
                                                       </div>
                                                       <div class="form-group col-md-12 triggertableDiv_wrap" style="height: 190px;" >
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
	                                                           		<tr><td colspan="3">표시할 데이터가 없습니다.</td></tr>
	                                                           </tbody>
	                                                           
	                                                        </table>
	                                                      </div>
	                                                      <div class="form-group col-md-12 py-sm-3">
	                                                       <p style="color:#4b5eb5;font-size:12px;">※  O행이 선택되었습니다.</p>
	                                                      </div> 
                                                     </div>
                                                   </div>
                                                   
                                                   <!-- 동적할당 DIV -->
                                                     <div class="form-group row col-md-12 jq-time-target_sub3" name="" style="display:none;">
                                                        <label for="schCmpny" class="col-sm-4 col-form-label">프로세스 실행</label>
                                                         <div class="col-sm-8">
                                                            <input type="text" id="startStrategy" name="startStrategy" class="form-control float-left" style="width:20%; margin-right:5px;" value="1" maxlength="5" numberonly> 횟수
                                                            <!--  값은 1~10000 사이여야 합니다.-->
                                                         </div>
                                                     </div>
                                                   <!-- 실행타겟 END -->
                                                    
                                                   <!-- 파라미터 -->
                                                   <div class="jq-time-parameter" style="display:none;">
                                                        <div class="form-group col-md-12 py-sm-2">
					                                        <div class="card-body p-10">
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
			                            </div>
			                        </div>
			                     
			                        <!-- 우측영역 -->
			                        <div class="col-md-6" >
			                            <div class="card card-default">
			                                <form class="form-inline" onSubmit="return false;">
                                                <div class="card-body2">
                                                    
                                                    <div class="form-group col-sm-12">
                                                        <label for="timezones1" class="col-sm-4 col-form-label">표준시간대</label>
                                                         <div class="col-sm-8">
                                                            <select class="form-control" id="timezones1" style="width:90%;" >
                                                             <option value=""></option>
                                                            </select>
                                                        </div>
                                                     </div>
                                                              
	                                                 <!-- 구분점선 -->
	                                                 <div class="form-group col-md-12 py-sm-1"></div> 
	                                                 <div class="form-group col-md-12 line-top"></div> 
	                                                  
                                                     <div class="form-group col-md-12 py-sm-2" style="display:inline;"> 
                                                        <div class="col-sm-3 float-left">
                                                            <div class="m-2"></div>
                                                            <label for="sourcUpdtNm" class="col-form-label"><input type="radio" name="mat-radio-group-765" class="custom-radio" style="width:18px;height:18px;" value="0" checked>  분</label><br>
                                                            <label for="sourcUpdtNm" class="col-form-label"><input type="radio" name="mat-radio-group-765" class="custom-radio" style="width:18px;height:18px;" value="1">  매시</label><br>
                                                            <label for="sourcUpdtNm" class="col-form-label"><input type="radio" name="mat-radio-group-765" class="custom-radio" style="width:18px;height:18px;" value="2">  매일</label><br>
                                                            <label for="sourcUpdtNm" class="col-form-label"><input type="radio" name="mat-radio-group-765" class="custom-radio" style="width:18px;height:18px;" value="3">  매주</label><br>
                                                            <label for="sourcUpdtNm" class="col-form-label"><input type="radio" name="mat-radio-group-765" class="custom-radio" style="width:18px;height:18px;" value="4">  매월</label><br>
                                                            <label for="sourcUpdtNm" class="col-form-label"><input type="radio" name="mat-radio-group-765" class="custom-radio" style="width:18px;height:18px;" value="5">  고급</label>
                                                        
                                                        </div>
                                                        
                                                        <!-- 01 분 -->
                                                        <div class="col-sm-9 py-sm-1 float-left jq_time_setTime jq_time_setTime_sub_0" style="display:block;">
                                                            <div class="col-sm-2 float-left py-sm-2  text-success">매  </div> 
                                                            <div class="col-sm-10 py-sm-2 float-left"> 
                                                               <select class="form-control" id="minutelyAtMinute" name="minutelyAtMinute" style="width:40%;" >
                                                                 <option value="1">1</option>
	                                                             <option value="5">5</option>
	                                                             <option value="10">10</option>
	                                                             <option value="15">15</option>
	                                                             <option value="30">30</option>
	                                                            </select>분
                                                            </div>                                                                                                                        
                                                            <!-- <p style="color:#4b5eb5;font-size:12px;">※ 프로세스가 OOO에서 예약됩니다.</p> -->
                                                       </div>
                                                       <!-- 01 분 END -->
                                                       
                                                       <!-- 02 매시 -->
                                                        <div class="col-sm-9 py-sm-1 float-left jq_time_setTime jq_time_setTime_sub_1" style="display:none;">
                                                            <div class="col-sm-2 float-left py-sm-2  text-success">매  </div> 
                                                            <div class="col-sm-10 py-sm-2 float-left"> 
                                                               <input type="text" id="hourlyEveryHours" name="hourlyEveryHours" class="form-control float-left" style="width:50px;margin-right: 5px;" maxlength="2" numberonly>시간
                                                            </div>  
                                                            <div class="col-sm-2 float-left py-sm-2  text-success">시점  </div> 
                                                            <div class="col-sm-10 py-sm-2 float-left"> 
                                                               <input type="text" id="hourlyAtMinute" name="hourlyAtMinute" class="form-control float-left" style="width:50px;margin-right: 5px;"  maxlength="2" numberonly>분
                                                            </div>                                                                                                                        
<!--                                                             <p style="color:#4b5eb5;font-size:12px;">※ 프로세스가 OOO에서 예약됩니다.</p> -->                                                            
                                                       </div>
                                                       <!-- 02 매시 END -->
                                                       
                                                       <!-- 03 매일 -->
                                                        <div class="col-sm-9 py-sm-1 float-left jq_time_setTime jq_time_setTime_sub_2" style="display:none;">
                                                            <div class="col-sm-2 float-left py-sm-2  text-success">매일  </div> 
                                                            <div class="col-sm-10 py-sm-2 float-left"> 
                                                               <input type="text" id="dailyAtHour" name="dailyAtHour" class="form-control float-left" style="width:50px;margin-right: 5px;" maxlength="2" numberonly>시간
                                                            </div>  
                                                            <div class="col-sm-2 float-left py-sm-2  text-success">및  </div> 
                                                            <div class="col-sm-10 py-sm-2 float-left"> 
                                                               <input type="text" id="dailyAtMinute" name="dailyAtMinute" class="form-control float-left" style="width:50px;margin-right: 5px;" maxlength="2" numberonly>분
                                                            </div>                                                     
                                                             <!--<p style="color:#4b5eb5;font-size:12px;">※ 프로세스가 OOO에서 예약됩니다.</p> -->                                                            
                                                       </div>
                                                       <!-- 03 매일 END -->
                                                       
                                                       <!-- 04 매주 -->
                                                        <div class="col-sm-9 py-sm-1 float-left jq_time_setTime jq_time_setTime_sub_3" style="display:none;">
                                                            <div class="col-sm-2 float-left py-sm-2  text-success">매  </div> 
                                                            <div class="col-sm-10 py-sm-1 float-left">  
                                                                <input type="checkbox" name="weeklyDayofWeek" class="custom-checkbox" style="width:18px;height:18px;" data-item-name="월요일" value="MON">월요일
                                                                <input type="checkbox" name="weeklyDayofWeek" class="custom-checkbox" style="width:18px;height:18px;margin-left:8px;" data-item-name="화요일" value="TUE">화요일
                                                                <input type="checkbox" name="weeklyDayofWeek" class="custom-checkbox" style="width:18px;height:18px;margin-left:8px;" data-item-name="수요일" value="WED">수요일<br>
                                                                <input type="checkbox" name="weeklyDayofWeek" class="custom-checkbox" style="width:18px;height:18px;" data-item-name="목요일" value="THU">목요일
                                                                <input type="checkbox" name="weeklyDayofWeek" class="custom-checkbox" style="width:18px;height:18px;margin-left:8px;" data-item-name="금요일" value="FRI">금요일
                                                                <input type="checkbox" name="weeklyDayofWeek" class="custom-checkbox" style="width:18px;height:18px;margin-left:8px;" data-item-name="토요일" value="SAT">토요일 &nbsp;
                                                                <input type="checkbox" name="weeklyDayofWeek" class="custom-checkbox" style="width:18px;height:18px;" data-item-name="일요일" value="SUN">일요일
                                                             </div> 
                                                             <div class="col-sm-2 float-left py-sm-2  text-success">시점  </div> 
                                                            <div class="col-sm-10 py-sm-2 float-left"> 
                                                               <input type="text" id="weeklyAtHour" name="weeklyAtHour" class="form-control float-left" style="width:50px;margin-right: 5px;" maxlength="2" numberonly>시간
                                                            </div>
                                                             <div class="col-sm-2 float-left py-sm-2  text-success">및  </div> 
                                                            <div class="col-sm-10 py-sm-2 float-left"> 
                                                               <input type="text" id="weeklyAtMinute" name="weeklyAtMinute" class="form-control float-left" style="width:50px;margin-right: 5px;" maxlength="2" numberonly>분
                                                            </div>                                                      
                                                            <!-- <p style="color:#4b5eb5;font-size:12px;">※ 프로세스가 OOO에서 예약됩니다.</p> -->
                                                       </div>
                                                       <!-- 04 매주 END -->
                                                        
                                                        
                                                        <!-- 05 매월 -->
                                                        <div class="col-sm-9 py-sm-1 float-left jq_time_setTime jq_time_setTime_sub_4" style="display:none;">
                                                            <div class="col-sm-2 float-left py-sm-2  text-success">매  </div> 
                                                            <div class="col-sm-10 py-sm-2 float-left"> 
                                                               <input type="text" id="monthlyFrequency" name="monthlyFrequency" class="form-control float-left" style="width:50px;margin-right: 5px;" maxlength="2" numberonly>개월
                                                            </div>
                                                            
                                                            <div class="m-2"></div><!-- 사이간격 -->
                                                            
                                                            <div class="col-sm-2 float-left py-sm-2  text-success">매  </div> 
                                                            <div class="col-sm-10 py-sm-1 float-left">  
                                                                <input type="checkbox" name="monthlyDayofWeek" class="custom-checkbox" style="width:18px;height:18px;" data-item-name="월요일" value="MON">월요일
                                                                <input type="checkbox" name="monthlyDayofWeek" class="custom-checkbox" style="width:18px;height:18px;margin-left:8px;" data-item-name="화요일" value="TUE">화요일
                                                                <input type="checkbox" name="monthlyDayofWeek" class="custom-checkbox" style="width:18px;height:18px;margin-left:8px;" data-item-name="수요일" value="WED">수요일<br>
                                                                <input type="checkbox" name="monthlyDayofWeek" class="custom-checkbox" style="width:18px;height:18px;" data-item-name="목요일" value="THU">목요일
                                                                <input type="checkbox" name="monthlyDayofWeek" class="custom-checkbox" style="width:18px;height:18px;margin-left:8px;" data-item-name="금요일" value="FRI">금요일
                                                                <input type="checkbox" name="monthlyDayofWeek" class="custom-checkbox" style="width:18px;height:18px;margin-left:8px;" data-item-name="토요일" value="SAT">토요일 &nbsp;
                                                                <input type="checkbox" name="monthlyDayofWeek" class="custom-checkbox" style="width:18px;height:18px;" data-item-name="일요일" value="SUN">일요일
                                                             </div>  
                                                            
                                                            
                                                            
                                                            <div class="col-sm-2 float-left py-sm-2  text-success">시점 </div> 
                                                            <div class="col-sm-10 py-sm-1 float-left"> 
                                                               <input type="text" id="monthlyAtHour" name="monthlyAtHour" class="form-control" style="width:50px;margin-right: 5px;" maxlength="2" numberonly>시간 &nbsp; &nbsp; 
                                                               <input type="text" id="monthlyAtMinute" name="monthlyAtMinute" class="form-control" style="width:50px;margin-right: 5px;" maxlength="2" numberonly>분
                                                            </div> 
                                                                                                                         
                                                       </div>
                                                       <!-- 05 매월 END -->
                                                       
                                                       <!-- 06 고급 -->
                                                        <div class="col-sm-9 py-sm-1 float-left jq_time_setTime jq_time_setTime_sub_5" style="display:none;">
                                                            <div class="col-sm-4 float-left py-sm-2  text-success">Cron 표현식  </div> 
                                                            <div class="col-sm-8 py-sm-2 float-left"> 
                                                               <input type="text" id="advancedCron" name="advancedCron" class="form-control float-left" style="width:100%;margin-right: 5px;">
                                                            </div>                                                   
                                                       </div>
                                                       <!-- 06 고급 END -->
                                                          
                                                   </div>
                                                   
                                                   
                                                   <!-- 구분점선 -->                                                   
                                                   <div class="form-group col-md-12 line-top"></div> 
                                                   <div class="form-group col-md-12 py-sm-1"></div> 
                                                   <div class="form-group col-sm-12">
                                                        <label for="targetCalendars" class="col-sm-4 col-form-label">휴무일 제한사항</label>
                                                         <div class="col-sm-8">
                                                            <select class="form-control" id="targetCalendars" style="width:90%;" >
                                                             <option value=""></option>
                                                            </select>
                                                        </div>
                                                     </div>
                                                     
                                                     <!-- 구분점선 -->
                                                     <div class="form-group col-md-12 py-sm-1"></div> 
                                                     <div class="form-group col-md-12 line-top"></div>          
                                                     
                                                     <!-- 작업중지 -->
                                                     <div class="form-group col-md-12 py-sm-1"></div>
                                                     <div class="col-sm-12 custom-control custom-switch float-right">
							                            <input type="checkbox" id="customSwitch1" class="custom-control-input float-right">
							                            <label id="customSwitch1-label" class="custom-control-label  float-right" for="customSwitch1">다음이후 작업중지</label>
							                        </div>
							                        <!-- 작업중지 실행시 -->
							                        <div id="customSwitch1-div" style="display:none">
								                        <div class="col-sm-9 float-left">
								                             <div for="" class="col-sm-2 float-left">시점</div>
		                                                     <div class="col-sm-10 float-left">
		                                                       <input type="text" id="customSwitch1_day" class="form-control" style="width:50px;margin-right: 5px;" value="0" maxlength="2" numberOnly>일 &nbsp; &nbsp; 
		                                                       <input type="text" id="customSwitch1_hour" class="form-control" style="width:50px;margin-right: 5px;" value="0" maxlength="2" numberOnly>시간 &nbsp; &nbsp; 
		                                                       <input type="text" id="customSwitch1_minute" class="form-control" style="width:50px;margin-right: 5px;" value="0" maxlength="2" numberOnly>분
		                                                      </div>
	                                                    </div> 
								                        <div class="col-sm-3 py-sm-1 float-left"> 
	                                                       <label for="sourcUpdtNm" class="col-form-label"><input type="radio" name="customSwitch1-state" class="custom-radio" style="width:18px;height:18px;" value="SoftStop" checked> 중지</label>  &nbsp; &nbsp; 
	                                                       <label for="sourcUpdtNm" class="col-form-label"><input type="radio" name="customSwitch1-state" class="custom-radio" style="width:18px;height:18px;" value="Kill"> 종료</label>
	                                                    </div>
	                                                  </div>  
                                                    <!-- 작업중지 실행시 END--> 
                                                     
                                                    
                                                    <!-- 구분점선 -->
                                                     <div class="form-group col-md-12 py-sm-1"></div> 
                                                     <div class="form-group col-md-12 line-top"></div>          
                                                     
                                                     <!-- 다음트리거 -->
                                                     <div class="form-group col-md-12 py-sm-1"></div>
                                                     <div class="col-sm-12 custom-control custom-switch float-right">
                                                        <input id="customSwitch2" type="checkbox"  class="custom-control-input float-right">
							                            <label id="customSwitch2-label" class="custom-control-label  float-right" for="customSwitch2">다음 트리거 사용안함</label>
                                                    </div>
                                                    <!-- 다음트리거 사용안함체크시 -->
                                                    <div id="customSwitch2-div" style="display:none">
                                                         <div class="col-sm-9 float-left">
	                                                         <div for="" class="col-sm-2 float-left">시점</div>                                                  
			                                                 <div class="col-sm-10 float-left"> 
			                                                      <div class="input-group date float-left" id="customSwitch2_de_div" data-target-input="nearest"style="min-width:140px;width:40%;margin-right:5px;">
									                                  <input type="text" id="customSwitch2_de" name="customSwitch2_de" class="form-control datetimepicker-input" data-target="#customSwitch2_de_div"/>
									                                  <div class="input-group-append" data-target="#customSwitch2_de_div" data-toggle="datetimepicker">
									                                      <div class="input-group-text"><i class="fa fa-calendar"></i></div>
									                                  </div>
									                              </div>
									                              <div class="float-left">
				                                                      <select id="customSwitch2_hour" class="form-control float-left"  style="min-width: 60px;width:70%;">
				                                                          <option value='00'>00</option>
				                                                      </select>시
				                                                  </div>
				                                                  <div class="float-left">
				                                                      <select id="customSwitch2_Minute" class="form-control float-left"  style="min-width: 60px;width:70%;">
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
				                         	  <button type="button" class="btn btn-primary float-right" id="btnClose1"  style="margin:5px 0 15px 1px;">닫기</button>
	                                          <button type="button" class="btn btn-primary float-right" id="btnAdd1"  style="margin:5px 0 15px 4px;">추가</button>
	                                          
	                                      </div>
	                                 </div>
	                                 <!-- 우측영역 End -->
	                               </div>
                                </div>
                                <!-- 첫번째 탭  시간 End --> 
                                
                                <!-- 두번째 탭 큐 -->
                                <div class="tab-pane fade" id="queueTab" role="tabpanel" aria-labelledby="tabQueue">
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
                                              <button type="button" class="btn btn-primary float-right" id="btnClose2"  style="margin:5px 0 15px 1px;">닫기</button>
                                              <button type="button" class="btn btn-primary float-right" id="btnAdd2"  style="margin:5px 0 15px 4px;">추가</button>
                                          </div>
                                     </div>
                                     <!-- 우측영역 End -->
                                   </div>
                                </div>
                                <!-- 두번째 탭 큐 end -->                   
                            </div>
                        </div>
                      </div>
                   </div>
                <!--  템플릿 바디 끝 -->
<script type="text/javascript">
var lc_queue_data = undefined;
var lc_releases_data = undefined;
var lc_calendars_data = undefined;
var lc_robot_data = undefined;
var lc_insert_params = undefined;

var lc_select_releases_id = 0;
var lc_select_certain_releases_id = 0;


$(document).ready(function() {
    //이벤트 바인딩
    pageInit();
    bindEvent();
});

function pageInit(){
	/*
	https://dwrpadev.dongwon.com/odata/Releases?$select=Id,EnvironmentId,Name,Key,Arguments,InputArguments&$filter=contains(Name,%27re%27)&$top=10&$orderby=Name
	https://dwrpadev.dongwon.com/odata/Releases?$select=Id,EnvironmentId,Name,Key,Arguments,InputArguments&$filter=contains(Name,%27%27)&$top=10&$orderby=Name
	*/
	//프로세스 조회: https://dwrpadev.dongwon.com/odata/Releases?$select=Id,EnvironmentId,Name,Key,Arguments,InputArguments&$filter=contains(Name,%27re%27)&$top=10&$orderby=Name
	searchReleases('');
	
	//휴무일 제한 사항: https://dwrpadev.dongwon.com/odata/Calendars
	searchCalendars()
	
	searchTimezones()
	
	let customSwitch2_hour_html = "";
	for(let i = 0; i < 24; i++){
		const sTmp = i < 10 ? "0" + i : "" + i; 
		customSwitch2_hour_html += '<option value="'+ sTmp +'">'+sTmp+'</option>';
	}
	$("#customSwitch2_hour").html(customSwitch2_hour_html);
	$("#customSwitch3_hour").html(customSwitch2_hour_html);
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
	
	//특정로봇 초기화
}

function searchCalendars(){
	var url = '/resrce/triggerUr/searchCalendars';
    var param = {};
    callAsyncAjax(url, param, "searchCalendarsCallback");
}

function searchCalendarsCallback(data){
	//console.log("function searchCalendarsCallback")
	lc_calendars_data = data.result.resultList;
	GBL_createSearchResultComboBox({id: "targetCalendars", resultList: lc_calendars_data, optVal: "Id", optNm: "Name", emptyText: "일정이 선택되지 않았습니다."});
	GBL_createSearchResultComboBox({id: "queueCalendars", resultList: lc_calendars_data, optVal: "Id", optNm: "Name", emptyText: "일정이 선택되지 않았습니다."});
}

function searchEnvironmentRobots(searchKeyword){
	const sSearchKeyword = searchKeyword == undefined ? "" : searchKeyword;
	const sReleases = $("#targetReleases").val();
	if(sReleases == ""){
		//초기화 drawTargetRobotList()
	}
	else{
		var url = '/resrce/triggerUr/searchEnvironmentRobots';
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

function searchTimezones(){
	var url = '/resrce/triggerUr/searchTimezones';
	var param = {};
	callAsyncAjax(url, param, "searchTimezonesCallback");
	
}

function searchTimezonesCallback(data){
	//console.log("function searchTimezonesCallback")
	GBL_createSearchResultComboBox({id: "timezones1", resultList: data.result.resultList, optVal: "Value", optNm: "Name", selectValue: "Korea Standard Time", emptyOption: "Y"} );
	GBL_createSearchResultComboBox({id: "timezones2", resultList: data.result.resultList, optVal: "Value", optNm: "Name", selectValue: "Korea Standard Time", emptyOption: "Y"} );
	
	$('#timezones1').attr('disabled', 'true');
	$('#timezones2').attr('disabled', 'true');
}


function searchQueueDefinitions(){
	console.log("function searchQueueDefinitions()");
	var url = '/resrce/triggerUr/searchQueueDefinitions';
	var param = {};
	callAsyncAjax(url, param, "searchQueueDefinitionsCallback");
}

function searchQueueDefinitionsCallback(data){
	lc_queue_data = data.result.resultList;
	GBL_createSearchResultComboBox({id: "queueDefinitions", resultList: data.result.resultList, optVal: "Id", optNm: "Name", emptyText: "연결된 큐 선택"});
}

function insertProcessSchedulesCallback(data){
	mainPopCloseReload();
}



function bindEvent(){
	$('#customSwitch2_de_div, #customSwitch3_de_div').datetimepicker({
        format: 'YYYY-MM-DD'
      //, defaultDate: (new Date())
    });
	
	$("#btnClose1, #btnClose2").on("click", function() {
		mainPopClose();
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
	
	$("input[name=reg_target_checkRadio]").on("click", function(e){
		const oThis = $(e.target);
		const sRegTargetCheckRadioVal = oThis.val();
		if(sRegTargetCheckRadioVal == "All"){
			$(".jq-time-target_sub2").hide();
			$(".jq-time-target_sub3").hide();
		}
		else if(sRegTargetCheckRadioVal == "Specific"){
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
	
	$("#btnReleasesSearch").on("click", function(e){
		drawTargetRobotList([]);	//시간 > 특정로봇 초기화
		$("#timeParametaList tbody").html("");
		searchReleases($("#releasesSearchKwrd").val());
		
	});
	
	$("#btnReleasesSearch2").on("click", function(e){
		drawTargetRobotList([]);	//시간 > 특정로봇 초기화
		$("#timeParametaList tbody").html("");
		searchReleases($("#releasesSearchKwrd2").val());
	});
	
	$("#queueReleases").on("change", function(e){
		const oThis = $(e.target);
		const selectVal = oThis.val();
		$("#targetReleases").val(selectVal);;
		
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
			$("#queueParametaList tbody").html(sTmp);
			$("#timeParametaList tbody").html(sTmp);
		}
	});
	
	$("#targetReleases").on("change", function(e){
		const oThis = $(e.target);
		const selectVal = oThis.val();
		$("#queueReleases").val(selectVal);;
		
		const sRegTargetCheckRadioVal = $("input[name='reg_target_checkRadio']:checked").val();
		if(("" + lc_select_releases_id) != ("" + selectVal)){
			lc_select_releases_id = selectVal;
			
			if(sRegTargetCheckRadioVal == "Specific"){
				if(lc_select_certain_releases_id != selectVal){
					lc_select_certain_releases_id = selectVal;
					//로봇 검색
					searchEnvironmentRobots();
				}
			}
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
			
			
			
			$("#queueParametaList tbody").html(sTmp);
			$("#timeParametaList tbody").html(sTmp);
			
			//Arguments 항목 정의
			//InputArguments: 항목별 입력 내역
			//InputArguments
			//let selectObj.InputArguments
			
		}
	});
	$("#targetCalendars").on("change", function(e){
		const oThis = $(e.target);
		const selectVal = $("#targetReleases").val();
		const sRegTargetCheckRadioVal = $("input[name='reg_target_checkRadio']:checked").val();
		
		
		
		$("#queueCalendars").val(oThis.val());
		console.log("lc_select_releases_id:" + lc_select_releases_id);
		console.log("lc_select_certain_releases_id:" + lc_select_certain_releases_id);
	});
	
	$("#targetNm").on("foucusout", function(e){
		$("#queueName").val($(this).val());
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
	
	$("#startStrategy, #itemsActivationThreshold, #maxJobsForActivation, #itemsPerJobActivationTarget").on("focusout", function(e){
		console.log("processExecutCnt focusout")
		const oThis = $(e.target);
		const sThisVal = oThis.val();
		const sThisId = oThis.attr("id");
		
		if(sThisVal == "" || parseInt(sThisVal.replace(/,/ ,"")) < 1 || parseInt(sThisVal.replace(/,/ ,"")) > 10000 ){
			e.stopPropagation();
			e.preventDefault();
			alert("값은 1~10000 사이여야 합니다.");
			oThis.focus();
			return false;
		}
		
		
		if(sThisId == "maxJobsForActivation"){
			console.log("maxJobsForActivation check")
			if(sThisVal == "1"){
				$("#itemsPerJobActivationTarget").prop("readonly", true).val(1);
			}
			else{
				$("#itemsPerJobActivationTarget").prop("readonly", false);
			}
		}
		
	});
	
	$("#tabTime").on("click", function(e){
		const oThis = $(e.target);
		if(oThis.hasClass("active")){
			return false;
		}
		
		//이름
		$("#targetNm").val($("#queueName").val());
		
		//표준시간대
		$("#timezones1").val($("#timezones2").val());
		$('#timezones1').attr('disabled', 'true');
		
		//휴무일 제한사항
		$("#targetCalendars").val($("#queueCalendars").val());
		
		//파라미터
		$("#timeParametaList tbody").html($("#queueParametaList tbody").html());

		const aInputArgumentsItem = $("#queueParametaList input:text[name=inputArgumentsItem]");
		const iaInputArgumentsItem = aInputArgumentsItem.length;
		if(iaInputArgumentsItem > 0){
			const aInputArgumentsItem2 = $("#timeParametaList input:text[name=inputArgumentsItem]");
			const iaInputArgumentsItem2 = aInputArgumentsItem2.length;
			for(let i = 0; i < iaInputArgumentsItem2; i++){
				$(aInputArgumentsItem2[i]).val( $(aInputArgumentsItem[i]).val());
			}
		}
		
		
		////다음 트리거 사용않함
		var bCustomSwitch3 = $("input:checkbox[id=customSwitch3]").is(":checked");
		$("input:checkbox[id=customSwitch2]").prop("checked", bCustomSwitch3);
		if(bCustomSwitch3){
			$("#customSwitch2-div").show();
			$("#customSwitch2_de").val($("#customSwitch3_de").val());
			$("#customSwitch2_hour").val($("#customSwitch3_hour").val());
			$("#customSwitch2_Minute").val($("#customSwitch3_Minute").val());
		}
		else{
			$("#customSwitch2-div").hide();
		}
	});
	
	$("#tabQueue").on("click", function(e){
		const oThis = $(e.target);
		if(oThis.hasClass("active")){
			return false;
		}
		
		$("input:checkbox[id=customSwitch1]").prop("checked", false);
		$("#customSwitch1-div").hide()
		
		const oParams = Add1Check();
		if(oParams == false){
			return false;
		}
		lc_insert_params = oParams;
		
		$("#queueName").val($("#targetNm").val());
		$("#queueParametaList tbody").html($("#timeParametaList tbody").html());
		
		const aInputArgumentsItem = $("#timeParametaList input:text[name=inputArgumentsItem]");
		const iaInputArgumentsItem = aInputArgumentsItem.length;
		if(iaInputArgumentsItem > 0){
			const aInputArgumentsItem2 = $("#queueParametaList input:text[name=inputArgumentsItem]");
			const iaInputArgumentsItem2 = aInputArgumentsItem2.length;
			for(let i = 0; i < iaInputArgumentsItem2; i++){
				$(aInputArgumentsItem2[i]).val( $(aInputArgumentsItem[i]).val());
			}
		}
		
		
		//다음 트리거 사용 않함
		var bCustomSwitch2 = $("input:checkbox[id=customSwitch2]").is(":checked");
		$("input:checkbox[id=customSwitch3]").prop("checked", bCustomSwitch2);
		if(bCustomSwitch2){
			$("#customSwitch3-div").show();
			$("#customSwitch3_de").val($("#customSwitch2_de").val());
			$("#customSwitch3_hour").val($("#customSwitch2_hour").val());
			$("#customSwitch3_Minute").val($("#customSwitch2_Minute").val());
		}
		else{
			$("#customSwitch3-div").hide();
		}
		$("#timezones2").val($("#timezones1").val());
		$('#timezones2').attr('disabled', 'true');
		
		$("#queueCalendars").val($("#targetCalendars").val());
		
		
		$(".jq-time-target_sub2").hide();
		$(".jq-time-target_sub3").hide();
		
		$("input:radio[name='reg_target_checkRadio']:radio[value='All']").prop('checked', true); // 선택하기
		$("input:radio[name='reg_target_checkRadio']:radio[value='Specific']").prop('checked', false); // 해제하기
		$("input:radio[name='reg_target_checkRadio']:radio[value='JobsCount']").prop('checked', false); // 해제하기
		console.log("lc_queue_data: " + lc_queue_data)
		if(lc_queue_data == undefined){
			searchQueueDefinitions();
		}
		//https://dwrpadev.dongwon.com/odata/QueueDefinitions?$select=Id,Name&$filter=((startswith(Name,%27%27))%20and%20(((ProcessScheduleId%20eq%20null)%20or%20(ProcessScheduleId%20eq%20-1))))&$top=10&$orderby=Name
	});

	// 시간  > (radio)분/매시/매일/매주/매월/고급
	$("input:radio[name=mat-radio-group-765]").on("click", function(e){
		const oThis = $(e.target);
		const oThisVal = oThis.val();
		
		if($(".jq_" + oThisVal).is(':visible')){
			return false;
		}
		else{
			$(".jq_time_setTime").hide();
			$(".jq_time_setTime_sub_" + oThisVal).show();
		}
	});
	
	// 시간  > 다음이후 작업중지
	$("#customSwitch1-label").on("click", function(e){
		//console.log("#customSwitch1:" + $("input:checkbox[id=customSwitch1]").is(":checked"));
		const bChecked = !($("input:checkbox[id=customSwitch1]").is(":checked"));
		if(bChecked){
			$("#customSwitch1-div").show()
		}
		else{
			$("#customSwitch1-div").hide()
		}
		//$("input:checkbox[id=customSwitch1]").prop("checked", false)
	});
	
	$("#customSwitch2-label").on("click", function(e){
		//console.log("#customSwitch1:" + $("input:checkbox[id=customSwitch1]").is(":checked"));
		const bChecked = !($("input:checkbox[id=customSwitch2]").is(":checked"));
		if(bChecked){
			$("#customSwitch2-div").show()
		}
		else{
			$("#customSwitch2-div").hide()
		}
		//$("input:checkbox[id=customSwitch1]").prop("checked", false)
	});
	
	$("#btnAdd1").on("click", function(e){
		
		const oParams = Add1Check();
		if(oParams == false){
			return false;
		}
		callAsyncAjax("/resrce/triggerUr/insertProcessSchedules", oParams, "insertProcessSchedulesCallback");
		
		//input:radio[name=mat-radio-group-765]
	});
	
	$("#btnAdd2").on("click", function(e){
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
		let oParams = lc_insert_params;
		oParams.ExecutorRobots = [];
		oParams.StartStrategy = -1;
		oParams.StopProcessExpression =  "";
		
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
		
		callAsyncAjax("/resrce/triggerUr/insertProcessSchedules", oParams, "insertProcessSchedulesCallback");
	});
	
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
	
	
}




function drawTargetRobotList(aData){
	const iaData = aData.length;
	
	let sTmp = "";
	if(iaData > 0){
		for(let i = 0; i < iaData; i++){
			const oaData = aData[i];
			const sState = oaData.IsUnresponsive ? "(응답없음)" : "(사용가능)";
			
			sTmp += '<tr>';
			sTmp += '<td><input type="checkbox" name="targetRobotId" class="custom-checkbox" style="width:18px;height:18px;" value="'+ oaData.Robot.Id+'"></td>';
			sTmp += '<td>' + sState + oaData.Robot.Name + '</td>';
			sTmp += '<td>' + oaData.Robot.RobotEnvironments +'</td>';
			sTmp += '</tr>';
		}
		
		
	}
	else{
		sTmp = '<tr><td colspan="3">표시할 데이터가 없습니다.</td></tr>';
	}
	
	$("#targetRobotList tbody").html(sTmp);
}


function Add1Check(){
	
	const oTargetNm = $("#targetNm");
	const oTargetReleases = $("#targetReleases");
	if($.trim(oTargetNm.val()) == ""){
        alert("이를을 입력해 주십시오.");
        oTargetNm.focus();
        return false;
    }
	
	if($.trim(oTargetReleases.val()) == ""){
        alert("프로세스를 선택해 주십시오.");
        oTargetReleases.focus();
        return false;
    }
	
	//선택한 실행 타켓 시작
	const sRegTargetCheckRadioVal = $("input[name='reg_target_checkRadio']:checked").val();
	var aExecutorRobots = [];
	let iStartStrategy = -1;
	if(sRegTargetCheckRadioVal == "All"){			
	}
	else if(sRegTargetCheckRadioVal == "Specific"){
		const aRargetRobotId =  $("input:checkbox[name=targetRobotId]:checked")
		if(aRargetRobotId.length < 1 ){
			alert("로봇이 선택되지 않았습니다.");
			return false;
		}
		else{
			aRargetRobotId.each(function() {
				aExecutorRobots.push({Id: parseInt(this.value)});
			});
		}
		iStartStrategy = 0;
	}
	else if(sRegTargetCheckRadioVal == "JobsCount"){
		const oStartStrategy = $("#startStrategy");
		const sTmpStr = oStartStrategy.val();
		if(sTmpStr == ""){
			alert("프로세스 실행 횟수를 입력해 주십시오.");
		}
		else{
			const iTmpStr =  parseInt(sTmpStr.replace(/,/, ""));
			if(iTmpStr < 1 || iTmpStr > 10000){
				alert("프로세스 실행 횟수는  1 ~ 10,000 사이여야 합니다.");
				oStartStrategy.focus();
			}
			else{
				iStartStrategy = iTmpStr;
			}
		}
	}
	else{
		alert("잘못된 접근");
	}
	//선택한 실행 타켓 종료
	
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
	
	
	//표준 시간대
	const sTimeZoneId = $("#timezones1").val();
	
	//---동작 시간 시작
	let sStartProcessCron = "";
	let sStartProcessCronDetails = "";
	const sRunningTimeVal = $("input:radio[name=mat-radio-group-765]:checked").val();
	const iRunningTimeVal = parseInt(sRunningTimeVal);
	
	console.log("---");
	if(iRunningTimeVal == 0){
		sMinutelyAtMinute =  $("#minutelyAtMinute").val();
		sStartProcessCron =  "0 0/"+ sMinutelyAtMinute +" * 1/1 * ? *";
		sStartProcessCronDetails = "{\"type\":0,\"minutely\":{\"atMinute\":" + sMinutelyAtMinute + "},\"hourly\":{},\"daily\":{},\"weekly\":{\"weekdays\":[]},\"monthly\":{\"weekdays\":[]},\"advancedCronExpression\":\"\"}";
	}
	else if(iRunningTimeVal == 1){
		//numberonly
		const oHourlyEveryHours  = $("#hourlyEveryHours");
		const oHourlyAtMinute  = $("#hourlyAtMinute");
		if(oHourlyEveryHours.val() == ""){
			alert("시간을 입력해 주십시오.");
			oHourlyEveryHours.focus();
			return false;
		}
		else{
			const iTmpStr =  parseInt(oHourlyEveryHours.val().replace(/,/, ""));
			if(iTmpStr < 1 || iTmpStr > 23){
				alert("시간은  1 ~ 23 사이여야 합니다.");
				oHourlyEveryHours.focus();
				return false;
			}
		}
		
		if(oHourlyAtMinute.val() == ""){
			alert("분을 입력해 주십시오.");
			oHourlyAtMinute.focus();
			return false;
		}
		else{
			const iTmpStr =  parseInt(oHourlyAtMinute.val().replace(/,/, ""));
			if(iTmpStr > 59){
				alert("분은  0 ~ 59 사이여야 합니다.");
				oHourlyAtMinute.focus();
				return false;
			}
		}
		
		sStartProcessCron = "0 "+ oHourlyAtMinute.val() +" 0/"+ oHourlyEveryHours.val() +" 1/1 * ? *";
		sStartProcessCronDetails = "{\"type\":1,\"minutely\":{},\"hourly\":{\"frequencyInHours\":\""+ oHourlyEveryHours.val() +"\",\"atMinute\":\""+ oHourlyAtMinute.val() +"\"},\"daily\":{},\"weekly\":{\"weekdays\":[]},\"monthly\":{\"weekdays\":[]},\"advancedCronExpression\":\"\"}";
	}
	
	else if(iRunningTimeVal == 2){
		//numberonly
		const oDdailyAtHour  = $("#dailyAtHour");
		const oDailyAtMinute  = $("#dailyAtMinute");
		if(oDdailyAtHour.val() == ""){
			alert("시간을 입력해 주십시오.");
			oDdailyAtHour.focus();
			return false;
		}
		else{
			const iTmpStr =  parseInt(oDdailyAtHour.val().replace(/,/, ""));
			if(iTmpStr > 23){
				alert("시간은  0 ~ 23 사이여야 합니다.");
				oDdailyAtHour.focus();
				return false;
			}
		}
		
		if(oDailyAtMinute.val() == ""){
			alert("분을 입력해 주십시오.");
			oDailyAtMinute.focus();
			return false;
		}
		else{
			const iTmpStr =  parseInt(oDailyAtMinute.val().replace(/,/, ""));
			if(iTmpStr > 59){
				alert("분은  0 ~ 59 사이여야 합니다.");
				oDailyAtMinute.focus();
				return false;
			}
		}
		
		sStartProcessCron = "0 "+ oDailyAtMinute.val() +" "+ oDdailyAtHour.val() +" 1/1 * ? *";
		sStartProcessCronDetails = "{\"type\":2,\"minutely\":{},\"hourly\":{},\"daily\":{\"atHour\":\""+ oDdailyAtHour.val() +"\",\"atMinute\":\""+ oDailyAtMinute.val() +"\"},\"weekly\":{\"weekdays\":[]},\"monthly\":{\"weekdays\":[]},\"advancedCronExpression\":\"\"}";
	}
	
	else if(iRunningTimeVal == 3){
		
		const aDayofWeek = $("input:checkbox[name='weeklyDayofWeek']:checked");
		const iaDayofWeek = aDayofWeek.length
		const oWweeklyAtHour  = $("#weeklyAtHour");
		const oWeeklyAtMinute  = $("#weeklyAtMinute");
		
		if(iaDayofWeek < 1){
			alert("요일을 선택해 주십시오.");
			return false;
		}
		if(oWweeklyAtHour.val() == ""){
			alert("시간을 입력해 주십시오.");
			oWweeklyAtHour.focus();
			return false;
		}
		else{
			const iTmpStr =  parseInt(oWweeklyAtHour.val().replace(/,/, ""));
			if(iTmpStr > 23){
				alert("시간은  0 ~ 23 사이여야 합니다.");
				oWweeklyAtHour.focus();
				return false;
			}
		}
		
		if(oWeeklyAtMinute.val() == ""){
			alert("분을 입력해 주십시오.");
			oWeeklyAtMinute.focus();
			return false;
		}
		else{
			const iTmpStr =  parseInt(oWeeklyAtMinute.val().replace(/,/, ""));
			if(iTmpStr > 59){
				alert("분은  0 ~ 59 사이여야 합니다.");
				oWeeklyAtMinute.focus();
				return false;
			}
		}
		
		let sDoWVal = "";
		let sDoWDetailVal = "";
		for(let i = 0; i < iaDayofWeek; i++){
			const oaDayofWeek = $(aDayofWeek[i]);
			if(sDoWVal != "") {
				sDoWVal += ",";
				sDoWDetailVal += ",";
			}
			const sTempVal = oaDayofWeek.val()
			const sTempNm = oaDayofWeek.attr("data-item-name");
			sDoWVal += sTempVal;
			sDoWDetailVal += "{\"id\":\"" + sTempVal +"\",\"weekly\":\""+ sTempNm + "\",\"monthly\":\""+ sTempNm + "\"}";
		}
		
		sStartProcessCron = "0 "+ oWeeklyAtMinute.val() +" "+ oWweeklyAtHour.val() +" ? * "+ sDoWVal +" *"
		sStartProcessCronDetails = "{\"type\":3,\"minutely\":{},\"hourly\":{},\"daily\":{},\"weekly\":{\"weekdays\":["+ sDoWDetailVal +"],\"atHour\":\""+ oWweeklyAtHour.val() +"\",\"atMinute\":\""+oWeeklyAtMinute.val() +"\"},\"monthly\":{\"weekdays\":[]},\"advancedCronExpression\":\"\"}"
	}
	
	else if(iRunningTimeVal == 4){
		
		const aDayofWeek = $("input:checkbox[name='monthlyDayofWeek']:checked");
		const iaDayofWeek = aDayofWeek.length
		const oFrequency = $("#monthlyFrequency");
		const oAtHour  = $("#monthlyAtHour");
		const oAtMinute  = $("#monthlyAtMinute");
		
		if(oFrequency.val() == ""){
			alert("개월을 입력해 주십시오.");
			oFrequency.focus();
			return false;
		}
		else{
			const iTmpStr =  parseInt(oFrequency.val().replace(/,/, ""));
			if(iTmpStr < 1 || iTmpStr > 23){
				alert("개월은  1 ~ 12 사이여야 합니다.");
				oFrequency.focus();
				return false;
			}
		}
				
		if(iaDayofWeek < 1){
			alert("요일을 선택해 주십시오.");
			return false;
		}
		if(oAtHour.val() == ""){
			alert("시간을 입력해 주십시오.");
			oAtHour.focus();
			return false;
		}
		else{
			const iTmpStr =  parseInt(oAtHour.val().replace(/,/, ""));
			if(iTmpStr > 23){
				alert("시간은  0 ~ 23 사이여야 합니다.");
				oAtHour.focus();
				return false;
			}
		}
		
		if(oAtMinute.val() == ""){
			alert("분을 입력해 주십시오.");
			oAtMinute.focus();
			return false;
		}
		else{
			const iTmpStr =  parseInt(oAtMinute.val().replace(/,/, ""));
			if(iTmpStr > 59){
				alert("분은  0 ~ 59 사이여야 합니다.");
				oAtMinute.focus();
				return false;
			}
		}
		
		let sDoWVal = "";
		let sDoWDetailVal = "";
		for(let i = 0; i < iaDayofWeek; i++){
			const oaDayofWeek = $(aDayofWeek[i]);
			if(sDoWVal != "") {
				sDoWVal += ",";
				sDoWDetailVal += ",";
			}
			const sTempVal = oaDayofWeek.val()
			const sTempNm = oaDayofWeek.attr("data-item-name");
			sDoWVal += sTempVal;
			sDoWDetailVal += "{\"id\":\"" + sTempVal +"\",\"weekly\":\""+ sTempNm + "\",\"monthly\":\""+ sTempNm + "\"}";
		}
		//oFrequency
		//oAtHour
		//oAtMinute
		sStartProcessCron =  "0 "+ oAtMinute.val() +" "+ oAtHour.val() +" ? 1/"+ oFrequency.val() +" "+ sDoWVal +" *"
		sStartProcessCronDetails = "{\"type\":4,\"minutely\":{},\"hourly\":{},\"daily\":{},\"weekly\":{\"weekdays\":[]},\"monthly\":{\"weekdays\":["+ sDoWDetailVal +"],\"atMinute\":\""+ oAtMinute.val() +"\",\"atHour\":\""+ oAtHour.val() +"\",\"frequencyInMonths\":\""+ oFrequency.val() +"\"},\"advancedCronExpression\":\"\"}"
	}
	else if(iRunningTimeVal == 5){
		const oAdvancedCron  = $("#advancedCron");
		
		if(oAdvancedCron.val() == ""){
			alert("Cron 표현식을 입력해 주십시오.");
			return false;
		}
		sStartProcessCron =  oAdvancedCron.val();
		sStartProcessCronDetails = "{\"type\":5,\"minutely\":{},\"hourly\":{},\"daily\":{},\"weekly\":{\"weekdays\":[]},\"monthly\":{\"weekdays\":[]},\"advancedCronExpression\":\""+ oAdvancedCron.val() +"\"}";
		
		
	}
	
	
	
	
	
	
	//---동작 시간 종료
	
	
	//휴무일 제한사항 시작
	let bUseCalendar = false;
	let iCalendarId = 0;
	const sTargetCalendarsVal = $("#targetCalendars").val();
	if(sTargetCalendarsVal != ""){
		bUseCalendar = true;
		iCalendarId = parseInt(sTargetCalendarsVal);
	}
	//휴무일 제한사항 종료
	
	//--다음이후 작업 중지 시작
	let sStopProcessExpression = "";
	let sStopStrategy = null
	const bCustomSwitch1Checked = $("input:checkbox[id=customSwitch1]").is(":checked");
	if(bCustomSwitch1Checked){
		const oCustomSwitch1_Day = $("#customSwitch1_day");
		const oCustomSwitch1_Hour = $("#customSwitch1_hour");
		const oCustomSwitch1_Minute = $("#customSwitch1_minute");
		if(oCustomSwitch1_Day.val() == ""){
			alert("다음이후 작업중지 > 일을 입력해 주십시오.");
			oCustomSwitch1_Day.focus();
			return false;
		}
		else if(oCustomSwitch1_Hour.val() == ""){
			alert("다음이후 작업중지  시간을 입력해 주십시오.");
			oCustomSwitch1_Hour.focus();
			return false;
		}
		else if(oCustomSwitch1_Minute.val() == ""){
			alert("다음이후 작업중지  분을 입력해 주십시오.")
			oCustomSwitch1_Minute.focus();
			return false;
		}
		
		const iCustomSwitch1_Day = parseInt(oCustomSwitch1_Day.val());
		const iCustomSwitch1_Hour = parseInt(oCustomSwitch1_Hour.val());
		const iCustomSwitch1_Minute = parseInt(oCustomSwitch1_Minute.val());
		let iStopProcessExpression = 0;
		if(iCustomSwitch1_Day > 10){
			alert("다음이후 작업중지 > 10일을 초과할 수 없습니다.");
			return false;
		}
		else if(iCustomSwitch1_Hour > 23){
			alert("다음이후 작업중지 > 23시간을 초과할 수 없습니다.");
			return false;
		}
		else if(iCustomSwitch1_Minute > 59){
			alert("다음이후 작업중지 > 59분을 초과할 수 없습니다.");
			return false;
		}
		
		iStopProcessExpression = (iCustomSwitch1_Day * 3600 * 24) + (iCustomSwitch1_Hour * 3600) + (iCustomSwitch1_Minute * 60)
		if(iStopProcessExpression == 0){
			alert("다음이후 작업중지 > 1분이상 입력해 주십시오");
			return false;
		}

		sStopProcessExpression = "" + iStopProcessExpression;
		sStopStrategy = $("input:radio[name=customSwitch1-state]:checked").val();
	}
	//--다음이후 작업 중지 종료
	
	//다음 트리거 사용안함 시작
	let sStopProcessDate = null
	const bCustomSwitch2Checked = $("input:checkbox[id=customSwitch2]").is(":checked");
	if(bCustomSwitch2Checked){
		const oCustomSwitch2_de = $("#customSwitch2_de")
		if(oCustomSwitch2_de.val() == ""){
			alert("시점 날짜를 입력해 주십시오.");
			return false
		}
		sStopProcessDate = oCustomSwitch2_de.val() + "T" + $("#customSwitch2_hour").val() + ":" + $("#customSwitch2_Minute").val() + ":00Z"
	}
	
	//Release 정보 시작
	let oSelectReleases = lc_releases_data.find(function(releases) {
		  return releases.Id === parseInt(oTargetReleases.val());
		});
	
	//Release 정보 종료
	

	let oParams = {
			Enabled: true
			, ExternalJobKey: ""
			, ReleaseId: oSelectReleases.Id
			, ReleaseName: oSelectReleases.Name
			, ExecutorRobots: aExecutorRobots
			, InputArguments: sInputArgumentsItemTmp
			, Name: oTargetNm.val()
			, StartProcessCron: sStartProcessCron
			, StartProcessCronDetails: sStartProcessCronDetails
			, StartStrategy: iStartStrategy
			, StopProcessDate: sStopProcessDate
			, StopProcessExpression: sStopProcessExpression
			, StopStrategy: sStopStrategy
			, TimeZoneId: sTimeZoneId
			, UseCalendar: bUseCalendar
	};
	
	if(bUseCalendar){
		oParams.CalendarId = iCalendarId;
	}
	
	return oParams;
}
</script>