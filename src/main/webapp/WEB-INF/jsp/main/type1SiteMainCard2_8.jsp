<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>



<div class="card-header">
    <h3 class="card-title">RPA 담당자</h3>
     <!-- 20201016 ja -  셋팅 팝업 버튼 추가 -->
     <div class="card-tools">
         <button type="button" class="btn btn-tool" title="Contacts" data-widget="chat-pane-toggle"><i class="fas fa-cog"></i></button>
     </div>
     <!-- // 20201016 ja -  셋팅 팝업 버튼 추가 -->
</div>
<div class="card-body" style="max-height: 160px; overflow-y: auto;">
    <div class="card-body-wrap">
	    <div class="row" id="chargerDiv"></div>
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
        getRpaChargerList();  
    });

    
    //RPA 담당자
    function getRpaChargerList(){        
        var url = "/main/user/getRpaChargerList";
        var param = {}; 
        callAsyncAjax(url, param, "drawRpaChargerList");
    }
    
    
    //RPA 담당자
    function drawRpaChargerList(data){
        
        var rpaChargerList = data.result.rpaChargerList;
        var iRpaChargerList = rpaChargerList.length;
        var tmp = '';
        
        $.each(rpaChargerList ,function(idx,item){
            tmp += '<div class="col-md-4">';
            tmp += '<div class="profile">';
            tmp += '<div class="profile-txt">';
            tmp += '<strong>'+item.chargernm+'</strong>';
            tmp += '</div>';
            tmp += '</div>';
            tmp += '<div class="profile-add">'+item.roleNm+'/<br>'+item.deptNm+'</div>';
            tmp += '</div>';
        });
        
        $('#chargerDiv').html(tmp);
        
        if(data.result.chargerAuthor == "Y"){
             //실행결과
            $("#chargerDiv").on("click", function() {
                 var url = "/orgnzt/user/userManageListMain";
                 location.replace(url);
            });
            
            $("#chargerDiv").css({ cursor: 'pointer' });
        }
    }


</script>                                
                        