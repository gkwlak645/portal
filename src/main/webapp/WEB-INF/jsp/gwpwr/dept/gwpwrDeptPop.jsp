<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="modal-dialog modal-lg" style="width:450px;">
    <div class="modal-content">
        <div class="modal-header">
            <h4 class="modal-title">부서검색</h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="modal-body">
            <div>
                <input type="text" id="schDept" maxlength="20" style="width:80%;">
                <button type="button" id="btnSearch" class="btn btn-info float-right">조회</button>
            </div><br>
            <div id="gwpwrDeptTree" style="height:250px;overflow:auto;"></div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-primary" id="btnGwpwrSelect">선택</button>
            <button type="button" class="btn btn-primary" data-dismiss="modal" id="btnGwpwrClose">닫기</button>
        </div>
    </div>
</div>

<script>

var cmpnyCd = $('#cmpnyCd').val();

	$(document).ready(function() {
	    
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
	    
	    //그룹웨어 부서 트리 그리기
	    drawGwpwrDeptTree();
	}
	
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent(){
    	//조회버튼 클릭 이벤트 처리
        $("#btnSearch").on("click",function(){ 
        	refreshJstree();
        });
    	
        $("#schDept").keyup(function(e){
            if(e.keyCode == 13){
            	refreshJstree();
            }
        });
    }

	/*
     * 부서트리 그리기
     * @param
     * @return
     */
    function drawGwpwrDeptTree() { 
        $('#gwpwrDeptTree').jstree({
            'core' : {
                'data' : {
                    'url' : "/gwpwr/dept/getGwpwrDeptList",
                    'data' : function(node) {  
                        return { 
                            "id" : node.id
                            ,"schDept" : $('#schDept').val()
                            ,"cmpnyCd" : cmpnyCd
                        };
                    },
                    'dataFilter' : function(data, type) {
                        var jsonData = JSON.parse(data);
                        var parsedData = changeData(jsonData);
                        parsedData = JSON.stringify(parsedData);
                        return parsedData;
                    }
                },
                'themes' : {
                    'name' : 'proton',
                    'responsive' : true
                }
            }
        });
    }
	
    /*
     * 부서트리 그리기
     * @param
     * @return
     */
	/* function parseData(data) {

        var deptList = data.result;
        
        var treeArr = [];
        
        $.each(deptList, function(index, item) {
        	var dept = new Object();
        	item.id = item.deptCd;
        	item.text = item.deptNm;
        	if (item.upDeptCd == "") {
        		item.parent = "#";
        	} else {
        		item.parent = item.upDeptCd;
        	}
        	treeArr.push(item);
        });
        
        return treeArr;
	} */
    
	function changeData(data) { 
		var deptList = data.result;
        var jsonData = '';
        jsonData += '[';
        
        var schDept =  $('#schDept').val();
        
        if (schDept == "" || schDept == "undefined" || schDept == null) { 
        	$.each(deptList, function(index, item) {
                /* if (item.upDeptCd == "" || item.upDeptCd == "undefined" || item.upDeptCd == null ) { */
                if (item.upDeptCd == "ORGROOT") {
                    jsonData += '{ "id" : "' + item.deptCd + '", "parent" : "#", "text" : "' + item.deptNm + '" , "deptNm" : "' + item.deptNm + '" , "state" : {"opened":true}   }, ';
                } else {
                    jsonData += '{ "id" : "' + item.deptCd + '", "parent" : "' + item.upDeptCd + '", "text" : "' + item.deptNm + '" , "deptNm" : "' + item.deptNm + '" }, ';
                }
             });
        }else{
        	$.each(deptList, function(index, item) {
                jsonData += '{ "id" : "' + item.deptCd + '", "text" : "' + item.deptNm + '" , "deptNm" : "' + item.deptNm + '" }, ';
            });
        }
        
        jsonData = jsonData.substr(0, jsonData.length - 2);
        jsonData += ']';
        jsonData = JSON.parse(jsonData); 
        return jsonData;
    }
	
	function refreshJstree() {
        $("#gwpwrDeptTree").jstree("refresh");
    }


</script>