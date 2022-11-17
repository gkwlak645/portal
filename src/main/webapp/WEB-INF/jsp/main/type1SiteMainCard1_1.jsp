<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="card-header">
    <h2 class="card-title" id="title">RPA현황</h2>
     <!-- 20201016 ja -  셋팅 팝업 버튼 추가 -->
     <div class="card-tools">
         <button type="button" class="btn btn-tool" title="Contacts" data-widget="chat-pane-toggle"><i class="fas fa-cog"></i></button>
     </div>
     <!-- // 20201016 ja -  셋팅 팝업 버튼 추가 -->
</div>
<div class="card-body">
    <div class="rpa_circle" >
        <div class="rpa_circle_wrap">
            <div class="rpa_circle_item bg-navy" style="height: 156.438px;">
                <div class="circle_innr" >
					<i class="icon fas fa-2x fa-funnel-dollar"></i>
                    <h6 style="margin-bottom: 0; padding: 4px 0;">절감시간</h6>
                    <h4 id="redcnAmt">0</h4>
                </div>
            </div>
			<div class="radio_wrap" style="text-align: left;">
				<div>
					<input type="radio" name="chkRoi" id="roiWeek" checked>
					<label for="roiWeek">Week</label>
				</div>
				<div>
					<input type="radio" name="chkRoi" id="roiMon">
					<label for="roiMon">Month</label>
				</div>
				<div>
					<input type="radio" name="chkRoi" id="roiYear">
					<label for="roiYear">Year</label>
				</div>
				<!-- <div class="text-secondary" id="stdYear">
					(기준 : 2020년 )
				</div> -->
				<div class="text-secondary">
					(단위 : 천시간)
				</div>
			</div>
            <div class="rpa_circle_item bg-danger" style="height: 156.438px;">
                <div class="circle_innr" id="processMngDiv">
                    <i class="icon fas fa-2x fa-envelope"></i>
                    <h6 style="margin-bottom: 0; padding: 4px 0;">프로세스</h6>
                    <h4 id="processMngCnt">0</h4>
                </div>
            </div>
            <div class="rpa_circle_item bg-success" id="robotDiv" style="height: 156.438px;">
                <div class="circle_innr">
                    <i class="icon fas fa-2x fa-robot"></i>
                    <h6 style="margin-bottom: 0; padding: 4px 0;">봇수</h6>
                    <h4 id="robotCnt">0</h4>
                </div>
            </div>
            <div class="rpa_circle_item bg-gray" style="height: 156.438px;">
                <div class="circle_innr">
                    <i class="icon fas fa-2x fa-thumbs-up"></i>
                    <h6 style="margin-bottom: 0; padding: 4px 0;">최근 성공률(7일)</h6>
                    <h4 id="succesRt">0<span>%</span></h4>
                </div>
            </div>
            <div class="rpa_circle_item" style="height: 156.438px;background-color: #eee !important">
                <div class="circle_innr">
                    <i class="icon fas fa-2x fa-chart-bar"></i>
                    <h6 style="margin-bottom: 0; padding: 4px 0;">절감률</h6>
                    <h4 id="redcnRt">0<span>%</span></h4>
                </div>
            </div>
        </div>
    </div>
    <!-- 20201016 ja -  셋팅 팝업 추가 -->
    <div class="direct-chat-contacts custom-popup" style="display: none;">
        <div class="pop-wrap">
            <ul class="pop-list"></ul>
        </div>
    </div>
    <!-- // 20201016 - ja 셋팅 팝업 추가 -->
</div>

<script>

  $(document).ready(function() { 
	  //getToYear();
      getRPAStatusCnt(); 
      
      //프로세스
      $("input[name='chkRoi']").on("change", function() {
    	  getRPAStatusCnt();
      });
      
  });
  
  //현재 년도 가져오기
  function getToYear(){
      var date = new Date()
      $('#stdYear').html('(기준 : ' + date.getFullYear() + '년 )')
  }

  
  // RPA - 현황
  function getRPAStatusCnt(){        
      var url = "/main/rpaStatus/getRPAStatusCnt";
      var param = {};
      
      param.chkRoi = $('input[name="chkRoi"]:checked').attr('id');

      callAsyncAjax(url, param, "drawRPAStatusCnt");
  }
  
  // RPA - 현황 콜백
  function drawRPAStatusCnt(data){
  	
	  //****************** 날짜 기준 : 올해년도(1/1 ~ 12/31) ******************
	  
	  //title 
	  $('#title').html("RPA현황 "+"( "+data.result.cmpnyNm+" )");
	  
	  //절감금액(운영 프로세스의 전체 절감시간 * 올 해의 시간당 인건비 단가)
      $('#redcnAmt').html(addCommas(data.result.redcnAmt));
  	
      //프로세스 운영(O1:운영중)
      $('#processMngCnt').html(addCommas(data.result.processMngCnt));
      
      //봇 총 개수
      $('#robotCnt').html(addCommas(data.result.robotCnt));
      
      //절감률 (운영 프로세스의 전체 절감시간 / 운영 프로세스의 전체 업무시간 ) * 100
      $('#redcnRt').html(data.result.redcnRt+"<span>%</span>");
      
      //최근 성공률 (JOB 성공횟수 / JOB 총 수행 건수) * 100
      $('#succesRt').html(data.result.succesRt+"<span>%</span>");
      
      
      if(data.result.processMngRedngAuthor == "Y"){
    	//프로세스
          $("#processMngDiv").bind("click", function() {
               var url = "/task/manage/taskManageMain";
               location.replace(url);
          });
    	
          $("#processMngDiv").css({ cursor: 'pointer' });
      }
      
      
      if(data.result.robotRedngAuthor == "Y"){
    	  //봇 수
          $("#robotDiv").bind("click", function() {
               var url = "/resrce/robot/robotMngMain";
               location.replace(url);
          });
    	  
          $("#robotDiv").css({ cursor: 'pointer' });
      }
    
      
  }


</script>
