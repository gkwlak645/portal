<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<div class="card-header">
      <h3 class="card-title">절감시간  Top3</h3>
    <!-- 20201016 ja -  셋팅 팝업 버튼 추가 -->
     <div class="card-tools">
         <button type="button" class="btn btn-tool" title="Contacts" data-widget="chat-pane-toggle"><i class="fas fa-cog"></i></button>
     </div>
     <!-- // 20201016 ja -  셋팅 팝업 버튼 추가 -->
</div>
<div class="card-body">
      <div class="card-body-wrap">
        <div class="row" id="topRtDiv">
            <div class="col-md-4">
                <div class="ranking3">
                    <i class="fas fa-4x fa-award float-left" style="color: #e6d333;margin-bottom:8px;"></i>
                    <div class="float-left" style="margin-left: 4px;">
                        <strong>영업관리부</strong>
                        <div class="savetime text-success"><strong>15,000H</strong></div>
                    </div>
                </div>
                <div class="text-secondary">일매출 실적입력 일매출 실적입력</div>
            </div>
            <div class="col-md-4">
                <div class="ranking3">
                    <i class="fas fa-4x fa-award float-left" style="color: #a1a1a1;margin-bottom:8px;"></i>
                    <div class="float-left" style="margin-left: 4px;">
                        <strong>재무</strong>
                        <div class="savetime text-success"><strong>11,000H</strong></div>
                    </div>
                </div>
                <div class="text-secondary">전자잔액대사</div>
            </div>
            <div class="col-md-4">
                <div class="ranking3">
                    <i class="fas fa-4x fa-award float-left" style="color: #daa182;margin-bottom:8px;"></i>
                    <div class="float-left" style="margin-left: 4px;">
                        <strong>생산</strong>
                        <div class="savetime text-success"><strong>9,400H</strong></div>
                    </div>
                </div>
                <div class="text-secondary">온라인주문자동화온라인주문자동화</div>
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
        getTopRedcnTmList();  
    });

    
    //절감시간 Top3
    function getTopRedcnTmList(){        
        var url = "/main/topRedcnTm/getTopRedcnTmList";
        var param = {}; 
        callAsyncAjax(url, param, "drawTopRedcnTmList");
    }
    
    
    //절감시간 Top3
    function drawTopRedcnTmList(data){ 
        
        var topRedcnTmList = data.result.topRedcnTmList;
        var tmp = '';
        
        $.each(topRedcnTmList ,function(idx,item){
            
        	tmp += '<div class="col-md-4">';
        	tmp += '<div class="ranking3">';
        	
        	if(idx == 0){
        		tmp += '<i class="fas fa-4x fa-award float-left" style="color: #e6d333;margin-bottom:8px;"></i>';
        	}else if(idx == 1){
        		tmp += '<i class="fas fa-4x fa-award float-left" style="color: #a1a1a1;margin-bottom:8px;"></i>';
        	}else if(idx == 2){
        		tmp += '<i class="fas fa-4x fa-award float-left" style="color: #daa182;margin-bottom:8px;"></i>';
        	}
        	
        	tmp += '<div class="float-left" style="margin-left: 4px;">';
        	
        	var clsnm =  item.clsnm == null || item.clsnm == '' || item.clsnm == 'undefined' ? '' : item.clsnm;
        	
        	tmp += '<strong>'+clsnm+'</strong>';
        	tmp += '<div class="savetime text-success"><strong>'+addCommas(item.sumRedcnTm)+'H</strong></div>';
        	tmp += '</div>';
        	tmp += '</div>';
        	tmp += '<div class="text-secondary">'+item.processNm+'</div>';
        	tmp += '</div>';
        	
        });
        
        $('#topRtDiv').html(tmp);
        
    }


</script>    





     
                                   