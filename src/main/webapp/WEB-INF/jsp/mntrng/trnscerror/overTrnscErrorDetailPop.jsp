<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<div class="card card-primary" id="cardDiv">
    <div class="card-header">
        <h3 class="card-title">중복오류통합</h3>
    </div>
    <div class="card-body">
        <div class="row">
            <div class="col-md-12">
                <form class="form-inline" id="overTrnscErrorDetail">
	                <div class="form-group col-md-6 py-sm-2">
                        <label for="trnscErrorSn" class="col-sm-4 col-form-label">아이디</label>
                        <div class="col-sm-8">
                             <input type="text" id="trnscErrorSn" class="form-control" disabled style="width:80%;" />
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="errorUnitySn" class="col-sm-4 col-form-label">오류통합아이디</label>
                        <div class="col-sm-8">
                             <input type="text" id="errorUnitySn" class="form-control" disabled style="width:80%;" />
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="reprsntAt" class="col-sm-4 col-form-label">대표여부</label>
                        <div class="col-sm-8">
                             <input type="text" id="reprsntAt" class="form-control" disabled style="width:80%;" />
                        </div>
                    </div>
                    <div class="form-group col-md-6 py-sm-2">
                        <label for="cmpnyNm" class="col-sm-4 col-form-label">회사</label>
                        <div class="col-sm-8">
                            <input type="text" id="cmpnyNm" class="form-control" disabled style="width:80%;"/>
                        </div>
                    </div>
	                <div class="form-group col-md-6 py-sm-2">
	                    <label for="occrrncSeCd" class="col-sm-4 col-form-label">오류발생구분<b style="color: red;"> *</b></label>
                        <div class="col-sm-8">
                            <select id="occrrncSeCd" name="occrrncSeCd" class="form-control" style="width:80%;"></select>
                        </div>
	                </div>
	                <div class="form-group col-md-6 py-sm-2">
                        <label for="tyCd" class="col-sm-4 col-form-label">오류유형<b style="color: red;"> *</b></label>
                        <div class="col-sm-8">
                            <select id="tyCd" name="tyCd" class="form-control" style="width:80%;"></select>
                        </div>
                    </div>
	                <div class="form-group col-md-6 py-sm-2">
	                    <label for="occrrncDe" class="col-sm-4 col-form-label">발생일</label>
	                    <div class="col-sm-8">
	                        <input type="text" id="occrrncDe" class="form-control" disabled style="width:80%;" />
	                    </div>
	                </div>
	                <div class="form-group col-md-6 py-sm-2">
	                    <label for="occrrncHm" class="col-sm-4 col-form-label">발생시간</label>
	                    <div class="col-sm-8">
	                        <input type="text" id="occrrncHm" class="form-control" disabled style="width:80%;"/>
	                    </div>
	                </div>
	                <div class="form-group col-md-6 py-sm-2">
	                    <label for="processCd" class="col-sm-4 col-form-label">프로세스코드</label>
	                    <div class="col-sm-8">
	                        <input type="text" id="processCd" class="form-control" disabled style="width:80%;"/>
	                    </div>
	                </div>
	                <div class="form-group col-md-6 py-sm-2">
                        <label for="processNm" class="col-sm-4 col-form-label">프로세스명</label>
                        <div class="col-sm-8">
                            <input type="text" id="processNm" class="form-control" disabled style="width:80%;"/>
                        </div>
                    </div>
                    <div class="form-group col-md-12 py-sm-2">
                        <label for="errorCn" class="col-sm-2 col-form-label">오류내용</label>
                        <div class="col-sm-10">
                            <input type="text" id="errorCn" class="form-control" disabled style="width:92.5%;"/>
                        </div>
                    </div>
                    <div class="col-md-12 float-right">
                        <button type="button" class="btn btn-outline-primary float-right" id="saveOverTrnsc">중복오류통합</button>
                    </div>
                </form>
              <div class="row">
		        <div class="col-md-12 py-sm-2">
                    <div id="trnscErrorGridPop"></div>
                    <div id="trnscErrorGridPopPager" class="portal-pager"></div>
		        </div>
		      </div>
              <div class="float-right">
                  <button type="button" class="btn btn-primary" id="trnscErrorCancel">닫기</button>
              </div>
        </div>
    </div>
</div>

<style>
.js_hide
{
   display:none;
}
</style>  

<script>

