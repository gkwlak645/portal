<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div id="unmanagtErrorMainDiv" class="container-fluid wrap">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <form class="form-inline">
                        <div class="form-group col-md-12 py-sm-1">
                              <div class="col-md-6 cus_radio">
                                  <div class="col-form-label col-sm-2 cus_label">기간</div>
                                  <div class="cus_dataing">
                                      <select id="searchYear" class="form-control cus_dataing-year" disabled></select>
                                      <label>년</label>
                                      <select id="searchMonth" class="form-control cus_dataing-month"></select>
                                      <label>월</label>
                                  </div>
                                    <input style="margin-left: 20px;" type="radio" name="chkPer" id="periYear" value="Y">
                                    <label for="periYear">년도별</label>
                                    <input type="radio" name="chkPer" id="periMoth" value="M"  checked>
                                    <label for="periMoth">월별</label>
                              </div>
                              <div class="col-md-6">
                                  <label class="col-form-label col-sm-2">회사</label>
                                  <div class="col-sm-8 selectbox">
                                       <select id="searchCmpnyCd" class="form-control select" style="width: 60%"></select>
                                      <button type="button" id="btnSearch" class="btn btn-info">검색</button>
                                  </div>
                              </div>
                        </div>
                    </form> 
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-body">
                    <div class="cus_table-wrap">
                        <button type="button" id="btnOutExport" class="btn btn-primary float-right" style="margin: 5px 0 15px 2px;">엑셀 다운로드</button>
                        <table class="cus_table" id="procStsList">
                            <colgroup>

                            </colgroup>
                            <thead>
                                <tr>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- 프로세스1 -->
                            </tbody>
                         </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 로딩바  -->
<div class="dimmed" style="display:none"></div>
<div class="loading" style="display:none">
    <div class="loading-bar"><div></div><div></div><div></div><div></div></div>
    <span class="loading-text"></span>
</div>

<!-- 엑셀 다운로드 FORM -->                    
<form id="downloadFormExel" name="downloadFormExel" method="post">
    <input type="hidden" id="fileNo" name="fileNo" value="" />
    <input type="hidden" id="fileNm" name="fileNm" value="" />
</form>

<script type="text/javascript">

var dataorexcel = 'data';

$(document).ready(function() {
	loadingTextChange();
    //pageInit();
    //bindEvent();
    searchList();
});

function loadingTextChange() {
	if(dataorexcel == 'data') {
		$(".loading-text")[0].innerHTML = "데이터 로딩 중...";
	}else {
		$(".loading-text")[0].innerHTML = "엑셀 다운로드 중...";
	}
}

