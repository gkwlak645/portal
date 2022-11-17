<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"     uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>

<!-- SEARCH FORM -->
 <div id="hlpdskMainPage" class="container-fluid wrap">
   <div class="row" alt="HelpDesk /처리요청">
       <div class="col-md-12">
           <div class="card">
               <div class="card-header" id="insert">
                   <form class="form-inline">
                   <div class="form-group col-md-6 py-sm-1">
                         
                       
                       <label for="searchCmpnyCd" class="col-sm-3 col-form-label">회사</label>
                             <div class="col-sm-4 float-left">
                                <select id="searchCmpnyCd" class="form-control float-left"  style="min-width:120px;width:100%;">
                                   <option value=""></option>
                               </select>        
                            </div>                        
                   </div>
                   <div class="form-group col-md-6 py-sm-1">
                       <label for="searchCombo2" class="col-form-label col-sm-3">카테고리</label>
                       <div class="col-sm-9">
                           <select class="form-control" id="searchCombo2" style="width: 54%;min-width:130px;">
                           </select>  
                       </div>                              
                   </div>
                   
                   <div class="form-group col-md-6 py-sm-1">
                     <label for="" class="col-form-label col-sm-3">날짜 <!-- <input type = "checkbox" id = "check" checked> --></label>                                            
                       <div class="col-sm-9 float-left">
                             <div class="input-group date float-left" id="startDeDiv" data-target-input="nearest"style="min-width:130px;width:30%;margin-right:5px;">
                                 <input type="text" id="startDe" name="startDe" class="form-control datetimepicker-input" data-target="#startDeDiv"/>
                                 <div class="input-group-append" data-target="#startDeDiv" data-toggle="datetimepicker">
                                     <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                 </div>
                             </div>
                             <div class="input-group date  float-left" id="endDeDiv" data-target-input="nearest"style="min-width:130px;width:30%;">
                                 <input type="text" id="endDe" name="endDe" class="form-control datetimepicker-input" data-target="#endDeDiv"/>
                                 <div class="input-group-append" data-target="#endDeDiv" data-toggle="datetimepicker">
                                     <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                 </div>
                             </div>
                        </div>                      
                   </div>
                   <div class="form-group col-md-6 py-sm-1">    
                                                      
                      <!-- <label for="" class="col-form-label col-sm-3">처리상태</label>
                      <div class="col-sm-9 float-left">
                        <select class="form-control  float-left" id="searchCombo" style="width: 54%;min-width:130px;">
                        </select>
                        <button type="button" id="searchBtn" class="btn btn-info  float-left">조회</button>
                       </div> -->
                       
                             <label class="col-form-label col-sm-3">작성자</label>
		                       <div class="col-sm-9">
		                           <input type="text" class="form-control" id="searchWriter" style="" value="" />
		                       </div>     
                       
                    </div>   
                    
                    
                    <div class="form-group col-md-6">
                       <label for="usr" class="col-sm-3 col-form-label">제목</label>
                       <div class="col-sm-9">
                         <input type="text" class="form-control float-left" value="" id="hlpdskSearch" style="min-width: 150px;width:100%;" placeholder="검색어"  maxlength="30">
                       </div>
                    </div>
                    
                    <button type="button" id="searchBtn" class="btn btn-info  float-left">조회</button>                      
                    
                                                                                             
                   </form> 
               </div>
           </div>
       </div>
   </div>
   <div class="row">
       <div class="col-md-12">
           <div class="card">
               <div class="card-body">                
                    <button type="button" id="regBtn" class="btn btn-primary float-right" style="margin:5px 0 15px 2px;">등록</button>                                         
                     <div id="answerSearchGrid"></div>
                     <div id="paging" class="portal-pager">
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 로딩바  -->
<div class="dimmed" style="display:none"></div>
<div class="loading" style="display:none">
    <div class="loading-bar"><div></div><div></div><div></div><div></div></div>
    <span class="loading-text">데이터 로딩 중...</span>
</div>
          
