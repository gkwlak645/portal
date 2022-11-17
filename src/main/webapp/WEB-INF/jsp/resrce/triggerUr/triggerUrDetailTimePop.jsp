<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!--  템플릿 바디 -->
					<div class="card card-primary card-tabs">
                        <div class="card-header">
					        <h3 class="card-title">시간 상세</h3>
					    </div>                      
                        <div class="card-body" >
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
                                                            <input type="text" class="form-control float-left col-sm-9" id="releasesSearchKwrd" name="searchKwrd" style="width:60%;min-width:75px;" value="" />
                                                            <button type="button" id="btnReleasesSearch" class="btn btn-info float-left ">조회</button>
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
				                         	  <button type="button" class="btn btn-primary float-right" id="btnClose"  style="margin:5px 0 15px 1px;">닫기</button>
	                                          <button type="button" class="btn btn-primary float-right" id="btnUpdate"  style="margin:5px 0 15px 4px;">업데이트</button>
	                                          
	                                      </div>
	                                 </div>
	                                 <!-- 우측영역 End -->
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
	console.log("----	triggerUrDetailTimePop > ready");
	pageInit();
    bindEvent();
});

function pageInit(){
	let customSwitch2_hour_html = "";
	for(let i = 0; i < 24; i++){
		const sTmp = i < 10 ? "0" + i : "" + i; 
		customSwitch2_hour_html += '<option value="'+ sTmp +'">'+sTmp+'</option>';
	}
	$("#customSwitch2_hour").html(customSwitch2_hour_html);
}

function getProcessSchedulesCallback(data){
	console.log("function getProcessSchedulesCallback")
	lc_oProcessSchedule =  data.result;
	lc_select_releases_id = lc_oProcessSchedule.ReleaseId;
	console.log("-----------------11")
	//프로세스 정보
	initSearchReleases(lc_oProcessSchedule.ReleaseName)
	console.log("-----------------12")
	//이름
	$("#targetNm").val(lc_oProcessSchedule.Name)
	//선택된 프로세스 조회
	
	console.log("-----------------13")
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
	console.log("aaaa")
	if(lc_oProcessSchedule.InputArguments != null){
		const oInputArguments = JSON.parse(lc_oProcessSchedule.InputArguments);
		for (const sKey in oInputArguments) {
			$("input[name=inputArgumentsItem][item-data-name="+ sKey +"]").val(oInputArguments[sKey])
		}
	}
	
	//표준 시간대
	searchTimezones()
	
	//시간 세팅
	const oTimeInfo = JSON.parse(lc_oProcessSchedule.StartProcessCronDetails)
	const iTimeType = oTimeInfo.type;
	$("input[name=mat-radio-group-765][value=" + iTimeType +"]").click();
	if(iTimeType == 0){
		$("#minutelyAtMinute").val(oTimeInfo.minutely.atMinute);
	}
	else if(iTimeType == 1){
		$("#hourlyEveryHours").val(oTimeInfo.hourly.frequencyInHours);
		$("#hourlyAtMinute").val(oTimeInfo.hourly.atMinute);
	}
	else if(iTimeType == 2){
		$("#dailyAtHour").val(oTimeInfo.daily.atHour);
		$("#dailyAtMinute").val(oTimeInfo.daily.atMinute);
	}
	else if(iTimeType == 3){
		$("#weeklyAtHour").val(oTimeInfo.weekly.atHour);
		$("#weeklyAtMinute").val(oTimeInfo.weekly.atMinute);
		const  iWeekdays =  oTimeInfo.weekly.weekdays.length;
		for(let i = 0; i < iWeekdays; i++){
			$("input[name=weeklyDayofWeek][value="+ oTimeInfo.weekly.weekdays[i].id +"]").prop("checked", true)
			
		}
	}
	else if(iTimeType == 4){
		oTimeInfo.monthly
		$("#monthlyFrequency").val(oTimeInfo.monthly.frequencyInMonths);
		$("#monthlyAtHour").val(oTimeInfo.monthly.atHour);
		$("#monthlyAtMinute").val(oTimeInfo.monthly.atMinute);
		const  iWeekdays =  oTimeInfo.monthly.weekdays.length;
		for(let i = 0; i < iWeekdays; i++){
			$("input[name=monthlyDayofWeek][value="+ oTimeInfo.monthly.weekdays[i].id +"]").prop("checked", true)
		}
		
	}
	else if(iTimeType == 5){
		$("#advancedCron").val(oTimeInfo.advancedCronExpression);
	}
	
	//휴무일 제한사항
	searchCalendars();
	
	//다음이후 작업 중지
	if(lc_oProcessSchedule.StopProcessExpression != ""){
		$("#customSwitch1-label").click();
		let iStopProcessTime = parseInt(lc_oProcessSchedule.StopProcessExpression);
		if(iStopProcessTime >= 60 * 60 * 24){
			$("#customSwitch1_day").val(Math.floor(iStopProcessTime / (60*60*24)));
			iStopProcessTime = iStopProcessTime % (60*60*24)
		}
		else{
			$("#customSwitch1_day").val(0);
		}
		
		if(iStopProcessTime >= 60 * 60){
			$("#customSwitch1_hour").val(Math.floor(iStopProcessTime / (60*60)));
			iStopProcessTime = iStopProcessTime % (60*60)
		}
		else{
			$("#customSwitch1_hour").val(0);
		}
		
		if(iStopProcessTime >= 60){
			$("#customSwitch1_minute").val(Math.floor(iStopProcessTime / (60)));
			iStopProcessTime = iStopProcessTime % (60)
		}
		else{
			$("#customSwitch1_minute").val(0);
		}

		$("input[name=customSwitch1-state][value="+ lc_oProcessSchedule.StopStrategy +"]").prop("checked", true);
	}
	
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
	console.log("function initSearchReleasesCallback()")
	lc_releases_data = data.result.resultList;
	
	GBL_createSearchResultComboBox({id: "targetReleases", resultList: lc_releases_data, optVal: "Id", optNm: "Name", emptyOption: "Y", selectValue: lc_select_releases_id});
}