function pageInit() {
	//년도 정보 추가
    cmmn_makeYear("searchYear", 5);
	//월 정보 추가
    cmmn_makeMonth("searchMonth");
    
	//회사 정보 추가
    var params = [];
	
    <c:choose>
	    <c:when test="${txScreenAuthor.untenantAuthor eq 'Y'}">
	         //params.push({"id" : "searchCmpnyCd", "clsCd" : "0024"});    //회사
	         params.push({"id" : "searchCmpnyCd", "clsCd" : "0024", "selectValue": "${sessionUserInfo.txCmpnyCd}"});
	    </c:when>
	    <c:otherwise>
	          params.push({"id" : "searchCmpnyCd", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
	    </c:otherwise>
    </c:choose>

    requestCmmnCd(params);
    
};

function bindEvent(){
	// 연도별
	$('#periYear').on('click', function() {
	    $('.cus_dataing-year').attr('disabled', false); // 활성화
	    $('.cus_dataing-month').attr('disabled', true); // 비활성화
	    
	});

	//월별
	$('#periMoth').on('click', function() {
	     $('.cus_dataing-year').attr('disabled', true); // 활성화
	     $('.cus_dataing-month').attr('disabled', false); // 비활성화  
	});

	//검색
	$('#btnSearch').on('click', function() {
		searchList();
	});
	
	//엑셀다운로드
	$("#btnOutExport").on('click', function(){
        outExport();
    });
	
}

function searchList() {
    
    var radioVal = $('input[name="chkPer"]:checked').val();
    
    var searchYear = $("#searchYear").val();
    var searchMonth = $("#searchMonth").val();
    
    // year 선택 조회
    if(radioVal=="Y"){
        var url = '/stats/processExecutStatus/processExecutStatusYearList';
        var param = {searchYear: $("#searchYear").val(), searchCmpnyCd:$("#searchCmpnyCd").val()}; 
        callAsyncAjax(url, param, "yearDrawData");
    }else{
        // month 선택 조회
        var url = '/stats/processExecutStatus/processExecutStatusMonthList';
        var param = {searchYear: searchYear,searchMonth: searchMonth, searchCmpnyCd:$("#searchCmpnyCd").val()}; 
        callAsyncAjax(url, param, "monthDrawData");
    }
    
  //결재 로딩바 
    $('.dimmed').css({ display: 'block' });
    $('.loading').css({ display: 'block' });
    $('.loading').addClass('show');
}


// page 그리기
function yearDrawData(data){
    //데이터 화면에 출력
    var aResult = data.result.resultList
	$("#procStsList colgroup col").remove();
	$("#procStsList thead tr").remove();
	$("#procStsList tbody tr").remove();
	// col group 비율 설정
	var strrr = "";
	strrr += '<col width="10%">';
	strrr += '<col width="5%">';
	strrr += '<col width="10%">';
	strrr += '<col width="10%">';
	strrr += '<col width="5%">';
	
	for(var i=0; i < aResult.length; i++){
	        strrr += '<col width="*"></th>';
	}
	$("#procStsList colgroup").append(strrr);
	
	// thead 숫자에 따른 컬럼 설정
	var strr = "";
	strr += '<tr>';
	strr += '<th scope="col">회사명</th>';
	strr += '<th scope="col">프로세스코드</th>';
	strr += '<th scope="col">프로세스명</th>';
	strr += '<th scope="col">합계/평균</th>';
	strr += '<th scope="col">구분</th>';
    strr += '<th scope="col">01</th>';
    strr += '<th scope="col">02</th>';	
    strr += '<th scope="col">03</th>';
    strr += '<th scope="col">04</th>';
    strr += '<th scope="col">05</th>';    
    strr += '<th scope="col">06</th>';    
    strr += '<th scope="col">07</th>';    
    strr += '<th scope="col">08</th>';
    strr += '<th scope="col">09</th>';    
    strr += '<th scope="col">10</th>';
    strr += '<th scope="col">11</th>';
    strr += '<th scope="col">12</th>';
	strr += '<tr>';
	$("#procStsList thead").append(strr);
	
	// 시간별 / 봇 별 항목 ID 설정 그리기
	var str = "";
    var rowNo = 0;
    
	for(var j = 0; j < aResult.length ; j++){
	   
       if(rowNo != 2 ){
    	   str += '<tr>';
       }else{
    	   str += '<tr  class="lastline">';
       }
	   
	   if(rowNo == 0 ){
		   if(aResult[j].compCd != "ZZ"){
			    str += '<th rowspan="3">'+aResult[j].compNm+'</th>';
			    str += '<th rowspan="3">'+aResult[j].processCd+'</th>';
			    str += '<th rowspan="3">'+aResult[j].processNm+'</th>';
		   }else{
	            str += '<th rowspan="3" colspan="3">전체 합계/평균</th>';
		   }
	    }
	    if(aResult[j].gbn == "A"){
	    	str += '<td>'+aResult[j].monTot+'</td>';
	    	str += '<td style="text-align: center;">성공</td>';
	    }else if(aResult[j].gbn == "B"){
	    	str += '<td>'+aResult[j].monTot+'</td>';
	    	str += '<td style="text-align: center;">실패</td>';
	    }else if(aResult[j].gbn == "C"){
	    	str += '<td>'+aResult[j].monTot+'</td>';
	    	str += '<td style="text-align: center;">성공률</td>';
	    }
	    
        if(aResult[j].gbn == "TA"){
            str += '<td>'+aResult[j].monTot+'</td>';
            str += '<td style="text-align: center;">성공</td>';
        }else if(aResult[j].gbn == "TB"){
            str += '<td>'+aResult[j].monTot+'</td>';
            str += '<td style="text-align: center;">실패</td>';
        }else if(aResult[j].gbn == "TC"){
            str += '<td>'+aResult[j].monTot+'</td>';
            str += '<td style="text-align: center;">성공률</td>';
        }
	    
	    str += '<td>'+aResult[j].m01+'</td>';
	    str += '<td>'+aResult[j].m02+'</td>';
	    str += '<td>'+aResult[j].m03+'</td>';
	    str += '<td>'+aResult[j].m04+'</td>';
	    str += '<td>'+aResult[j].m05+'</td>';
	    str += '<td>'+aResult[j].m06+'</td>';
	    str += '<td>'+aResult[j].m07+'</td>';
	    str += '<td>'+aResult[j].m08+'</td>';
	    str += '<td>'+aResult[j].m09+'</td>';
	    str += '<td>'+aResult[j].m10+'</td>';
	    str += '<td>'+aResult[j].m11+'</td>';
	    str += '<td>'+aResult[j].m12+'</td>';
	    str += '</tr>';
	    
	    rowNo = rowNo + 1 ;
	    
       if(rowNo == 3 ){
    	   rowNo = 0;
        }
	}
	$("#procStsList tbody").append(str);
    //requestCmmnCd(params);
    
	$('.dimmed').css({ display: 'none' });
    $('.loading').css({ display: 'none' });
    $('.loading').removeClass('show');
}


//page 그리기
function monthDrawData(data){
    //데이터 화면에 출력
    var aResult = data.result.resultList
    var monthCnt = data.result.monthCnt
    $("#procStsList colgroup col").remove();
    $("#procStsList thead tr").remove();
    $("#procStsList tbody tr").remove();
    // col group 비율 설정
    var strrr = "";
    strrr += '<col width="15%">';
    strrr += '<col width="15%">';
    strrr += '<col width="15%">';
    strrr += '<col width="15%">';
    strrr += '<col width="10%">';
    
    for(var i=0; i < aResult.length; i++){
            strrr += '<col width="*"></th>';
    }
    $("#procStsList colgroup").append(strrr);
    
    // thead 숫자에 따른 컬럼 설정
    var strr = "";
    strr += '<tr>';
    strr += '<th scope="col">회사명</th>';
    strr += '<th scope="col">프로세스코드</th>';
    strr += '<th scope="col">프로세스명</th>';
    strr += '<th scope="col">합계/평균</th>';
    strr += '<th scope="col">구분</th>';
    strr += '<th scope="col">01</th>';
    strr += '<th scope="col">02</th>';  
    strr += '<th scope="col">03</th>';
    strr += '<th scope="col">04</th>';
    strr += '<th scope="col">05</th>';    
    strr += '<th scope="col">06</th>';    
    strr += '<th scope="col">07</th>';    
    strr += '<th scope="col">08</th>';
    strr += '<th scope="col">09</th>';    
    strr += '<th scope="col">10</th>';
    strr += '<th scope="col">11</th>';
    strr += '<th scope="col">12</th>';
    strr += '<th scope="col">13</th>';
    strr += '<th scope="col">14</th>';
    strr += '<th scope="col">15</th>';    
    strr += '<th scope="col">16</th>';    
    strr += '<th scope="col">17</th>';    
    strr += '<th scope="col">18</th>';
    strr += '<th scope="col">19</th>';    
    strr += '<th scope="col">20</th>';
    strr += '<th scope="col">21</th>';
    strr += '<th scope="col">22</th>';
    strr += '<th scope="col">23</th>';
    strr += '<th scope="col">24</th>';
    strr += '<th scope="col">25</th>';    
    strr += '<th scope="col">26</th>';    
    strr += '<th scope="col">27</th>';    
    strr += '<th scope="col">28</th>';
    if(monthCnt == 29){
        strr += '<th scope="col">29</th>';    
    }
    if(monthCnt == 30){
        strr += '<th scope="col">29</th>';
        strr += '<th scope="col">30</th>';
    }
    if(monthCnt == 31){
        strr += '<th scope="col">29</th>';    
        strr += '<th scope="col">30</th>';
        strr += '<th scope="col">31</th>'; 
    }
    
    
    strr += '<tr>';
    $("#procStsList thead").append(strr);
    
    // 시간별 / 봇 별 항목 ID 설정 그리기
    var str = "";
    var rowNo = 0;
    
    for(var j = 0; j < aResult.length ; j++){  //144
       if(rowNo != 2 ){
           str += '<tr>';
       }else{
           str += '<tr  class="lastline">';
       }
       if(rowNo == 0 ){
           if(aResult[j].compCd != "ZZ"){
                str += '<th rowspan="3">'+aResult[j].compNm+'</th>';
                str += '<th rowspan="3">'+aResult[j].processCd+'</th>';
                str += '<th rowspan="3">'+aResult[j].processNm+'</th>';
           }else{
                str += '<th rowspan="3" colspan="3">전체 합계/평균</th>';
           }
        }
        if(aResult[j].gbn == "A"){
            str += '<td>'+aResult[j].monTot+'</td>';
            str += '<th>성공</th>';
        }else if(aResult[j].gbn == "B"){
            str += '<td>'+aResult[j].monTot+'</td>';
            str += '<th>실패</th>';
        }else if(aResult[j].gbn == "C"){
            str += '<td>'+aResult[j].monTot+'</td>';
            str += '<th>성공률</th>';
        }
        
        if(aResult[j].gbn == "TA"){
            str += '<td>'+aResult[j].monTot+'</td>';
            str += '<th>성공</th>';
        }else if(aResult[j].gbn == "TB"){
            str += '<td>'+aResult[j].monTot+'</td>';
            str += '<th>실패</th>';
        }else if(aResult[j].gbn == "TC"){
            str += '<td>'+aResult[j].monTot+'</td>';
            str += '<th>성공률</th>';
        }
        
        str += '<td>'+aResult[j].d01+'</td>';
        str += '<td>'+aResult[j].d02+'</td>';
        str += '<td>'+aResult[j].d03+'</td>';
        str += '<td>'+aResult[j].d04+'</td>';
        str += '<td>'+aResult[j].d05+'</td>';
        str += '<td>'+aResult[j].d06+'</td>';
        str += '<td>'+aResult[j].d07+'</td>';
        str += '<td>'+aResult[j].d08+'</td>';
        str += '<td>'+aResult[j].d09+'</td>';
        str += '<td>'+aResult[j].d10+'</td>';
        str += '<td>'+aResult[j].d11+'</td>';
        str += '<td>'+aResult[j].d12+'</td>';
        str += '<td>'+aResult[j].d13+'</td>';
        str += '<td>'+aResult[j].d14+'</td>';
        str += '<td>'+aResult[j].d15+'</td>';
        str += '<td>'+aResult[j].d16+'</td>';
        str += '<td>'+aResult[j].d17+'</td>';
        str += '<td>'+aResult[j].d18+'</td>';
        str += '<td>'+aResult[j].d19+'</td>';
        str += '<td>'+aResult[j].d20+'</td>';
        str += '<td>'+aResult[j].d21+'</td>';
        str += '<td>'+aResult[j].d22+'</td>';
        str += '<td>'+aResult[j].d23+'</td>';
        str += '<td>'+aResult[j].d24+'</td>';
        str += '<td>'+aResult[j].d25+'</td>';
        str += '<td>'+aResult[j].d26+'</td>';
        str += '<td>'+aResult[j].d27+'</td>';
        str += '<td>'+aResult[j].d28+'</td>';
        
        if(monthCnt == 29){
            str += '<td>'+aResult[j].d29+'</td>';
        }
        if(monthCnt == 30){
            str += '<td>'+aResult[j].d29+'</td>';
            str += '<td>'+aResult[j].d30+'</td>';
        }
        if(monthCnt == 31){
            str += '<td>'+aResult[j].d29+'</td>';
            str += '<td>'+aResult[j].d30+'</td>';
            str += '<td>'+aResult[j].d31+'</td>';
        }
        str += '</tr>';
        
        rowNo = rowNo + 1 ;
        
       if(rowNo == 3 ){
           rowNo = 0;
        }
    }
    $("#procStsList tbody").append(str);
    //requestCmmnCd(params);

    $('.dimmed').css({ display: 'none' });
    $('.loading').css({ display: 'none' });
    $('.loading').removeClass('show');
}



//엑셀다운로드
function outExport(){
	dataorexcel = "excel";
	loadingTextChange(); // 엑셀 다운로드 중
       
    var url = '/stats/processExecutStatus/outExportProcessExecutStatusList';

    var param = {
    	  searchCmpnyCd : $("#searchCmpnyCd").val()
    	, yearSe        : $('input[name="chkPer"]:checked').val() 
    }; 
    
    
    // year 선택 조회
    if(param.radioVal=="Y"){
    	param.searchYear = $("#searchYear").val();
    }else{
    // month 선택 조회
        param.searchYear  = $("#searchYear").val();
        param.searchMonth = $("#searchMonth").val();
    }

    callAsyncAjax(url, param, "exportCallback");
    
    //결재 로딩바 
    $('.dimmed').css({ display: 'block' });
    $('.loading').css({ display: 'block' });
    $('.loading').addClass('show');
}

//엑셀다운로드 콜백
function exportCallback(data) {
    $("#fileNo").val(data.result.fileNo);
    $("#fileNm").val("프로세스별실행현황");
    
    var frmData = document.downloadFormExel;
    frmData.action = "/file/downloadExport"; 
    frmData.submit() ;
    
    $('.dimmed').css({ display: 'none' });
    $('.loading').css({ display: 'none' });
    $('.loading').removeClass('show');

    
    dataorexcel = "data";
    loadingTextChange(); // 데이터 로딩 중
}





</script>