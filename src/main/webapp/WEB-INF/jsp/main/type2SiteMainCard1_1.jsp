<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="card-header">
    <h3 class="card-title">그룹 현황</h3>
    <div class="card-tools">
        <button type="button" class="btn btn-tool" title="Contacts" data-widget="chat-pane-toggle">
            <i class="fas fa-cog"></i>
        </button>
    </div>
</div>
<div class="card-body" id="ownerMainDiv"><!-- 카드 스크롤 타입 .body_scrl 추가 -->
    <div class="board_ty4-wrap">
        <div class="board_ty4">
            <div class="board_ty4-left">
                <div class="board001">
                    <div id="type2Card1_1_std_Date"></div>
                    <div class="board002">
                        <ul id="searchType2Card1_1_ul1">
                            <li>1</li>
                            <li>2</li>
                            <li>3</li>
                            <li>4</li>
                            <li>5</li>
                            <li>6</li>
                            <li>7</li>
                            <li>8</li>
                        </ul>
                        <span>절감시간(Hr)</span>
                    </div>
                    <ul class="board003">
                        <li>
                            <div class="board002">
                                <ul id="searchType2Card1_1_ul2">
                                    <li>1</li>
                                    <li>2</li>
                                    <li>3</li>
                                    <li>4</li>
                                </ul>
                            </div>
                            <span>개발과제(건)</span>
                        </li>
                        <li>
                            <div class="board002">
                                <ul id="searchType2Card1_1_ul3">
                                    <li>1</li>
                                    <li>2</li>
                                    <li>3</li>
                                    <li>4</li>
                                </ul>
                            </div>
                            <span>환산인원(명)</span>
                        </li>
                        <li>
                            <div class="board002">
                                <ul id="searchType2Card1_1_ul4">
                                    <li>1</li>
                                    <li>2</li>
                                    <li>3</li>
                                    <li>4</li>
                                </ul>
                            </div>
                            <span>개발자수(명)</span>
                        </li>
                        <li>
                            <div class="board002">
                                <ul id="searchType2Card1_1_ul5">
                                    <li>1</li>
                                    <li>2</li>
                                    <li>3</li>
                                    <li>4</li>
                                </ul>
                            </div>
                            <span>운영봇수(대)</span>
                        </li>
                    </ul>
                </div>
                <!-- 테이블 -->
                <div class="board-container">
                    <table>
                        <colgroup>
                            <col style="width: 100px;">
                            <col>
                            <col>
                            <col>
                            <col>
                            <col>
                            <col>
                            <col>
                            <col>
                        </colgroup>
                        <tbody>
                            <tr class="board-row" id="searchType2Card1_1_tr1">
                            </tr>
                            <!-- active class 입력시 ROW 색 변환 -->
                            <tr class="board-row"  id="searchType2Card1_1_tr2">
                            </tr>
                            <tr class="board-row" id="searchType2Card1_1_tr3">
                            </tr>
                            <tr class="board-row row-line" id="searchType2Card1_1_tr4">
                            </tr>
                            <tr class="board-row" id="searchType2Card1_1_tr5">
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="radio_wrap">
            <div>
                <input type="radio" name="chkRoi" value="1">
                <label for="roiWeek">Week</label>
            </div>
            <div>
                <input type="radio" name="chkRoi" value="2">
                <label for="roiMon">Month</label>
            </div>
            <div>
                <input type="radio" name="chkRoi" value="3">
                <label for="roiYear">Year</label>
            </div>
            <div>
                <input type="radio" name="chkRoi" value="4" checked>
                <label for="roiTotal">Total</label>
            </div>
            <div>
                <input type="radio" name="chkRoi" value="5" >
                <label for="roiCus">기간설정</label>
            </div>
        </div>
    </div>
    <div class="direct-chat-contacts custom-popup">
        <div class="pop-wrap">
            <ul class="pop-list">
                <li class="pop-list-item">테스트 텍스트</li>
            </ul>
        </div>
    </div>
