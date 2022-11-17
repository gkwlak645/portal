<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!--  템플릿 바디 -->        
 <div class="card card-primary" id="unmanagtErrorRegDiv">                   
    <div class="card-header" alt="과제 >과제개발상세">
        <h3 class="card-title">과제 상세</h3>
    </div>
    <div class="card-body">
        <div class="row" style="min-height:560px;">
            <div class="col-md-12">
                <form class="form-inline" id="unmanagtErrorDetail">                    
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">과제코드<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <input type="hidden" id="devlopSn" class="form-control"  style="width:80%;"  value="" disabled>
                            <input type="text" id="taskCd" class="form-control"  style="width:80%;"  value="" disabled>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">과제명<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <input type="text" id="taskNm" class="form-control"  style="width:80%;" maxlength="100" />
                        </div>
                    </div>
                    <div class="form-group col-md-12 py-sm-2">
                        <label for="errorCn" class="col-sm-2 col-form-label">과제설명<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-10">
                            <textarea rows="2" id="taskDc" class="form-control" style="width:92.5%;" maxlength="2000"></textarea>
                        </div>
                    </div>                   
                    
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">회사<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <select id="cmpnyCd" class="form-control" style="width:80%;margin-right: 3px;" type="text" ></select>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">업무분류<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <select id="clsCd" class="form-control" style="width:80%;margin-right: 3px;" type="text" ></select>
                        </div>
                    </div>
                    
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">업무담당부서<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <input type="hidden" id="jobChrgDeptCd" class="form-control float-left" style="width:50%;margin-right: 3px;" type="text" >
                            <input type="text" id="jobChrgDeptNm" class="form-control float-left" style="width:50%;margin-right: 3px;" type="text" disabled>
<%--                             <input type="button" class="btn btn-outline-primary float-left" id="btnSearchDept" name="btnSearchDept" value="부서검색" />--%>
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">업무담당자<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-8">
                            <input type="hidden" id="jobChargerId" class="form-control float-left" style="width:50%;margin-right: 3px;" type="text" >
                            <input type="text" id="jobChargerNm" class="form-control float-left" style="width:50%;margin-right: 3px;" type="text" disabled>
                            <input type="button" class="btn btn-outline-primary float-left" id="btnSearchUser" name="btnSearchUser" value="사원검색" />
                        </div>
                    </div>
                                      
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="sourcUpdtNm" class="col-sm-4 col-form-label">업무시간(연간)</label>
                        <div class="col-sm-8">
                            <input type="text" id="jobTm" class="form-control float-left" style="width:120px;margin-right: 3px;" value="" type="text" maxlength="8" decimalNumberType1>H
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="managtChargerId" class="col-sm-4 col-form-label">빈도</label>
                        <div class="col-sm-8">
                            <select id="fqCd" class="form-control float-left" style="width:30%;margin-right: 10px;" type="text" ></select>
                            <input type="text" id="executCnt" class="form-control float-left" style="width:120px;margin-right: 3px;" type="text" value="" maxlength="5" numberOnly>회
                        </div>
                    </div>      
                    
                </form>
                <div class="float-right py-sm-3">
<c:if test="${txScreenAuthor.wrtngAuthor eq 'Y' && identityFlag}">
                    <button type="button" class="btn btn-primary" id="saveBtn">저장</button>
                    <button type="button" class="btn btn-primary" id="deleteBtn">삭제</button>
</c:if>
                    <button type="button" class="btn btn-primary" id="backListBtn">닫기</button>
                </div>
                <div id="divSearchUser" class="modal fade" tabindex="-1" role="dialog"></div>
            </div>
        </div>
    </div>
</div>
<script>

