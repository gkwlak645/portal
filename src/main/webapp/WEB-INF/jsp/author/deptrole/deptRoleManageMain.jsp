<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<div class="row">
    <div class="col-md-6" alt="권한>부서별역할">
        <div class="card card-default">
            <div class="card-body" style="height:420px; overflow:auto;">
                <div id="jstree"></div>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="card card-default">
             <div class="card-body" style="height:auto;height:420px;">
				                <div class="form-group" style="overflow-y:auto; vertical-align:middle;" id="selectRole" style="overflow:auto;">
				                </div> 
				                <div style="display:table-cell; vertical-align:bottom;margin: 0.25rem 0.5rem 1.5rem 0.5rem;"  class="form-group float-right">
				                    <c:if test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
				                        <button type="button" class="btn btn-primary float-right" id="updateRoleDept" disabled>저장</button>
				                    </c:if>
				                </div>
             </div>
        </div>
     </div>
</div>
<script>
    var selectCd = "";
    function pageInit() {
        drawJstree();
        callAsyncAjax("/author/rolemng/roleMngList", {}, "showRole");
    };

    function bindEvent() {
    	$("#jstree").on("changed.jstree", function(e, data) {
    		$("#updateRoleDept").attr("disabled",false);
            var deptCode = data.selected.toString();
            selectCd = deptCode;
            var url = '/author/deptrole/deptRole';
            var param = {
                    deptCd : selectCd
            };
            callAsyncAjax(url, param, "showDeptRole");
        });
    	
    	$("#updateRoleDept").on("click",function(){
   			var radioVal = $('input:radio[name="checkRole"]:checked').val();
            var url = "/author/deptrole/deptInsertRole";
            var param = {
                    deptCd : selectCd,
                    roleCd : radioVal
            };
            callAsyncAjax(url, param, "successSave");
    	});
    };
    
    function drawJstree() {
        $('#jstree').jstree({
            'core' : {
                'data' : {
                    'url' : function(node) {
                        var sUri = "/orgnzt/dept/deptManageList";
                        return sUri;
                    },
                    'data' : function(node) {
                        return {
                            "nId" : node.id
                        };
                    },
                    'dataFilter' : function(data, type) {
                        var jsonData = JSON.parse(data);
                        var sdata = changeData(jsonData);
                        sdata = JSON.stringify(sdata);
                        return sdata;
                    }
                },
                'themes' : {
                    'name' : 'proton',
                    'responsive' : true
                }
            }
        });
    }
    
    function changeData(data) {
        var deptList = data.result.deptList;
        var jsonData = '';
        jsonData += '[';

        $.each(deptList, function(index, item) {
            if (item.upDeptCd == "") {
                jsonData +='{ "id" : "'+item.deptCd+'", "parent" : "#", "text" : "'+item.deptNm+'" }, ';
            } else {
                jsonData +='{ "id" : "'+item.deptCd+'", "parent" : "'+item.upDeptCd+'", "text" : "'+item.deptNm+'" }, ';
            }
        });
        jsonData = jsonData.substr(0, jsonData.length - 2);
        jsonData += ']';
        jsonData = JSON.parse(jsonData);
        return jsonData;
    }
    
    function showDeptRole(data){
    	var deptRole = data.result.deptRole;
    	if(deptRole != null){
    		$('input:radio[name="checkRole"]:input[value="'+deptRole.roleCd+'"]').prop("checked", true);
    	}else{
    		$('input:radio[name="checkRole"]').prop("checked", false);
    	}
    }
    
    function successSave(){
        alert("저장되었습니다.");
    }
    
    function showRole(data){
    	console.log(data);
    	var roleList = data.result.roleMngList;
    	var html = "";
    	$.each(roleList,function(index,item){
	    	html += '<label>';
	    	html +=    '<input type="radio" name="checkRole" value="'+item.roleCd+' "style="width:24px; margin-bottom: 8px;" name="checkRole" value=';
	    	html +=    '<span>'+item.roleNm+'</span>';
	    	html += '</label><br/>';
    	});
    	$("#selectRole").append(html);
    }
</script>