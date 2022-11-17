<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"     uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!-- SEARCH FORM -->
 <div id="hlpdskMainPage" class="container-fluid wrap">
    <div class="row" alt="커뮤니티 >공지사항">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header" id="insert">
                    <form class="form-inline py-sm-2">
                        <div class="form-group col-md-5 py-sm-2">
                          <label for="searchCombo2" class="col-form-label" style="width:70px; margin:0 10px 0 5px;">요청회사</label>
                            <div class="col-sm-4 float-left" style="width: 74%;margin: 0 0 2px 0;">
                              <select class="form-control" id="cmpCombo" style="width: 54%;min-width:130px;">
                              </select>
                            </div>
                        </div>                        
                        <div class="form-group col-md-5 py-sm-2">                        
                          <label for="" class="col-form-label" style="width:70px; margin:0 10px 0 5px;">요청자</label>
                            <input type="text" class="form-control" id="nameSearch" placeholder="" style="" value="" />                              
                        </div>                        
                        <div class="form-group col-md-5 py-sm-2">
							<label for="searchCombo2" class="col-form-label" style="width:70px; margin:0 10px 0 5px;">처리상태</label>
                            <div class="col-sm-4 float-left" style="width: 74%;margin: 0 0 2px 0;">
                              <select class="form-control" id="sttCombo" style="width: 54%;min-width:130px;">
                              </select>
                            </div>
                        </div>
                        <div class="form-group col-md-5 py-sm-2" >
                        <input type = "checkbox" id = "check" checked>
                        <label for="" class="col-form-label" style="width:70px; margin:0 10px 0 5px;">요청일</label>
                          <div class="col-sm-4 float-left" style="min-width: 134px;">                             
                              <div class="input-group date" id="startDeDiv" data-target-input="nearest" style="min-width:130px;margin: 0 0 2px 0;">                                  
                                  <input type="text" id="startDe" name="startDe" class="form-control datetimepicker-input" data-target="#startDeDiv"/>
                                      <div class="input-group-append" data-target="#startDeDiv" data-toggle="datetimepicker">
                                          <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                  </div>
                              </div>
                          </div>
                          <div class="col-sm-4  float-left" style="min-width: 134px;">
                              <div class="input-group date" id="endDeDiv" data-target-input="nearest" style="min-width:130px;margin: 0 0 2px 0;">
                                  <input type="text" id="endDe" name="endDe" class="form-control datetimepicker-input" data-target="#endDeDiv"/>
                                  <div class="input-group-append" data-target="#endDeDiv" data-toggle="datetimepicker">
                                      <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                  </div>
                              </div>
                          </div>
                        </div>                        
                        <div class="form-group col-md-5 py-sm-2">
                          <label for="searchCombo2" class="col-form-label" style="width:70px; margin:0 10px 0 5px;">요청구분</label>
                            <div class="col-sm-4 float-left" style="width: 74%;margin: 0 0 2px 0;">
                              <select class="form-control" id="reqCombo" style="width: 54%;min-width:130px;">
                              </select>
                            </div>
                        </div>                        
                        <div class="form-group col-md-5 py-sm-2">                        
                          <label for="" class="col-form-label" style="width:70px; margin:0 10px 0 5px;">제목</label>
                            <input type="text" class="form-control" id="hlpdskSearch" placeholder="" style="" value="" />                              
                        </div>                        
                        <div style="margin: 0 0 2px 0;">
                          <button type="button" id="searchBtn" class="btn btn-info  float-left">검색</button>
                        </div>
                      </div>
                    </div>                                                                               
                </form>
            </div>                 
        </div> 
    </div>                     
    <div class="row">
        <div class="col-md-12">        
	       <div class= "card">
	           <div class = "card-body">
		           <br />
		          <div id="answerSearchGrid"></div>
	              <div id="paging" class="portal-pager"></div>
	            </div>
            </div>	        
           </div>
         </div>
          
