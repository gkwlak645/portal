<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>



<div class="card-header">
    <h3 class="card-title">명예의 전당(기여점수)</h3>
    <!-- 20201016 ja -  셋팅 팝업 버튼 추가 -->
     <div class="card-tools">
         <button type="button" class="btn btn-tool" title="Contacts" data-widget="chat-pane-toggle"><i class="fas fa-cog"></i></button>
     </div>
     <!-- // 20201016 ja -  셋팅 팝업 버튼 추가 -->
</div>
<div class="card-body">
   <div class="card-body-wrap" style="padding-top:7px;">
	  <div class="row" id="rankCntrbtDiv">
	      <div class="col-md-6">
	          <div class="list_ty5">
	              <div class="list-item">
	                  <div class="list-left">
	                      <i class="fas fa-trophy" style="color: #eb661a;"></i>
	                      <span style="padding: 0 4px;">김동원</span>
	                      <span class="text-secondary">테크팩솔루션</span>
	                  </div>
	                  <div class="list-right">
	                      <div class="text-success">0.9</div>
	                  </div>
	              </div>
	              <div class="list-item">
	                  <div class="list-left">
	                      <i class="fas fa-trophy" style="color: #eb661a;"></i>
	                      <span style="padding: 0 4px;">김동원</span>
	                      <span class="text-secondary">홈푸드</span>
	                  </div>
	                  <div class="list-right">
	                      <div class="text-success">1,500시간</div>
	                  </div>
	              </div>
	              <div class="list-item">
	                  <div class="list-left">
	                      <i class="fas fa-trophy" style="color: #eb661a;"></i>
	                      <span style="padding: 0 4px;">김동원</span>
	                      <span class="text-secondary">홈푸드</span>
	                  </div>
	                  <div class="list-right">
	                      <div class="text-success">1,500시간</div>
	                  </div>
	              </div>
	          </div>
	      </div>
	      <div class="col-md-6">
	          <div class="list_ty5">
	              <div class="list-item">
	                  <div class="list-left">
	                      <i class="fas fa-trophy" style="color: green;"></i>
	                      <span style="padding: 0 4px;">김동원</span>
	                      <span class="text-secondary">홈푸드</span>
	                  </div>
	                  <div class="list-right">
	                      <div class="text-success">1,500시간</div>
	                  </div>
	              </div>
	              <div class="list-item">
	                  <div class="list-left">
	                      <i class="fas fa-trophy" style="color: green;"></i>
	                      <span style="padding: 0 4px;">김동원</span>
	                      <span class="text-secondary">홈푸드</span>
	                  </div>
	                  <div class="list-right">
	                      <div class="text-success">1,500시간</div>
	                  </div>
	              </div>
	              <div class="list-item">
	                  <div class="list-left">
	                      <i class="fas fa-trophy" style="color: green;"></i>
	                      <span style="padding: 0 4px;">김동원</span>
	                      <span class="text-secondary">홈푸드</span>
	                  </div>
	                  <div class="list-right">
	                      <div class="text-success">1,500시간</div>
	                  </div>
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
 </div>

                        
 <script>
    

    $(document).ready(function() { 
        getCntrbtRankList();  
    });

    
    //부분별 프로세스 현황
    function getCntrbtRankList(){        
        var url = "/main/cntrbtRank/getRankCntrbtList";
        var param = {};
        
        //명예의 전당 절감시간 기준
        param.chkRankStd = 'cntrbtRank';
        param.cntrbtYear = String(new Date().getFullYear());

        callAsyncAjax(url, param, "drawRankCntrbtList");
    }
    
    
    //나의 프로세스
    function drawRankCntrbtList(data){
        
        var rankCntrbtList = data.result.rankCntrbtList;
        var iRankCntrbtList = rankCntrbtList.length;
        var tmp = '';
        var chkSIdx = 0;
        
        $.each(rankCntrbtList ,function(idx,item){
            
             var chkEIdx = (idx+1) % 3;
             
             if(chkSIdx == idx){
                 tmp += '<div class="col-md-6">';
                 tmp += '<div class="list_ty5">';
                 chkSIdx = chkSIdx+3;
             }

             tmp += '<div class="list-item">';
             tmp += '<div class="list-left">';
             tmp += '<span style="padding: 0 4px;">'+item.cntrbtrank+'</span>';
             tmp += '<span style="padding: 0 4px;">'+item.usernm+'</span>';
             tmp += '<span class="text-secondary">'+item.cmpnyNm+'</span>';
             tmp += '</div>';
             tmp += '<div class="list-right">';
             tmp += '<div class="text-success">'+addCommas(item.cntrbtscore)+'</div>';
             tmp += '</div>';
             tmp += '</div>';
             
             if(chkEIdx == 0 || idx == iRankCntrbtList){ 
                 tmp += '</div>';
                 tmp += '</div>';
             }
            
        });
        
        $('#rankCntrbtDiv').html(tmp);
        
        
        if(data.result.rankAuthor == "Y"){
             //실행결과
            $("#rankCntrbtDiv").on("click", function() {
                 var url = "/cmmnty/cntrbtRank/cntrbtRankMain";
                 location.replace(url);
            });
            
            $("#rankCntrbtDiv").css({ cursor: 'pointer' });
        }
        
    }


</script>                         
                        
                        