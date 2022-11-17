<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>


<div>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-6" alt="기준정보 > 공통코드관리">
				<div class="card card-primary">
					<div class="card-body">
					    <div style="height:50px;">
                             <div class="form-group row"  style="margin: 0.25rem 0.5rem 1.5rem 0.5rem;">
                                 <label for="schClsCd" class="col-form-label" style="width:70px;">분류코드</label>
                                 <div style="padding-left:10px;">
                                     <input type="text" class="form-control"style="width:120px;" id="schClsCd" maxlength="4" placeholder="분류코드"/>
                                 </div>
                                 <label for="schClsNm" class="col-form-label" style="padding-left:20px; width:90px;">분류코드명</label>
                                 <div style="padding-left:10px;">
                                     <input type="text" class="form-control"style="width:120px;" id="schClsNm" maxlength="20" placeholder="분류코드명" />
                                 </div>
                                 <div class="float-right">
                                     <input type="button" id="searchClsBtn" class="btn btn-info btn-flat"  value="검색" />
                                 </div>
                             </div>
                         </div>
						<div id="cmmnClsCdGrid"></div>
						<div class="form-group" style="margin: 1.25rem 0.1rem 1rem 0.1rem;">
                            <label for="inputDescription">분류코드<b style="color: red;"> *</b></label>
                            <input type="text" id="inputClsCd" class="form-control" maxlength="4" disabled>
                        </div>
                        <div class="form-group" style="margin: 0.25rem 0.1rem 1rem 0.1rem;">
                            <label for="inputDescription">분류코드명<b style="color: red;"> *</b></label>
                            <input type="text" id="inputClsCdNm" maxlength="20" class="form-control" >
                        </div>
                        <div class="form-group" style="margin: 0.25rem 0.1rem 1rem 0.1rem;">
                            <label for="inputDescription">분류코드 설명</label>
                            <input type="text" id="inputClsCdDc" maxlength="60" class="form-control" >
                        </div>
                        <div class="form-group" style="margin: 0.25rem 0.1rem 1rem 0.1rem;">
                            <label for="inputDescription">사용여부<b style="color: red;"> *</b></label>
                            <select class="form-control custom-select" id="inputUseAt">
                                <option value="" selected disabled>선택</option>
                                <option value="Y">사용</option>
                                <option value="N">미사용</option>
                            </select>
                        </div>
                         <div class="float-right" style="margin: 0.25rem 0.1rem 0 0.1rem;">
                            <c:if test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
                                <button type="button" class="btn btn-primary"  style="margin:5px 0 15px 0;" id="btnInsertClsCd" >추가</button>
                                <button type="button" class="btn btn-primary"  style="margin:5px 0 15px 0;" id="btnUpdateClsCd">저장</button>
                                <button type="button" class="btn btn-primary"  style="margin:5px 0 15px 0;" data-toggle="modal" data-target="#modal-lg-clsCd" id="btnDeleteClsCdCheck">삭제</button>
                            </c:if>
                        </div>
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="card card-info">
					<div class="card-body">
					    <div style="height:50px;">
                             <div class="form-group row"  style="margin: 0.25rem 0.5rem 1.5rem 0.5rem;">
                                 <label for="schCd" class="col-form-label" style="width:50px;">코드</label>
                                 <div style="padding-left:10px;">
                                     <input type="text" class="form-control"style="width:120px;" id="schCd" maxlength="4" placeholder="코드" />
                                 </div>
                                 <label for="schCdNm" class="col-form-label" style="padding-left:20px; width:70px;">코드명</label>
                                 <div style="padding-left:10px;">
                                     <input type="text" class="form-control"style="width:120px;" id="schCdNm" maxlength="20" placeholder="코드명" />
                                 </div>
                                 <div class="float-right">
                                     <input type="button" id="searchCdBtn" class="btn btn-info btn-flat" value="검색" />
                                 </div>
                             </div>
                         </div>
					    <div id="cmmnCdGrid"></div>
                        <div class="form-group" style="margin: 1.25rem 0.1rem 1rem 0.1rem;">
                            <label for="inputDescription">코드<b style="color: red;"> *</b></label>
                            <input type="text" id="inputCd" class="form-control" maxlength="4" disabled>
                        </div>
                        <div class="form-group"style="margin: 0.25rem 0.1rem 1rem 0.1rem;">
                            <label for="inputDescription">코드명<b style="color: red;"> *</b></label>
                            <input type="text" id="inputCdNm" maxlength="20" class="form-control" >
                        </div>
                        <div class="form-group"style="margin: 0.25rem 0.1rem 1rem 0.1rem;">
                            <label for="inputDescription">코드 설명</label>
                            <input type="text" id="inputCdDc" maxlength="60" class="form-control" >
                        </div>
                        <div class="form-group"style="margin: 0.25rem 0.1rem 1rem 0.1rem;">
                            <label for="inputDescription">사용여부<b style="color: red;"> *</b></label>
                            <select class="form-control custom-select" id="inputUseAt2">
                                <option value="">선택</option>
                                <option value="Y" selected>사용</option>
                                <option value="N">미사용</option>
                            </select>
                        </div>
                        <div class="float-right" style="margin: 0.25rem 0.1rem 0 0.1rem;">
                            <c:if test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
                            <button type="button" class="btn btn-primary"  style="margin:5px 0 15px 0;" id="btnInsertCd">추가</button>
                            <button type="button" class="btn btn-primary"  style="margin:5px 0 15px 0;" id="btnUpdateCd">저장</button>
                            <!-- <button type="button" class="btn btn-primary"  style="margin:5px 0 15px 0;" id="btnDeleteCd">삭제</button> -->
                            <button type="button" class="btn btn-primary"  style="margin:5px 0 15px 0;" data-toggle="modal" data-target="#modal-lg-cd" id="btnDeleteCdCheck">삭제</button>
                            </c:if>
                        </div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="modal fade-dept" id="modal-lg-clsCd">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header"></div>
            <div class="modal-body" >
                                    하위 코드가 모두 삭제 됩니다. 진행하시겠습니까? 
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" id="btnDeleteClsCd" data-dismiss="modal">확인</button>
            </div>
        </div>
   </div>
