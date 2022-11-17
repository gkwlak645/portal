<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div id="unmanagtErrorMainDiv" class="container-fluid wrap">
    <div class="row">
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <div class="person_robot-wrap">
                        <table class="person_robot" id="roleUserStsList">
                            <colgroup>
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
    searchList();
});

function searchList() {
    
    // year 선택 조회
        var url = '/stats/npRobotStatus/npRobotStatusList';
        var param = {}; 
        callAsyncAjax(url, param, "npRobotSDrawData");
}


function npRobotSDrawData(data){
	
    var aResult = data.result.resultList
    var roleCnt = data.result.roleCnt
    $("#roleUserStsList colgroup col").remove();
    $("#roleUserStsList thead tr").remove();
    $("#roleUserStsList tbody tr").remove();
	
	
    var strrr = "";
    /* strrr += '<col style="width:400px;">';
    strrr += '<col style="width:250px;">'; */
    strrr += '<col style="width:100px;">';
    strrr += '<col style="width:60px;">';
    
    $("#roleUserStsList colgroup").append(strrr);
    
    // thead 숫자에 따른 컬럼 설정
    var strr = "";
    strr += '<tr>';
    strr += '    <th scope="col" colspan="3">구분</th>';
    strr += '    <th scope="col">현황</th>';
    strr += '<tr>';
    $("#roleUserStsList thead").append(strr);

    var str = "";
    var rowNo = 0;
    var aa = roleCnt + 2;
    var bb = roleCnt + 1;
    
    for(var j = 0; j < aResult.length ; j++){

        if(rowNo != bb ){
            str += '<tr>';
        }else{
            str += '<tr class="lastline">';
        }
        
        if(rowNo == 0 ){
            str += '<th  style="width:100px;" rowspan="'+aa+'">'+aResult[j].cmpnyNm+'</th>';
        }
        
        if(aResult[j].gbn == "A"){
        	str += '   <th  style="width:60px;" rowspan="'+bb+'">인원수</th>';  
        }else if(aResult[j].gbn == "C"){
        	str += '   <th colspan="2">봇수</th>';
        }
        
        if(aResult[j].gbn == 'A'){
            str += '    <th style="width:20px;">인원합계</th>';
        }else if(aResult[j].gbn == 'B'){
            str += '<th  style="width:150px;">'+aResult[j].roleNm+'</th>';
        }
        
        str += '    <th style="text-align:left;">'+aResult[j].userCnt+'</th>';
        str += '</tr>';
        rowNo = rowNo + 1 ;
        if(rowNo == aa ){
            rowNo = 0;
         }
    }
    
    $("#roleUserStsList tbody").append(str);
    //requestCmmnCd(params);
}


</script>












