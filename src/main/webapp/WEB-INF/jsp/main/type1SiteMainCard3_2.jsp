<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>



<div class="card-header">
    <h3 class="card-title">신규등록 프로세스</h3>
    <select id="listType2" ></select>
     <!-- 20201016 ja -  셋팅 팝업 버튼 추가 -->
     <div class="card-tools">
         <button type="button" class="btn btn-tool" title="Contacts" data-widget="chat-pane-toggle"><i class="fas fa-cog"></i></button>
     </div>
     <!-- // 20201016 ja -  셋팅 팝업 버튼 추가 -->
</div>
<div class="card-body">
    <div class="card-body-wrap">
	    <div class="list_ty1" id="newProcessDiv">
	       <div class="list-item">조회된 내용이 없습니다.</div>
	    </div>
	    <!-- 20201016 ja -  셋팅 팝업 추가 -->
	    <div class="direct-chat-contacts custom-popup" style="display: none;">
	        <div class="pop-wrap">
	            <ul class="pop-list"></ul>
	        </div>
	    </div>
	    <!-- // 20201016 - ja 셋팅 팝업 추가 -->
	</div>
</div>





<script>
    

    $(document).ready(function() { 
    	
    	var params = [];
        params.push({"id" : "listType2", "clsCd" : "0051"});
        requestCmmnCd(params);
        $('#listType2 option:first').remove();
        
        getNewProcessList();  
        
        $("#listType2").on("change", function() {
        	getNewProcessList();  
        });
        
        
    });

    
    //나의 프로세스
    function getNewProcessList(){        
        var url = "/main/task/getNewProcessList";
        var param = {
        	 listType : $('#listType2').val()	
        }; 
        callAsyncAjax(url, param, "drawNewProcessList");
    }
    
    
    //나의 프로세스
    function drawNewProcessList(data){
    	
        var newProcessList = data.result.newProcessList;

        var tmp = "";
        
        if(newProcessList.length > 0){
        	
             $.each(newProcessList, function(idx, item) {
            	 
	            tmp += '<div class="list-item">';
	            tmp += '<div class="list-left">';
	            tmp += '<div class="list-tit">'+item.processNm+'</div>';
	            tmp += '<div class="text-muted">'+item.date+'/'+item.usernm+'</div>';
	            tmp += '</div>';
	            tmp += '<div class="list-right">';
	            tmp += '<div class="text-success"><strong>'+item.redcnTm+' H</strong></div>';
	            tmp += '<div class="text-muted">'+item.deptnm+'</div>';
	            tmp += '</div>';
	            tmp += '</div>';
	            
             });
             
             if(data.result.jobsAuthor == "Y"){
                 //오늘의 프로세스 실행현황
                 $("#newProcessDiv").on("click", function() {
                      var url = "/mntrng/jobmntrng/jobMntrngMain?mainInitAt=Y";
                      location.replace(url);
                 });
                
                $("#newProcessDiv").css({ cursor: 'pointer' });
             }
             
             
        }else{
            tmp = '<div class="list-item">조회된 내용이 없습니다.</div>';
        }
        
        $('#newProcessDiv').html(tmp);
        
        
    }


</script>