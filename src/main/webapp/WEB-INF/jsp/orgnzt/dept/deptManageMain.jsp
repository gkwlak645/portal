<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="row">
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
	<div class="col-md-6">
		<div class="card card-default" alt="조직>부서관리">
			<div class="card-body" style="height:520px; overflow:auto;">
				<div id="jstree"></div>
			</div>
		</div>
	</div>
	<div class="col-md-6">
		<div class="card card-default">
			<div class="card-body" style="height:520px">
		        <div id="rightMain" style="display:none;">
					<div class="form-group" style="margin: 0.25rem 0.1rem 1rem 0.1rem;">
					    <label for="inputDeptCode">부서코드</label>
					    <input type="text" class="form-control" id="inputDeptCode" disabled />
					</div>
					<div class="form-group" style="margin: 0.25rem 0.1rem 1rem 0.1rem;">
					    <label for="inputDeptName">부서명</label>
					    <input type="text" class="form-control" id="inputDeptName" />
					</div>
					<div class="form-group" style="margin: 0.25rem 0.1rem 1rem 0.1rem;">
					    <label for="inputUpDeptCode">상위부서코드</label>
					    <input type="text" class="form-control" id="inputUpDeptCode" disabled />
					</div>
					<div class="form-group" style="margin: 0.25rem 0.1rem 1rem 0.1rem;">
					    <label for="inputDeptOrdr">정렬 순서</label>
					    <div>
                           <input type="text" class="col-md-10 form-control" style="margin-top:5px;width:50%;float:left;"  id="inputDeptOrdr" disabled />                          
                           <button type="button" class="btn btn-outline-primary float-right" style="width:60px;"  id="ordrUp">up</button>
                           <button type="button" class="btn btn-outline-primary float-right" id="ordrDown">down</button>
                        </div>
					</div>
                    <br/>
                    <div class="form-group" style="margin: 1.25rem 0.1rem 0 0.1rem;">
                        <label for="inputUseAt">사용여부</label>
					    <select class="form-control" id="inputUseAt">
					        <option selected></option>
					        <option value="Y">예</option>
					        <option value="N">아니오</option>
					    </select>
                    </div>
                    <br/>
                    <div class="float-right" style="margin: 0.25rem 0.1rem 1rem 0.1rem;">
						<c:if test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
							<button type="button" class="btn btn-primary" style="margin:5px 0 15px 0;"id="addDept">추가</button>
							<button type="button" class="btn btn-primary" style="margin:5px 0 15px 0;"id="saveDept">저장</button>
							<button type="button" class="btn btn-primary" style="margin:5px 0 15px 0;"id="deleteDept">삭제</button>
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
			var deptCode = data.selected.toString();
			$("#rightMain").css("display","block");
			selectCd = deptCode;
			var url = '/orgnzt/dept/deptDetail';
			var param = {
				    deptCd : selectCd
			};
			$("#addDept").attr("disabled",false);
			callAsyncAjax(url, param, "showDeptInfo");
		});
		
		$("#addDept").on("click",function(){
			if(ordr > 99){
				alert("더이상 부서를 추가할 수 없습니다.");
				return false;
			}
			var deptCode = "";
            var check = 0;
            var selectNode = $("#jstree").jstree(true).get_node(selectCd);
            var children = $("#jstree").jstree().get_node(selectNode).children;
            var upDeptCode = $("#inputDeptCode").val();
            var tmp = 2 * selectNode.parents.length;
            var comparison = new Array();
            
            if(tmp > 10){
            	alert("더이상 하위부서를 추가할 수 없습니다.");
            	return false;
            }
            
            deptCode = upDeptCode.substr(0,tmp-2);
            
            $.each(children, function(index, item) {
                var result = item.substr(tmp - 2, 2);
                comparison.push(result);
            });
            
            var maxNum = Math.max.apply(null,comparison);
            var minNum = Math.min.apply(null,comparison);
           
            if(minNum != 1){
            	deptCode += "01";
            }else if(maxNum == comparison.length){
                if(maxNum >= 9){
                	deptCode += (maxNum+1);
                }else{
                	deptCode += ("0"+(maxNum+1));
                }
            }else{
            	comparison = comparison.sort(function(a,b){return a-b;});
            	
            	for(var i = 0; i < comparison.length-1 ; i++){
            		
            		if((comparison[i+1]-comparison[i]) > 1){
            			if(comparison[i] >= 9){
	            			deptCode += (Number(comparison[i])+1);
            			}else{
	            			deptCode += "0" + (Number(comparison[i])+1);
            			}
            			break;
            		}
            	}
            }
            
            for (var j = 0; j < upDeptCode.length - tmp; j++) {
            	deptCode += "0";
            }
            
            $("#inputDeptCode").val(deptCode);
            $("#inputDeptName").val("");
            $("#inputUpDeptCode").val(upDeptCode);
            $("#inputDeptOrdr").val(ordr);
            $("#inputUseAt").val("");
            $("#addDept").attr("disabled",true);
		});
		
		$("#saveDept").on("click",function(){
			if(isValidation()){
				var url = "/orgnzt/dept/deptUpdate";
				var param = {
					    deptCd : $("#inputDeptCode").val()
					  , deptNm : $("#inputDeptName").val()
                      , upDeptCd : $("#inputUpDeptCode").val()
                      , deptOrdr : $("#inputDeptOrdr").val()
					  , useAt : $("#inputUseAt").val()
				};
				
				callAsyncAjax(url, param, "refreshJstree");
			}
		});
		
		$("#deleteDept").on("click",function(){
			var isDelete = "";
			if(ordr == 1){
				isDelete = confirm("선택한 부서가 삭제됩니다. 진행하시겠습니까?");
			}else{
				isDelete = confirm("하위 부서가 모두 삭제됩니다. 진행하시겠습니까?");
			}
			if(isDelete){
				var url = "/orgnzt/dept/deptDelete";
				var param = {
	                    deptCd : selectCd
	            };
				callAsyncAjax(url, param, "allSort");
			}
		});
		
		$("#inputUseAt").on("focus",function(){
			prev_val = $(this).val();
		}).on("change",function(){
			$(this).blur(); 
			var state = $(this).val();
			if(state == "N"){
				if(ordr != 1){
					var isUseAt = confirm("하위 부서가 모두 미사용으로 변경됩니다. 진행하시겠습니까?");
					if(!isUseAt){
						$(this).val(prev_val);
						return false;
					}
				}
			}
		});
		
		$("#ordrUp").on("click",function(){
			var url = "/orgnzt/dept/deptUpdateOrdr";
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
            
            $("#jstree").jstree("move_node", children[tmp], parent, tmp);
            $("#jstree").jstree("move_node", children[tmp - 1], parent, Number(tmp) + Number(1));
            
            param1 = {
                    deptCd : children[tmp]
                  , deptOrdr : tmp
            };
            param2 = {
                    deptCd : children[tmp - 1]
                  , deptOrdr : Number(tmp) + Number(1)
            };
			callAsyncAjax(url, param1);
			callAsyncAjax(url, param2,"refreshJstree");
		});
		
		$("#ordrDown").on("click",function(){
			var url = "/orgnzt/dept/deptUpdateOrdr";
			var param1 = "";
            var param2 = "";
            var tmp = "";
            var selectNode = $("#jstree").jstree(true).get_node(selectCd);
			var parent = $("#jstree").jstree(true).get_node(selectCd).parent;
			var children = $("#jstree").jstree().get_node(parent).children;

			$.each(children,function(index,item){
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
            $("#jstree").jstree("move_node", children[Number(tmp) + Number(1)], parent, Number(tmp) + Number(1));
            
            param1 = {
            	deptCd : children[tmp]
			  , deptOrdr : Number(tmp) + Number(2)
			};
			param2 = {
				deptCd : children[Number(tmp) + Number(1)]
			  , deptOrdr : Number(tmp) + Number(1)
			};
            
            callAsyncAjax(url, param1);
            callAsyncAjax(url, param2,"refreshJstree");
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
	
	
	function showDeptInfo(data){
		var deptInfo = data.result.deptDetail.item;
		if(deptInfo == null || deptInfo == ""){
			return false;
		}
		console.log(deptInfo);
		$("#inputDeptCode").val(deptInfo.deptCd);
		$("#inputDeptName").val(deptInfo.deptNm);
		$("#inputUpDeptCode").val(deptInfo.upDeptCd);
		$("#inputDeptOrdr").val(deptInfo.deptOrdr);
		$("#inputUseAt").val(deptInfo.useAt);
		if(deptInfo.upDeptCd == ""){
			$("#deleteDept").attr('disabled', true);
		}else{
			$("#deleteDept").attr('disabled', false);
		}
		ordr = data.result.deptDetail.ordr;
	}
	function refreshJstree(){
		$("#jstree").jstree("refresh");
	}
	function isValidation(){
		var deptNm = $("#inputDeptName").val();
		var useAt = $("#inputUseAt").val();
		if(deptNm == null || deptNm == ""){
			alert("부서명이 비어있습니다.")
			$("#inputDeptName").focus();
			return false;
		}else if(useAt == null || useAt == ""){
			alert("사용여부를 선택해주세요.")
			$("#inputUseAt").focus();
			return false;
		}else{
			return true;
		}
	}
	
	function allSort(){
        var url = "/orgnzt/dept/deptUpdateOrdr";
        var parent = $("#jstree").jstree(true).get_node(selectCd).parent;
        var children = $("#jstree").jstree().get_node(parent).children;
        children.splice(children.indexOf(selectCd),1);
        $.each(children,function(index, item){
            $("#jstree").jstree("move_node", item, parent, index+1);
            var param = {
                deptCd :item,
                deptOrdr : index+1    
            };
            callAsyncAjax(url, param);
        })
        refreshJstree();
    }
</script>