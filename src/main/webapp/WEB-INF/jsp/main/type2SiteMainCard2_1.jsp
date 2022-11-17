<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="card-header">
    <h3 class="card-title">가동률</h3>
    <div class="card-tools">
        <button type="button" class="btn btn-tool" title="Contacts" data-widget="chat-pane-toggle">
            <i class="fas fa-cog"></i>
        </button>
    </div>
</div>
<div class="card-body">
                <!-- 막대 그래프 -->
	<div class="bar_chart">
	    <div class="chart_innr" id="operListchart">
	    
	    </div>
	</div>
				<!-- //막대 그래프 -->
    <div class="direct-chat-contacts custom-popup">
        <div class="pop-wrap">
            <ul class="pop-list">
                <li class="pop-list-item">테스트 텍스트</li>
            </ul>
        </div>
    </div>
<script type="text/javascript">

$(document).ready(function(){
	
	searchType2Card2_1();

});

function searchType2Card2_1(oSearchData){
	
	//ajax
	var url = '/main/main/getOwnerMainOperRateList';
	var param = {};

	if(oSearchData == null || oSearchData == '' || oSearchData == undefined){
		param.searchType = 4;
	}else{
		param = oSearchData;
	}
	
    callAsyncAjax(url, param, "drawOperRateList");
} 

function drawOperRateList(data){
	
	var ownerMainOperRateList = data.result.resultList;
	
	var tmp = "";
	
	$.each(ownerMainOperRateList, function(idx,item){
		
		tmp += '<div class="chart_item_wrap">'
		//그룹은 색상다르게 표시
		if(item.VIEW_ORDER == 1){
			tmp += '<div class="chart_item act">'
		}else{
			tmp += '<div class="chart_item">'
		}
		tmp += '<span class="chart_item_per" style="height: '+item.operating_rate+'%;"></span>'
		tmp += '<span class="chart_num" style="bottom: '+item.operating_rate+'%">'+item.operating_rate+'%</span>'
		tmp += '</div>'
		tmp += '<div class="chart_label"><span>'+item.CMPNY_NM+'</span></div>'
		tmp += '</div>'
	});
	
	$('#operListchart').html(tmp);
}

</script>
</div>
