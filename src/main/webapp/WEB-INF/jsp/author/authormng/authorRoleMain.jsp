<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<div class="row">
	<div class="col-md-12">
	   <div class="card card-default">
	       <div class="card-body" style="margin-top:2px;height:auto; min-height:50px">
                <div id="roleSelect" class="col-md-4"></div>
            </div>
	   </div>
	</div>
    <div class="col-md-6">
        <div class="card card-default">
            <div class="card-body" style="height:450px; overflow:auto;">
                <div id="jstree"></div>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="card card-default" alt="권한>권한관리">
            <div class="card-body" style="height:450px;padding:16px;">
                <div id="rightMain">
	                <div style="text-align: center;"><h5><label> <span id="selectedRole"></span>역할의 메뉴관리 권한</label></h5></div>
	                <div class="form-group" style="margin: 0.25rem 0.5rem 1.5rem 0.5rem;">
	                    <label>
		                    <input type="checkbox" class="custom-checkbox" style="width:18px;height:18px;" name="auth" value="auth1" id="authId1"/>
		                    <span id="authNm1">읽기</span>
	                    </label><br/>
	                    
	                    <label>
		                    <input type="checkbox" class="custom-checkbox" style="width:18px;height:18px;" name="auth" value="auth2" id="authId2"  />
		                    <span  id="authNm2">쓰기</span>
	                    </label><br/>
	                    
	                    <label>
		                    <input type="checkbox" class="custom-checkbox" style="width:18px;height:18px;" name="auth" value="auth3" id="authId3"  />
		                    <span id="authNm3">전체 테넌트 보기</span>
		                    <input type="text" id="inputId3" maxlength="30"  style="width:150px;line-height:1;height: 26px;margin-left:10px;vertical-align: bottom;">
	                    </label><br/>
	                    
	                    <label>
		                    <input type="checkbox" class="custom-checkbox" style="width:18px;height:18px;" name="auth" value="auth4" id="authId4"  />
		                    <span id="authNm4">접수권한</span>
		                    <input type="text" id="inputId4" maxlength="30" style="width:150px;line-height:1;height: 26px;margin-left:10px;vertical-align: bottom;">
	                    </label><br/>
	                    
	                    <label>
		                    <input type="checkbox" class="custom-checkbox" style="width:18px;height:18px;" name="auth" value="auth5" id="authId5" />
		                    <span id="authNm5">reserved3</span>
		                    <input type="text" id="inputId5" maxlength="30"  style="width:150px;line-height:1;height: 26px;margin-left:10px;vertical-align: bottom;">
	                    </label><br/>
	                    
	                    <label>
		                    <input type="checkbox" class="custom-checkbox" style="width:18px;height:18px;" name="auth" value="auth6" id="authId6" />
		                    <span id="authNm6">reserved4</span>
		                    <input type="text" id="inputId6" maxlength="30"  style="width:150px;line-height:1;height: 26px;margin-left:10px;vertical-align: bottom;">
	                    </label><br/>
	                    
	                    <label>
		                    <input type="checkbox" class="custom-checkbox" style="width:18px;height:18px;" name="auth" value="auth7" id="authId7" />
		                    <span style="id="authNm7">reserved5</span>
		                    <input type="text" id="inputId7" maxlength="30"  style="width:150px;line-height:1;height: 26px;margin-left:10px;vertical-align: bottom;">
	                    </label>
	                </div>
	                <br/><br/> 
	                <div class="float-right">
	                    <c:if test="${txScreenAuthor.redngAuthor eq 'Y'}">
	                       <c:if test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
	                           <button type="button" class="btn btn-primary" id="saveAuth">저장</button>
	                       </c:if>
	                    </c:if>
	                </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var selectRole = "";
    var selectRoleName = "";
    var menuCode = "";
    function pageInit() {
    	$("#rightMain").hide();
    	getSelectbox();
    	
    };

    function bindEvent() {
        $("#jstree").on("changed.jstree", function(e, data) {
            menuCode = data.selected.toString();
            var url = "/author/authormng/selectAuthorRole";
            var param = {
            		roleCd : selectRole
                  , menuCd : menuCode
            };
            callAsyncAjax(url, param, "showAuthorRoleAuth");
        });
        
        
        $("#saveAuth").on("click", function() {
        	var auth = new Array();
        	var authNm = new Array();
        	
        	for(var i = 1 ; i <= 7 ; i++){
        		if($('input:checkbox[id="authId'+i+'"]').is(":checked") == true){
        			auth[i] = "Y";
        			
        		}else{
        			auth[i] = "N";
        		}
        	}
        	
            for(var i = 3 ; i<=7; i++){
        		authNm[i] = $("#inputId"+i).val();
        	}
        	
        	var param = {
                    roleCd : selectRole
                  , menuCd : menuCode
                  , redngAuthor : auth[1]
                  , wrtngAuthor : auth[2]
                  , untenantAuthor : auth[3]
                  , resveAuthor2 : auth[4]
                  , resveAuthor3 : auth[5]
                  , resveAuthor4 : auth[6]
                  , resveAuthor5 : auth[7]
                  , resveAuthorNm1 : authNm[3]
                  , resveAuthorNm2 : authNm[4]
                  , resveAuthorNm3 : authNm[5]
                  , resveAuthorNm4 : authNm[6]
                  , resveAuthorNm5 : authNm[7]
                };
            var url = "/author/authormng/authUpdate";
            callAsyncAjax(url, param, "successSave");
        });
        
        $("#authId1").on("change",function(){
        	if(!$("#authId1").is(":checked")){
        		if(confirm("현재 메뉴 및 하위 메뉴의 권한을 전부 취소하시겠습니까?")){
        			$("input:checkbox[id='authId2']").prop("checked", false);
        			$("input:checkbox[id='authId3']").prop("checked", false);
        			$("input:checkbox[id='authId4']").prop("checked", false);
        			$("input:checkbox[id='authId5']").prop("checked", false);
        			$("input:checkbox[id='authId6']").prop("checked", false);
        			$("input:checkbox[id='authId7']").prop("checked", false);
        		}else{
        			return false;
        		}
        	}
        	
        });
       	
        $("#authId4, #authId5, #authId6, #authId7").on("change",function(){
       		if(!$("#authId4").is(":checked")){
                $("#inputId4").hide();
                $("#inputId4").val('');
            }else{
                $("#inputId4").show();
            }
       		if(!$("#authId5").is(":checked")){
                $("#inputId5").hide();
                $("#inputId5").val('');
            }else{
                $("#inputId5").show();
            }
       		if(!$("#authId6").is(":checked")){
                $("#inputId6").hide();
                $("#inputId6").val('');
            }else{
                $("#inputId6").show();
            }
       		if(!$("#authId7").is(":checked")){
                $("#inputId7").hide();
                $("#inputId7").val('');
            }else{
                $("#inputId7").show();
            }
       	});
        
        $(document).on("change","#inputSelect",function(){
        	selectRole = $(this).val();
        	selectRoleName = $("#inputSelect option:checked").text();
        	$("input:checkbox[name='auth']").prop("checked",false);
        	$("#selectedRole").text(selectRoleName);
        	$("#rightMain").hide();
        	drawJstree();
        	$("#jstree").jstree("close_all");
        });
    }

    function drawJstree() {
        $('#jstree').jstree({
            'core' : {
                'data' : {
                    'url' : function(node) {
                        var sUri = "/menu/menumng/selectMenuList";
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
                        console.log(sdata);
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
        var menuList = data.result.menuList;
        var jsonData = '';
        jsonData += '[';

        $.each(menuList, function(index, item) {
            if (item.upMenuCd == "") {
                jsonData += '{ "id" : "' + item.menuCd + '", "parent" : "#", "text" : "' + item.menuNm + '" }, ';
            } else {
                jsonData += '{ "id" : "' + item.menuCd + '", "parent" : "' + item.upMenuCd + '", "text" : "' + item.menuNm + '" }, ';
            }
        });
        jsonData = jsonData.substr(0, jsonData.length - 2);
        jsonData += ']';
        jsonData = JSON.parse(jsonData);
        return jsonData;
    }

    function showAuthorRoleAuth(data) {
    	inputHide();
    	if(selectRole != "" && menuCode != ""){
    		$("#rightMain").show();
	    	$("input:checkbox[name='auth']").prop("checked",false);
	    	//$("input:checkbox[id='authId1']").prop("checked", true);
	        var authInfo = data.result.selectAuth;
	        if (authInfo == null) {
	            return false;
	        }
	        
	        if(authInfo.redngAuthor == "Y"){
	        	$("input:checkbox[id='authId1']").prop("checked", true);
            }
	        
	        if(authInfo.wrtngAuthor == "Y"){
		        $("input:checkbox[id='authId2']").prop("checked", true);
	        }
	        
	        if(authInfo.untenantAuthor == "Y"){
		        $("input:checkbox[id='authId3']").prop("checked", true);
	        }else{
            }
	        if(authInfo.resveAuthor2 == "Y"){
		        $("input:checkbox[id='authId4']").prop("checked", true);
	            $("#inputId4").val(authInfo.resveAuthorNm2).show();
	        }else{
                $("#inputId4").val(authInfo.resveAuthorNm2).hide();
            }
	        if(authInfo.resveAuthor3 == "Y"){
		        $("input:checkbox[id='authId5']").prop("checked", true);
	            $("#inputId5").val(authInfo.resveAuthorNm3).show();
	        }else{
                $("#inputId5").val(authInfo.resveAuthorNm3).hide();
            }
	        if(authInfo.resveAuthor4 == "Y"){
                $("input:checkbox[id='authId6']").prop("checked", true);
                $("#inputId6").val(authInfo.resveAuthorNm4).show();
            }else{
                $("#inputId6").val(authInfo.resveAuthorNm4).hide();
            }
	        if(authInfo.resveAuthor5 == "Y"){
                $("input:checkbox[id='authId7']").prop("checked", true);
                $("#inputId7").val(authInfo.resveAuthorNm5).show();
            }else{
                $("#inputId7").val(authInfo.resveAuthorNm5).hide();
            }
    	}
    }
    
    function getSelectbox(){
    	var url = "/author/authormng/getSelectbox";
    	var param = {};
    	callAsyncAjax(url, param, "showSelectbox");
    }
    
    function showSelectbox(data){
    	var result = data.result.selectbox;
    	var html = '';
    	html += '<label for="roleSelect">역할명</label>';
    	html += '<select class="form-control" id="inputSelect" style="margin-left:15px;width:57%; display:inline-block;">';
    	html +=    '<option value="" checked>- 선택하세요 -</option>'
    	
    	$.each(result,function(index,item){
    		html += '<option value="'+item.roleCd+'">'+item.roleNm+'</option>'
    	});
    	html += '</select>';
    	$("#roleSelect").html(html);
    }
    
    function successSave() {
        alert("저장 완료");
    }
    
    function inputHide(){
        $("#inputId3, #inputId4, #inputId5, #inputId6, #inputId7").hide();
    }
</script>