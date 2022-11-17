<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="card card-primary" alt="자원>프로세스관리 등록">
    <div class="card-header">
        <!-- <h3 class="card-title">프로세스 등록</h3> -->
    </div>
    <div class="card-body">
       <form id="version" class="form-inline">
            <div class="col-md-12 row" style="min-height:580px;">
                <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                     <label class="col-sm-4 col-form-label">회사<b style="color: red;">*</b></label>
                     <div class="col-sm-8">
                         <select class="form-control" id="cmpny" style="width:60%;margin-right: 3px;">
                         <option value="">선택</option>
                         </select>
                     </div>
                </div>
                <div class="form-group col-md-6 py-sm-2" ></div>
                <div class="form-group col-md-6 py-sm-2">
                    <label class="col-sm-4 col-form-label">과제<b style="color: red;">*</b></label>
                     <div class="col-sm-8">
                         <select class="form-control" id="taskCd" style="width:60%;margin-right: 3px;">
                         <option value="">회사를 선택하지 않았습니다.</option>
                         </select>
                     </div>
                </div>
                <div class="form-group col-md-6 py-sm-2">
                    <label class="col-sm-4 col-form-label">프로세스<b style="color: red;">*</b></label>
                     <div class="col-sm-8">
                         <select class="form-control" id="taskProcessCd" style="width:60%;margin-right: 3px;">
                         <option value="">과제를 선택하지 않았습니다.</option>
                         </select>
                     </div>
                </div>
                <div class="form-group col-md-6 py-sm-2">
                    <label for="" class="col-sm-4 col-form-label">패키지 이름<b style="color: red;">*</b></label>
                    <div class="col-sm-8">
                        <select class="form-control" id="processName" style="width:60%;margin-right: 3px;" >
                            <option value="">회사를 선택하지 않았습니다.</option>
                        </select>
                    </div>
                </div>
                <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                    <label for="" class="col-sm-4 col-form-label">패키지 버전<b style="color: red;">*</b></label>
                    <div class="col-sm-8">
                        <select class="form-control" id="processVersion" style="width:60%;margin-right: 3px;" >
                            <option value="">패키지를 선택하지 않았습니다.</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-group col-md-6 py-sm-2">
                    <label for="" class="col-sm-4 col-form-label">환경<b style="color: red;">*</b></label>
                    <div class="col-sm-8">
                        <select class="form-control" id="envrnCd" style="width:60%;margin-right: 3px;" >
                            <option value="">회사를 선택하지 않았습니다.</option>
                        </select>
                    </div>
                </div>
                <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                    <label for="" class="col-sm-4 col-form-label">설명</label>
                    <div class="col-sm-8">
                        <textarea rows="1" id="description" class="form-control" style="width:60%;margin-right: 3px;" maxlength="60"></textarea>
                    </div>
                </div> 
                
                 <div class="form-group col-md-12" id="paramDivNone" style="display : block;">
                    <label>현재 패키지 버전에 입력 또는 출력 파라미터가 없습니다.</label>
                 </div>
                 <div class="form-group col-md-12" id="paramDiv" style="display : block;">
	                <div class="form-group col-md-12">
		                <div class="form-group col-md-6 py-sm-2">
		                    <div class="card-body p-10">
		                        <table id="tblInput" class="table table-sm" style="height:60px;">
		                            <colgroup>
		                              <col width="30%">
		                              <col width="*">
		                            </colgroup>
		                            <thead>
		                                <tr>
		                                    <th style="text-align:center; height:20px;" colspan="2">입력 값</th>
		                                </tr>
		                            </thead>
		                            <tbody>
		                                <tr>
		                                    <td>파라미터</td>
		                                    <td>값</td>
		                                </tr>
		                            </tbody>                                               
		                        </table>
		                    </div>
		                </div>
		                <div class="form-group col-md-6 py-sm-2">
		                    <div class="card-body p-0">
		                        <table id="tblOutput" class="table table-sm"  style="height:60px;">
		                            <thead>
		                                <tr>
		                                    <th style="text-align:center; height:20px;">출력 값</th>
		                                </tr>
		                            </thead>
		                            <tbody>
		                                <tr>
		                                    <td>파라미터</td>
		                                </tr>
		                            </tbody>   
		                        </table>
		                    </div>
		                </div>
		            </div>
	            </div>
                <div class="col-sm-12 custom-control custom-switch">     
                    <input type="checkbox" id="customSwitch2" class="custom-control-input" >                       
                    <label class="custom-control-label float-right" for="customSwitch2">프로세스를 자동으로 시작</label>                         
                </div>   
            </div>
        </form>                     
        <div class="float-right" style="margin:15px 0 15px 2px;">
            <c:if test="${txScreenAuthor != null}">
                <c:if test="${txScreenAuthor.wrtngAuthor eq 'N'}">
                    <button type="button" class="btn btn-primary float-right" id="Cancel">목록으로</button><br><br>
                </c:if>
                <c:if test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
                   <button type="button" class="btn btn-primary" id="btnUpdate">등록</button>
                    &nbsp;
                   <button type="button" class="btn btn-primary" id="btnClose">취소</button>
                </c:if>
            </c:if>
       </div>
    </div>
