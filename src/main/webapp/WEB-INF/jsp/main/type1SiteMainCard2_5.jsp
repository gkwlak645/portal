<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- card-header -->
<div class="card-header">
    <h3 class="card-title">실행결과</h3>
    <!-- 20201016 ja -  셋팅 팝업 버튼 추가 -->
    <div class="card-tools">
        <button type="button" class="btn btn-tool" title="Contacts" data-widget="chat-pane-toggle">
            <i class="fas fa-cog"></i>
        </button>
    </div>
    <!-- // 20201016 ja -  셋팅 팝업 버튼 추가 -->
</div>
<!-- /card-header -->
<!-- card-body -->
<div class="card-body" style="padding: 0;">
    <div class="stepbox" id="jobsCntDiv">
        <div class="stepbox-item step_succ">
            <strong class="step-txt">성공</strong>
            <i class="step-icon fas fa-2x fa-redo-alt" style="background-color: #0065bd;"></i>
            <span  class="step-num" id="jobsSucCnt">0</span>
        </div>
        <div class="stepbox-item step_fals">
            <strong class="step-txt">실패</strong>
            <i class="step-icon fas fa-2x fa-ban" style="background-color: #eb661a;"></i>
            <span  class="step-num" id="jobsFaiCnt">0</span>
        </div>
        <div class="stepbox-item step_hold">
            <strong class="step-txt">보류</strong>
            <i class="step-icon fas fa-2x fa-pause" style="background-color: grey;"></i>
            <span  class="step-num" id="jobsPenCnt">0</span>
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
<!-- /card-body -->



<script>
    

    $(document).ready(function() { 
    	getJobsCnt();  
    });

    
    //나의 프로세스
    function getJobsCnt(){        
        var url = "/main/jobmntrng/getJobsCnt";
        var param = {}; 
        callAsyncAjax(url, param, "drawJobsCnt");
    }
    
    
    //나의 프로세스
    function drawJobsCnt(data){
        //성공
        $('#jobsSucCnt').html(addCommas(data.result.jobsSucCnt));
        //실패
        $('#jobsFaiCnt').html(addCommas(data.result.jobsFaiCnt));
        //보류
        $('#jobsPenCnt').html(addCommas(data.result.jobsPenCnt));
        
        
        if(data.result.jobsAuthor == "Y"){
        	 //실행결과
            $("#jobsCntDiv").on("click", function() {
                 var url = "/mntrng/jobmntrng/jobMntrngMain?mainInitAt=Y";
                 location.replace(url);
            });
            
            $("#jobsCntDiv").css({ cursor: 'pointer' });
        }
    }


</script>