function initRobotIdsForProcessSchedules(){
	let oParams = {schduleId: lc_select_schdule_id, loading_id: (lc_loading_id++)}
	///odata/ProcessSchedules(128)
	callSyncAjax("/resrce/triggerUr/getRobotIdsForProcessSchedules", oParams, "initRobotIdsForProcessSchedulesCallback");
}

function initRobotIdsForProcessSchedulesCallback(data){
	const aBot = data.result.value;
	const iaBot = aBot.length
	if(iaBot > 0){
		for(let i=0; i < iaBot; i++){
			console.log("aBot[i]: " + aBot[i])
			$("input[name=targetRobotId][value="+ aBot[i] +"]").attr("checked", true);
		}
		//aBot
	}
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
	lc_select_releases_id = "";
	
	//특정로봇 초기화
}

function searchTimezones(){
	var url = '/resrce/triggerUr/searchTimezones';
	var param = {};
	callAsyncAjax(url, param, "searchTimezonesCallback");
	
}

function searchTimezonesCallback(data){
	//console.log("function searchTimezonesCallback")
	GBL_createSearchResultComboBox({id: "timezones1", resultList: data.result.resultList, optVal: "Value", optNm: "Name", selectValue: lc_oProcessSchedule.TimeZoneId, emptyOption: "Y"} );	
	$('#timezones1').attr('disabled', 'true');
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
	if(lc_oProcessSchedule.CalendarId != null){
		$("#targetCalendars").val("" + lc_oProcessSchedule.CalendarId);
	}
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
		callSyncAjax(url, param, "searchEnvironmentRobotsCallback");
	}
}

function searchEnvironmentRobotsCallback(data){
	drawTargetRobotList(data.result.resultList);
}

function updateProcessSchedulesCallback(data){
	mainPopCloseReload();
}

function bindEvent(){
	console.log("----	triggerUrDetailTimePop > ready()");
	$('#customSwitch2_de_div').datetimepicker({
        format: 'YYYY-MM-DD'
      //, defaultDate: (new Date())
    });
	
	//닫기
	$("#btnClose").on("click", function() {
		mainPopClose();
	});
	
	//프로세스 조회
	$("#btnReleasesSearch").on("click", function(e){
		drawTargetRobotList([]);	//시간 > 특정로봇 초기화
		$("#timeParametaList tbody").html("");
		searchReleases($("#releasesSearchKwrd").val());
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
		}
		else{
			let sTmp =  "";
			let selectObj = lc_releases_data.find(function(releases) {
				  return releases.Id === parseInt(selectVal);
				});
			
			//par
			drawParameterList(selectObj.Arguments.Input);
		}
	});
	
	//실행정보
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
	
	//파라미터
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
	
	//실행타겟 > 모든로봇/특정로봇/동적으로할당
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
	
	$("#btnUpdate").on("click", function(e){
		const oParams = Add1Check();
		if(oParams == false){
			return false;
		}
		oParams.Id = lc_oProcessSchedule.Id
		oParams.ExternalJobKey = lc_oProcessSchedule.ExternalJobKey
		oParams.Enabled = lc_oProcessSchedule.Enabled
		callAsyncAjax("/resrce/triggerUr/updateProcessSchedules", oParams, "updateProcessSchedulesCallback");
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
			return false;
		}
	});
	
	let oParams = {schduleId: lc_select_schdule_id, loading_id: (lc_loading_id++)}
	///odata/ProcessSchedules(128)
	callSyncAjax("/resrce/triggerUr/getProcessSchedules", oParams, "getProcessSchedulesCallback");
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
	$("#timeParametaList tbody").html(sTmp);
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