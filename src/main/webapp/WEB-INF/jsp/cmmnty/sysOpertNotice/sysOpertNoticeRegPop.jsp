<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
        
 <div class="card card-primary" id="mainRegDiv">                   
    <div class="card-header" alt="커뮤니티 >시스템작업공지등록">
        <h3 class="card-title">등록</h3>
    </div>
    <div class="card-body">
        <div class="row" style="min-height:674px;">
            <div class="col-md-12">
                <form class="form-inline" id="unmanagtErrorDetail">    
                    <div class="form-group col-md-12 py-sm-2">
                        <label for="errorCn" class="col-sm-2 col-form-label">공지제목<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-10">
                            <input type="text" id="sj" class="form-control float-left" style="width:90%;" maxlength="100">
                        </div>
                    </div>  
                    <div class="form-group col-md-12">
                        <label for="errorCn" class="col-sm-2 col-form-label">공지내용<b style="color:red;padding-left:10px;">*</b></label>
                        <div class="col-sm-10">
                            <textarea rows="20" id="cn" class="form-control" style="width:90%;"></textarea>
                        </div>
                    </div> 
                                      
                    <div class="form-group col-md-12 py-sm-2">
                        <label class="col-sm-2">업무시스템</label>
                        <div class="col-sm-9" class="table" >
                        <input type="button" class="btn btn-outline-primary float-right" id="btnCntcSysAdd" value="추가" />
                        <table class="table float-left" id="cntcSysList" style="padding:0;margin-top:10px;">
                            <colgroup>
                              <col width="25%">
                              <col width="*">
                              <col width="20%">
                            </colgroup>
                            <thead>                             
                                <tr>
                                    <th>분류</th>
                                    <th>회사명</th>
                                    <th>시스템코드</th>
                                    <th>시스템명</th>
                                    <th>삭제</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                         </table>
                     </div>   
                   </div>  
                </form>
                <div class="float-right py-sm-3">
                    <button type="button" class="btn btn-primary" id="registerBtn">등록</button>
                    <button type="button" class="btn btn-primary" id="backListBtn">닫기</button>
                </div>
                <div id="divSearchUser" class="modal fade" tabindex="-1" role="dialog"></div>
            </div>
        </div>
    </div>
</div>

<!-- 로딩바  -->
<div class="dimmed" style="display:none"></div>
<div class="loading" style="display:none">
    <div class="loading-bar"><div></div><div></div><div></div><div></div></div>
    <span class="loading-text">등록 진행중...</span>
</div>

<script>

$(document).ready(function() {
    //이벤트 바인딩
    pageInit();
    bindEvent();
});

    function pageInit(){}
    
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent() {
        $("#backListBtn").on("click", function() { 
            mainPopClose();
        });
        
        // 등록 버튼
        $("#registerBtn").on("click",function(){
        	var oSj = $("#sj");
        	var oCn = $("#cn");
            
        	if($.trim(oSj.val()) == ""){
                alert("공지제목을 입력해 주십시오.");
                oSj.focus();
                return false;
            }
        	else if($.trim(oCn.val()) == ""){
                alert("공지내용을 입력해 주십시오.");
                oCn.focus();
                return false;
            }
        	
        	var aObj = $(".jq_cntcSysChackbox");
        	if(aObj.length < 1){
        		alert("대상시스템을 1개 이상 입력해 주십시오.");
                return false;
        	}
            var aCntcSysList = [];
            $.each(aObj, function(index, item) {
                aCntcSysList.push({cntcSysCd:$(item).val()});
            });
            
            var param = {
                    sj: oSj.val()
                    , cn: oCn.val()
                    , cntcSysList: aCntcSysList
            };
            
            callAsyncAjax("/cmmnty/sysOpertNotice/insertSysOpertNotice", param, "mainPopCloseReload");
            
             //결재 로딩바 
            $('.dimmed').css({ display: 'block' });
            $('.loading').css({ display: 'block' });
            $('.loading').addClass('show');
            
        });
        
        $("#btnCntcSysAdd").on("click", function() { 
            openSearchCntcSysPopup("divSearchUser", "callbackOpenSearchCntcSysPopup");
        });
    }
    
    function openSearchCntcSysPopup(divId, callbackName){
        var url = "/task/develop/searchCntcSysPopup";
        $.ajax({
            url : url,
            dataType : "html",
            type : "GET",
            async : false,
            success : function(result){
                $("#" + divId).html(result);
                $("#" + divId).modal('show');
                
                $("#btnGwpwrSelect").on("click", function(){
                    if ($("#gwpwrGrid").jsGrid("option", "selectData") == null || $("#gwpwrGrid").jsGrid("option", "selectData") == "") {
                        alert("업무시스템을 선택하셔야 합니다.");
                        return;
                    }
                    if (callbackName != null && callbackName != undefined) {
                        var fn = window[callbackName];
                        if (typeof fn === "function") {
                            fn($("#gwpwrGrid").jsGrid("option", "selectData"));
                        }
                    }
                    $("#" + divId).modal('hide');
                });
            }
        });
    }
    
    function callbackOpenSearchCntcSysPopup(data){
        var str = "";
        str += '<tr>';
        str += '    <td>'+ data.cntcSysClsNm+'<input type="hidden" class="jq_cntcSysChackbox" value="' + data.cntcSysCd+ '"></td>';
        str += '    <td>'+ (data.cmpnyNm == undefined ? "" : data.cmpnyNm) +'</td>';
        str += '    <td>' + data.cntcSysCd + '</td>';
        str += '    <td>' + data.cntcSysNm + '</td>';
        str += '    <td><input type="button" class="btn btn-outline-success" onclick="deleteCntcSys(this)" value="삭제" /></td>';
        str += '</tr>';
        $("#cntcSysList tbody").append(str);
        
    }
    
    function deleteCntcSys(oObj){
    	$(oObj).closest("tr").remove();
    }

</script>
 </div>