</div>
<script type="text/javascript">
var lc_type2Card1_1_view_std_Date = GBL_formatDate((new Date()).setDate((new Date()).getDate() -1))
//$("#type2Card1_1_std_Date").html(lc_type2Card1_1_view_std_Date);
//기간 검색
$(document).ready(function(){
	$("input:radio[name=chkRoi]").click(function(e){
		const oThis = $(e.target);
		if(oThis.val() == "5"){
			viewSearchDatePop();
		}
		else{
			initType2Card1_1();
		}
		
	})
	
	initType2Card1_1();
	searchType2Card1_1_sch2();
});


function viewSearchDatePop() {
	appendDetailPopup("ownerMainDiv", "/main/searchDatePop");
};

function initType2Card1_1(){
	const sSelVal = $("input[name='chkRoi']:checked").val();
	const oSearchData = {searchType: sSelVal, searchStartDate:"1970-01-01", searchEndDate:"1970-01-01" }
	card1_1_all_search(oSearchData);
}

function card1_1_all_search(oSearchData){
	const aSearchCard = ["searchType2Card1_1_sch1", "searchType2Card2_1", "searchType2Card2_2"];
	
	const iaSearchCard = aSearchCard.length;
	for(let i = 0; i < iaSearchCard; i++){
		const fn = window[aSearchCard[i]];
		 if (typeof fn === "function") {
		 	fn(oSearchData);
		 }
	}
}

//절감시간(Hr), 개발과제(건), 환산인원(명)
function searchType2Card1_1_sch1(oSearchData){
	let oParam = $.extend({}, oSearchData);
	
	if(oParam.searchType == "5"){
		$("#type2Card1_1_std_Date").html("검색기간: " + oParam.searchStartDate + " ~ " + oParam.searchEndDate)
	}
	else{
		$("#type2Card1_1_std_Date").html("기준일: " + lc_type2Card1_1_view_std_Date)
	}
	
	oParam.loading_id =  (lc_loading_id++);
	callAsyncAjax("/main/main/searchType2Card1_1_sch1", oParam, "searchType2Card1_1_sch1Callback");	
}

function searchType2Card1_1_sch1Callback(data){
	const sTotRedcnTm = GBL_lpad(data.result.resultList1[0].redcnTm, 8, "0");
	searchType2Card1_1_drawUl({id:"searchType2Card1_1_ul1", text: sTotRedcnTm})
	searchType2Card1_1_drawUl({id:"searchType2Card1_1_ul2", text: GBL_lpad(data.result.resultList2[0].taskCnt, 4, "0")})
	searchType2Card1_1_drawUl({id:"searchType2Card1_1_ul3", text: GBL_lpad(data.result.resultList1[0].exchangePerson, 4, "0")})
	
	searchType2Card1_1_drawTr1({id: "searchType2Card1_1_tr1", title: "절감시간(Hr)", selector: "redcnTm", list: data.result.resultList1, total: parseInt(sTotRedcnTm)});
	
	searchType2Card1_1_drawTr2({id: "searchType2Card1_1_tr2", title: "개발과제(건)", selector: "taskCnt", list: data.result.resultList2});
	searchType2Card1_1_drawTr2({id: "searchType2Card1_1_tr3", title: "환산인원(명)", selector: "exchangePerson", list: data.result.resultList1});
}

//개발자수, 운영봇수(대)
function searchType2Card1_1_sch2(){
	callAsyncAjax("/main/main/searchType2Card1_1_sch2", {}, "searchType2Card1_1_sch2Callback");
}

function searchType2Card1_1_sch2Callback(data){
	searchType2Card1_1_drawUl({id:"searchType2Card1_1_ul4", text: GBL_lpad(data.result.resultList1[0].devCnt, 4, "0")})
	searchType2Card1_1_drawUl({id:"searchType2Card1_1_ul5", text: GBL_lpad(data.result.resultList2[0].robotCnt, 4, "0")})
	
	searchType2Card1_1_drawTr2({id: "searchType2Card1_1_tr4", title: "개발자수(명)", selector: "devCnt", list: data.result.resultList1});
	searchType2Card1_1_drawTr2({id: "searchType2Card1_1_tr5", title: "운영봇수(대)", selector: "robotCnt", list: data.result.resultList2});
}

