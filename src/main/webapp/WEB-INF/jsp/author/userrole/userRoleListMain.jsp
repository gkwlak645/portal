<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<div class="row">
    <div class="col-md-8">
        <div class="card card-default">
            <div class="card-body" style="height:auto; min-height:450px" alt="권한>사용자별역할">
                <form name="searchForm" class="form-horizontal">
                    <div class="row">
                        <div style="height:40px;">
                            <div class="form-group row" style="margin: 0.25rem 0.5rem 1.5rem 0.5rem;">
                                <label for="inputUserId" class="col-form-label">사용자아이디</label>
                                <div style="padding-left:15px;">
                                    <input type="text" class="form-control" style="width:120px;"id="inputUserId" placeholder="사용자아이디" />
                                </div>
                            </div>
                        </div>
                        
                        
                        <div style="height:40px;">
                            <div class="form-group row" style="margin: 0.25rem 0.5rem 1.5rem 0.5rem;">
                            
                                <label for="inputEmpNm" class="col-form-label"  style="width:79px;">사용자명</label>
                                
                                <div style="padding-left:15px;">
                                    <input type="text" class="form-control"style="width:100px;" id="inputEmpNm" placeholder="사용자명" />
                                </div>
                                <div class="float-right">
                                <input type="button" id="btnUserSearch" class="btn btn-info btn-flat" value="검색" />
                                </div>

                            </div>
                        </div>   
                              
                    </div>
                </form>
                <div class="card-body2">
                    <div id="roleMngJsGrid"></div>
                </div>
            </div>
        </div>
    </div>
 
    
    <div class="col-md-4" >
        <div class="card card-default">
            <div class="card-body" style="height:490px;">
                <div class="form-group" style="overflow-y:auto; vertical-align:middle;" id="roleList"></div>
                <div class="form-group float-right" style="vertical-align:bottom;margin: 0.25rem 0.5rem 1.5rem 0.5rem;">
                    <c:if test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
                        <button type="button" class="btn btn-primary float-right" id=updateRoleMng>저장</button>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 로딩바  -->
<div class="dimmed" style="display:none"></div>
<div class="loading" style="display:none">
    <div class="loading-bar"><div></div><div></div><div></div><div></div></div>
    <span class="loading-text">사용자 조회 중...</span>
</div>

<script>

    var selectUserId ="";  
    
    function pageInit() {
    	
    	roleList();
    	
    	ajaxGridRole('','');
    };
    
    function bindEvent() {
    	
    	$("#inputUserId, #inputEmpNm").keyup(function(e){
            if(e.keyCode == 13){
            	var id = $("#inputUserId").val();
                var name = $("#inputEmpNm").val();
                ajaxGridRole(id,name);
            }
        });
    	
          $("#updateRoleMng").on("click",function(){
        	if(selectUserId == ""){
        		alert('사용자를 선택 해 주세요.');
        		return false;
        	}
        	
        	var radioVal = $('input:radio[name="checkRole"]:checked').val();
        	
        	/* var chkVal = new Array();
        	$("input:checkbox[name=checkRole]").each(function() {
        		 if(this.checked){
        			 chkVal.push($(this).val());
        		 }
        	}); */
        	
            var url = "/author/userrole/updateUserRole";
            var param = {
                    "userId" : selectUserId,
                    "roleCd" : radioVal
                    //"roleCdAray" : chkVal
            };

            callAsyncAjax(url, param, "callBackUpdateUserRole");
        }); 
        
        $("#btnUserSearch").on("click", function(){
        	var id = $("#inputUserId").val();
        	var name = $("#inputEmpNm").val();
        	ajaxGridRole(id,name);
        });      
        
        
    };

    function ajaxGridRole(id,name){
        var url = "/orgnzt/user/userRoleMngList";
        var param = {
                 "userId": id
                ,"empNm": name
        };
         callAsyncAjax(url, param, "drawGrid"); 
         
         $('.dimmed').css({ display: 'block' });
         $('.loading').css({ display: 'block' });
         $('.loading').addClass('show');
    }
    
    function drawGrid(data){
        if(data != ""){
           var userList = data.result.userRoleMng;
        }
        $("#roleMngJsGrid").jsGrid({
            height : "400",
            width : "100%",
            autoload: true,
            sorting : true,
            rowClick: function(args){
            	selectUserId=args.item.userId;
            	$(".jsgrid-row, .jsgrid-alt-row").removeClass("highlight");
                gRow = this.rowByItem(args.item);
                gRow.addClass("highlight");
                autoRoleMngChecked(selectUserId);
            },
            data: userList,
            fields : [ 
                {name: "userId" ,title : "사용자아이디",type : "text", width : 110, align:"left"}, 
                {name: "empNm" ,title : "사용자명", type : "text", width : 110, align:"left"}, 
//                {name: "empNo" ,title : "사원번호", type : "text", width : 110, align:"center"}, 
//                {name: "pstNm" ,title : "직급", type : "text", width : 70, align:"center"}, 
                {name: "deptNm" ,title : "부서", type : "text", width : 110, align:"left"} 
            ]
        });
        
        $('.dimmed').css({ display: 'none' });
        $('.loading').css({ display: 'none' });
        $('.loading').removeClass('show');
    }
    
    function roleMngUser(data){
    	var userId = data;
    	return userId;
    }
    
    function autoRoleMngChecked(data){
    	var url = "/author/userrole/getUserRole";
        var param = {
                "userId" : data
        };
        callAsyncAjax(url, param, "userRoleChecked");
    } 
    
    function userRoleChecked(data){
    	
    	var getRoleCd = data.result.userRole;
        if(getRoleCd != null){
            $('input:radio[name="checkRole"]:radio[value="'+getRoleCd.roleCd+'"]').prop("checked", true);
        }else{
            $("input:radio[name='checkRole']").prop("checked", false);
        }
    	
    	
    	/* $("input:checkbox[name='checkRole']").prop("checked", false);
    	var getRoleCdList = data.result.userRoleList;
    	
    	$.each(getRoleCdList, function(index, item){
            var getRoleCd = item;
            if(getRoleCd != null){
                $('input:checkbox[name="checkRole"]:checkbox[value="'+getRoleCd.roleCd+'"]').prop("checked", true);
            }else{
                $('input:checkbox[name="checkRole"]:checkbox[value="'+getRoleCd.roleCd+'"]').prop("checked", false);
            }
        });  */
    	
    }
    
    function roleList(){
    	var url ="/author/rolemng/roleMngList";
    	var param ={
    			useAt : "Y"
    	};
    	
    	callAsyncAjax(url, param, "drawRoleList");
    }
    
    function drawRoleList(data){
    	var valRole = data.result.roleMngList;
    	$.each(valRole, function(index, item){
    		var resultRole = item;
    		$("#roleList").append("<input type='radio' style='width:24px; margin-bottom: 8px;' name='checkRole' id='" +resultRole.roleCd+ "' value='" +resultRole.roleCd+ "'><label for='" +resultRole.roleCd+ "'>"+resultRole.roleNm+"</label><br/>")
    	});
    }
    
    
    function callBackUpdateUserRole(){
    	alert('저장되었습니다.');
    	ajaxGridRole($("#inputUserId").val(),$("#inputEmpNm").val());
    	$("input:radio[name='checkRole']").prop("checked", false);
    	//$("input:checkbox[name='checkRole']").prop("checked", false);
    }
</script>