</div>

<div class="modal fade-dept" id="modal-lg-useAt">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header"></div>
            <div class="modal-body" >
                                    하위 코드가 모두 비활성화 됩니다. 진행하시겠습니까? 
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal" id="btnUseAtCancel">취소</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
            </div>
        </div>
   </div>
</div>

<div class="modal fade-dept" id="modal-lg-cd">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header"></div>
            <div class="modal-body" >
                                    코드가 삭제 됩니다. 진행하시겠습니까? 
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" id="btnDeleteCd" data-dismiss="modal">확인</button>
            </div>
        </div>
   </div>
</div>

<script>
	var userList = "";
	var chekClsCd ="";

	function pageInit() {
		cmmnCdClsDrawGrid();
		drawCdGrid("");
		 if($("#inputClsCd").val("")){
             $("#btnDeleteClsCdCheck").attr("disabled", true);
         }
		 if($("#inputCd").val("")){
             $("#btnDeleteCdCheck").attr("disabled", true);
         }
	}

	function bindEvent() {
		
		$("#schClsCd, #inputClsCd, #schCd, #inputCd").on("blur keyup", function() {
	        $(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
	        $(this).val( $(this).val().replace(/(\s*)/g, '' ) );
	    });
		
		$("#schClsCd, #schClsNm").keyup(function(e){
            if(e.keyCode == 13){
            	cmmnCdClsDrawGrid();
            	cmmnCdDrawGrid("");
            	$("#inputClsCd").attr("disabled", false);
                setCmmnClsCd();
            }
        });
		
		$("#schCd, #schCdNm").keyup(function(e){
            if(e.keyCode == 13){
            	cmmnCdDrawGrid($("#inputClsCd").val());
            	$("#inputCd").attr("disabled", false);
                setCmmnCd();
            }
        });
		
		$("#searchClsBtn").on("click",function(){ 
			cmmnCdClsDrawGrid();
			drawCdGrid("");
			$("#inputClsCd").attr("disabled", false);
            setCmmnClsCd();
        });
		
		$("#searchCdBtn").on("click",function(){ 
			cmmnCdDrawGrid($("#inputClsCd").val());
            $("#inputCd").attr("disabled", false);
            setCmmnCd();
        });
        
		
		$("#btnInsertCd").on("click", function(){
			$("#inputCd").attr("disabled", false);
			setCmmnCd();
			//getCd();
		});
		
		$("#btnInsertClsCd").on("click", function(){
			$("#inputClsCd").attr("disabled", false);
            setCmmnClsCd();
        });
		
		$("#btnUpdateCd").on("click", function(){ 
			var clsCd = $("#inputClsCd").val();
			var cd = $("#inputCd").val();
	        var cdNm = $("#inputCdNm").val();
	        var cdDc = $("#inputCdDc").val();
	        var useAt = $("#inputUseAt2").val();
	        if(clsCd == "" || clsCd == null){
	        	clsCd = chekClsCd;
	        }
	        if(clsCd == "" || clsCd == null){
	        	alert("분류코드를 선택해 주세요!");
	        	return false;
	        }
	        if(cd == null || cd == ""){
	        	alert("코드를  입력해주세요.");
	        	$("#inputCd").focus();
	        	return false;
	        }else if(cdNm == null || cdNm == ""){
                alert("코드명을  입력해주세요.");
                $("#inputCdNm").focus();
                return false;
            }else if(useAt == null || useAt == ""){
                alert("사용여부를 선택해주세요");
                $("#inputUseAt2").focus();
                return false;
            }else{
	        	inputCmmnCd(clsCd, cd, cdNm, cdDc, useAt);
	        	cmmnCdDrawGrid(clsCd);
	            $("#inputCd").attr("disabled", true);
	            $("#inputClsCd").attr("disabled", true);
	            setCmmnCd();
	        }
		});
		
		$("#btnUpdateClsCd").on("click", function(){
            var clsCd = $("#inputClsCd").val();
            var clsCdNm = $("#inputClsCdNm").val();
            var clsCdDc = $("#inputClsCdDc").val();
            var useAt = $("#inputUseAt").val();
            if(clsCd == null || clsCd == ""){
            	alert("분류코드를  입력해주세요.");
            	return false;
            }else if(clsCdNm == null || clsCdNm == ""){
            	alert("분류코드명을  입력해주세요.");
                $("#inputClsCdNm").focus();
                return false;
            }else if(useAt == null || useAt == ""){
            	alert("사용여부를 선택해주세요");
            	$("#inputUseAt").focus();
            	return false;
            }else{
            	inputCmmnClsCd(clsCd, clsCdNm, clsCdDc, useAt);
            	$("#inputCd").attr("disabled", true);
            	$("#inputClsCd").attr("disabled", true);
                setCmmnClsCd();
            }
        });
		
		$("#btnDeleteCd").on("click", function(){
			var clsCd = $("#inputClsCd").val();
			var cd = $("#inputCd").val();
			if(clsCd == "" || clsCd == null){
				clsCd=chekClsCd;
			}
			deleteCmmnCd(clsCd, cd);
			cmmnCdDrawGrid(clsCd);
 			/* setCmmnCd(); */ 
		});
		
		$("#btnDeleteClsCd").on("click", function(){
            var clsCd = $("#inputClsCd").val();
            deleteCmmnClsCd(clsCd);
            setCmmnClsCd();
        });
		
		$("#inputUseAt").on("change", function(){
			var useAt = $("#inputUseAt").val();
			if(useAt == "N"){
			    $("#modal-lg-useAt").modal("show");
			}
		});
		
		$("#btnUseAtCancel").on("click", function(){
			$("#inputUseAt").val("Y");
		});
	}
	
	function cmmnCdClsDrawGrid() {
		var url = "/stdrinfo/cmmncd/getCmmnClsCdList";
		var param ={
				 clsCd    : $("#schClsCd").val()
			    ,clsCdNm : $("#schClsNm").val()
		}; 
		callAsyncAjax(url, param, "drawClsCdGrid");
	}
	
	function drawClsCdGrid(data) {
		if (data != "") {
			userList = data.result.cmmnCdList;
		}
		if($("#inputClsCd").val("")){
            $("#btnDeleteClsCdCheck").attr("disabled", true);
        }
		$("#cmmnClsCdGrid").jsGrid({
			height : "260",
			width : "100%",
			autoload : true,
			sorting : true,
			scroll : true,
			rowClick : function(args) {
			    $(".jsgrid-row, .jsgrid-alt-row").removeClass("highlight");
				chekClsCd = args.item.clsCd;
			    var gRow = this.rowByItem(args.item);
				gRow.addClass("highlight");
				var clsCdDc = args.item.clsCdDc;
				$("#btnDeleteClsCdCheck").attr("disabled", false);
				setCmmnCd();
				/* setCmmnClsCd(); */
				$("#inputClsCd").attr("disabled", true);
				cmmnClsCdValue(args.item.clsCd, args.item.clsCdNm, args.item.useAt, clsCdDc); 
				cmmnCdDrawGrid(args.item.clsCd); 
			},
			data : userList.items,
			fields : [ {
			    name : "clsCd",
				title : "분류코드",
				type : "text",
				align : "center",
				width : 50
			    }, {
				name : "clsCdNm",
				title : "분류코드명",
				type : "text",
				align : "center",
				width : 100
			    }, {
				name : "useAt",
				title : "사용여부",
				type : "text",
				align : "center",
				width : 50
			    } ]
			});   
		
	}

	function cmmnClsCdValue(clsCd, clsCdNm, useAt, clsCdDc) {
		$("#inputClsCd").val(clsCd);
		$("#inputClsCdNm").val(clsCdNm);
		$("#inputClsCdDc").val(clsCdDc);
	    $("#inputUseAt").val(useAt).attr("selected", "selected");
	}
	
	
	function cmmnCdDrawGrid(value) {
		/* if(value == "" || value == null){
			alert('분류코드를 선택해 주세요.');
			return false;
		} */
        var url = "/stdrinfo/cmmncd/getCmmnCdList";
        var param = {
        		 clsCd   : value
        		,cd      : $("#schCd").val()
                ,cdNm    : $("#schCdNm").val()
        };
        
        callSyncAjax(url, param, "drawCdGrid"); //동기로 바꿔봄 => 비동기로 움직이다 보니 그리드를 그리기전에 다른 일을 처리하여 그리드가 나타나지 않음
    }
	
    function drawCdGrid(data) {
    	var userCdList = "";
        if (data != "") {
            var userCdList = data.result.cmmnCdList;
        }
        if($("#inputCd").val("")){
            $("#btnDeleteCdCheck").attr("disabled", true);
        }
        $("#cmmnCdGrid").jsGrid({
            height : "260",
            width : "100%",
            autoload : true,
            sorting : true,
            scroll : true,
            rowClick : function(args) {
                $(".jsgrid-row, .jsgrid-alt-row").removeClass("highlightSec");
                var gRow = this.rowByItem(args.item);
                gRow.addClass("highlightSec");
                var cdDc = args.item.clsCdDc;
               cmmnCdValue(args.item.cd, args.item.cdNm,args.item.useAt, args.item.cdDc);
               $("#inputCd").attr("disabled", true);
               $("#btnDeleteCdCheck").attr("disabled", false);
            },
            data : userCdList.items,
            fields : [ {
                name : "cd",
                title : "코드",
                type : "text",
                align : "center",
                width : 50
                }, {
                name : "cdNm",
                title : "코드명",
                type : "text",
                align : "center",
                width : 100
                }, {
                name : "useAt",
                title : "사용여부",
                type : "text",
                align : "center",
                width : 50
                } ],
                onRefreshed: function(args) {
                    if (args.grid.data.length) {
                        var gridBody = $("#cmmnCdGrid").find('.jsgrid-grid-body');
                        gridBody.find('.jsgrid-table tr:first-child').trigger('click');
                        
                    }else{
                        setCmmnCd();
                    }
                }
            });
    }
    
    function cmmnCdValue(cd, cdNm, useAt, cdDc) { 
    	$("#inputCd").val(cd);
    	$("#inputCdNm").val(cdNm);
    	$("#inputCdDc").val(cdDc);
        $("#inputUseAt2").val(useAt).attr("selected", "selected");
    }
    
    function setCmmnCd(){
    	$("#inputCd").val("");
        $("#inputCdNm").val("");
        $("#inputCdDc").val("");
        $("#inputUseAt2").val("Y").attr("selected", "selected"); 
    }
   
     function setCmmnClsCd(){
     	$("#inputClsCd").val("");
    	$("#inputClsCdNm").val("");
    	$("#inputClsCdDc").val("");
        $("#inputUseAt").val("").attr("selected", "selected");
    	/* var gridBody = $("#cmmnClsCdGrid").find('.jsgrid-grid-body');
        console.log(gridBody);
        gridBody.find('jsgrid-table tr:first-child').trigger('click'); */
    }
     
     function getCd(clsCd){
         var url = "/stdrinfo/cmmncd/getCd";
         var params = {
                  "clsCd" : chekClsCd
         };
         callSyncAjax(url, params, "setCd");
     }
     
     function setCd (data){
    	 $("#inputCd").val(data.result.cd);
    	 $("#inputCdNm").val("");
         $("#inputCdDc").val("");
         $("#inputUseAt2").val("Y").attr("selected", "selected"); 
     }
     
    
    function inputCmmnCd(clsCd, cd, cdNm, cdDc, useAt){
        var clsCd2 = clsCd;
        var url = "/stdrinfo/cmmncd/inputCmmnCd";
        var params = {
        		 "clsCd" : clsCd2
        		,"cd" : cd
        		,"cdNm" : cdNm
        		,"cdDc" : cdDc
        		,"useAt" : useAt
        };
        callSyncAjax(url, params, "reLoad");
    }
    
    function inputCmmnClsCd(clsCd, clsCdNm, clsCdDc, useAt){
         var url = "/stdrinfo/cmmncd/inputCmmnClsCd";
         var params = {
                  "clsCd" : clsCd
                 ,"clsCdNm" : clsCdNm
                 ,"clsCdDc" : clsCdDc
                 ,"useAt" : useAt
         };
         callAsyncAjax(url, params, "reLoadCls");
    }
    
    function reLoad(){
    	$("#inputCd").attr("disabled", true);
    	cmmnCdDrawGrid();
    }
    
    function reLoadCls(data){
        $("#inputClsCd").attr("disabled", true);
        cmmnCdClsDrawGrid();
        cmmnCdDrawGrid(); 
    }
    
    function deleteCmmnCd(clsCd, cd){
    	var url = "/stdrinfo/cmmncd/deleteCmmnCd";
    	var params = {
    			"clsCd" : clsCd,
    			"cd" : cd
    	};
    	callSyncAjax(url, params, "reLoad");
    }
    
    function deleteCmmnClsCd(clsCd){
        var url = "/stdrinfo/cmmncd/deleteCmmnClsCd";
        var params = {
                "clsCd" : clsCd
        };
        callAsyncAjax(url, params, "reLoadCls");
    }
    
</script>