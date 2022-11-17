<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!--  템플릿 바디 -->        
 <div class="card card-primary" id="botMntrngPopDiv">                   
    <div class="card-header">
        <h3 class="card-title">프로세스 상태 정보</h3>
    </div>
    <div class="card-body">
        <div class="row" ><!-- style="min-height:674px;" -->
            <div class="col-md-12">
                 <form id="processDetailOrLog">                                                              
                    <div class="row">
                        <div class="form-group col-md-12 py-sm-2"> 
                            <div id="processDetailGrid"></div>
                        </div>
                    </div>
                    
                    <!-- <div class="form-group col-md-12 py-sm-2">                                              
                        <div> 
                            <div id="processDetailLog"></div>
                        </div>
                    </div> -->  

                    <table class="table float-left" style="padding:0;margin-top:10px;">
                            <colgroup>
                              <col width="10%">
                              <col width="20%">
                              <col width="*">
                            </colgroup>
                            <thead>                             
                                <tr>
                                    <th>ID</th>
                                    <th>프로세스명</th>
                                    <th>로그</th>
                                </tr>
                            </thead>
                            <tbody>
                                  <tr>
                                    <td class="text-jobsid"></td>
                                    <td class="text-processnm"></td>
                                    <td class="text-log" style="text-align:left"></td>
                                  </tr>                                  
                              </tbody>
                         </table>
                </form>

                <div class="float-right py-sm-3">
                    <button type="button" class="btn btn-primary" id="closeLogBtn">로그정보 닫기</button>                    
                    <button type="button" class="btn btn-primary" id="closeBtn">프로세스 상태 정보 닫기</button>
                </div>
                <div id="divSearchUser" class="modal fade" tabindex="-1" role="dialog"></div>
            </div>
        </div>
    </div>
    
</div>
<!--  템플릿 바디 끝 -->                  
   