function searchType2Card1_1_drawTr1(oData){
    let sTemp = '<th scope="row">' + oData.title +'</th>';
    const sSelector = oData.selector;
    const aList = oData.list;
    const iaList = aList.length;
    const iTotal = oData.total;
    
    sTemp += '<!-- //막대 그래프 시작-->';
    for(let i = 1; i < iaList; i++){
        const oaList = aList[i];
        const iVal =  oaList[sSelector] == undefined ? 0 : parseInt(oaList[sSelector]);
        let iRate = 0;
        if(iVal > 0){
            iRate = Math.round(iVal / iTotal * 100);
        }
        
        if(i==1) {
        	// 처음
            sTemp += '<td style="padding:0;padding-bottom:7px;border-right:none;">';
        }
        else if(i == iaList - 1) {
        	// 마지막
            sTemp += '<td style="padding:0;padding-bottom:7px;border-left:none;">';
        }
        else {
        	// 중간
            sTemp += '<td style="padding:0;padding-bottom:7px;border-left:none;border-right:none;">';
        }

        sTemp += '<div class="bar_chart">';
        sTemp += '      <div class="chart_innr">';

        sTemp += '<div class="chart_item_wrap">';
        sTemp += '  <div class="chart_item">';
        sTemp += '      <span class="chart_item_per" style="height: '+ iRate +'%;"></span>';
        sTemp += '      <span class="chart_num" style="bottom: '+ iRate +'%"> '+ addCommas(oaList.redcnTm) +'</span>';
        sTemp += '  </div>';
        sTemp += '  <div class="chart_label"><span>'+ oaList.cmpnyNm +'</span></div>';
        sTemp += '</div>';
        
        sTemp += '</div>';
        sTemp += '</div>';
        
        sTemp += '</td>';
    }
    sTemp += <!-- //막대 그래프 종료 -->';
    $("#" + oData.id).html(sTemp);
}

 function searchType2Card1_1_drawTr1_save(oData){
	let sTemp = '<th scope="row">' + oData.title +'</th>';
	const sSelector = oData.selector;
	const aList = oData.list;
	const iaList = aList.length;
	const iTotal = oData.total;
	
	sTemp += '<td colspan="'+ (iaList -1) +'" style="padding: 0; padding-bottom: 7px;">';
	sTemp += '<!-- //막대 그래프 시작--><div class="bar_chart">';
	sTemp += '		<div class="chart_innr">';
	for(let i = 1; i < iaList; i++){
		const oaList = aList[i];
		const iVal =  oaList[sSelector] == undefined ? 0 : parseInt(oaList[sSelector]);
		let iRate = 0;
		if(iVal > 0){
			iRate = Math.round(iVal / iTotal * 100);
		}
		sTemp += '<div class="chart_item_wrap">';
		sTemp += '	<div class="chart_item">';
		sTemp += '		<span class="chart_item_per" style="height: '+ iRate +'%;"></span>';
		sTemp += '		<span class="chart_num" style="bottom: '+ iRate +'%"> '+ addCommas(oaList.redcnTm) +'</span>';
		sTemp += '	</div>';
		sTemp += '	<div class="chart_label"><span>'+ oaList.cmpnyNm +'</span></div>';
		sTemp += '</div>';
	}
	sTemp += '</div></div>    <!-- //막대 그래프 종료 --></td>';
	$("#" + oData.id).html(sTemp);
}

function searchType2Card1_1_drawTr2(oData){
	let sTemp = '<th scope="row">' + oData.title +'</th>'
	const sSelector = oData.selector;
	const aList = oData.list;
	const iaList = aList.length;
	
	for(let i = 1; i < iaList; i++){
		const oaList = aList[i];
		sTemp += '<td>' + (oaList[sSelector] == undefined ? 0 : oaList[sSelector]) + '</td>'
	}
	
	$("#" + oData.id).html(sTemp);
}

function searchType2Card1_1_drawUl(oData){
	const sTot = oData.text;
	const asTot = sTot.split('');
	const iasTot = asTot.length;
	let sTemp = "";
	for(let i = 0; i < iasTot; i++){
		sTemp += "<li>"+ asTot[i]+"</li>"
	}
	
	$("#" + oData.id).html(sTemp);
}
</script>