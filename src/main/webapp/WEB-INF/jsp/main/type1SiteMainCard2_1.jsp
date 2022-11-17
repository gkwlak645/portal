<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="card-header">
    <h3 class="card-title">나의 프로세스</h3>
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
        <div class="row">
            <div class="col-md-4" id="taskProcessMngDiv">
                <dl class="process">
                    <dt style="color: #0065bd;">
                        <i class="fas fa-tv"></i>
                        <span>운영</span>
                    </dt>
                    <dd id="taskProcessMngCnt">0</dd>
                </dl>
            </div>
            <div class="col-md-4" id="taskProcessDevDiv">
                <dl class="process process-line">
                    <dt style="color: #01b2f5;">
                        <i class="fas fa-tools"></i>
                        <span>개발</span>
                    </dt>
                    <dd id="taskProcessDevCnt">0</dd>
                </dl>
            </div>
            <div class="col-md-4" id="taskIdeaDiv">
                <dl class="process">
                    <dt style="color: #ffb3b3;">
                        <i class="fas fa-lightbulb"></i>
                        <span>아이디어</span>
                    </dt>
                    <dd id="taskIdeaCnt">0</dd>
                </dl>
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
    	getTaskProcessCnt();  
    	
    });

    
    //나의 프로세스
    function getTaskProcessCnt(){        
        var url = "/main/task/getTaskProcessCnt";
        var param = {}; 
        callAsyncAjax(url, param, "drawTaskProcessCnt");
    }
    
    
    //나의 프로세스
    function drawTaskProcessCnt(data){
    	//운영
        $('#taskProcessMngCnt').html(addCommas(data.result.taskProcessMngCnt));
        //개발
    	$('#taskProcessDevCnt').html(addCommas(data.result.taskProcessDevCnt));
        //아이디어
        $('#taskIdeaCnt').html(addCommas(data.result.taskIdeaCnt));
        
        if(data.result.taskProcessMngAuthor == "Y"){
        	//운영
            $("#taskProcessMngDiv").bind("click", function() {
                 var url = "/task/manage/taskManageMain";
                 location.replace(url);
            });
        	
            $("#taskProcessMngDiv").css({ cursor: 'pointer' });
        }
	   
	    if(data.result.taskProcessDevAuthor == "Y"){
	    	 //개발
            $("#taskProcessDevDiv").bind("click", function() {
                 var url = "/task/develop/taskDevelopMain";
                 location.replace(url);
            });
	    	 
            $("#taskProcessDevDiv").css({ cursor: 'pointer' });
	    }
	   
	    if(data.result.taskIdeaAuthor == "Y"){
	    	//아이디어
            $("#taskIdeaDiv").bind("click", function() {
                 var url = "/task/idea/taskIdeaMain";
                 location.replace(url);
            });
	    	
            $("#taskIdeaDiv").css({ cursor: 'pointer' });
	    }
    }


</script>