//프로세스코드
var processCd;

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
        params.push({"id" : "overTrnscErrorDetail #occrrncSeCd"     , "clsCd" : "0025"});                  //오류발생구분
        params.push({"id" : "overTrnscErrorDetail #managtTyCd"      , "clsCd" : "0032"});                  //조치유형
        params.push({"id" : "overTrnscErrorDetail #managtSttusCd"   , "clsCd" : "0031"});                  //현상태
        requestCmmnCd(params);
        
	    //상세 페이지 데이터 조회
	    getDetailData(trnscErrorSn);
	}
	
	/*
	 * 이벤트 바인딩
	 * @param
	 * @return
	 */
	function bindEvent() {
		
        $("#trnscErrorCancel").on("click", function() { 
        	//closePOPTrnsc();
        	closePOPonly();
        });
        
        
        //오류발생구분 change 이벤트
        $("#overTrnscErrorDetail #occrrncSeCd").on("change",function(){
            var occrrncSeCd = $('#overTrnscErrorDetail #occrrncSeCd').val(); 
            chgOccrrncSeCd(occrrncSeCd);
        });
        
        $("#saveOverTrnsc").on("click", function() { 
        	 if($("#overTrnscErrorDetail #occrrncSeCd").val() == null || $("#trnscErrorDetail #occrrncSeCd").val() == '') {
                 alert("오류발생구분을 입력해주세요.");
                 $('#overTrnscErrorDetail #occrrncSeCd').focus();
             } else if($("#overTrnscErrorDetail #tyCd").val() == null || $("#trnscErrorDetail #tyCd").val() == '') {
                 alert("오류유형을 선택해주세요.");
                 $('#overTrnscErrorDetail #tyCd').focus();
             }else{
            	 updateDetailData();
             }
s        }); 
        
	}
	
	/*
     * 그리드 초기화
     * @param
     * @return
     */
    function drawGridPop(data){

        var params = {};
        if (data != null && data != undefined) {
            if (data.result != null && data.result.resultList != null) {
                
                var resultList = data.result.resultList;
                
                $.each(resultList,function(idx,item){
                	resultList[idx].chk = true;
                }); 
                
                params = resultList;
                
            }
            drawPager("trnscErrorGridPopPager", data.result.paginationInfo, "searchTrnscErrorPopList");
        }

        $("#trnscErrorGridPop").jsGrid({
              height : "auto"
            , width : "100%"
            , autoload: true
            , sorting : true
            , align : "center"
            , multiselect: true
            , data : params
            , rowClick: function(arg){
                //trnscErrorDetail(arg.item.trnscErrorSn);
            }
            , fields : [
                  {name: "chk"   , title : ""    , width : 30 , sorting: false ,align : "center"
                	  ,itemTemplate: function(data) { 
                          //return $("<input>").html('<input type="checkbox" name="chkOver" value="">');
                		  return $("<input>").attr("class", "custom-checkbox").attr("style", "width:18px;height:18px;").attr("type", "checkbox").attr("name", "chkOver")
                      }
                      ,headerTemplate: function() {
                          return $("<input>").attr("class", "custom-checkbox").attr("style", "width:18px;height:18px;").attr("type", "checkbox")
                          .on("click", function () {
                        	  if($(this).prop("checked")){ 
                        		  $("input[name=chkOver]").prop("checked",true); 
                              }else{ 
                            	  $("input[name=chkOver]").prop("checked",false); 
                              }
                          });
		              }
                  }
                , {name: "occrrncDe"        , title : "발생일"          , type : "text"        , width : 50, align : "center"}
                , {name: "occrrncHm"        , title : "발생시간"         , type : "text"        , width : 30, align : "center"}
                , {name: "errorUnitySn"     , title : "오류통합아이디"     , type : "text"        , width : 50, align : "center"}
                , {name: "errorCn"          , title : "오류내용"        , type : "text"        , width : 100}
                , {name: "trnscErrorSn"     ,css: "js_hide"}
            ]
        });
        
    }
	/*
	 * 데이터 조회
	 * @param
	 * @return
	 */
	function getDetailData(id) { 
		var param = {"id" : id};
		callSyncAjax("/mntrng/trnscerror/getOverTrnscErrorDetail", param, "printDetailData");
	}
	
    /*
     * 데이터 출력
     * @param
     * @return
     */
	function printDetailData(data) { 
    	
    	if (data != null &&  data.result != null) { 
    	
    		processCd = data.result.processCd;
    		
    		$("#overTrnscErrorDetail #trnscErrorSn").val(data.result.trnscErrorSn);
    		$("#overTrnscErrorDetail #errorUnitySn").val(data.result.errorUnitySn);
    		
    		$("#overTrnscErrorDetail #reprsntAt").val(data.result.reprsntAt);
    		$("#overTrnscErrorDetail #cmpnyNm").val(data.result.cmpnyNm);
    		
    		$('#overTrnscErrorDetail #occrrncSeCd').val(data.result.occrrncSeCd).prop("selected", true);
    		
    		
    		$("#overTrnscErrorDetail #occrrncDe").val(data.result.occrrncDe);
    		$("#overTrnscErrorDetail #occrrncHm").val(data.result.occrrncHm);
    		
    		$("#overTrnscErrorDetail #processCd").val(data.result.processCd);
    		$("#overTrnscErrorDetail #processNm").val(data.result.processNm);
    		
    		$("#overTrnscErrorDetail #errorCn").val(data.result.errorCn);
            
            chgOccrrncSeCd(data.result.occrrncSeCd);
            $('#overTrnscErrorDetail #tyCd').val(data.result.tyCd).prop("selected", true);
            
            searchTrnscErrorPopList();
            
    	}
	}
    
    
    /*
     * 검색
     * @param 페이지번호
     * @return
     */
    function searchTrnscErrorPopList(pageNo) {

        var url = '/mntrng/trnscerror/getTrnscErrorList';
        var currentPageNo = 1;
        if (pageNo != null && pageNo != undefined && pageNo != "") {
            currentPageNo = pageNo;
        }
        
        
        var param = {
        	  chkDe                 : 'occrrncDe'
        	, processCd             : processCd
            , currentPageNo         : currentPageNo
            , recordCountPerPage    :   10
            , pageSize              :   10
            , startDe               : '20200901'
            , endDe                 : '20200910'
        };

        callAsyncAjax(url, param, "drawGridPop");
    }
    
	
	/*
     * 데이터 저장
     * @param
     * @return
     */
    function updateDetailData(jobId) {
		
    	if($('input:checkbox[name="chkOver"]:checked').length <= 0){
            alert('체크박스를 선택 해주세요.');
            return;
        }
		
    	var updateTrancList = new Array();
    	
    	updateTrancList[0] = {errorUnitySn :  $("#overTrnscErrorDetail #errorUnitySn").val()
    			            , reprsntAt    :   "Y"
			    			, occrrncSeCd  :  $("#overTrnscErrorDetail #occrrncSeCd").val()
			    			, tyCd         :  $("#overTrnscErrorDetail #tyCd").val()
			    			, where        :  {trnscErrorSn : trnscErrorSn}}

    	
        $('input:checkbox[name="chkOver"]').each(function() {
            if(this.checked){
            	var td = $(this).closest("tr").children();
            	var overTrnscErrorSn = td.eq(5).text();
            	
                var chkOver = {errorUnitySn : "", reprsntAt : "N", occrrncSeCd : "", tyCd : "",  where : ""};
                
                chkOver.errorUnitySn    =    $("#overTrnscErrorDetail #errorUnitySn").val();
                chkOver.occrrncSeCd     =    $("#overTrnscErrorDetail #occrrncSeCd").val();
                chkOver.tyCd            =    $("#overTrnscErrorDetail #tyCd").val();
                chkOver.where           =    {trnscErrorSn : overTrnscErrorSn};
                
                updateTrancList.push(chkOver);
            }
        });

        var param = {
        	updateTrancList : updateTrancList
        };
        
        callSyncAjax("/mntrng/trnscerror/updateOverTrnscErrorDetail", param, "callBackUpdateDetailData");
    }
	
	
	function callBackUpdateDetailData(){
		alert('저장되었습니다.');
		closePOPTrnsc();
	}
	
	
	function chgOccrrncSeCd(occrrncSeCd){
		var params = [];
        if(occrrncSeCd == '01'){
            params.push({"id" : "overTrnscErrorDetail #tyCd" , "clsCd" : "0026"});    
        }else if(occrrncSeCd == '02'){
            params.push({"id" : "overTrnscErrorDetail #tyCd" , "clsCd" : "0027"});
        }else if(occrrncSeCd == '03'){
            params.push({"id" : "overTrnscErrorDetail #tyCd" , "clsCd" : "0028"});
        }else if(occrrncSeCd == '04'){
            params.push({"id" : "overTrnscErrorDetail #tyCd" , "clsCd" : "0029"});
        }else if(occrrncSeCd == '05'){
            params.push({"id" : "overTrnscErrorDetail #tyCd" , "clsCd" : "0030"});
        }else{}
        
        requestCmmnCd(params);
	}
	
	

</script>