<script>

    var cudPage = 1;    
    
    //자동시작 함수
    function pageInit() {
    	
        var params = [];        
        /* params.push({"id" : "searchCombo", "clsCd" : "0041"});
        params.push({"id" : "searchCombo2", "clsCd" : "0036"}); */
        
        params.push({"id" : "searchCombo2", "clsCd" : "0058"});
        params.push({"id" : "searchCmpnyCd", "clsCd" : "0024"});
        //params.push({"id" : "searchCmpnyCd", "clsCd" : "0024", "selectValue": "${sessionUserInfo.txCmpnyCd}"});
         
        requestCmmnCd(params);
        
        
        
       /*  if("${requestSn}" != null && "${requestSn}" != ""){
        	detailPageMove("${requestSn}");
        } */
        
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
        
        getHlpdskList(cudPage);   

    };
   
    function bindEvent(){
    	
        
        /* 검색버튼 누를 시 검색 및 그리드 작성 */
        $("#searchBtn").on("click",function(){
            $(".pagingClass").remove();
            getHlpdskList(cudPage);
        });
        
       /*  엔터 키 누를시 검색 및 그리드 작성 */
        $("#hlpdskSearch").keyup(function(e){
            if(e.keyCode == 13){
                $(".pagingClass").remove();
                getHlpdskList(cudPage); 
            }
        });
       
        /* 등록페이지 이동 */
        $("#regBtn").on("click", function(){
        	$('.card-header').hide();
        	$('.card-body').hide();
            var url = "/hlpdsk/requst/hlpdskCreate";
            appendDivDetailGet(url);
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
            }
        });
        
        //체크박스 클릭시
        /* $("#check").on("click", function(){        	
        	if ($("input:checkbox[id='check']").is(":checked") == true){
        		$("#startDe").attr("disabled", false);
        		$("#endDe").attr("disabled", false);
        	} else {
                $("#startDe").attr("disabled", true);
                $("#endDe").attr("disabled", true);
        	}   
        }); */        
    }
    
    // 헬프데스크
    function getHlpdskList(cudPage){        
        var url = "/hlpdsk/requst/getHlpdsk";
        var searchCombo = $("#searchCombo").val();
        var searchCombo2 = $("#searchCombo2").val();        
        var hlpdskSearch = $("#hlpdskSearch").val();
        var requstCmpnyCd = $("#searchCmpnyCd").val();
        var searchWriter = $("#searchWriter").val();
        var startDt = unhyphenationPhoneNum($("#startDe").val());
        var lastDt = unhyphenationPhoneNum($("#endDe").val());
        var param = new Object();
        var currentPageNo = 1;
        
        if (cudPage != null && cudPage != undefined && cudPage != "") {
            currentPageNo = cudPage;
        }
        param.processSttusCd = searchCombo;
        param.requstSe = searchCombo2;
        param.pageInfo = {currentPageNo : currentPageNo};
        param.requstSj = hlpdskSearch;
        param.requstCmpnyCd = requstCmpnyCd;
        param.requstUserId = searchWriter.trim();
        
        /* if ($("input:checkbox[id='check']").is(":checked") == false){
            startDt = "all";
        } */
        
        param.startDt = startDt;
        param.lastDt = lastDt;
        
        callAsyncAjax(url, param, "drawGrid");
        
        $('.dimmed').css({ display: 'block' });
        $('.loading').css({ display: 'block' });
        $('.loading').addClass('show');
    }
    
    // 헬프데스크 콜백
    function drawGrid(data){
        var pageSize = 10;
        
        if(data != ""){
        	hlpdskList = data.result.hlpdskList;
        	drawPager("paging", hlpdskList.pageInfo, "getHlpdskList");
        }
        $("#answerSearchGrid").jsGrid({
            height : "auto",
            width : "100%",
            autoload: true,
            sorting : true,
            rowClick: function(arg){
                detailPageMove(arg.item.requstSn);
            },
            data: data.result.hlpdskList.items,    
            fields : [ 
                {name: "regDt" ,title : "날짜",type : "text", 
                	    itemTemplate:function(value){
                	    return moment(value).format('YYYY-MM-DD HH:mm');
                    }, width : 70, align:"center"}, 
                {name : "cmpNm", title : "회사", width:70, align:"center"},
                {name : "empNm", title : "작성자", width:55, align:"center"},
                {name: "requstSe" ,title : "카테고리",
                    	itemTemplate:function(value){
                    		return $("#searchCombo2 option[value='" + value +"']").text();
                    	}, width : 60, align:"center"}, 
                {name: "requstSj" ,title : "제목", type : "text", width : 240, align:"center"}
                /* {name: "processSttusCd" ,title : "처리상태",
	                	itemTemplate:function(value){
	                       return $("#searchCombo option[value='" + value +"']").text();
                        }, width : 50, align:"center"}, 
                {name: "processDe" ,title : "처리일", type : "text", width : 50, align:"center"} */                      
            ],
            //noDataContent: "검색된 글이 없습니다."
        });
        
        // 로딩 끝
        $('.dimmed').css({ display: 'none' });
        $('.loading').css({ display: 'none' });
        $('.loading').removeClass('show');
    }
    
    // 상세페이지 이동    
    function detailPageMove(requstSn){
    	$('.card-header').hide();
        $('.card-body').hide();
        var url = "/hlpdsk/requst/hlpdskDetail";
        appendDivDetailGet(url);
        var id = requstSn;
        var url_2 = "/hlpdsk/requst/detailHlpdsk";
        var param = {
            requstSn : id
        };
        callAsyncAjax(url_2, param, "getProper");
        
        $('.dimmed').css({ display: 'block' });
        $('.loading').css({ display: 'block' });
        $('.loading').addClass('show');
    }
    
    // 상세보기 값 셋팅
    function getProper(data){
    	var stCd = data.result.helpdskDetail.processSttusCd;    	
        $("#searchCombo3").val(data.result.helpdskDetail.requstSe); 
        $("#requstSj2").val(data.result.helpdskDetail.requstSj);
        $("#requstCn2").val(data.result.helpdskDetail.requstCn.replaceAll("<br>", "\r\n"));
        $("#requstSn2").val(data.result.helpdskDetail.requstSn);
        $("#processSttusCd").val(data.result.helpdskDetail.processSttusCd);
        fileGrpNoVal = data.result.helpdskDetail.requstFileGrpNo;
   
        //처리결과
        $("#requstCn3").val(data.result.helpdskDetail.processCn);
        $("#processDe").val(data.result.helpdskDetail.processDe);
        $("#userNm").val(data.result.helpdskDetail.processUserId);
        
        $("#sttusCd").val($("#searchCombo option[value='" + stCd +"']").text());
        
        if(fileGrpNoVal == undefined || fileGrpNoVal == ""){
        	fileGrpNoVal = 0;
        } else {
        	fileGrpNoVal = data.result.helpdskDetail.requstFileGrpNo;
        }
        
        var userId = "${txUserId}";
        var isSame = data.result.helpdskDetail.requstUserId == userId ? true : false;

        hlpUpload.draw(fileGrpNoVal, isSame);

        var processSttusCd = $("#processSttusCd").val();
        
        //alert(data.result.helpdskDetail.requstUserId + " vs " + userId);
        
        if( data.result.helpdskDetail.requstUserId != userId ) {
        	$("#requstSj2").prop("disabled", true);
        	$("#searchCombo3").prop("disabled", true);
        	$("#requstCn2").prop("disabled", true);
        	        
            /* $("#btnDelFile0").prop("disabled", true); // 첨부파일 삭제 버튼
            $("#btnAdd").prop("disabled", true); // 첨부파일 추가 버튼
            $("#file0").prop("disabled", true); // 파일선택 버튼 */
        }
        
        if (processSttusCd == "04" || data.result.helpdskDetail.requstUserId != userId) {
            $("#updateBtn").hide();
            $("#deleteBtn").hide();
        }

        // 로딩 끝
        $('.dimmed').css({ display: 'none' });
        $('.loading').css({ display: 'none' });
        $('.loading').removeClass('show');
        
        /* fileGrpNoVal2 = data.result.helpdskDetail.processFileGrpNo;
        
        if(fileGrpNoVal2 == undefined || fileGrpNoVal2 == ""){
            fileGrpNoVal2 = 0;
        } else {
            fileGrpNoVal2 = data.result.helpdskDetail.processFileGrpNo;
        }        
        hlpUpload2.draw(Number(fileGrpNoVal2), true); */
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