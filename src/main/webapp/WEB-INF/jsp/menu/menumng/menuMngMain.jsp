<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<div class="row">
    <div class="col-md-5" alt="메뉴>메뉴관리">
        <div class="card card-default">
            <div class="card-body" style="height:660px; overflow:auto;">
                <div id="jstree"></div>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="card card-default">
            <div class="card-body" style="height:660px;">
	            <!-- <div id="rightMain" style="display:none;" > -->
	            <div id="rightMain">
	                <div class="form-group" style="margin: 0.25rem 0.1rem 1rem 0.1rem;">
	                    <label for="inputMenuCd">메뉴코드</label>
	                    <input type="text" class="form-control" id="inputMenuCd" maxlength="10" disabled />
	                </div>
	                <div class="form-group" style="margin: 0.25rem 0.1rem 1rem 0.1rem;">
	                    <label for="inputMenuNm">메뉴명<b style="color: red;"> *</b></label>
	                    <input type="text" class="form-control" id="inputMenuNm" maxlength="20"/>
	                </div>
	                <div class="form-group" style="margin: 0.25rem 0.1rem 1rem 0.1rem;">
	                    <label for="inputMenuUrl">메뉴 URL</label>
	                    <input type="text" class="form-control" id="inputMenuUrl" maxlength="60"/>
	                </div>
	                <div class="form-group" style="margin: 0.25rem 0.1rem 1rem 0.1rem;">
	                    <label for="inputMenuDc">메뉴 설명</label>
	                    <input type="text" class="form-control" id="inputMenuDc" maxlength="60"/>
	                </div>
	                <div class="form-group" style="margin: 0.25rem 0.1rem 1rem 0.1rem;">
	                    <label for="inputUpMenuCd">상위메뉴코드</label>
	                    <input type="text" class="form-control" id="inputUpMenuCd" maxlength="10" disabled />
	                </div>
	                <div class="form-group" style="margin: 0.25rem 0.1rem 1rem 0.1rem;">
	                    <label for="inputMenuOrdr">정렬 순서</label>
	                    <div>
	                       <input type="text" class="col-md-10 form-control" style="width:50%;float:left;" id="inputMenuOrdr" disabled />	                       
		                   <div id="ordrBtn" style="display:none;">
		                       <button type="button" class="btn btn-outline-primary float-right" style="width:60px;"  id="ordrUp">up</button>
		                       <button type="button" class="btn btn-outline-primary float-right" id="ordrDown">down</button>
		                   </div>
	                    </div>
	                </div>
	                <br/>
	                <div class="form-group" style="margin: 0.25rem 0.1rem 0 0.1rem;">
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
		                 <div id="controlBtn" style="display:none;">
		                    <button type="button" class="btn btn-primary" id="addMenu">추가</button>
		                    <button type="button" class="btn btn-primary" id="saveMenu">저장</button>
		                    <button type="button" class="btn btn-primary" id="deleteMenu">삭제</button>
		                </div>    
	                    </c:if>
	                </div>
	            </div>
            </div>
        </div>
    </div>
