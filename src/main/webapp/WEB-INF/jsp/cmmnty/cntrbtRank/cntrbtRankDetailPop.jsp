<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

 <div class="card card-primary" id="unmanagtErrorRegDiv">                   
    <div class="card-header" alt="커뮤니티 >시스템작업공지상세">
        <h3 class="card-title">상세조회</h3>
    </div>
    <div class="card-body">
        <div class="row" style="min-height:674px;">
            <div class="col-md-12">
                 <form class="form-inline" id="unmanagtErrorDetail">    
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="errorCn" class="col-sm-2 col-form-label">연도</label>
                        <div class="col-sm-10">
                            <input type="text" id="cntrbtYy" class="form-control" style="width:30%;" readonly>
                        </div>
                    </div>  
                    <div class="form-group col-md-6 py-sm-2"">
                        <label for="errorCn" class="col-sm-2 col-form-label">회사</label>
                        <div class="col-sm-10">
                            <input type="text" id="cmpnyNm" class="form-control" style="width:30%;" readonly>
                        </div>
                    </div>
                    
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="errorCn" class="col-sm-2 col-form-label">부서</label>
                        <div class="col-sm-10">
                            <input type="text" id="deptNm" class="form-control" style="width:30%;" readonly>
                        </div>
                    </div>  
                    <div class="form-group col-md-6 py-sm-2"">
                        <label for="errorCn" class="col-sm-2 col-form-label">성명</label>
                        <div class="col-sm-10">
                            <input type="text" id="usernm" class="form-control" style="width:30%;" readonly>
                        </div>
                    </div> 
                    
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="errorCn" class="col-sm-2 col-form-label">랭킹</label>
                        <div class="col-sm-10">
                            <input type="text" id="cntrbtrank" class="form-control" style="width:30%;" readonly>
                        </div>
                    </div>  
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="errorCn" class="col-sm-2 col-form-label">기여점수</label>
                        <div class="col-sm-10">
                            <input type="text" id="cntrbtscore" class="form-control" style="width:30%;" readonly>
                        </div>
                    </div>
                                      
                    <div class="form-group col-md-12 py-sm-2">
                        <table class="table" style="margin-top:20px;" id="cntrbtInfoList">
                            <colgroup>
                              <col width="20%">                                           
                              <col width="20%">
                              <col width="*">
                              <col width="15%">
                              <col width="15%">
                            </colgroup>
                            <thead>                             
                                <tr>
                                    <th>과제코드</th>
                                    <th>프로세스코드</th>
                                    <th>프로세스명</th>
                                    <th>절감시간</th>
                                    <th>기여점수</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                         </table>
                     </div>  
                </form>
                <div class="float-right py-sm-3">
                    <button type="button" class="btn btn-primary" id="closeBtn">닫기</button>
                </div>
                <div id="divSearchUser" class="modal fade" tabindex="-1" role="dialog"></div>
            </div>
        </div>
    </div>
</div>
<script>
                
$(document).ready(function() {
	
});
/*
 * 이벤트 바인딩
 * @param
 * @return
 */
 $("#closeBtn").on("click", function() { 
     closePop();
 });

function cntrbtRankDetailPopDrawData(data){
	
    var aResult = data.result.cntrbtRankDetail;
    var bResult = data.result.cntrbtInfoList;
    
    $('#cntrbtYy').val($('#searchYear').val())
    
    for (var sKey in aResult) {
        if(sKey == "cntrbtscore"){
        	$("#" + sKey).val(aResult[sKey].toFixed(2));
        }
        else{
            $("#" + sKey).val(aResult[sKey]);
        }
    }
    
    if(bResult.length > 0){
        drawCntrbtInfoList(bResult);
    }
}

function drawCntrbtInfoList(aList){
    var iaList = aList.length;
    for(var i = 0; i < iaList; i++){
        var oaList = aList[i];
        var str = "";
        str += '<tr>';
        str += '    <td>' + oaList.taskCd + '</td>';
        str += '    <td>' + oaList.processCd + '</td>';
        str += '    <td>' + oaList.processNm +'</td>';
        str += '    <td>' + addCommas(oaList.sumRedcnTm) + '</td>';
        str += '    <td>' + oaList.cntrbtscore.toFixed(2); + '</td>';
        str += '</tr>';
        $("#cntrbtInfoList tbody").append(str);
    }
}
</script>
<!--  템플릿 바디 끝 -->