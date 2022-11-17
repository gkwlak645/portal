<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="card-header">
     <h3 class="card-title">시스템작업공지</h3>
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
         <div class="list_ty3" id="sysOpertNoticeListDiv">
            <div class="list-item">조회된 내용이 없습니다.</div>
             <!-- <div class="list-item">
                 <div class="list-left">
                     <div class="list-tit">리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역</div>
                 </div>
                 <div class="list-right">
                     <span class="list-time text-secondary">2019-04-24 08:00 ~ 23:00</span>
                     <span class="text-primary" style="display: inline-block; width: 75px; text-align: center;">홈푸드</span>
                 </div>
             </div>
             <div class="list-item">
                 <div class="list-left">
                     <div class="list-tit">리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역</div>
                 </div>
                 <div class="list-right">
                     <span class="list-time text-secondary">2019-04-24 08:00 ~ 23:00</span>
                     <span class="text-primary" style="display: inline-block; width: 75px; text-align: center;">홈푸드</span>
                 </div>
             </div>
             <div class="list-item">
                 <div class="list-left">
                     <div class="list-tit">리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역</div>
                 </div>
                 <div class="list-right">
                     <span class="list-time text-secondary">2019-04-24 08:00 ~ 23:00</span>
                     <span class="text-primary" style="display: inline-block; width: 75px; text-align: center;">홈푸드</span>
                 </div>
             </div>
             <div class="list-item">
                 <div class="list-left">
                     <div class="list-tit">리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역</div>
                 </div>
                 <div class="list-right">
                     <span class="list-time text-secondary">2019-04-24 08:00 ~ 23:00</span>
                     <span class="text-primary" style="display: inline-block; width: 75px; text-align: center;">홈푸드</span>
                 </div>
             </div> -->
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
    	getSysOpertNoticeList();  
    });

    
    // 헬프데스크
    function getSysOpertNoticeList(){        
        var url = "/main/sysOpertNotice/getSysOpertNoticeList";
        var param = {}; 
        callAsyncAjax(url, param, "drawSysOpertNoticeList");
    }
    
    // 헬프데스크 콜백
    function drawSysOpertNoticeList(data){

        var sysOpertNoticeList = data.result.sysOpertNoticeList;
        
        var tmp = "";
        
        if(sysOpertNoticeList.length > 0){
        	 $.each(sysOpertNoticeList, function(idx, item) {
        		 
        		 var cntcSysCmpnyNm = item.cntcSysCmpnyNm.split(',');
        		 
        		 //cntcSysCmpnyNm.length > 1 ? cntcSysCmpnyNm = cntcSysCmpnyNm[0] + " 외" + Number(cntcSysCmpnyNm.length)-1 + "건" : cntcSysCmpnyNm = cntcSysCmpnyNm[0]
        		 cntcSysCmpnyNm.length > 1 ? cntcSysCmpnyNm = cntcSysCmpnyNm[0] + " 외" : cntcSysCmpnyNm = cntcSysCmpnyNm[0]
        		 
                 tmp += '<div id="sysOpertNoticeDiv'+idx+'" class="list-item" style="cursor: pointer;" >';
                 tmp += '<input type="hidden" name="sonSn" value="'+item.sonSn+'">';
                 tmp += '<div class="list-left">';
                 tmp += '<div class="list-tit">'+item.sj+'</div>';
                 tmp += '</div>';
                 tmp += '<div class="list-right">';
                 tmp += '<span class="list-time text-secondary">'+item.regDt+'</span>';
                 tmp += '<div class="text-primary" style="display: inline-block; width: 125px; text-align: center;" title="'+item.cntcSysCmpnyNm+'">'+cntcSysCmpnyNm+'</div>';
                 tmp += '</div>';
                 tmp += '</div>';
             });
        }else{
            tmp = '<div class="list-item">조회된 내용이 없습니다.</div>';
        }
        
        $('#sysOpertNoticeListDiv').html(tmp);
        
        //list 선택시 일자 불러오기
        $("div[id^=sysOpertNoticeDiv]").on("click", function(e){
            var sonSn = $(this).find('input[name=sonSn]').val();
            var url = "/cmmnty/sysOpertNotice/sysOpertNoticeMain?sonSn="+sonSn;
            location.replace(url);
        });
        
    }


</script>
 