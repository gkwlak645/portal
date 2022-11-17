<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<!--  템플릿 바디 -->

<div id="layer001" class="layer" style="z-index:1">
		<div class="layer_innr">
	        <div class="layer_header">
	            검색기간
	        </div>
	        <div class="layer_body">
	            <div class="float_clear">
	                <div class="input-group date float-left" id="startDeDiv" data-target-input="nearest" style="min-width:140px;width:30%;margin-right:5px;">
	                    <input type="text" id="startDe" name="startDe" class="form-control datetimepicker-input" data-target="#startDeDiv">
	                    <div class="input-group-append" data-target="#startDeDiv" data-toggle="datetimepicker">
	                        <div class="input-group-text"><i class="fa fa-calendar"></i></div>
	                    </div>
	                </div>
	                <span style="float: left; margin-right: 5px;">~</span>
	                <div class="input-group date  float-left" id="endDeDiv" data-target-input="nearest" style="min-width:140px;width:30%;">
	                    <input type="text" id="endDe" name="endDe" class="form-control datetimepicker-input" data-target="#endDeDiv">
	                    <div class="input-group-append" data-target="#endDeDiv" data-toggle="datetimepicker">
	                        <div class="input-group-text"><i class="fa fa-calendar"></i></div>
	                    </div>
	                </div>
	            </div>
	            <div class="layer_btn_wrap">
	                <button type="button" class="btn btn-primary" id="searchDateBtn">검색</button>
	                <button type="button" class="btn btn-secondary" id="closeBtn">닫기</button>
	            </div>
	        </div>
	        <a href="javascript:;" class="layer_close" id="closeBtnAtag">닫기</a>
	    </div>
	</div>

<script>

$(document.body).ready(function () {
	$("#closeBtn, #closeBtnAtag").on("click", function() { 
	    $(".over").remove();
	});
	
	$("#searchDateBtn").on("click", function() { 
		searchDatePop();
	});

	/* 시작날짜 내보내기 */
	$('#startDeDiv').datetimepicker({
	    format: 'YYYY-MM-DD'
	  , defaultDate: (new Date()).setDate((new Date()).getDate() -1)
	});

	$('#endDeDiv').datetimepicker({
	    format: 'YYYY-MM-DD'
	  , defaultDate: (new Date()).setDate((new Date()).getDate() -1)
	});
	
	
});

function searchDatePop(){
	const oStartDe = $("#startDe");
	const oEndDe = $("#endDe");

	let oStdStartDe = new Date(oEndDe.val())
	oStdStartDe.setMonth(oStdStartDe.getMonth() -1)
	oStdStartDe.setDate(oStdStartDe.getDate() + 1)
	
	const sStdStartDe = GBL_formatDate(oStdStartDe);
	const sStdEndDe = GBL_formatDate(new Date());
	
	
	if(oEndDe.val() >=  sStdEndDe){
		alert("검색 종료일은 오늘보다 작아야합니다.");
		oEndDe.focus();
		return false;
	}
	else if(oStartDe.val() < sStdStartDe){
		alert("검색 기간은 최대 1달입니다.");
		oEndDe.focus();
		return false;
	}
	
	const oSearchData = {searchType:5, searchStartDate:oStartDe.val(), searchEndDate:oEndDe.val() }
	card1_1_all_search(oSearchData);
	
	$(".over").remove();
}


</script>

<!--  템플릿 바디 끝 -->