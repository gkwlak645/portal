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
                                  <input type="radio" name="chkPer" id="periYear" value="Y" checked>
                                  <label for="periYear">당월</label>
                                  <input type="radio" name="chkPer" id="periSum" value="M">
                                  <label for="periSum">누계</label>
                              </div>
                              <div class="col-md-6">
                                  <div class="cus_dataing">
                                      <select id="searchYear" class="form-control cus_dataing-year"></select>
                                      <label>년</label>
                                      <select id="searchMonth" class="form-control cus_dataing-month"></select>
                                      <label>월</label>
                                  </div>
                                  <button type="button" id="btnSearch" class="btn btn-info float-right">검색</button>
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
                    <div class="person_robot-wrap">
                        <table class="person_robot" id="planAgainstList">
                            <colgroup>
                                <col>
                                <col style="width: 16%">
                                <col style="width: 9%">
                                <col style="width: 8%">
                                <col style="width: 7%">
                                <col style="width: 7%">
                                <col style="width: 7%">
                                <col style="width: 7%">
                                <col style="width: 7%">
                                <col style="width: 7%">
                                <col style="width: 7%">
                                <col style="width: 7%">
                                <col style="width: 7%">
                            </colgroup>
                            <thead>
                            </thead>
                            <tbody>
                            </tbody>
                         </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

/* custom.css 파일에서 ctrl + F를 통해 person_robot를 검색한다.
 * 
 */


$(document).ready(function() {
    pageInit();
    bindEvent();
    searchList();
});


function pageInit() {
    //년도 정보 추가
    cmmn_makeYear("searchYear", 5);
    //월 정보 추가
    cmmn_makeMonth("searchMonth");

    
    //회사 정보 추가
    var params = [];
    params.push({"id" : "searchCmpnyCd", "clsCd" : "0024"});    //회사
    requestCmmnCd(params);
};

function bindEvent(){
	//검색
    $('#btnSearch').on('click', function() {
    	searchList()
    });
}



function searchList(){
    var radioVal = $('input[name="chkPer"]:checked').val();
    var searchYear = $("#searchYear").val();
    var searchMonth = $("#searchMonth").val();
    var param = {searchYear: searchYear, searchMonth:searchMonth, radioVal:radioVal};
    var url = '/stats/planAgainstPerforStatus/getPlanAgainstPerforStatusList';
    callAsyncAjax(url, param, "allDrawData");
}

function allDrawData(data){
	
	var aResult = data.result.resultList
    var year = $("#searchYear").val();
    var month = $("#searchMonth").val();
	 
	 $("#planAgainstList thead tr").remove();
	 $("#planAgainstList tbody tr").remove();
	
	 
 // thead 숫자에 따른 컬럼 설정
	 var strr = "";
	 strr += '<tr>';
	 strr += '  <th scope="col" rowspan="4" colspan="2">구분</th>';
	 strr += '  <th scope="col" rowspan="4">'+year+'년 연간목표</th>';
	 strr += '  <th scope="col" colspan="9">'+month+'월 당월</th>';
	 strr += '</tr>';
	 
	 strr += '<tr>';
	 strr += '  <th scope="col" rowspan="3">계획</th>';
	 strr += '  <th scope="col" colspan="6">전망</th>';
	 strr += '  <th scope="col" rowspan="3">차이</th>';
	 strr += '  <th scope="col" rowspan="3">달성률</th>'; 
	 strr += '</tr>';

     strr += '<tr>';
     strr += '  <th scope="col" rowspan="2">합계</th>';	 
     strr += '  <th scope="col" rowspan="2">PI</th>';
     strr += '  <th scope="col" colspan="4">RPA</th>';
     strr += '</tr>';
     
     strr += '<tr>';
     strr += '  <th scope="col">합계</th>';    
     strr += '  <th scope="col">상근</th>';
     strr += '  <th scope="col">파워유저</th>';
     strr += '  <th scope="col">외주</th>';
     strr += '</tr>';
	 $("#planAgainstList thead").append(strr);

	 var str = "";
	 var rowNo = 0;
	 
	 for(var j = 0; j < aResult.length ; j++){
	    
	    if(rowNo != 2 ){
	        str += '<tr>';
	    }else{
	        str += '<tr  class="lastline">';
	    }
	    
	    if(rowNo == 0 ){
             str += '<th rowspan="3">'+aResult[j].cmpnyNm+'</th>';
	     }
	    
	     if(aResult[j].gbn == "A"){
             str += '<th style="text-align: center;">과제개수</th>';
	     }else if(aResult[j].gbn == "B"){

	    	 str += '<th style="text-align: center;">절감시간</th>';
	     }else if(aResult[j].gbn == "C"){
	    	 str += '<th style="text-align: center;">과제당 절감시간</th>';
	     }
	     str += '  <td>'+aResult[j].tcCnt+'</td>';
	     str += '  <td>'+aResult[j].mcCnt+'</td>';
	     str += '  <td>'+aResult[j].sumNo1+'</td>';
	     str += '  <td>'+aResult[j].piCnt+'</td>';
	     str += '  <td>'+aResult[j].sumNo2+'</td>';
	     str += '  <td>'+aResult[j].sangCnt+'</td>';
	     str += '  <td>'+aResult[j].pwuCnt+'</td>';
	     str += '  <td>'+aResult[j].outCnt+'</td>';
	     str += '  <td>'+aResult[j].difCnt+'</td>';
	     str += '  <td>'+aResult[j].sucPer+'</td>';
	     str += '</tr>';
	     
	     rowNo = rowNo + 1 ;
	     
	    if(rowNo == 3 ){
	        rowNo = 0;
	     }
	 }
	 $("#planAgainstList tbody").append(str);
	 //requestCmmnCd(params);
}















</script>