</div>

    
<script>


var versionList;

	$(function() {
	
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
            params.push({"id" : "cmpny", "clsCd" : "0024"});    //회사
            resetPage();
        }else{
            params.push({"id" : "cmpny", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
            $('#paramDivNone').css({ display: 'block' });
            $('#paramDiv').css({ display: 'none' });
        }
        requestCmmnCd(params);
        
        if(chkCmpnyCd()){
            getTaskCdList();
            getProcessAPIList();
            getEnvrnAPIList(); 
        }
	}
	
	/*
	 * 이벤트 바인딩
	 * @param
	 * @return
	 */
	function bindEvent() {
		
		//과제프로세스 SELECT
		 $("#cmpny").on("change", function() { 
			 //초기화
			 resetPage();
			 
			 if(chkCmpnyCd()){
				 getTaskCdList();
				 getProcessAPIList();
				 getEnvrnAPIList(); 
			 }
        });
		
		//프로세스 SELECT
         $("#taskCd").on("change", function() {
        
             //과제, 프로세스 초기화
             $("#taskProcessCd").html('');
             
             if(($("#cmpny").val() != null && $("#cmpny").val() != "")
            		 && ($("#taskCd").val() != null && $("#taskCd").val() != "")){
            	 getTaskProcessList();
             }
             else {
            	 $("#taskProcessCd").html('<option value="">과제를 선택하지 않았습니다.</option>');
             }
        });
		
       //패키지 SELECT
         $("#processName").on("change", function() {
        	 if(chkCmpnyCd()){
        		//과제, 프로세스 초기화
                 $("#processVersion").html('');
                 if(($("#cmpny").val() != null && $("#cmpny").val() != "")
                         && ($("#processName").val() != null && $("#processName").val() != "")){
                     getProcessVersionAPIList();
                 }
                 else {
                	 
                	 $("#processVersion").html('<option value="">패키지를 선택하지 않았습니다.</option>');
                	 $('#tblInput').hide();
                	 $('#tblOutput').hide();
                	 $('#paramDivNone').html('<label>현재 패키지 버전에 입력 또는 출력 파라미터가 없습니다.</label>');
                	 $('#paramDivNone').css({ display: 'block' });
                 }
        	 }else{
        		 alert('회사를 선택하지 않았습니다.');
        	 }

        });
       
       
       //버전 SELECT
         $("#processVersion").on("change", function() {
        	 if($("#processVersion").val() != null && $("#processVersion").val() != ""){
        		 getVersionParam($("#processVersion option:selected").text());
        	 }
        });
       
		//팝업닫기 event
		$("#cancel, #btnClose").on("click", function() {
        	closePOP();
        });
        
		//프로세스 등록
        $("#btnUpdate").on("click", function() {
        	
        	if($("#cmpny").val() == null || $("#cmpny").val() == ""){
                alert("회사를 선택하세요.");
                return false;
            }else if($("#taskCd").val() == null || $("#taskCd").val() == ""){
                alert("과제를 선택하세요.");
                return false;
            }else if($("#taskProcessCd").val() == null || $("#taskProcessCd").val() == ""){
                alert("프로세스를 선택하세요.");
                return false;
            }else if($("#processName").val() == null || $("#processName").val() == ""){
                alert("패키지 이름을 선택하세요.");
                return false;
            }else if($("#processVersion").val() == null || $("#processVersion").val() == ""){
                alert("패키지 버전을 선택하세요.");
                return false;
            }else if($("#envrnCd").val() == null || $("#envrnCd").val() == ""){
                alert("환경을 선택하세요.");
                return false;
            }else{
            	processRegister();
            }
        	
        });
		
	}
	
	
	/*
     * 페이지 초기화
     * @param
     * @return
     */
    function resetPage() {
        
    	 //과제, 프로세스 초기화
        $("#taskCd").html('<option value="">회사를 선택하지 않았습니다.</option>');
        $("#taskProcessCd").html('<option value="">과제를 선택하지 않았습니다.</option>');
        $("#processName").html('<option value="">회사를 선택하지 않았습니다.</option>');
        $("#processVersion").html('<option value="">패키지를 선택하지 않았습니다.</option>');
        $("#envrnCd").html('<option value="">회사를 선택하지 않았습니다.</option>');
        
        $('#paramDivNone').css({ display: 'block' });
        $('#paramDiv').css({ display: 'none' });
    }
	
	/*
     * 회사코드 여부 확인
     * @param
     * @return
     */
    function chkCmpnyCd() {
		
		var result = false;
		var cmpny = $("#cmpny").val();
		
		if(cmpny == null || cmpny == ""){
			result = false;
		}else{
			result = true;
		}
        
        return result;
    }
	
	
	/*
     * 과제 리스트 조회
     * @param
     * @return
     */
    function getTaskCdList() {
        
        var url = '/resrce/process/getTaskCdList';
        var param = {
        	cmpnyCd : $("#cmpny").val()
        };
        callAsyncAjax(url, param, "callBackGetTaskCdList");
        
    }
	
	
	function callBackGetTaskCdList(data){
		var taskList = data.result;
		var tmp = "";
		tmp = "<option value=''>선택</option>";
		$.each(taskList, function(idx, item) { 
           //tmp += "<option value='"+item.taskCd+"'>"+item.taskNm+"</option>";
           
           tmp += "<option value='"+item.taskCd+"'>["+item.taskCd+"] "+item.taskNm+"</option>";
        });
		$("#taskCd").html(tmp);
	}
	
	
	/*
     * 과제-프로세스 리스트 조회
     * @param
     * @return
     */
    function getTaskProcessList() {
        
        var url = '/resrce/process/getProcessCdList';
        var param = {
        	  cmpnyCd   : $("#cmpny").val()
            , taskCd    :   $("#taskCd").val()
        };
        callAsyncAjax(url, param, "callBackTaskProcessList");
        
    }
	
	function callBackTaskProcessList(data){
		var taskProcessList = data.result;
        var tmp = "";
        tmp = "<option value=''>선택</option>";
        $.each(taskProcessList, function(idx, item) { 
           tmp += "<option value='"+item.processCd+"'>"+item.processNm+"</option>";
        });
        $("#taskProcessCd").html(tmp);
	}
	
	
	
	/*
     * 패키지(프로세스,릴리즈) 리스트 조회
     * @param 페이지번호
     * @return
     */
    function getProcessAPIList() {
        var url = '/resrce/process/getProcessAPIList';
        
        var param = {
        		cmpnyCd   : $("#cmpny").val()
        };
        
        callAsyncAjax(url, param, "callBackGetProcessAPIList");
    }
    
    
    function callBackGetProcessAPIList(data){
        var processList = data.result;
        var tmp = "";
        //tmp = "<option value=''>선택</option>";
        $.each(processList, function(idx, item) { 
           tmp += "<option value='"+item.Id+"'>"+item.Id+"</option>";
        });
        $("#processName").html(tmp);
        
        for(var i=0; i<$("#processName").length; i++){
        	 
            //여러개의 셀렉트 박스가 존재하기 때문에 $('.select').eq(i) 로 하나씩 가져온다.
            var oOptionList = $("#processName").eq(i).find('option');
             
            oOptionList.sort(function(a, b){
                if (a.text > b.text) return 1;
                else if (a.text < b.text) return -1;
                else {
                    if (a.value > b.value) return 1;
                    else if (a.value < b.value) return -1;
                    else return 0;
                }
            });
         
            $("#processName").eq(i).html(oOptionList);            
        }       
        
        $('#processName').prepend("<option value=''>선택</option>");
        
        $("#processName option:eq(0)").prop("selected", true);
    }
    
    
    /*
     * 패키지(프로세스,릴리즈) 버전 조회
     * @param 페이지번호
     * @return
     */
    function getProcessVersionAPIList() {
        var url = '/resrce/process/getProcessVersionAPIList';
        
        var param = {
        	cmpnyCd   : $("#cmpny").val()
           ,processId : $("#processName").val()
        };
        
        callAsyncAjax(url, param, "callBackGetProcessVersionAPIList");
    }
    
    
    function callBackGetProcessVersionAPIList(data){
    	
    	$('#paramDivNone').css({ display: 'none' });
    	$('#paramDiv').css({ display: 'block' });
    	
        versionList = data.result;
        var tmp = "";
        tmp = "<option value=''>선택</option>";
        $.each(versionList, function(idx, item) { 
        	
            if(item.IsLatestVersion){
            	tmp += "<option value='"+item.Id+"' selected>"+item.Version+"</option>";
            	printParameterInfo(item.Arguments);
            }else{
            	tmp += "<option value='"+item.Id+"'>"+item.Version+"</option>";
            }	
        	
        });
        $("#processVersion").html(tmp);
        
        $('#tblInput').show();
        $('#tblOutput').show();
    }
    
    /*
     * 버전 변경시 파라미터 재세팅
     * @param 페이지번호
     * @return
     */
    function getVersionParam(version){ 
        $.each(versionList, function(idx, item) { 
            if(item.Version == version){ 
                printParameterInfo(item.Arguments);
            }  
        });
    }
	
	
	
	
	/*
     * 환경 리스트 조회
     * @param 페이지번호
     * @return
     */
    function getEnvrnAPIList() {
        var url = '/resrce/envrn/getEnvrnAPIList';
        
        var param = {
        	cmpnyCd   : $("#cmpny").val()
        };
        
        callAsyncAjax(url, param, "callBackGetEnvrnAPIList");
    }
	
	
	function callBackGetEnvrnAPIList(data){
		var envrnList = data.result;
        var tmp = "";
        tmp = "<option value=''>선택</option>";
        $.each(envrnList, function(idx, item) {  
           tmp += "<option value='"+item.Id+"'>"+item.Name+"</option>";
        });
        $("#envrnCd").html(tmp);
	}
	
	
    
    /*
     * 파라미터 리스트 조회
     * @param
     * @return
     */
    function getProcessParamterList() {
    	
        var url = '/resrce/process/getProcessParamterList';
        var param = {
            id : $("#id").val()
        };
        callAsyncAjax(url, param, "printParameterInfo");
    	
    }
    
    /*
     * 파라미터 정보 출력
     * @param
     * @return
     */
    function printParameterInfo(data) {
    	
    	if (data != null) {
    		if (data.Input != null) {
    			var inputList = JSON.parse(data.Input);
    		    var tmp = "<tr><td>파라미터</td><td>값</td></tr>";
    			for (var i = 0; i < inputList.length; i++) {
	    			var input = inputList[i];
	    			var type = input.type; 
	    			type = type.split(',')[0].replace("System.", "");
	    			
	    			if(type == "Int32"){
	    				tmp += "<tr><td>"+ type + "<br/>" +  input.name + "</td><td><input type='text' name = 'inputParam' id='" + input.name + "' maxlength='4' numberOnly/></td></tr>";
	    			}else{
	    				tmp += "<tr><td>"+ type + "<br/>" +  input.name + "</td><td><input type='text' name = 'inputParam' id='" + input.name + "' maxlength='20'/></td></tr>";
	    			}
	    			
    			}
    			
    			$("#tblInput > tbody:last").html(tmp);
    			
    		}else{
    			$("#tblInput > tbody:last").html("<tr><td>파라미터</td><td>값</td></tr><tr><td colspan='2'>이 버전에 대한 입력 파라미터가 정의되지 않았습니다.</td></tr>");
    		}
    		
            if (data.Output != null) {
                
                var outputList = JSON.parse(data.Output);
                var tmp = "<tr><td>파라미터</td></tr>";
                for (var i = 0; i < outputList.length; i++) {
                    var output = outputList[i];
                    var type = output.type; 
                    type = type.split(',')[0].replace("System.", "");
                    
                    tmp += "<tr><td>"+ type + "<br/>" +  input.name + "</td></tr>"
                    
                }
                
                $("#tblOutput > tbody:last").html(tmp);
                
            }else{
            	$("#tblOutput > tbody:last").html("<tr><td>파라미터</td></tr><tr><td>이 버전에 대한 출력 파라미터가 정의되지 않았습니다.</td></tr>");
            }
         
    	}else{
    		$("#tblInput > tbody:last").html("<tr><td>파라미터</td><td>값</td></tr><tr><tr><td colspan='2'>이 버전에 대한 입력 파라미터가 정의되지 않았습니다.</td></tr>");
    		$("#tblOutput > tbody:last").html("<tr><td>파라미터</td></tr><tr><td>이 버전에 대한 출력 파라미터가 정의되지 않았습니다.</td></tr>");
    	}
    }
    
     
     
      /*
       * 파라미터 등록
       * @param
       * @return
       */
       function processRegister(){
    	  
    	  /*  {"Name":"Direct_접속_E_Robot_robot","Description":"","EnvironmentName":"E_Robot_robot","EnvironmentId":128
    		,"ProcessKey":"Direct_접속","ProcessVersion":"1.0.7226.15579","InputArguments":"{}"
    		,"ProcessSettings":{"ErrorRecordingEnabled":false,"Duration":40,"Frequency":500,"Quality":100,"AutoStartProcess":true}} */
    		
    		
    		/* {"Name":"Direct_접속_E_Robot_robot","Description":"","EnvironmentName":"E_Robot_robot","EnvironmentId":128
    			,"ProcessKey":"Direct_접속","ProcessVersion":"1.0.7226.15579","InputArguments":"{}"
    			,"ProcessSettings":{"ErrorRecordingEnabled":false,"Duration":40,"Frequency":500,"Quality":100,"AutoStartProcess":false}} */
    	   
    	   var param = {};
    			
    	   param = {"Name":"","Description":"","EnvironmentName":"","EnvironmentId":0
                   ,"ProcessKey":"","ProcessVersion":"","InputArguments":"{}"
                   ,"ProcessSettings":{"ErrorRecordingEnabled":false,"Duration":40,"Frequency":500,"Quality":100,"AutoStartProcess":false}};
    	   
    	   //------------------------------------------ 프로세스 기본 정보 --------------------------------------------		
    	   param.cmpnyCd = $("#cmpny").val();
    	   
    	   //param.taskCd = $("#taskCd").val();
    	   
    	   param.processCd = $("#taskProcessCd").val();
    	   
    	   //------------------------------------------ 프로세스 api 정보 --------------------------------------------    
    	   param.Name = $("#processName").val() + "_" + $("#envrnCd option:selected").text() ;
    	   
    	   param.Description = $("#description").val();
    	   
    	   param.EnvironmentName = $("#envrnCd option:selected").text();
    	   
    	   param.EnvironmentId = parseInt($("#envrnCd").val());
    	   
    	   param.ProcessKey = $("#processName").val();
    	   
    	   param.ProcessVersion = $("#processVersion option:selected").text();
    	   
    	   var inputParamValue = $("input[name='inputParam']").length;
		   
    	   if(inputParamValue > 0){
    		   var inputName = new Array(inputParamValue);
               var inputValue = new Array(inputParamValue);
               
               var InputData = {};
               var InputArguments = {};
               
               for(var i=0; i<inputParamValue; i++){                          
                  inputName[i] = $('input[name="inputParam"]').eq(i).attr("id");
                  inputValue[i] = $('input[name="inputParam"]').eq(i).val()  == "" ? null : $('input[name="inputParam"]').eq(i).val().replace(',','');
               }
               
               for (idx in inputName) {
                   InputData[inputName[idx]] = inputValue[idx];
               } 
               
               //InputArguments.InputArguments = JSON.stringify(InputData);
               param.InputArguments = JSON.stringify(InputData);
    		   
    	   }
		   
		   if($("input:checkbox[id=customSwitch2]").is(":checked")){
			   param.ProcessSettings.AutoStartProcess = true;
		   }
		   
		   
		   callSyncAjax("/resrce/process/insertProcess", param, "callBackInsertProcess");
    	   
       }
      
       
       
        function callBackInsertProcess(){
            alert('저장되었습니다.');
            searchProcessList();
            closePOP();
        }
        
    


</script>