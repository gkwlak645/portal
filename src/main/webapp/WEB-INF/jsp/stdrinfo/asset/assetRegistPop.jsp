<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="card card-primary" id="cardDiv">
<div class="card-header">
    <h3 class="card-title">상세조회</h3>
</div>
<div class="card-body"style="height:704px; overflow:auto;">
        <div class="row">
            <div class="col-md-12">
                <form class="form-inline" id="assetRegistForm">
	                 <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
	                         <label class="col-sm-3 col-form-label">회사<b style="color:red;padding-left:10px;">*</b></label>
	                         <div class="col-sm-9">
	                             <select class="form-control" id="cmpny" style="width:80%;  max-width:220px;margin-right: 3px;">
	                             <option value="">선택</option>
	                             </select>
	                         </div>
	                     </div>
	                     <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
	                         <label class="col-sm-3 col-form-label">Asset명<b style="color:red;padding-left:10px;">*</b></label>
	                         <div class="col-sm-9">
	                             <input type="text" id="name" class="form-control" maxlength="80" style="width:80%;margin-right: 3px;" required>
	                         </div>
	                     </div>   
	                     
	                     <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
	                         <label class="col-sm-3 col-form-label">형식<b style="color:red;padding-left:10px;">*</b></label>
	                         <div class="col-sm-9">
	                             <select id="valueType" class="form-control" style="width:80%;margin-right: 3px;" type="text" >
	                             <option value="">선택</option>
	                         </select>
	                     </div>
	                 </div>
	                 <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
	                      <label for="deviceId"  class="col-sm-3 col-form-label">전역값</label>
	                      <div class="col-sm-9">
	                          <input type="checkbox" id="cbxValueScope" class="form-control" style="width:18px;height:18px;" checked>
	                      </div>
	                  </div>   
	                  <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
	                       <label for="deviceId" class="col-sm-3 col-form-label">설명</label>
	                       <div class="col-sm-9">
	                           <textarea style="width:80%;margin-right: 3px;" type="form-control" id="description" class="form-control" maxlength="80"   required></textarea>
	                       </div>
	                  </div> 
	                  <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;" id="textDiv">
	                         <label class="col-sm-3 col-form-label">텍스트<b style="color:red;padding-left:10px;">*</b></label>
	                         <div class="col-sm-9">
	                             <input type="text" name="value" id="textValue" class="form-control" maxlength="1000" style="width:80%;margin-right: 3px;" required>
	                         </div>
	                     </div>  
	                     <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;" id="booleanDiv">
	                         <label class="col-sm-3 col-form-label">텍스트<b style="color:red;padding-left:10px;">*</b></label>
	                         <div class="col-sm-9">
	                             <input type="radio" name="value" id="trueValue" value="True" checked /> <label for="trueValue">True </label>
	                             <input type="radio" name="value" id="falseValue" value="False"/> <label for="falseValue">False</label>
	                         </div>
	                     </div> 
	                     <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;" id="intDiv">
	                         <label class="col-sm-3 col-form-label">텍스트<b style="color:red;padding-left:10px;">*</b></label>
	                         <div class="col-sm-9">
	                             <input type="text" name="value" id="intValue" class="form-control" maxlength="10" style="width:80%;margin-right: 3px;" required numberOnly>
	                         </div>
	                     </div> 
	                     <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;" id="cdDiv">
	                         <label class="col-sm-3 col-form-label">텍스트<b style="color:red;padding-left:10px;">*</b></label>
	                         <div class="col-sm-4">
	                             <input type="text" name="value" id="cdIdValue" class="form-control" maxlength="50" placeholder="사용자이름" style="width:100%;margin-right: 3px;" required>
	                         </div>
	                         <div class="col-sm-4">
	                             <input type="password" name="value" id="cdPwValue" class="form-control" maxlength="50" placeholder="암호" style="width:100%;margin-right: 3px;" required>
	                         </div>
	                     </div>                                   
	                 <div class="row">
	                    <div class="col-md-12 py-sm-2">
	                        <div class="card">
	                            <div class="card-body">
	                                <button type="button"  id="btnRateReg" class="btn btn-primary float-right"  style="margin:5px 0 15px 3px;">저장</button>
	                    <button type="button" id="btnRateDel" class="btn btn-primary float-right"  style="margin:5px 0 15px 3px;">삭제</button>
	                    <button type="button" id="btnRateAdit" class="btn btn-primary float-right"  style="margin:5px 0 15px 3px;">추가</button>
	                
	                    <div id="assetRobtGrid" class="jsGridRate"></div>
	                    <div id="assetRobtGridPager" class="portal-pager"></div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
               </form>
                 <div class="float-right" style="margin:15px 0 15px 2px;">
                    <c:if test="${txScreenAuthor.wrtngAuthor eq 'N'}">
                        <button type="button" class="btn btn-primary float-right" id="cancel">목록으로</button><br><br>
                    </c:if>
                    <c:if test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
                        <button type="button" class="btn btn-primary" id="assetDel" data-toggle="modal" data-target="#modal-lg3">삭제</button>
                        &nbsp;
                        <button type="button" class="btn btn-primary" id="btnRegist">등록</button>
                        <button type="button" class="btn btn-primary" id="btnUpdate">수정</button>
                        &nbsp;
                        <button type="button" class="btn btn-primary" id="btnClose">취소</button>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>
    
    
