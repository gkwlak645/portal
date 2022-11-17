<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div id="CntcSysMainDiv" class="container-fluid wrap">

  <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <form class="form-inline">
                        <div class="form-group col-md-5 py-sm-2">
                            <label for="cntcType" class="col-sm-4 col-form-label">분류</label>
                            <div class="col-sm-8">
                                <select id="cntcType" class="form-control"></select>
                            </div>
                        </div>
                        <div class="form-group col-md-5 py-sm-2">
                            <label for="cmpny" class="col-sm-4 col-form-label">회사</label>
                            <div class="col-sm-8">
                               <select class="form-control" id="cmpny" required>
                                    <!-- <option selected disabled>계열사선택</option>
                                    <option value="I">동원산업</option>
                                    <option value="X">동원로엑스</option>
                                    <option value="F">동원FnB</option>
                                    <option value="H">동원홈푸드</option>
                                    <option value="C">동원시스템즈</option>
                                    <option value="T">테크팩솔루션</option>
                                    <option value="A">동원건설산업</option> -->
                                </select>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <button type="button" id="btnSearch" class="btn btn-info float-right">조회</button>
                        </div>
                    </form> 
                </div>
            </div>
        </div>
    </div>


	<div class="row">
		<div class="col-md-12">
			<div class="card">
				<div class="card-body"></div>
				<div class="col-md-11">
					<button type="button" class="btn btn-info float-right" id="btnReg">등록</button>
				</div>
    
    <div class="card-body">
				<div id="cntcGrid"></div>
				<div id="cntcGridPager" class="portal-pager"></div>
   </div>

			</div>
		</div>
	</div>

</div>



<script>
function pageInit() {
	
	var params = [];

    if("${txScreenAuthor.untenantAuthor}" == 'Y'){
        params.push({"id" : "cmpny", "clsCd" : "0024"});    //회사
    }else{
        params.push({"id" : "cmpny", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
    }

    params.push({"id" : "cntcType", "clsCd" : "0035"});  //연계시스템분류
    requestCmmnCd(params);
   
    getCntcSysList();
};


function bindEvent(){
	  $("#btnReg").on("click",function(){
          appendDetailPopup("CntcSysMainDiv", "/stdrinfo/cntcsys/cntcSysRegister");
      });	
	  $("#btnSearch").on("click",function(){
		  getCntcSysList();
      });	
	  
	  $("#cntcType").on("change", function(){
		  if($("#cntcType").val() == "01"){
			  $("#cmpny").attr('disabled', true);
			  $("#cmpny").val("").prop("selected", true);
		  }else if($("#cntcType").val() == "02"){
			  if("${txScreenAuthor.untenantAuthor}" == 'Y'){
			  	$("#cmpny").val("").attr('disabled', false);
			  }
			  else{
				  $("#cmpny").val("${sessionUserInfo.txCmpnyCd}").attr('disabled', true);  
			  }
			  
		  }  
	  });
}



//리스트 단순 조회
function getCntcSysList(pageNo, typeCd){
	
	var url = '/stdrinfo/cntcsys/getCntcSysList';
	var currentPageNo = 1;
	if (pageNo != null && pageNo != undefined && pageNo != "") {
        currentPageNo = pageNo;
    }
	
	var param ={
			cntcType: $("#cntcType").val(),
			cmpny:$("#cmpny").val(),
			currentPageNo:currentPageNo,
            recordCountPerPage:10,
            pageSize:10			
	};
	 
	callAsyncAjax(url,param,"drawGrid");				
	
}



function drawGrid(data){
	
	
	
	
	var params = {}
	
	if (data != null && data != undefined) {
        if(data.result.paginationInfo != null){
        	params =  data.result.resultList;
                  drawPager("cntcGridPager",data.result.paginationInfo,"getCntcSysList"); 
	             }
	     }
	   $("#cntcGrid").jsGrid({
           height : "auto"
           , width : "100%"
           , autoload: true
           , sorting : true
           , align : "center"
           , data : params
           , rowClick:   function(arg){
               popupCntcDetail(arg.item.cntcSysCd);
           } 
           , fields : [
                 {name: "cntcSysClsNm"       , title : "분류"           , type : "text"   , width : 30}
               , {name: "cmpnyNm"             , title : "회사"           , type : "text"   , width : 30}
               , {name: "cntcSysCd"           , title : "시스템코드"        , type : "text"   , width : 30, align:"center"}
               , {name: "cntcSysNm"           , title : "시스템명"           , type : "text"   , width : 30}
               , {name: "sysDc"               , title : "설명"         , type : "text"   , width : 30}
               , {name: "useAt"               , title : "사용여부"            , type : "text"   , width : 30, align:"center"}
               
           ]
       });
	
	
}

function popupCntcDetail(cd){
	appendDetailPopup( "CntcSysMainDiv" , "/stdrinfo/cntcsys/cntcDetailPagePop", "getCntcDetail", cd);
	//getCntcDetail(cd);
};



function getCntcDetail(cd) {
	
	var url = '/stdrinfo/cntcsys/getCntcDetail'
	var param = {"sysCd" : cd} ;
	
	callAsyncAjax(url, param, "printCntcDetail");
		
}


function printCntcDetail(data){
	
	
	var cntcInfo = data.result;
	
	//$("#cntcType").val(cntcInfo.cntcSysClsCd);
	//$("#cmpny").val(cntcInfo.cmpnyCd);
	
	var params = [];
	params.push({"id" : "cntcType1", "clsCd" : "0035", "disable": "Y", "selectValue" : cntcInfo.cntcSysClsCd});//연계시스템분류  
	params.push({"id" : "cmpny1", "clsCd" : "0024", "disable": "Y", "selectValue" : cntcInfo.cmpnyCd});    //회사
	
	requestCmmnCd(params);
	
	$("#sysCd").val(cntcInfo.cntcSysCd);
	$("#sysNm").val(cntcInfo.cntcSysNm);
	$("#sysDc").val(cntcInfo.sysDc);
	$("#use").val(cntcInfo.useAt);
	
		
}














</script>


