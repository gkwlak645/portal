<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="card card-primary" id = "cardDiv">
    <div class="card-header">
        <h3 class="card-title">프로세스 이력관리</h3>
    </div>
    <div class="row">
        <div class="col-md-12">
	        <div class="card-header">
	            <form class="form-inline">	                
	                <div class="form-group col-md-12">
	                  <label for="schCmpny" class="col-sm-2 col-form-label">프로세스 코드</label>
	                  <div class="col-sm-10">
	                      <input type="text" class="form-control float-left" value="" id="processCode" style="min-width: 100px;width:20%;" Readonly>
	                  </div>
	                </div>
					<div class="form-group col-md-12">
						<label for="searchProcessState" class="col-sm-2 col-form-label">프로세스 명</label>
						<div class="col-sm-10">
						<input type="text" class="form-control float-left" value="" id="processName" style="min-width: 100px;width:20%;" Readonly>
					</div>
	             </div>
	                <div class="form-group col-md-12" style="margin: 0.3rem 0 0.3rem 0;">
	                  <label for="usr" class="col-sm-2 col-form-label">TARGET 시작 시간</label>
	                  <div class="col-sm-10">
	                      <input type="text" class="form-control float-left" value="" id="targetStartDt" style="min-width: 100px;width:20%;" Readonly>
	                  </div>
	                </div>
	                <div class="form-group col-md-6">
	                    <button type="button" id="btnReg" class="btn btn-primary float-right">등록</button>
	                    <button type="button" id="btnCancel" class="btn btn-info float-right">닫기</button>
	                </div>
	            </form>
	        </div>
	    </div>
    </div>
</div>

<script>

var processCd;
var jobsId;
var targetId;
var sttus;


    $(document).ready(function() {
        
        //이벤트 바인딩
        bindEvent();
        
        drawMapp();
    });
    
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
       		if(confirm('매핑 데이터를 등록하시겠습니까?')){
        		var url = '/mntrng/pouserhistmng/poUserMapping';

                var param = {
                	jobsId: jobsId
                    , processCd      : $("#processCode").val()
                    , processNm      : $("#processName").val()
                    , targetId		 : targetId
                    , sttus			 : sttus
                }; 

                callAsyncAjax(url, param, "closePOP");
           	}
           	return false;
        });
    }
    
    /*
     * 이력 관리 상세 팝업 - 데이터 등록 
     * @param
     * @return
     */
    function drawMapp(){
    	
    	var url = '/mntrng/pouserhistmng/getDetailMappData';
        
        var param = {
        	jobsId: jobsId
        	, sttus: sttus
        }; 
        
        callAsyncAjax(url, param, "setData");
	
        // 로딩 끝
        $('.dimmed').css({ display: 'none' });
        $('.loading').css({ display: 'none' });
        $('.loading').removeClass('show');
    }
    
    /*
     * 조회된 디테일 데이터 등록 
     * @param
     * @return
     */
     function setData(data){
    	//alert(JSON.stringify(data));
    	if(data.result != null){
    		$("#processCode").val(data.result.processCd);
    		$("#processName").val(data.result.processNm);
    		$("#targetStartDt").val(data.result.startDt);
    		targetId = data.result.jobsId;
    	}else{
    		alert("이력관리 데이터가 존재하지않습니다.");
    		closePOP();
    	}
    }
 </script>