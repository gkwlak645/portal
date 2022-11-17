<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="card-header">
    <h3 class="card-title">오늘의 프로세스 실행현황</h3>
     <select id="listType" ></select>
     <!-- 20201016 ja -  셋팅 팝업 버튼 추가 -->
     <div class="card-tools">
         <button type="button" class="btn btn-tool" title="Contacts" data-widget="chat-pane-toggle">
             <i class="fas fa-cog"></i>
         </button>
     </div>
     <!-- // 20201016 ja -  셋팅 팝업 버튼 추가 -->
</div>
<div class="card-body">
    <div class="card-body-wrap">
        <div class="list_ty4" id="todayProcessListDiv">
            <div class="list-item">
                    <div class="list-tit">조회된 내용이 없습니다.</div>
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
    	
    	var params = [];
        params.push({"id" : "listType", "clsCd" : "0050"});
        requestCmmnCd(params);
        $('#listType option:first').remove();
        
    	getTodayProcessList();  
        
        $("#listType").on("change", function() {
        	getTodayProcessList();  
        });
        
        
    });

    
    //나의 프로세스
    function getTodayProcessList(){        
        var url = "/main/task/getTodayProcessList";
        var param = {
        	listType : $('#listType').val()	
        }; 
        callAsyncAjax(url, param, "drawTodayProcessList");
    }
    
    
    //나의 프로세스
    function drawTodayProcessList(data){
    	
    	if(data.result.listType != null && data.result.listType != "" && data.result.listType == "M"){
    		$('#listType').val('M').prop('selected',true);
    		$('#listType').prop('disabled',true);
    	}

        var todayProcessList = data.result.todayProcessList;

        var tmp = "";
        
        if(todayProcessList.length > 0){
             $.each(todayProcessList, function(idx, item) {
            	 
            	 var stateTmp = '';
            	 //성공
            	 if(item.State == '5'){
            		 stateTmp = '<i class="list-icon fas fa-redo-alt" style="background-color: #0065bd;"></i>';
            	 //실패
            	 }else if(item.State == '2' || item.State == '3' || item.State == '4' || item.State == '6' || item.State == '7' || item.State == '8'){
            		 stateTmp = '<i class="list-icon fas fa-ban" style="background-color: #eb661a;"></i>'; 
            	 //보류
            	 }else if(item.State == '0'){
            		 stateTmp = '<i class="list-icon fas fa-pause" style="color: #6c757d; background-color: #ddd;"></i>';
            	 }else if(item.State == '1'){
                 //실행중
            		 stateTmp = '<i class="list-icon fas fa-play" style="background-color: #BCE55C;"></i>';
                 }else{
            		 stateTmp = '';
            	 }
                 
	            tmp += '<div class="list-item">';
	            tmp += stateTmp;
	            tmp += '<div class="list-left">';
	            tmp += '<div class="list-tit">'+item.releaseName+'</div>';
	            tmp += '<div class="text-secondary">'+item.startTime+'</div>';
	            tmp += '</div>';
	            tmp += '<div class="list-right list-item">';
	            //tmp='<div class="list-left" style="width: 60%">';
	            //tmp='<div class="text-warning" style="font-size: 18px;">73%</div>';
	            //tmp='<div class="list-tit text-secondary">line 33 of 68 Delay</div>';
	            //tmp='</div>';
	            tmp += '<div class="list-right text-center" style="width: 75%; height: 3em; overflow: hidden;">'+item.robotName+'</div>';
	            tmp += '</div>';
	            tmp += '</div>';
	            
             });
             
             if(data.result.jobsAuthor == "Y"){
                 //오늘의 프로세스 실행현황
                 $("#todayProcessListDiv").on("click", function() {
                      var url = "/mntrng/jobmntrng/jobMntrngMain?mainInitAt=Y";
                      location.replace(url);
                 });
                
                $("#todayProcessListDiv").css({ cursor: 'pointer' });
             }
             
             
        }else{
            tmp = '<div class="list-item">조회된 내용이 없습니다.</div>';
        }
        
        $('#todayProcessListDiv').html(tmp);
        
        
    }


</script>