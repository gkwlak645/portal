<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<div class="card-header">
    <h3 class="card-title">HelpDesk</h3>
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
        <div class="list_ty2" id="hlpdskListDiv">
            <div class="list-item">조회된 내용이 없습니다.</div>
            <!-- <div class="list-item">
                <div class="list-left">
                    <div class="list-tit">오늘부터 성공률이 측정됩니다.</div>
                </div>
                <div class="list-right">
                    <div class="text-secondary">2019-04-24</div>
                </div>
            </div>
            <div class="list-item">
                <div class="list-left">
                    <div class="list-tit">월간보고를 준비해주세요</div>
                </div>
                <div class="list-right">
                    <div class="text-secondary">2019-04-24</div>
                </div>
            </div>
            <div class="list-item">
                <div class="list-left">
                    <div class="list-tit">코드번호 F00101점검 부탁드립니다.</div>
                </div>
                <div class="list-right">
                    <div class="text-secondary">2019-04-24</div>
                </div>
            </div>
            <div class="list-item">
                <div class="list-left">
                    <div class="list-tit">리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역</div>
                </div>
                <div class="list-right">
                    <div class="text-secondary">2019-04-24</div>
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
	    getHlpdskList();  
	});

	
	// 헬프데스크
    function getHlpdskList(){        

		var url = "/main/requst/getHlpdsk";
        var param = {}; 
        callAsyncAjax(url, param, "drawHlpdskList");
    }
    
    // 헬프데스크 콜백
    function drawHlpdskList(data){

    	var hlpdskList = data.result.hlpdskList;
    	
    	var tmp = "";
    	
    	if(hlpdskList.length > 0){
    		$.each(hlpdskList, function(idx, item) {
                tmp += '<div id="hlpdskDiv'+idx+'" class="list-item" style="cursor: pointer;" >';
                tmp += '<input type="hidden" name="requestSn" value="'+item.requstSn+'">';
                tmp += '<div class="list-left">';
                tmp += '<div class="list-tit">'+item.requstSj+'</div>';
                tmp += '</div>';
                tmp += '<div class="list-right">';
                tmp += '<div class="text-secondary">'+item.regdt+'</div>';
                tmp += '</div>';
                tmp += '</div>';
            });
    	}else{
    		tmp = '<div class="list-item">조회된 내용이 없습니다.</div>';
    	}
    	
    	$('#hlpdskListDiv').html(tmp);
    	
        //list 선택시 일자 불러오기
        $("div[id^=hlpdskDiv]").bind("click", function(e){
            var requestSn = $(this).find('input[name=requestSn]').val();
            var url = "/hlpdsk/requst/hlpdskMain?requestSn="+requestSn;
            location.replace(url);
        });
    	
    }


</script>


