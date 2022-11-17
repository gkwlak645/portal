<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="card card-primary" id="cardDiv">
	<div class="card-header">
		<h3 class="card-title">업무시스템 등록</h3>
	</div>
	<div class="card-body">
		<div class="row">
			<div class="col-md-12">
				<form class="form-inline">
					<div class="form-group col-md-6 py-sm-2">
						<label class="col-sm-4 col-form-label"> 분류<b style="color: red; padding-left: 10px;">*</b></label>
						<div class="col-sm-8">
							<select id="cntcType1" class="form-control"></select>
						</div>
					</div>
					<div class="form-group col-md-6 py-sm-2">
						<label class="col-sm-4 col-form-label"> 회사<b style="color: red; padding-left: 10px;">*</b></label>
						<div class="col-sm-8">
							<select id="cmpny1" class="form-control"></select>
						</div>
					</div>
					<div class="form-group col-md-6 py-sm-2">
						<label class="col-sm-4 col-form-label">시스템코드<b
							style="color: red; padding-left: 10px;">*</b></label>
						<div class="col-sm-8">
							<input type="text" id="sysCd" class="form-control" readonly="readonly" />
						</div>
					</div>
					<div class="form-group col-md-6 py-sm-2">
						<label class="col-sm-4 col-form-label">시스템명<b
							style="color: red; padding-left: 10px;">*</b></label>
						<div class="col-sm-8">
                            <input type="text" id="sysNm" class="form-control">
						</div>
					</div>
					<div class="form-group col-md-12 py-sm-6">
						<label class="col-sm-2 col-form-label">설명</label>
						<div class="col-10">
							<textarea id="sysDc" class="form-control"></textarea>
						</div>
					</div>
					<div class="form-group col-md-12 py-sm-2">
						<label class="col-sm-2 col-form-label">사용여부</label>
						<div class="col-6">
							<select id="use" class="form-control">
								<option value="Y">사용</option>
								<option value="N">미사용</option>
							</select>
						</div>
					</div>
				</form>
				<div class="float-right">
					<button type="button" class="btn btn-primary" id="btnRegist">등록</button>
					<button type="button" class="btn btn-primary" id="btnClose">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>


<script>
	$(document).ready(function() {

		bindEvent();
		pageInit();
	});
	
	function pageInit(){
		
		
		
	}
	
	

	function bindEvent() {
		    

		$("#btnClose").on("click", function() {
			$(".over").remove();
		});
	
		$("#btnRegist").on("click", function() {
			if($("#cntcType1").val() == null || $("#cntcType1").val() == ''){
                alert("분류를 선택해주세요.");
                return
            } else if($("#cntcType1").val() == '02' && ($("#cmpny1").val() == '' || $("#cmpny1").val() == null)) {
                alert("회사를 입력해주세요.");
                return
            } else if($("#sysCd").val() == '' || $("#sysCd").val() == null) {
                alert("시스템코드를 입력해주세요.");
                return
            } else if($("#sysNm").val() == '') {
                alert("시스템명을 입력해주세요.");
                return    
            } else{
            	   cntcRegister();
            }
	    });
		
		//코드 자동채번 
		$("#cmpny1").on("change", function(){
			var url = '/stdrinfo/cntcsys/autoNumSelect';
			
			if($("#cmpny1").val() == ""){
				return false;
			}
			
			var param = {Tenant : $("#cmpny1").val()}
			callAsyncAjax(url,param,"pirntcode");			
		});
		
		$("#cntcType1").on("change", function(){
			if($("#cntcType1").val() == "01"){
				$("#cmpny1").attr('disabled', true);
				var url = '/stdrinfo/cntcsys/autoNumSelect';
				
				var param = { Tenant : "Z"}
				callAsyncAjax(url,param,"pirntcode");
			}
			else{
				$("#cmpny1").attr('disabled', false);
				
				if($("#cmpny1").val() == ""){
					$("#sysCd").val("");
	                return false;
	            }
	            
	            var param = {Tenant : $("#cmpny1").val()}
	            callAsyncAjax(url,param,"pirntcode");   
			}
		});
		
		
		
		
		$("#cntcType1").on("change", function(){
            if($("#cntcType1").val() == "02"){
                           
                $("#cmpny1").attr('disabled', false);
            }
		
        });
		
		var params = [];
		params.push({"id" : "cmpny1", "clsCd" : "0024"});    //회사
	     
	    params.push({"id" : "cntcType1", "clsCd" : "0035"});  //연계시스템분류
	    requestCmmnCd(params);
	
	}
	//연계시스템 등록
	function cntcRegister(){
		var url = "/stdrinfo/cntcsys/cntcRegister";
        var param = new Object();		
		
        param.CntcType = $("#cntcType1").val();
        if($("#cntcType1").val() == "01"){
        	param.Tenant = null;
        }
        else{
        	param.Tenant = $("#cmpny1").val();
        }
        
        param.SysCd = $("#sysCd").val();
        param.SYsNm = $("#sysNm").val();
        param.SysDc = $("#sysDc").val();
        param.Use = $("#use").val();
        callSyncAjax(url, param, 'closePOP');
  	}
	
	//닫기
	   function closePOP(){
	        $(".over").remove();
	        getCntcSysList();
	    }
	
	//코드 자동채번 print
	   function pirntcode(data){
		 $("#sysCd").val(data.result.NEXT_CD);   
		   		   
	   }
	   
	   
	   
	
</script>