<script>

	$(document.body).ready(function () { 
		pageInit();
	});
	
    /*
     * 페이지 초기화
     * @param
     * @return
     */
    function pageInit() {
        //그리드 초기화
        searchBotMntrngListDetail();
        
        // 닫기 버튼
        $("#closeBtn").on('click', function(){
            closePOP();
        });
        
        // 로그내용 닫기
        $("#closeLogBtn").on('click', function(){
        	$(".text-jobsid").empty();
            $(".text-processnm").empty();
            $(".text-log").empty();
        });
    }     
    
    // 상세 창 결과 색깔 이미지 표시
    function processResult(sttus) {
    	if(sttus == 1) {
    		// 실패
    		return '<img src="/resources/images/dist/color_red.gif" alt="color_red">';
    	}
    	else if(sttus == 2) {
    		// 실행중
    		return '<img src="/resources/images/dist/twinkle.gif" alt="twinkle">';
    	}
        else if(sttus == 3) {
        	// 성공
        	return '<img src="/resources/images/dist/color_green.gif" alt="color_green">';         
        }
        else if(sttus == 4) {
        	// 기타
        	return '<img src="/resources/images/dist/color_gray.gif" alt="color_gray">';
        }
		
		return '<img src="/resources/images/dist/color_blue.gif" alt="color_blue">';		
    }
    
    // 실시간 버튼 또는 BATCH 버튼 표시 여부
    function buttonResult(sttus, jobsId, jobKey) {
    	if((sttus == null || sttus == "") ||
    	   (jobsId == null || jobsId == "") ||
    	   (jobKey == null || jobKey == "")) {
    		return "예정";
    	}
    	
    	var buttonTemplate = '<button class="btn btn-outline-primary"style="padding:2px;min-width:74px;" onClick=\"realTimeLogClick(' + jobKey + ')\">실시간</button>';
    	
    	if(sttus != 2) {
    		// 실행 중이 아니라면 BATCH 버튼 표시
    		buttonTemplate += '<button class="btn btn-outline-secondary"style="padding:2px;min-width:74px;" onClick=\"jobIdClick(' + jobsId + ')\">BATCH</button>';
    	}
    	
        return buttonTemplate;        
    }
    
    // 일 시 분 초 변환
    function convertMS(second) {
    	if(second == null || second == undefined) {
    		return "예정";
    	}
    	
        var d = parseInt(second/86400);
        var h = parseInt((second%86400)/3600)
        var m = parseInt(((second%86400)%3600)/60);
        var s = ((second%86400)%3600)%60;

        if(d != 0) {
        	return d + "일 " + h + "시 " + m + "분 " +  s + "초";
        }
        else if(h != 0) {
        	return h + "시 " + m + "분 " +  s + "초";
        }
        else if(m != 0) {
        	return m + "분 " +  s + "초";
        }
        
        return s + "초";
    }
    
    // 실시간 버튼 클릭
    function realTimeLogClick(jobKey) {
        $(".over").remove(); // 팝업창 닫기
        window.location.href="/mntrng/realtimelog/realTimeLogMain?jobKey=" + jobKey; // Batch 로그 보기로 이동(기존 Transaction으로 이동)
        return false
    }
    
    // Batch 버튼 클릭 -> 트랜잭션 로그로 이동
    function jobIdClick(jobId) {
    	$(".over").remove(); // 팝업창 닫기
        window.location.href="/mntrng/trnscerror/trnscErrorMain?jobId=" + jobId; // Batch 로그 보기로 이동(기존 Transaction으로 이동)
        return false
    }

    // 실패 또는 기타일 때 info 출력
    function showErrorLog(sttus, log, jobsId, processNm) {
    	// jsGrid로 구현
    	/* var params = new Array();
    	params.push(log);

    	$("#processDetailLog").empty();
        
    	$("#processDetailLog").jsGrid({
            height : "auto"
          , width : "100%"
          , autoload: true
          , sorting : true
          , align : "left"
          , data : params
          , fields : [
              {name: "info"      , title : "로그"     , type : "text"  , width : 80, align : "left", 
                  itemTemplate: 
                      function(value, item) { 
                       return '<span style="display: block;    text-decoration: none;    text-overflow: ellipsis;    white-space: nowrap;    overflow: hidden;" title="'+ item +'">' + item + '</span>'
                      }
                }         
          ]
       });
    	
       $("#processDetailLog").show(); */
       
       // html로 구현
       $(".text-jobsid").html(jobsId);
       $(".text-jobsid").html($(".text-jobsid").html().replace(/\n/g, '<br/>'));
       
       $(".text-processnm").html(processNm);
       $(".text-processnm").html($(".text-processnm").html().replace(/\n/g, '<br/>'));
       
       if(log == null || log == "") {
    	   log = "NULL";
       }
       
       $(".text-log").html(log);
       $(".text-log").html($(".text-log").html().replace(/\n/g, '<br/>'));
       if(sttus == 1) {
    	   // 실패면 왼쪽 정렬
    	   $(".text-log").attr('style', "text-align:left;");
       }
       else {
    	   // 나머지 상태면 가운데 정렬
    	   $(".text-log").attr('style', "text-align:center;");   
       }
    }

    /*
     * 프로세스 상태정보 그리드 초기화(윗부분) -> ID, 결과, 프로세스명, 시작시간, 종료시간, 처리시간, 로그 버튼
     * @param
     * @return
     */
    function drawGrid(data) {
        var params = new Array();
        debugger;
        for(var i = 0 ; i < Object.keys(data).length; i++){    	
            params[i] = {
            		'jobsId'          : (data[i].jobsId == null || data[i].jobsId == "") ? "예정" : data[i].jobsId,
                    'processResult'   : processResult(data[i].sttus),
                    'processNm'       : data[i].processNm,
                    'startDt'         : data[i].startDt,
                    'endDt'           : (data[i].endDt == null || data[i].endDt == "") ? "예정" : data[i].endDt,
                    'executTm'        : convertMS(data[i].executTm),
                    'orcStateNm'      : (data[i].orcStateNm == null || data[i].orcStateNm == "") ? "예정" : data[i].orcStateNm,
                    'realTimeOrBatch' : buttonResult(data[i].sttus, data[i].jobsId, data[i].jobKey),
                    'sttus'           : data[i].sttus,
                    'info'            : data[i].info,
                    'jobKey'          : data[i].jobKey
            };  
        }
        
        params.sort(function(a, b){
            return a.jobsId < b.jobsId ? -1 : 1;
        });
        
        $("#processDetailGrid").jsGrid({
              height : "auto"
            , width : "100%"
            , autoload: true
            , sorting : true
            , align : "left"
            , data : params
            , rowClick: function(args) {
            	var $target = $(args.event.target); 
            	
                if($target.closest(".btn-outline-primary").length) {
                    // 실시간 버튼 클릭
                    realTimeLogClick(args.item.jobKey);
                    return;
                }
                else if($target.closest(".btn-outline-secondary").length) {
                    // BATCH 버튼 클릭
                	jobIdClick(args.item.jobsId);
                	return;
                }

            	// 실패했거나 기타
            	if(args.item.sttus == 1 || args.item.sttus == 4) {
                    showErrorLog(args.item.sttus, args.item.info, args.item.jobsId, args.item.processNm);
                }
            	else {
            		/* $("#processDetailLog").hide(); */
            		$(".text-jobsid").empty();
            	    $(".text-processnm").empty();
            	    $(".text-log").empty();
            	}
            }
            , fields : [
            	  {name: "jobsId"           , title : "ID"           , type : "text"  , width : 20, align : "right"  } 
                , {name: "processResult"    , title : "결과"          , type : "text"  , width : 15, align : "center" } 
                , {name: "processNm"        , title : "프로세스명"      , type : "text"  , width : 90, align : "left"   }
                , {name: "startDt"          , title : "시작시간"      , type : "text"  , width : 45, align : "left"   }
                , {name: "endDt"            , title : "종료시간"       , type : "text"  , width : 45, align : "left"   }
                , {name: "executTm"         , title : "처리시간"       , type : "text"  , width : 40, align : "left"   }
                , {name: "orcStateNm"       , title : "상태"          , type : "text"  , width : 40, align : "left"   }
                , {name: "realTimeOrBatch"  , title : "로그"          , type : "text"  , width : 60, align : "left" } 
            ]
        });
        
        // 로딩 끝
        $('.dimmed').css({ display: 'none' });
        $('.loading').css({ display: 'none' });
        $('.loading').removeClass('show');
    }
    
    function searchBotMntrngListDetail() {  	
    	// 초기 세팅
    	drawGrid(detailProcessArray);
    }

</script>