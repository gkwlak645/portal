<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<div class="card-header">
    <h3 class="card-title">명예의 전당(절감시간)</h3>
    <!-- 20201016 ja -  셋팅 팝업 버튼 추가 -->
     <div class="card-tools">
         <button type="button" class="btn btn-tool" title="Contacts" data-widget="chat-pane-toggle"><i class="fas fa-cog"></i></button>
     </div>
     <!-- // 20201016 ja -  셋팅 팝업 버튼 추가 -->    
</div>
<div class="card-body">
    <div class="card-body-wrap" style="padding-top:7px;">
        <div class="row" id="rankDiv">
            <div class="col-md-6">
                <div class="list_ty5">
                    <div class="list-item">
                        <div class="list-left">
                            <i class="fas fa-trophy" style="color: #eb661a;"></i>
                            <span style="padding: 0 4px;">김동원</span>
                            <span class="text-secondary">홈푸드</span>
                        </div>
                        <div class="list-right">
                            <div class="text-success">1,500</div>
                        </div>
                    </div>
                    <div class="list-item">
                        <div class="list-left">
                            <i class="fas fa-trophy" style="color: #eb661a;"></i>
                            <span style="padding: 0 4px;">김동원</span>
                            <span class="text-secondary">홈푸드</span>
                        </div>
                        <div class="list-right">
                            <div class="text-success">1,500</div>
                        </div>
                    </div>
                    <div class="list-item">
                        <div class="list-left">
                            <i class="fas fa-trophy" style="color: #eb661a;"></i>
                            <span style="padding: 0 4px;">김동원</span>
                            <span class="text-secondary">홈푸드</span>
                        </div>
                        <div class="list-right">
                            <div class="text-success">1,500</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="list_ty5">
                    <div class="list-item">
                        <div class="list-left">
                            <i class="fas fa-trophy" style="color: #63d1ae;"></i>
                            <span style="padding: 0 4px;">김동원</span>
                            <span class="text-secondary">홈푸드</span>
                        </div>
                        <div class="list-right">
                            <div class="text-success">1,500</div>
                        </div>
                    </div>
                    <div class="list-item">
                        <div class="list-left">
                            <i class="fas fa-trophy" style="color: #63d1ae;"></i>
                            <span style="padding: 0 4px;">김동원</span>
                            <span class="text-secondary">홈푸드</span>
                        </div>
                        <div class="list-right">
                            <div class="text-success">1,500</div>
                        </div>
                    </div>
                    <div class="list-item">
                        <div class="list-left">
                            <i class="fas fa-trophy" style="color: #63d1ae;"></i>
                            <span style="padding: 0 4px;">김동원</span>
                            <span class="text-secondary">홈푸드</span>
                        </div>
                        <div class="list-right">
                            <div class="text-success">1,500</div>
                        </div>
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


                        
<script>
    

    $(document).ready(function() { 
    	getRankRedcnTmList();  
    });

    
    //부분별 프로세스 현황
    function getRankRedcnTmList(){        
        var url = "/main/cntrbtRank/getRankRedcnTmList";
        var param = {};
        
        //명예의 전당 절감시간 기준
        param.chkRankStd = 'sumRedcnTmRank';
        param.cntrbtYear = String(new Date().getFullYear());

        callAsyncAjax(url, param, "drawRankRedcnTmList");
    }
    
    
    //나의 프로세스
    function drawRankRedcnTmList(data){
        
        var rankRedcnTmList = data.result.rankRedcnTmList;
        var iRankRedcnTmList = rankRedcnTmList.length;
        var tmp = '';
        var chkSIdx = 0;
        
        $.each(rankRedcnTmList ,function(idx,item){
            
             var chkEIdx = (idx+1) % 3;
             
             if(chkSIdx == idx){
                 tmp += '<div class="col-md-6">';
                 tmp += '<div class="list_ty5">';
                 chkSIdx = chkSIdx+3;
             }

             tmp += '<div class="list-item">';
             tmp += '<div class="list-left">';
             tmp += '<span style="padding: 0 4px;">'+item.sumredcntmrank+'</span>';
             tmp += '<span style="padding: 0 4px;">'+item.usernm+'</span>';
             tmp += '<span class="text-secondary">'+item.cmpnyNm+'</span>';
             tmp += '</div>';
             tmp += '<div class="list-right">';
             tmp += '<div class="text-success">'+addCommas(item.sumRedcnTm)+'</div>';
             tmp += '</div>';
             tmp += '</div>';
             
             if(chkEIdx == 0 || idx == iRankRedcnTmList){ 
                 tmp += '</div>';
                 tmp += '</div>';
             }
            
        });
        
        $('#rankDiv').html(tmp);
        
        
        if(data.result.rankAuthor == "Y"){
             //실행결과
            $("#rankDiv").on("click", function() {
                 var url = "/cmmnty/cntrbtRank/cntrbtRankMain";
                 location.replace(url);
            });
            
            $("#rankDiv").css({ cursor: 'pointer' });
        }
        
    }


</script>                        
                        
                    
                    
                    
                    