</div>
<script>
	var selectCd = "";
	var ordr = "";
	var prev_val = "";
	function pageInit() {
		drawJstree();
	};

	function bindEvent() {
		$("#jstree").on("changed.jstree", function(e, data) {
			var menuCode = data.selected.toString();
			$("#ordrBtn").css("display","block");
			$("#controlBtn").css("display","block");
			selectCd = menuCode;
			var url = '/menu/menumng/menuDetail';
			var param = {
					menuCd : selectCd
			};
			$("#addMenu").attr("disabled", false);
			callAsyncAjax(url, param, "showMenuInfo");
		});
		
		$("#addMenu").on("click", function() {
			if(ordr > 99){
				alert("더이상 메뉴를 추가할 수 없습니다.");
				return false;
			}
			var menuCode = "";
			var check = 0;
			var tmp = 0;
			
			var selectNode = $("#jstree").jstree(true).get_node(selectCd);
			var children = $("#jstree").jstree().get_node(selectNode).children;
			var upMenuCode = $("#inputMenuCd").val();

			if(selectNode){
				tmp = 2 * selectNode.parents.length;
			}else{
				alert("추가할 메뉴의 상위메뉴를 선택하세요.");
                return false;
			}
			
			var comparison = new Array();

			if(tmp > 10){
                alert("더이상 하위메뉴를 추가할 수 없습니다.");
                return false;
            }
			
			menuCode = upMenuCode.substr(0,tmp-2);
			
			$.each(children, function(index, item) {
				var result = item.substr(tmp - 2, 2);
				comparison.push(result);
			});
			
			var maxNum = Math.max.apply(null,comparison);
			var minNum = Math.min.apply(null,comparison);
			
			if(minNum != 1){
				menuCode += "01";
			}else if(maxNum == comparison.length){
				if(maxNum >= 9){
					menuCode += (maxNum+1);
				}else{
					menuCode += ("0"+(maxNum+1));
				}
			}else{
			    comparison = comparison.sort(function(a,b){return a-b;});
                
                for(var i = 0; i < comparison.length-1 ; i++){
                    
                    if((comparison[i+1]-comparison[i]) > 1){
                        if(comparison[i] >= 9){
                        	menuCode += (Number(comparison[i])+1);
                        }else{
                        	menuCode += "0" + (Number(comparison[i])+1);
                        }
                        break;
                    }
                }
			}
			
			for (var j = 0; j < upMenuCode.length - tmp; j++) {
				menuCode += "0";
			}
			
			$("#inputMenuCd").val(menuCode);
			$("#inputMenuNm").val("");
			$("#inputMenuUrl").val("");
			$("#inputMenuDc").val("");
			$("#inputUpMenuCd").val(upMenuCode);
			$("#inputMenuOrdr").val(ordr);
			$("#inputUseAt").val("Y").attr("selected",true);
			$("#addMenu").attr("disabled", true);
		});


		$("#saveMenu").on("click", function() {
			if (isValidation()) {
				var url = "/menu/menumng/menuUpdate";
				var param = {
					menuCd : $("#inputMenuCd").val()
				  ,	menuNm : $("#inputMenuNm").val()
				  ,	menuUrl : $("#inputMenuUrl").val()
				  ,	menuDc : $("#inputMenuDc").val()
				  ,	upMenuCd : $("#inputUpMenuCd").val()
				  ,	menuOrdr : $("#inputMenuOrdr").val()
				  ,	useAt : $("#inputUseAt").val()
				};
				callAsyncAjax(url, param, "refreshJstree");
			}
		});

		$("#deleteMenu").on("click", function() {
			var isDelete = "";
			if (ordr == 1) {
				isDelete = confirm("선택한 메뉴가 삭제됩니다. 진행하시겠습니까?");
			} else {
				isDelete = confirm("하위 메뉴가 모두 삭제됩니다. 진행하시겠습니까?");
			}
	
			if (isDelete) {
				var url = "/menu/menumng/menuDelete";
				var param = {
					menuCd : selectCd
				};
	
				callAsyncAjax(url, param, "allSort");
			}
		});

		$("#inputUseAt").on("focus", function() {
			prev_val = $(this).val();
		}).on("change",	function() {
			$(this).blur();
			var state = $(this).val();
			if (state == "N") {
				if (ordr != 1) {
					var isUseAt = confirm("하위 메뉴가 모두 미사용으로 변경됩니다. 진행하시겠습니까?");
					if (!isUseAt) {
						$(this).val(prev_val);
						return false;
					}
				}
			}
		});

		$("#ordrUp").on("click",function() {
			var url = "/menu/menumng/menuUpdateOrdr";
			var param1 = "";
			var param2 = "";
			var tmp = "";
			var selectNode = $("#jstree").jstree(true).get_node(selectCd);
			var parent = $("#jstree").jstree(true).get_node(selectCd).parent;
			var children = $("#jstree").jstree().get_node(parent).children;
			
			$.each(children, function(index, item) {
				if (item == selectNode.id) {
					tmp = index;
				}
			});
			
			if (tmp == 0) {
				return false;
			}
			
			$("#jstree").jstree("move_node", children[tmp],	parent, tmp);
			$("#jstree").jstree("move_node", children[tmp - 1],	parent, Number(tmp) + Number(1));
	
			param1 = {
				menuCd : children[tmp]
			  , menuOrdr : tmp
			};
			param2 = {
				menuCd : children[tmp - 1]
			  , menuOrdr : Number(tmp) + Number(1)
			};
			
			callAsyncAjax(url, param1);
			callAsyncAjax(url, param2, "refreshJstree");
		});

		$("#ordrDown").on("click",function() {
			var url = "/menu/menumng/menuUpdateOrdr";
			var param1 = "";
            var param2 = "";
			var tmp = "";
			var selectNode = $("#jstree").jstree(true).get_node(selectCd);
			var parent = $("#jstree").jstree(true).get_node(selectCd).parent;
			var children = $("#jstree").jstree().get_node(parent).children;
			
			$.each(children, function(index, item) {
				if (item == selectNode.id) {
					if (index == children.length - 1) {
						tmp = -1;
					} else {
						tmp = index;
					}
				}
			});
			
			if (tmp == -1) {
				return false;
			}
			
			$("#jstree").jstree("move_node", children[tmp],parent, Number(tmp) + Number(2));
			$("#jstree").jstree("move_node", children[Number(tmp) + Number(1)], parent,	Number(tmp) + Number(1));
	
			param1 = {
				menuCd : children[tmp]
			  , menuOrdr : Number(tmp) + Number(2)
			};
			param2 = {
				menuCd : children[Number(tmp) + Number(1)]
			  , menuOrdr : Number(tmp) + Number(1)
			};
			callAsyncAjax(url, param1);
			callAsyncAjax(url, param2, "refreshJstree");
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
				jsonData += '{ "id" : "' + item.menuCd + '", "parent" : "#", "text" : "' + item.menuNm + '" ,"state" : {"opened":true}}, ';
			} else {
				jsonData += '{ "id" : "' + item.menuCd + '", "parent" : "' + item.upMenuCd + '", "text" : "' + item.menuNm + '" }, ';
			}
		});
		jsonData = jsonData.substr(0, jsonData.length - 2);
		jsonData += ']';
		jsonData = JSON.parse(jsonData);
		return jsonData;
	}

	function showMenuInfo(data) {
		var menuInfo = data.result.menuDetail.item;
		if (menuInfo == null) {
			return false;
		}
		$("#inputMenuCd").val(menuInfo.menuCd);
		$("#inputMenuNm").val(menuInfo.menuNm);
		$("#inputMenuUrl").val(menuInfo.menuUrl);
		$("#inputMenuDc").val(menuInfo.menuDc);
		$("#inputUpMenuCd").val(menuInfo.upMenuCd);
		$("#inputMenuOrdr").val(menuInfo.menuOrdr);
		$("#inputUseAt").val(menuInfo.useAt);
		
		if (menuInfo.upMenuCd == "") {
			$("#deleteMenu").attr('disabled', true);
		} else {
			$("#deleteMenu").attr('disabled', false);
		}
		
		ordr = data.result.menuDetail.ordr;
	}

	function isValidation() {
		var menuNm = $("#inputMenuNm").val();
		var useAt = $("#inputUseAt").val();
		if (menuNm == null || menuNm == "") {
			alert("메뉴명이 비어있습니다.")
			$("#inputMenuNm").focus();
			return false;
		} else if (useAt == null || useAt == "") {
			alert("사용여부를 선택해주세요.")
			$("#inputUseAt").focus();
			return false;
		} else {
			return true;
		}
	}
    function allSort(){
    	var url = "/menu/menumng/menuUpdateOrdr";
    	var parent = $("#jstree").jstree(true).get_node(selectCd).parent;
        var children = $("#jstree").jstree().get_node(parent).children;
        children.splice(children.indexOf(selectCd),1);
        $.each(children,function(index, item){
        	$("#jstree").jstree("move_node", item, parent, index+1);
        	var param = {
       			menuCd :item,
                menuOrdr : index+1	
        	};
        	callAsyncAjax(url, param);
        })
        refreshJstree();
    }
	function refreshJstree() {
		$("#jstree").jstree("refresh");
	}
</script>