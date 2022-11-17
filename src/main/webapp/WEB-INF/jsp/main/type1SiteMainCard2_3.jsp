<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="card-header">
    <h3 class="card-title">Automation index</h3>
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
        <div class="board_ty3">
            <div class="board">
                <i class="board-icon fas fa-clock"></i>
                <div class="board-text">
                    <div class="board-tit">절감시간</div>
                    <div class="board-point">
                        <strong class="text-warning" id="redcnTm">0</strong>
                        <span class="text-secondary">H/年</span>
                    </div>
                </div>
            </div>
            <div class="board">
                <i class="board-icon fas fa-chart-pie"></i>
                <div class="board-text">
                    <div class="board-tit">개선지수</div>
                    <div class="board-point">
                        <strong class="text-warning" id="imprvm">0</strong>
                    </div>
                </div>
            </div>
        </div>
        <!-- <div class="row">
            <div class="col-md-6" style="overflow: hidden;">
                <i class="fas fa-4x fa-clock float-left" style="color: grey;"></i>
                <div class="float-left">
                    <h6>절감시간</h6>
                    <div class="text-secondary"><strong class="text-warning" style="margin-right: 4px; font-size: 25px;">560</strong>H/年</div>
                </div>
            </div>
            <div class="col-md-6" style="overflow: hidden;">
                <i class="fas fa-4x fa-chart-pie float-left" style="color: grey;"></i>
                <div class="float-left">
                    <h6>개선지수</h6>
                    <div><strong class="text-warning" style="font-size: 25px;">2.1</strong></div>
                </div>
            </div>
        </div> -->
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
      getAutomationIndex();  
  });

  
  // RPA - 현황
  function getAutomationIndex(){        
      var url = "/main/automationIndex/getAutomationIndexCnt";
      var param = {}; 
      callAsyncAjax(url, param, "drawAutomationIndexCnt");
  }
  
  // RPA - 현황 콜백
  function drawAutomationIndexCnt(data){
    
      //****************** 날짜 기준 : 올해년도(1/1 ~ 12/31) ******************
      
      //절감시간
      $('#redcnTm').html(addCommas(data.result.sumRedcnTm));
  
      //개선지수
      $('#imprvm').html(addCommas(data.result.sumImprvm));
      
  }


</script>