<div class="modal fade-dept" id="modal-lg3">
   <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header"></div>
            <div class="modal-body">
                <span>해당 Asset를 삭제하시겠습니까?</span>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" id="assetDelete">삭제</button>
            </div>
        </div>
    </div>
</div>
    
<script>

// asset 원래 이름
var orgName;
//회사코드
var cmpnyCd
//asset 아이디
var assetId;
// 그리드선택 data
var selectData;
// 로봇 list
var robotList;
//추가시 templet
var addTemp = "";

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
        
    	cmpnyCd = "${sessionUserInfo.txCmpnyCd}";
    	
        var params = [];
        if("${txScreenAuthor.untenantAuthor}" == 'Y'){
            params.push({"id" : "cmpny", "clsCd" : "0024"});    //회사
	    }else{
	        params.push({"id" : "cmpny", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
	    }

        params.push({"id" : "valueType", "clsCd" : "0033"});
        requestCmmnCd(params);
        
        
       
        
      //상세 페이지 데이터 조회
      if(assetId != null && assetId != ""){ 
    	  //수정일 경우 asset정보, robot list, assetRobtlist 모두 가져옴
    	  getDetailData();
    	  $("#btnUpdate").show();
          $("#btnRegist").hide();
      }else{
    	  //등록일 경우 robot list 가져온 뒤 grid 바인딩
    	  searchRobtList(cmpnyCd);
    	  $("#textDiv").show();
          $("#booleanDiv, #intDiv, #cdDiv").hide();
          $("#btnRegist").show();
          $("#btnUpdate").hide();
          $("#assetDel").hide();
      }
      
      

       // 로딩 끝
	   $('.dimmed').css({ display: 'none' });
	   $('.loading').css({ display: 'none' });
	   $('.loading').removeClass('show');
    }
    
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent() {
    	
    	btnRateDelController();
    	
    	//추가 버튼클릭시 
        $("#btnRateAdit").on("click", function(){
        	var cmpnyCd = $("#cmpny").val();
            var valueType = $("#valueType").val();
        	chgInsertTemp(valueType);
        	if(cmpnyCd == null || cmpnyCd == ""){
                alert('회사를 선택해주세요.');
                return false;
            }else if(valueType == null || valueType == ""){
                alert('형식을 선택해주세요.');
                return false;
            }else{
            	$("#assetRegistForm .jsgrid-edit-row").remove();
                $("#assetRegistForm .jsgrid-row, .jsgrid-alt-row").show();
                insertRowController();
                $("#btnRateDel").attr("disabled", true);
            }
        	
        	/* if(chgInsertTemp()){
        		$("#assetRegistForm .jsgrid-edit-row").remove();
                $("#assetRegistForm .jsgrid-row, .jsgrid-alt-row").show();
                insertRowController();
                $("#btnRateDel").attr("disabled", true);
        	} */
        });
        
        //로봇 asset 저장버튼 클릭시
        $("#btnRateReg").on("click", function(){
        	var isNew = true;
            var robtId = "";
            var robotNm = "";
            var value = "";
            var cdPw = "";
            var overRobtChk = "";
            var valueType = $("#valueType").val();
            
            if($("#assetRegistForm .jsgrid-insert-row").css("display") == "table-row"){
            	robtId = $("#insertRobtId").val();
            	robotNm = $("#insertRobtId option:selected").text();

                if(valueType == '3'){
                	 value = $("input:radio[name=gridinValue]:checked").val();
                }else if(valueType == '4'){
                	 value = $("#inputIntValue").val();
                }else if(valueType == '5'){
                	 value = $("#inputCdIdValue").val();
                     cdPw = $("#inputCdPwValue").val();
                }else{
                	 value = $("#inputTextValue").val();
                }
                
                var gridList = $("#assetRobtGrid").jsGrid("option", "data");
                $.each(gridList, function(idx, item) {
                    if(item.robotId == robtId){
                        overRobtChk = null;
                    }
                });
            }else {
               isNew = false;
               robtId = $("#updtRobtId").val();
               robotNm = $("#updtRobtId option:selected").text();

               if(valueType == '3'){
                    value = $("input:radio[name=gridUpValue]:checked").val();
               }else if(valueType == '4'){
                    value = $("#updtIntValue").val();
               }else if(valueType == '5'){
            	    value = $("#updtCdIdValue").val();
            	    cdPw = $("#updtCdPwValue").val();
               }else{
                    value = $("#updtTextValue").val();
               } 
            }
            
            if(robtId == null || robtId == ""){
                alert("로봇을 선택하세요.");
                return false;
            }else if(value == null || value == ""){
                alert("값을 입력해 주세요.");
                return false;
            }else if(valueType == '5' && (cdPw == null || cdPw == "")){
                alert("값을 입력해 주세요.");
                return false;
            }else if(overRobtChk == null){
                alert("이 로봇에는 이미 연결된 Asset 값이 있습니다.");
                $("#insertRobtId").val('').prop("selected", true);
                $('#inputTextValue').val('');
                return false;
            }else{
                var param; 
                if(valueType == '5'){
                	param = {"robotId" : robtId, "value" : value, "robotNm" : robotNm , "cdId" : value ,"cdPw" : cdPw }; 
                }else{
                	param = {"robotId" : robtId, "value" : value, "robotNm" : robotNm};
                }
               
                if(isNew){
                	$("#assetRobtGrid").jsGrid("insertItem", param); 
                	$("#insertRobtId").val('').prop('selected',true);
                	$("input[name='gridinValue']").not("input:radio[name='gridinValue']").val('');
                }else{
                	$("#assetRobtGrid").jsGrid("updateItem",null, param);
                	$("#updtRobtId").val('').prop('selected',true);
                	$("input[name='gridUpValue']").not("input:radio[name='gridUpValue']").val('');
                }
            }
            
            btnRateDelController();
        });
        
        
        //로봇 asset 삭제버튼 클릭시 
        $("#btnRateDel").on("click", function(){
        	var robotId = selectData.robotId
        	
        	
        	if(confirm(selectData.robotNm+"을(를) 삭제하시겠습니까?")){
                var robtGrid = $("#assetRobtGrid").jsGrid("option", "data"); 

                robtGrid = robtGrid.filter(function(d){ return d.robotId != robotId});
                // true 일 떄, 남김
                // false면 삭제
 
                //drawRobtGrid({result : {assetRobotList : robtGrid}});
                drawRobtGrid({result : {assetDetail : robtGrid}});

                btnRateDelController();
        	}
        });
        
        
       //jsGrid영역 외 클릭시 추가, 수정 금지
        $("body").on("click", function(e){
            if($(e.target).hasClass("content-wrapper")){
                $('#assetRegistForm .jsgrid-insert-row').css({ display: 'none' });
                $("#assetRegistForm .jsgrid-row, .jsgrid-alt-row").removeClass("highlight");
                $("#assetRegistForm .jsgrid-edit-row").remove();
                $("#assetRegistForm .jsgrid-row, .jsgrid-alt-row").show();
                $("#btnRateDel").attr("disabled", true);
            }
        });

       
       //등록 ,수정전 체크
    	$("#btnRegist ,#btnUpdate").on("click", function() {  
    		
    		var ValueScope = $("input:checkbox[id=cbxValueScope]").is(":checked");
    		
    		var robtGrid = $("#assetRobtGrid").jsGrid("option", "data"); 

        	if($("#cmpny").val() == null || $("#cmpny").val() == '') {
                alert("회사를 선택해주세요.");
                $('#cmpny').focus();
            } else if($("#name").val() == null || $("#name").val() == '') {
            	alert("Asset명을 입력해주세요.");
                $('#name').focus();
            }else if($("#valueType").val() == null || $("#valueType").val() == '') {
                alert("형식을 선택해주세요.");
                $('#valueType').focus();
            }else if(ValueScope && ($("#valueType").val() == 2 && ($("#textValue").val() == null || $("#textValue").val() == ''))) {
            	alert("텍스트를 입력해주세요.");   
                $('#textValue').focus();
            }else if(ValueScope && ($("#valueType").val() == 3 && ($("input:radio[name='value']").val() == null || $("input:radio[name='value']").val() == ''))) {
            	alert("텍스트를 입력해주세요."); 
            }else if(ValueScope && ($("#valueType").val() == 4 && ($("#intValue").val() == null || $("#intValue").val() == ''))) {
            	alert("텍스트를 입력해주세요.");
                $('#intValue').focus();
            }else if(ValueScope &&($("#valueType").val() == 5 && ($("#cdIdValue").val() == null || $("#cdIdValue").val() == ''))) {
            	alert("텍스트를 입력해주세요.");
                $('#cdIdValue').focus();
            }else if(ValueScope &&($("#valueType").val() == 5 && ($("#cdPwValue").val() == null || $("#cdPwValue").val() == ''))) {
                alert("텍스트를 입력해주세요.");
                $('#cdPwValue').focus();
            }else if(!ValueScope && (robtGrid == null || 0 >= robtGrid.length)){
            	 alert("하나 이상의 로봇이 필요합니다.");
            }else{
            	if(assetId != null && assetId != ""){ 
                    updateAsset(); 
                }else{
                	registAsset();
                }
            }  
        });

    	
       //팝업 종료
        $("#cancel, #btnClose").on("click", function() {
            closePOP();
        });
        
       //asset 삭제
        $("#assetDelete").on("click", function() {
        	deleteAsset();
        });
        
        //형식 변경 event
        $("#valueType").on("change", function() {
        	var valueType = $("#valueType").val();
        	$("input[name='value']").not("input:radio[name='value']").val('');
        	if(valueType == '3'){
                $("#booleanDiv").show();
                $("#textDiv, #intDiv, #cdDiv").hide();
            }else if(valueType == '4'){
                $("#intDiv").show();
                $("#textDiv, #booleanDiv, #cdDiv").hide();
            }else if(valueType == '5'){
                $("#cdDiv").show();
                $("#textDiv, #booleanDiv, #intDiv").hide();
            }else{
                $("#textDiv").show();
                $("#booleanDiv, #intDiv, #cdDiv").hide();
            }
        	
        	//table 다시 그리기
        	drawRobtGrid("");
        	chgInsertTemp(valueType);
        });
        
        //전역값 변경 evnet
        $("#cbxValueScope").on("change", function() {
        	 if($("input:checkbox[id='cbxValueScope']").is(":checked")){
        		 $("input[name='value']").prop("disabled",false); 
        		 $("input[name='value']").empty();
        		 $("#textValue").empty();
        	 }else{
        		 $("input[name='value']").prop("disabled",true); 
        	 }
        });
        
        
        //전역값 변경 evnet
        $("#cmpny").on("change", function() {
        	searchRobtList($('#cmpny').val());
        });
        
        
    }
    
    //로봇 list 가져오기
    function searchRobtList(txCmpnyCd){
    	robotList = "";
    	if(txCmpnyCd != null && txCmpnyCd != ""){
    		var url = "/stdrinfo/asset/getRobtList";
            param = {
                    cmpnyCd :   txCmpnyCd
            };
            callAsyncAjax(url, param, "callBackSearchRobtList");
    	}else{
    		drawRobtGrid("");
    	}
    }
    
    function callBackSearchRobtList(data){
    	if (data != null &&  data.result != null) { 
    		robotList =  data.result.robotList;
    		drawRobtGrid("");
    	}
    }
   
    
    //insertRow 컨트롤
    function insertRowController(){
        if ($('#assetRegistForm .jsgrid-insert-row').css('display') == "none") {
            //Add 버튼 보이기, Show Add Button
            $('#assetRegistForm .jsgrid-insert-row').css({ display: 'table-row' });
            return true;
        }
        if ($('#assetRegistForm .jsgrid-insert-row').css('display') == "table-row") {
            //Add 버튼 숨기기, Hide Add Button 
            $('#assetRegistForm .jsgrid-insert-row').css({ display: 'none' });
            $("#insertRobtId").val("").attr("selected", "selected");
            return true;
        }
    }
    
     //selectField 커스텀 하기
    var selectField = function(config){
        jsGrid.Field.call(this, config);
    };
    selectField.prototype = new jsGrid.Field({
        //기본 탬플릿
        itemTemplate : function(value){
                return value;
        },
        //insert탬플릿
        insertTemplate : function(){ 
        	var tmp = ''; 
        	tmp += "<select id='insertRobtId'>";
            tmp += "<option value=''>선택</option>";
            $.each(robotList, function(idx, item) {
                tmp += "<option value='" + item.robotId + "'>" + item.name + "</option>";
            });
            tmp += "</select>";
            return tmp;
        },
        //edit탬플릿
        editTemplate : function(value){ 
        	var tmp = '';
        	tmp += "<select id='updtRobtId' disabled>";
	            $.each(robotList, function(idx, item) {
	            	if(item.name == value){
	            		tmp += "<option value='" + item.robotId + "' selected>" + item.name + "</option>";
	            	}
	            });
	        tmp += "</select>";
            return tmp;              
        },
        //editvalue
        editValue: function() {
            return this.editControl.val();
        }
    });
    
    
    //textField 커스텀 하기
    var textField = function(config){
        jsGrid.Field.call(this, config);
    };
    textField.prototype = new jsGrid.Field({
        //기본 탬플릿
        itemTemplate : function(value){
                return value;
        },
        //insert탬플릿
        insertTemplate : function(){ 
        	return '<div id="insertTemp"></div>';
        },
        //edit탬플릿
        editTemplate : function(value){ 
            var tmp = "";
            var valueType = $("#valueType").val();
            if(valueType == '2'){
                tmp += '<input type="text" name="gridUpValue" id="updtTextValue" maxlength="50" value="'+value+'">';
            }else if(valueType == '3'){
            	if(value == "True"){
            		tmp += '<input type="radio" name="gridUpValue" id="updtTrueValue" value="True" checked style="width:5%;"/> <label for="trueValue" style="width:5%;margin-right: 3px;">True </label>';
                    tmp += '<input type="radio" name="gridUpValue" id="updtFalseValue" value="False" style="width:5%;"/> <label for="falseValue" style="width:5%;">False</label>';
            	}else{
            		tmp += '<input type="radio" name="gridUpValue" id="updtTrueValue" value="True" style="width:5%;"/> <label for="trueValue" style="width:5%;margin-right:3px;">True </label>';
                    tmp += '<input type="radio" name="gridUpValue" id="updtFalseValue" value="False" checked style="width:5%;"/> <label for="falseValue" style="width:5%;">False</label>';
            	}
            }else if(valueType == '4'){
                tmp = '<input type="text" name="gridUpValue" id="updtIntValue" maxlength="10" value="'+value+'" numberOnly>';
            }else if(valueType == '5'){
                tmp += '<input type="text" name="gridUpValue" id="updtCdIdValue"  maxlength="50" value="'+value+'" placeholder="사용자이름" style="width:40%;margin-right: 3px;">';
                tmp += '<input type="password" name="gridUpValue" id="updtCdPwValue" maxlength="50" placeholder="암호" style="width:40%;margin-right: 3px;">';
            }else{
                alert('형식을 선택해주세요.');
                tmp += '';
            }
            return tmp;
        }

    });
      
    //jsGrid에 커스텀 필드 적용
    jsGrid.fields.select = selectField;
    jsGrid.fields.text = textField;
    
    //Insert Temp html 그려주기
    function chgInsertTemp(valueType){
    	var tmp = "";
    	
        if(valueType == '2'){
            tmp += '<input type="text" name="gridinValue" id="inputTextValue" maxlength="50" >';
        }else if(valueType == '3'){
            tmp += '<input type="radio" name="gridinValue" id="inputTrueValue" value="True" checked style="width:5%;"  /> <label for="inputTrueValue" style="width:5%;margin-right: 3px;">True </label>';
            tmp += '<input type="radio" name="gridinValue" id="inputFalseValue" value="False" style="width:5%;" /> <label for="inputFalseValue" style="width:5%;">False</label>';
        }else if(valueType == '4'){
            tmp = '<input type="text" name="gridinValue" id="inputIntValue"  maxlength="10" numberOnly>';
        }else if(valueType == '5'){
            tmp += '<input type="text" name="gridinValue" id="inputCdIdValue"  maxlength="50" placeholder="사용자이름" style="width:40%;margin-right: 3px;">';
            tmp += '<input type="password" name="gridinValue" id="inputCdPwValue" maxlength="50" placeholder="암호" style="width:40%;margin-right: 3px;">';
        }else{

        }
        
        $('#assetRegistForm  .jsgrid-insert-row .jsgrid-cell > #insertTemp').html(tmp);
        
    }
    
    //jsGrid그리기
    function drawRobtGrid(data){
        var params = {};
        
       if (data == null ||  data == "" ||  data == undefined) {
            //params = data.result.rateUpdt;
            //drawPager("rateGridPager", data.result.paginationInfo, "searchEnvrnList");
    	   params = [];
        }else{
        	//params = data.result.assetRobotList;
        	params = data.result.assetDetail.filter(function(d) {return d.robotNm != null && d.robotNm != ""});
        }
        
        $("#assetRobtGrid").jsGrid({
              height : "auto"
            , width : "100%"
            , autoload: true
            , sorting : true
            , align : "center"
            , data : params 
            , inserting: false
            , selectData : false
            , editing : true
            , rowClick: function(args){
                    selectData = args.item;
                    this.editItem($(args.event.target).closest("tr"));
                    $("#btnRateDel").attr("disabled", false);
                    $("#assetRegistForm .jsgrid-row, .jsgrid-alt-row").removeClass("highlight");

                    //addrow 숨기기
                    if ($('#assetRegistForm  .jsgrid-insert-row').css('display') == "table-row") {
                        $('#assetRegistForm  .jsgrid-insert-row').css({ display: 'none' });
                        return true;
                    }
            }
            , fields : [
                 {name: "id"        , title : "아이디"  , type : "text"   , width : 0      , visible : false}
                ,{name: "robotId"   , title : "로봇"   , type : "text"    , width : 0     , visible : false}
                ,{name: "robotNm"   , title : "로봇"  , type : "select"   , width : 80      , align : "left"}
                ,{name: "value"     , title : "값"   , type : "text"   , width : 250      , align : "left"}
            ]
        }); 
    }
    
    //삭제버튼 컨트롤
    function btnRateDelController(){
    	selectData="";
        $("#btnRateDel").attr("disabled", true);
    }
    
    
    /*
     * 데이터 조회
     * @param
     * @return
     */
    function getDetailData() {
        var param = {cmpnyCd : cmpnyCd, "id" : assetId}; 
        callSyncAjax("/stdrinfo/asset/getAssetDetail", param, "printDetailData");
    }

    function showAndhide(vt)
    {
    	if(vt == parseInt(3)){ 
            $("#booleanDiv").show();
            $("#textDiv, #intDiv, #cdDiv").hide();
        }else if(vt == parseInt(4)){
            $("#intDiv").show();
            $("#textDiv, #booleanDiv, #cdDiv").hide();
        }else if(vt == parseInt(5)){ 
            $("#cdDiv").show();
            $("#textDiv, #booleanDiv, #intDiv").hide(); 
        }else{ 
            
            $("#textDiv").show();
            $("#booleanDiv, #intDiv, #cdDiv").hide();
        }
    }

    /*
     * Asset 데이터출력
     * @param
     * @return
     */
    function printDetailData(data) {
    
    	if (data != null &&  data.result != null &&  data.result.assetDetail != null) {
    		
    	    //로봇 등록시 list
    		robotList =  data.result.robotList;
    		
    		//asset data 상세
    		var assetData = data.result.assetDetail;		
    		
    		$("input:checkbox[id='cbxValueScope']").prop("checked", false);
            $("input[name='value']").prop("disabled",true);
            
    		/* $("#textDiv").show();
            $("#booleanDiv, #intDiv, #cdDiv").hide(); */
    
    		
    	    for(var i=0; i<assetData.length; i++) {
    	    	$('#cmpny').val(assetData[i].cmpnyCd).prop("selected", true);
                $('#cmpny').attr('disabled', true);
                
                $("#name").val(assetData[i].name);
                
                $("#valueType").val(assetData[i].valueType).prop("selected", true);
                $("#valueType").attr('disabled', true);
                
                chgInsertTemp(assetData[i].valueType);
                showAndhide(assetData[i].valueType);
                
    	    	if(assetData[i].robotId == null || assetData[i].robotId == "") {

    	    		$("input:checkbox[id='cbxValueScope']").prop("checked", true);
    	    		$("input[name='value']").prop("disabled", false);
    	    		
                    if(assetData[i].valueType == parseInt(3)){ 
                        $("#booleanDiv").show();
                        $("#textDiv, #intDiv, #cdDiv").hide();
                        
                        if(assetData[i].value != "" && assetData[i].value != null){
                            $('input:radio[name=value]:input[value=' + assetData[i].value + ']').attr("checked", true);
                        }
                        
                        var assetRobotList = data.result.assetRobotList; 
                        if(assetRobotList != null || assetRobotList.length>0){
                            $.each(assetRobotList, function(idx, item) {
                                if(item.value == "True"){
                                    assetRobotList[idx].value = "True";
                                }else{
                                    assetRobotList[idx].value = "False";
                                }
                            });
                        }
                    }else if(assetData[i].valueType == parseInt(4)){
                        $("#intDiv").show();
                        $("#textDiv, #booleanDiv, #cdDiv").hide();
                        $("#intValue").val(assetData[i].value);
                    }else if(assetData[i].valueType == parseInt(5)){ 
                        $("#cdDiv").show();
                        $("#textDiv, #booleanDiv, #intDiv").hide(); 
                        
                        if(assetData[i].value != "" && assetData[i].value != null){
                            var value = JSON.parse(assetData[i].value);
                            $("#cdIdValue").val(value.Username);
                        }
                        
                        var assetRobotList = data.result.assetRobotList; 
                        if(assetRobotList != null || assetRobotList.length>0){
                            $.each(assetRobotList, function(idx, item) {
                                var value = JSON.parse(item.value);
                                assetRobotList[idx].value = value.Username;
                                assetRobotList[idx].cdId = value.Username;
                            });
                        }
                    }else{ 
                        
                        $("#textDiv").show();
                        $("#booleanDiv, #intDiv, #cdDiv").hide();
                        $("#textValue").val(assetData[i].value);
                    }

                    
                    $("#description").val(assetData[i].description);
                    $("#value").val(assetData[i].value);                
                }
    	    
    	    	
            }
    	    

            drawRobtGrid(data);
            
    	}else{
    		alert('asset을 찾을 수 없습니다.');
    		closePOP();
    	}
    	
    }
    
    /*
     * Asset 등록
     * @param
     * @return
     */
    function registAsset() {
    	
    	var param ={}
    	param.cmpnyCd            =   $("#cmpny").val()
        param.Name               =   $("#name").val()
        param.Description        =   $("#description").val()
        param.CanBeDeleted       =   true
        param.HasDefaultValue    =   $("input:checkbox[id=cbxValueScope]").is(":checked");
        
        var ValueScope;

        var valueType = $("#valueType").val();
        if(valueType == '3'){
            param.ValueType    =   "Bool"
            param.ValueScope   =   ValueScope;
            param.BoolValue    = param.HasDefaultValue ? $("input:radio[name=value]:checked").val() : null;
        }else if(valueType == '4'){
            param.ValueType    =   "Integer"
            param.ValueScope   =   ValueScope;
            param.IntValue     = param.HasDefaultValue ? $("#intValue").val() : null;
        }else if(valueType == '5'){
            param.ValueType    =   "Credential"
            param.ValueScope   =   ValueScope;
            param.CredentialUsername = param.HasDefaultValue ? $("#cdIdValue").val() : null;
            param.CredentialPassword = param.HasDefaultValue ? $("#cdPwValue").val() : null;
        }else{
           param.ValueType    =   "Text"
           param.ValueScope   =   ValueScope;
           param.StringValue  = param.HasDefaultValue ? $("#textValue").val() : null;
        }
        
        param.RobotValues        =   getRobotValues();
        
        // 로봇별 asset이 1개라도 있으면 PerRobot이다.
        if(param.RobotValues.length > 0) {        
            param.ValueScope = "PerRobot";
        }
        else {
            param.ValueScope = "Global";
        }
    	
        callSyncAjax("/stdrinfo/asset/registAsset", param, "callBackAsset");
        
        
    }
    
    
    /*
     * Asset 수정
     * @param
     * @return
     */
    function updateAsset() {  
    	var param ={} 
              param.cmpnyCd            =   $("#cmpny").val() 
    	      param.Id                 =   assetId
    	      param.Name               =   $("#name").val()
    	      param.Description        =   $("#description").val()
    	      param.CanBeDeleted       =   true
   	          param.HasDefaultValue    =   $("input:checkbox[id=cbxValueScope]").is(":checked");
    	      param.orgName            =   orgName
    	      
    	     var valueType = $("#valueType").val();
   	         if(valueType == '3'){
   	        	 param.ValueType    =   "Bool"
   	             param.BoolValue    = param.HasDefaultValue ? $("input:radio[name=value]:checked").val() : null;
   	         }else if(valueType == '4'){
   	        	 param.ValueType    =   "Integer"
   	             param.IntValue     = param.HasDefaultValue ? $("#intValue").val() : null;
   	         }else if(valueType == '5'){
   	        	 param.ValueType    =   "Credential"
   	             param.CredentialUsername = param.HasDefaultValue ? $("#cdIdValue").val() : null;
   	             param.CredentialPassword = param.HasDefaultValue ? $("#cdPwValue").val() : null;
   	         }else{
   	        	param.ValueType    =   "Text"
   	            param.StringValue  = param.HasDefaultValue ? $("#textValue").val() : null;
   	         }
   	         
    	      param.RobotValues        =   getRobotValues();
    	     
    	      
    	      // 로봇별 asset이 1개라도 있으면 PerRobot이다.
    	      if(param.RobotValues.length > 0) {	  
    	    	  param.ValueScope = "PerRobot";
    	      }
    	      else {
    	    	  param.ValueScope = "Global";
    	      }

              callSyncAjax("/stdrinfo/asset/updateAsset", param, "callBackAsset");
    }
    
    /*
     * Asset 로봇별 지정 등록/수정
     * @param
     * @return
     */
    function getRobotValues() {
    	
    	var robtGrid = $("#assetRobtGrid").jsGrid("option", "data");
        
    	var RobotValues = [];
    	
    	$.each(robtGrid, function(idx, item) {
    		var param = {}
    		var isNew;
    		
    		/* param = {"Id":"","RobotId":0,"RobotName":"","StringValue":"","BoolValue":false,"IntValue":0
                    ,"ValueType":"","Value":"","CredentialUsername":"","CredentialPassword":"","ExternalName":"","CredentialStoreId":null}  */
    		
    		param = {"RobotId":0,"RobotName":"","StringValue":"","BoolValue":false,"IntValue":0
                    ,"ValueType":"","Value":"","CredentialUsername":"","CredentialPassword":"","ExternalName":"","CredentialStoreId":null} 
            
    		if(item.id == null || item.id == "" || item.id == undefined){ //신규
    			//param.Id = -9007199254740990;
    			isNew = true;  
            }else{ //수정
            	//param.Id = item.id;
            	isNew = false;  
            }
    		
    		param.RobotId = parseInt(item.robotId); 
    		param.RobotName = item.robotNm;
    		
    		var valueType = $("#valueType").val();
            if(valueType == '3'){
                param.ValueType    = "Bool"
                param.BoolValue    = item.value;
            }else if(valueType == '4'){
            	item.value == null || item.value == "" || item.value == undefined ? param.IntValue = 0 : param.IntValue = parseInt(removeCommas(item.value));
                param.ValueType    =   "Integer"
            }else if(valueType == '5'){
                param.ValueType    =   "Credential"
                param.CredentialUsername = item.cdId;
                param.CredentialPassword = item.cdPw;
            }else{
               param.StringValue  = item.value;
               param.ValueType    =   "Text";
            }
    		
            if(isNew){
            	param.CredentialStoreId = 1;
            }

            RobotValues.push(param);
        });
    	
    	return RobotValues;
    	
    }
    
    
    /*
     * Asset 삭제
     * @param
     * @return
     */
    function deleteAsset() {
        var param = {
       		 cmpnyCd : $("#cmpny").val()
       		,id      :  assetId
        };
        
         callSyncAjax("/stdrinfo/asset/deleteAsset", param, "callBackDeleteAsset");
    }
    
    
    function callBackAsset(param){
    	alert('저장되었습니다.');
    	searchAssetList();
    	closePOP();
    }
    
    function callBackDeleteAsset(){
        alert('삭제되었습니다.');
        searchAssetList();
        $("#modal-lg3").modal("toggle");
        closePOP();
    }
    

</script>