$(document).ready(function() {
	bindEvent();
});
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent() {
        /* 취소 버튼 누를 시 */
        $("#backListBtn").on("click", function() { 
            mainPopClose();
        });
        
        $("#deleteBtn").on("click", function() {
        	if(confirm("삭제 하시겠습니까?")){
        		var param = {
                        devlopSn: $("#devlopSn").val()
        		}
        		
        		callAsyncAjax("/task/develop/deleteTaskDevelop", param, "mainPopCloseReloadType2");
        	}
        });

        $("#saveBtn").on("click", function() { 
        	if(confirm("변경된 내용을 저장 하시겠습니까?")){
        		var oTaskCd = $("#taskCd");
                var oTaskNm = $("#taskNm");
                var oTaskDc = $("#taskDc");
                var oCmpnyCd = $("#cmpnyCd");
                var oClsCd = $("#clsCd");
                var oDeptCd = $("#jobChrgDeptCd");
                var oChargerId = $("#jobChargerId");
                var oJobTm = $("#jobTm");
                var sJobTmVal = oJobTm.val();
                
                if($.trim(oTaskCd.val()) == ""){
                    alert("과제코드를 입력해 주십시오.");
                    oTaskCd.focus();
                    return false;
                }
                else if(oTaskCd.val().length < 4){
                    alert("과제코드는 4자리입니다.");
                    oTaskCd.focus();
                    return false;
                }
                else if($.trim(oTaskNm.val()) == ""){
                    alert("과제명을 입력하세요.");
                    oTaskNm.focus();
                    return false;
                }
                else if($.trim(oTaskDc.val()) == ""){
                    alert("과제 설명을 입력하세요.");
                    oTaskDc.focus();
                    return false;
                }
                else if($.trim(oCmpnyCd.val()) == ""){
                    alert("회사를 선택하세요.");
                    oCmpnyCd.focus();
                    return false;
                }
                else if($.trim(oClsCd.val()) == ""){
                    alert("분류를 입력하세요.");
                    oClsCd.focus();
                    return false;
                }
                else if($.trim(oDeptCd.val()) == ""){
                    alert("부서를 입력하세요.");
                    oDeptCd.focus();
                    return false;
                }
                else if($.trim(oChargerId.val()) == ""){
                    alert("업무담당자를 입력하세요.");
                    oDeptcd.focus();
                    return false;
                }
                else if($.trim(sJobTmVal) != ""){
                    sJobTmVal = sJobTmVal.replace(/,/gi, "");
                    if(parseInt(sJobTmVal) >= 1000000){
                        alert("작업시간을 1,000,000미만으로 입력해 주십시오.");
                        oJobTm.focus();
                        return false;
                    }
                }
                
                var param = {
                		devlopSn: $("#devlopSn").val()
                      , taskCd : oTaskCd.val()
                      , taskNm : oTaskNm.val()
                      , taskDc : oTaskDc.val()
                      , cmpnyCd : oCmpnyCd.val()
                      , clsCd : oClsCd.val()
                      , jobChrgDeptCd : oDeptCd.val()
                      , jobChrgDeptNm : $("#jobChrgDeptNm").val()
                      , jobChargerId : oChargerId.val()
                      , jobChargerNm : $("#jobChargerNm").val()
                      , jobTm : sJobTmVal
                      , fqCd : $("#fqCd").val()
                      , executCnt : $("#executCnt").val()
                };
                callAsyncAjax("/task/develop/updateTaskDevelop", param, "mainPopCloseReloadType2");
        	}
        	
        });
        
        $("#btnSearchUser").on("click",function(){
            openGwpwrUserPopup("divSearchUser", "callbackSearchUser");
        });
        
        $("#btnSearchDept").on("click",function(){
            openGwpwrDeptPopup("divSearchUser", "callbackSearchDept");
        });
    }
    
    /*
     * 사원검색 콜백 함수
     * @param
     * @return
     */
    function callbackSearchUser(data) {
        $("#jobChargerId").val(data.gwpwrId);
        $("#jobChargerNm").val(data.userNm);
        $("#jobChrgDeptCd").val(data.deptCd);
        $("#jobChrgDeptNm").val(data.deptNm);
    }
    

</script>

<!--  템플릿 바디 끝 -->    
