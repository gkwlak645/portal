<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<div class="row">
    <div class="col-md-6">
        <div class="card card-default" alt="권한>역할관리">
            <div class="card-body" style="height:auto; min-height:362px;">
                <div id="roleJsGrid"></div>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="card card-default">
            <div class="card-body" style="height:auto;">
                <div class="form-group">
                    <label for="inputRoleCode">역할코드<b style="color: red;"> *</b></label>
                    <input type="text" class="form-control" id="inputRoleCd" maxlength="4" disabled numberOnlyNoComma />
                </div>
                <div class="form-group">
                    <label for="inputRoleName">역할명<b style="color: red;"> *</b></label>
                    <input type="text" class="form-control" id="inputRoleNm" maxlength="20"/>
                </div>
                <div class="form-group">
                    <label for="inputRoleDc">역할설명</label>
                    <input type="text" class="form-control" id="inputRoleDc" maxlength="60"/>
                </div>
                <div class="form-group">
                    <label for="inputUseAt">사용여부<b style="color: red;"> *</b></label>
                    <select class="form-control" id="inputUseAt">
                        <option value="">선택</option>
                        <option value="Y">사용</option>
                        <option value="N">미사용</option>
                    </select>
                </div>
                <br/>
                <div class="float-right">
                    <c:if test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
                        <button type="button" class="btn btn-primary" style="margin:5px 0 15px 0;"id="btnInputRole">추가</button>
                        <button type="button" class="btn btn-primary" style="margin:5px 0 15px 0;"id="btnUpdateRole">저장</button>
                        <button type="button" class="btn btn-primary" style="margin:5px 0 15px 0;"data-toggle="modal" data-target="#modal-lg-role" id="btnDeleteRoleCheck">삭제</button>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade-dept" id="modal-lg-role">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header"></div>
            <div class="modal-body" >
                                   삭제하시겠습니까? 
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" id="btnDeleteRole" data-dismiss="modal">삭제</button>
            </div>
        </div>
   </div>
</div>

<script>

	function pageInit() {
		cmmnCdDrawGrid();
		//$("#btnDeleteRoleCheck").attr("disabled", true);
		$("#btnDeleteRoleCheck").hide();
	}
	
	function bindEvent() {
		$(document).on("click", "#btnInputRole", function(){
			$("#inputRoleCd").attr("disabled", false);
			$("#inputRoleCd").val("");
			$("#inputRoleNm").val("");
			$("#inputRoleDc").val("");
			$("#inputUseAt").val("Y").attr("selected");
			$("#btnDeleteRoleCheck").hide();
		});
		
		$(document).on("click", "#btnUpdateRole", function(){
			var roleCd = $("#inputRoleCd").val();
			var roleNm = $("#inputRoleNm").val();
			var roleDc = $("#inputRoleDc").val();
			var useAt = $("#inputUseAt").val();

			if(roleCd == null || roleCd == '') {
				alert("역할코드를 확인해 주세요.");
                $('#inputRoleCd').focus();
				return false;
			}else if(roleNm == null || roleNm == '') {
                alert("역할명을 확인해 주세요.");
                $('#inputRoleNm').focus();
                return false;
            }else if(useAt == null || useAt == '') {
            	alert("사용여부를 확인해 주세요.");
            	$('#inputUseAt').focus();
            	return false;
			}else{
				var url = "/author/rolemng/updateRoleMng";
	            var params = {
	                     "roleCd" : roleCd
	                    ,"roleNm" : roleNm
	                    ,"roleDc" : roleDc
	                    ,"useAt" : useAt
	            }
	            callAsyncAjax(url, params, "reFreshGrid");
			}
		});
		
		$(document).on("click", "#btnDeleteRole", function(){
			var value = $("#inputRoleCd").val();
			if(value == '0001'){
				alert($("#inputRoleNm").val()+'은(는) 삭제 할 수 없습니다.');
				return false;
			}
			var url = "/author/rolemng/deleteRoleMng";
			var param = {"roleCd" : value};
			callAsyncAjax(url, param, "reFreshGrid");
		});
	}
	
	function cmmnCdDrawGrid() {
	    var url = "/author/rolemng/roleMngList";
	    var param = {};
	    callAsyncAjax(url, param, "drawRoleGrid");
	}
	
	function drawRoleGrid(data) {
		var userRoleList = data.result.roleMngList;
	    $("#roleJsGrid").jsGrid({
	        height : "294",
	        width : "100%",
	        autoload : true,
	        sorting : true,
	        scroll : true,
	        rowClick : function(args) {
	        	$("#inputRoleCd").attr("disabled", true);
	            $(".jsgrid-row, .jsgrid-alt-row").removeClass("highlight");
	            var gRow = this.rowByItem(args.item);
	            gRow.addClass("highlight");
	            var roleDc = args.item.roleDc;
	            roleValue(args.item.roleCd, args.item.roleNm, roleDc, args.item.useAt);
	            if(args.item.roleCd == '0001'){
	            	$("#btnDeleteRoleCheck").hide();
	            }else{
	            	$("#btnDeleteRoleCheck").show();
	            }
	        },
	        data : userRoleList,
	        fields : [ {
	            name : "roleCd",
	            title : "역할코드",
	            type : "text",
	            align : "center",
	            width : 50
	            }, {
	            name : "roleNm",
	            title : "역할명",
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
	
	function roleValue(roleCd, roleNm, roleDc, useAt){
		$("#inputRoleCd").val(roleCd);
		$("#inputRoleNm").val(roleNm);
		$("#inputRoleDc").val(roleDc);
	    $("#inputUseAt").val(useAt).attr("selected","selected");
	}
	
	function reFreshGrid(){
	    cmmnCdDrawGrid();
	    $("#inputRoleCd").attr("disabled", true);
	    $("#inputRoleCd").val("");
        $("#inputRoleNm").val("");
        $("#inputRoleDc").val("");
	    $("#inputUseAt").val("").attr("selected");
	}
</script>