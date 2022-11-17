<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="card card-primary" id = "cardDiv">
    <div class="card-header">
        <h3 class="card-title">프로세스 매핑</h3>
    </div>
    <div class="row">
        <div class="col-md-12">
	        <div class="card-header">
	            <form class="form-inline">
	                
	                <div class="form-group col-md-6 py-sm-2">
	                  <label for="schCmpny" class="col-sm-2 col-form-label">회사</label>
	                  <div class="col-sm-10">
	                      <select id="schCmpnyPop" class="form-control" style="width:60%;max-width:200px;">
	                          <option value=""></option>
	                      </select>
	                  </div>
	                </div>
	                <div class="form-group col-md-6 py-sm-2">
	             	<label for="searchProcessState" class="col-sm-2 col-form-label">프로세스 코드</label>
	                 <div class="col-sm-10">
	                     <input type="text" class="form-control float-left" value="" id="processCode" style="min-width: 100px;width:20%;" Readonly>
	                 </div>
	             </div>
	                <div class="form-group col-md-6 py-sm-2" style="margin: 0.3rem 0 0.3rem 0;">
	                  <label for="usr" class="col-sm-2 col-form-label">ORC 프로세스명</label>
	                  <div class="col-sm-10">
	                      <select id="orcProcessNm" class="form-control" style="width:60%;min-width:100px;">
	                          <option value=""></option>
	                      </select>
	                  </div>
	                </div>

	                <div class="form-group col-md-4 py-sm-2" style="margin-bottom: 10px">
	                    <button type="button" id="btnReg" class="btn btn-primary float-right">등록</button>
	                    <button type="button" id="btnCancel" class="btn btn-info float-right">닫기</button>
	                </div>
	            </form> 
	        </div>
	    </div>
    </div>
</div>

<script>

    $(document).ready(function() {

        //페이지 초기화
        pageInit();
        
        //이벤트 바인딩
        bindEvent();
    });

    /*
     * 페이지 초기화
     * @param
     * @return
     */
    function pageInit() {
        
    	var params = [];
        if("${txScreenAuthor.untenantAuthor}" == 'Y'){
            params.push({"id" : "schCmpnyPop", "clsCd" : "0024", "selectValue": cmpnyCdForSelectPop});    //회사
        }else{
            params.push({"id" : "schCmpnyPop", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
        }
        
        requestCmmnCd(params);
        
        // 프로세스 코드 등록
        $("#processCode").val(processCd);
        
        getOrcProcessNm(refDivCd);        	
    }
    
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent() {
        
        $("#btnCancel").on("click", function() {
            closePOP();
        });
        
        $("#btnReg").on("click", function() {
        	if($("#orcProcessNm").val()=='select'){
        		alert("매핑할 ORC프로세스 데이터를 선택하세요.");
        		return false;
        	}else{
        		if(confirm('매핑 데이터를 등록하시겠습니까?')){
	        		var url = '/mntrng/pousermapp/regMapping';
	
	                var param = {
	                    cmpnyCd               : cmpnyCdForSelectPop //"${sessionUserInfo.txCmpnyCd}"
	                    , processCd              : $("#processCode").val()
	                    , registerId              : "${sessionUserInfo.txUserId}"
	                    , orcReleaseId             : $("#orcProcessNm").val()
	                }; 
	
	                callAsyncAjax(url, param, "closePOP");
            	}
            	return false;
        	}
        });
    }
    
    /*
     * ORC 프로세스 명 조회
     * @param
     * @return
     */
     function getOrcProcessNm(divCd) {
    	
    	var url = '/mntrng/pousermapp/getOrcProcessNm';
 		
 		var param = {"divCd" : divCd 
 					, processCd : processCd
 					, tenantId : tenantIdForSelectPop //"${sessionUserInfo.txTenantId}"
 					};
 		
 		callSyncAjax(url, param, "popSelectList");
    }
    
     /*
      * ORC 프로세스 SelectBox 삽입
      * @param
      * @return
      */
      function popSelectList(data) {
    	
    	if(refDivCd == 0){
    		var tmp = '';
    		if(data.result != ''){
	    		tmp = "<option value=''>" + data.result[0].orcReleasesNm + "</option>";
    		}
    		$("#orcProcessNm").html(tmp);
    		$("#orcProcessNm").attr("disabled",true);
    		$("#btnReg").attr("disabled",true);
    	}else{
			var tmp = '';
			tmp = "<option value='select'>선택</option>";
			
			if(data.result != null){
		    	$.each(data.result, function(idx, cd) {
					//tmp += "<option value='" + cd.id + "'>" + cd.processKey + "</option>";
		    		tmp += "<option value='" + cd.id + "'>" + cd.name + "</option>";
				});
			}
	    	
	    	$("#orcProcessNm").html(tmp);
    	}
     }
    
 </script>