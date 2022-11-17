<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>



<div class="card-header">
    <h3 class="card-title">부분별 프로세스 현황</h3>
    <!-- 20201016 ja -  셋팅 팝업 버튼 추가 -->
     <div class="card-tools">
         <button type="button" class="btn btn-tool" title="Contacts" data-widget="chat-pane-toggle"><i class="fas fa-cog"></i></button>
     </div>
     <!-- // 20201016 ja -  셋팅 팝업 버튼 추가 -->
</div>
<div class="card-body">
	<div class="form-group board_ty1">
	    <div class="board-wrap2">
	       <div class="circle_board">
	           <div class="circle_board-innr" id="clsDiv"></div>
	       </div>
	    </div>
	    <div class="board-score">프로세스<strong id="allCnt">59</strong></div>
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
    	getClsProcessStatusCnt();  
    });

    
    //부분별 프로세스 현황
    function getClsProcessStatusCnt(){        
        var url = "/main/clsProcessStatus/getClsProcessStatusCnt";
        var param = {}; 
        callAsyncAjax(url, param, "drawClsProcessStatusCnt");
    }
    
    
    //나의 프로세스
    function drawClsProcessStatusCnt(data){
        
        var clsProcessStatusCntList = data.result.clsProcessStatusCntList;
        var iclsProcessStatusCntList = clsProcessStatusCntList.length;
        var tmp = '';
        var chkSIdx = 0;
        
        $.each(clsProcessStatusCntList ,function(idx,item){
        	
        	if(idx == iclsProcessStatusCntList-1){ 
                $('#allCnt').html(item.cnt);
            }else{
            	/* var chkEIdx = (idx+1) % 4;
                
                if(chkSIdx == idx){
                    tmp += '<div class="circle_board">';
                    chkSIdx = chkSIdx+4;
                } */

                tmp += '<div class="circle_wrap">';
                tmp += '<div class="circle_score">'+item.cnt+'</div>';
                tmp += '<div class="text">'+item.clsnm+'</div>';
                tmp += '</div>';
                
                /* if(chkEIdx == 0 || idx == iclsProcessStatusCntList-2){ 
                    tmp += '</div>';
                }  */
            }
        	
        });
        
        
        if(data.result.processMngRedngAuthor == "Y"){
             //실행결과
            $("#clsDiv").on("click", function() {
                 var url = "/task/manage/taskManageMain";
                 location.replace(url);
            });
            
            $("#clsDiv").css({ cursor: 'pointer' });
        }
        
        $('#clsDiv').html(tmp);
    }


</script>




