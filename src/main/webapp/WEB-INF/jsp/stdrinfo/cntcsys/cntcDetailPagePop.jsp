<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="card card-primary" id="cardDiv">
	<div class="card-header">
		<h3 class="card-title">업무시스템 상세</h3>
	</div>
	<div class="card-body">
		<div class="row">
			<div class="col-md-12">
				<form class="form-inline">
					<div class="form-group col-md-6 py-sm-2">
						<label class="col-sm-4 col-form-label"> 분류<b
							style="color: red; padding-left: 10px;">*</b></label>
						<div class="col-sm-8">
							<select id="cntcType1" class="form-control"></select>
						</div>
					</div>
					<div class="form-group col-md-6 py-sm-2">
						<label class="col-sm-4 col-form-label"> 회사<b
							style="color: red; padding-left: 10px;">*</b></label>
						<div class="col-sm-8">
							<select id="cmpny1" class="form-control"></select>
						</div>
					</div>
					<div class="form-group col-md-6 py-sm-2">
						<label class="col-sm-4 col-form-label">시스템코드<b
							style="color: red; padding-left: 10px;">*</b></label>
						<div class="col-sm-8">
							<input type="text" id="sysCd" class="form-control"  readonly="readonly" />
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
					<button type="button" class="btn btn-primary" id="btnEdit">수정</button>
					<%-- <button type="button" class="btn btn-primary" id="btnDel">삭제</button>--%>
					<button type="button" class="btn btn-primary" id="btnClose2">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>


<script>
$(document).ready(function() {

    bindEvent();

});

function bindEvent() {
    

    $("#btnClose2").on("click", function() {
        $(".over").remove();
    });
    $("#btnEdit").on("click", function() {
    	 if($("#sysNm").val() == '') {
             alert("시스템명을 입력해주세요.");
             $("#sysNm").focus();
             return    
         }
    	cntcModify();
    });
    $("#btnDel").on("click", function() {
        cntcDelete();
    });
    
      
}

// 연계시스템 상세 수정
function cntcModify(){
	
	var url = '/stdrinfo/cntcsys/cntcSysUpdate';
	var param = new Object();
	
	param.CntcType =$("#cntcType").val();
    param.Tenant =$("#cmpny").val();
    param.SysCd =$("#sysCd").val();
    
    param.SYsNm =$("#sysNm").val();
    
    param.SysDc =$("#sysDc").val();
    param.Use =$("#use").val();
		
	callAsyncAjax(url, param, 'closePOP');

}

//연계시스템 삭제
function cntcDelete(){
	
	var url = '/stdrinfo/cntcsys/cntcSysDelete';	
	var param = new Object();
	
	param.SysCd =$("#sysCd").val();
	
	callAsyncAjax(url, param, 'closePOP');
		
}

// 닫기
function closePOP(){
	 $(".over").remove();
	 getCntcSysList();
}

	
</script>