<script>

    var cudPage = 1;    
    
    //자동시작 함수
    function pageInit() {
    	
        var params = [];        
	    if("${txScreenAuthor.untenantAuthor}" == 'Y'){
            params.push({"id" : "cmpCombo", "clsCd" : "0024"});    //회사
        }else{
            params.push({"id" : "cmpCombo", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
        }
        params.push({"id" : "sttCombo", "clsCd" : "0041"});
        params.push({"id" : "reqCombo", "clsCd" : "0036"});
        requestCmmnCd(params);
        $("#sttCombo option[value='02']").remove();
        $("#sttCombo option[value='03']").remove();
        
        getHlpdskList(cudPage);        
    };
   
    function bindEvent(){
    	/* 시작날짜 */
    	$('#startDeDiv').datetimepicker({
            format: 'YYYY-MM-DD'
          , defaultDate: getMonthGapDate(-3)
        });
    	
    	/* 마지막날짜 */
        $("#endDeDiv").datetimepicker({
            format: 'YYYY-MM-DD'
          , defaultDate: (new Date())
        });
        
        /* 검색버튼 누를 시 검색 및 그리드 작성 */
        $("#searchBtn").on("click",function(){
            $(".pagingClass").remove();
            getHlpdskList(cudPage);
        });
        
       /*  제목 엔터 키 누를시 검색 및 그리드 작성 */
        $("#hlpdskSearch").keyup(function(e){
            if(e.keyCode == 13){
                $(".pagingClass").remove();
                getHlpdskList(cudPage); 
            }
        });
       
        /*  작성자 엔터 키 누를시 검색 및 그리드 작성 */
        $("#nameSearch").keyup(function(e){
            if(e.keyCode == 13){
                $(".pagingClass").remove();
                getHlpdskList(cudPage); 
            }
        });
        
        /*시작 일자가 마지막일자보다 클 시*/
        $("#startDe").on("propertychange change paste input", function(){
        	if(unhyphenationPhoneNum($("#startDe").val()) > unhyphenationPhoneNum($("#endDe").val())){
                alert("시작일자가 마지막 일자보다 미래일 수 없습니다.");
                var d = new Date();
                d.setMonth(d.getMonth() - 3);
                return $("#startDe").val($.datepicker.formatDate('yy-mm-dd', d));
                //return $("#startDe").val(getMonthGapDate(-3));
            }
        });
        
        /*마지막 일자가 시작 일자보다 작을 시*/
        $("#endDe").on("propertychange change paste input", function(){
            if(unhyphenationPhoneNum($("#startDe").val()) > unhyphenationPhoneNum($("#endDe").val())){
                alert("마지막 일자가  시작일자보다 과거일 수 없습니다.");
                return $("#endDe").val($.datepicker.formatDate('yy-mm-dd', new Date()));
                //return $("#endDe").val(getMonthGapDate(0)-1); //"-"추가 필요 
            }
        });
        
        //체크박스 클릭시
        $("#check").on("click", function(){
        	if ($("input:checkbox[id='check']").is(":checked") == true){
        		$("#startDe").attr("disabled", false);
        		$("#endDe").attr("disabled", false);
        	} else {
                $("#startDe").attr("disabled", true);
                $("#endDe").attr("disabled", true);
        	}   
        });
    }
    
    // 헬프데스크
    function getHlpdskList(cudPage){        
        var url = "/hlpdsk/receipt/getreceipthlpdsk";
        var cmpCombo = $("#cmpCombo").val();
        var sttCombo = $("#sttCombo").val();
        var reqCombo = $("#reqCombo").val();
        var hlpdskSearch = $("#hlpdskSearch").val();
        var nameSearch = $("#nameSearch").val();
        var startDt = unhyphenationPhoneNum($("#startDe").val());
        var lastDt = unhyphenationPhoneNum($("#endDe").val());
        var param = new Object();
        var currentPageNo = 1;
        
        if (cudPage != null && cudPage != undefined && cudPage != "") {
            currentPageNo = cudPage;
        }  
        param.requstCmpnyCd = cmpCombo;
        param.processSttusCd = sttCombo;
        param.requstSe = reqCombo;
        param.userNm = nameSearch;
        param.requstSj = hlpdskSearch;
        param.pageInfo = {currentPageNo : currentPageNo};
        
        if ($("input:checkbox[id='check']").is(":checked") == false){
            startDt = "all";
        }
        
        param.startDt = startDt;
        param.lastDt = lastDt;
        
        callAsyncAjax(url, param, "drawGrid");
    }
    
    // 헬프데스크 콜백
    function drawGrid(data){
        var pageSize = 10;
        
        if(data != ""){
        	hlpdskList = data.result.hlpdskList;
        	drawPager("paging", hlpdskList.pageInfo, "getHlpdskList");
        }
        $("#answerSearchGrid").jsGrid({
            height : "399",
            width : "100%",
            autoload: true,
            sorting : true,
            rowClick: function(arg){
                detailPageMove(arg.item.requstSn);
            },
            data: data.result.hlpdskList.items,    
            fields : [ 
                {name: "regDt" ,title : "요청일",type : "text", 
                	    itemTemplate:function(value){
                	    return moment(value).format('YYYY-MM-DD HH:mm');
                        }, width : 70, align:"center"}, 
                {name: "requstCmpnyCd" ,title : "회사",
                    	itemTemplate:function(value){
                    		return $("#cmpCombo option[value='" + value +"']").text();
                    	}, width : 70, align:"center"},
                {name: "userNm" ,title : "요청자명", type : "text", width : 55, align:"center"},
               	{name: "requstSe" ,title : "요청구분",
                        itemTemplate:function(value){
                        	return $("#reqCombo option[value='" + value +"']").text();
						}, width : 60, align:"center"},
                {name: "requstSj" ,title : "제목", type : "text", width : 240, align:"center"}, 
                {name: "processSttusCd" ,title : "처리상태",
                        itemTemplate:function(value){
                        	return $("#sttCombo option[value='" + value +"']").text();
                        }, width : 50, align:"center"},
                {name: "processDe" ,title : "처리일", type : "text", width : 60, align:"center"}                      
            ]
        });
    }
    
    // 상세페이지 이동    
    function detailPageMove(requstSn){
    	$('.card-header').hide();
        $('.card-body').hide();
        var url = "/hlpdsk/receipt/hlpdskReceiptDetail";
        appendDivDetailGet(url);
        var id = requstSn;
        var url_2 = "/hlpdsk/requst/detailHlpdsk";
        var param = {
            requstSn : id
        };
        callAsyncAjax(url_2, param, "getProper");
    }
    
    // 상세보기 값 셋팅
    function getProper(data){
    	//요청
        $("#searchCombo3").val(data.result.helpdskDetail.requstSe);
        $("#requstSj2").val(data.result.helpdskDetail.requstSj);
        $("#requstCn2").val(data.result.helpdskDetail.requstCn.replaceAll("<br>", "\r\n"));
        $("#requstSn2").val(data.result.helpdskDetail.requstSn);
        $("#processSttusCd").val(data.result.helpdskDetail.processSttusCd);
        $("#userNm").val(data.result.helpdskDetail.userNm);
        
        fileGrpNoVal = data.result.helpdskDetail.requstFileGrpNo;
        
        if(fileGrpNoVal == undefined || fileGrpNoVal == ""){
        	fileGrpNoVal = 0;
        } else {
        	fileGrpNoVal = data.result.helpdskDetail.requstFileGrpNo;
        }        
        hlpUpload.draw(fileGrpNoVal, true);
        
        //처리결과
        $("#requstCn3").val(data.result.helpdskDetail.processCn);
        $("#processDe").val(data.result.helpdskDetail.processDe);
        $("#processTm").val(data.result.helpdskDetail.processTm  == "0" ? "" : data.result.helpdskDetail.processTm);
        $("#sttusCd").val(data.result.helpdskDetail.processSttusCd);
        $("#userNm").val(data.result.helpdskDetail.userNm);
        
        fileGrpNoVal2 = data.result.helpdskDetail.processFileGrpNo;
        
        if(fileGrpNoVal2 == undefined || fileGrpNoVal2 == ""){
        	fileGrpNoVal2 = 0;
        } else {
        	fileGrpNoVal2 = data.result.helpdskDetail.processFileGrpNo;
        }        
        hlpUpload2.draw(Number(fileGrpNoVal2), true);
        
        var processSttusCd = $("#processSttusCd").val();
        if (processSttusCd == "04") {
            $("#updateBtn").hide();
            $("#deleteBtn").hide();
            
        }
    }
        
    function appendDivDetailGet(url){
        var html = "";
        html += '<div id="overPage2" class="over"></div>';
        $(".wrap").append(html);
        $.ajax({
            url : url,
            dataType : "html",
            type : "GET",
            async : false,
            success : function(result){
                $("#overPage2").html(result);
            }
        });
   }
    
</script>