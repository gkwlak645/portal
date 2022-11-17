<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="card card-primary" id = "cardDiv">
    <div class="card-header">
        <h3 class="card-title">상세페이지</h3>
    </div>
    <div class="card-body">
        <div class="row">
            <div id="excResHistDetail"></div>
                <div class="col-md-6">
                
<!--                                         입력값 -->
<!--                   <div id = "inputValue"></div> -->
                  
<!--                                         출력값 -->
<!--                   <div id="outputValue"></div>  -->
                <div class="float-right">
                    <button type="button" class="btn btn-primary" id="cancel">닫기</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>

var jobId;
    $(document).ready(function() {
       
        //페이지 초기화
        pageInit();
        
        //이벤트 바인딩
        bindEvent();
        
        searchResHistList(jobId);
        drawExHistList();
    });

    /*
     * 페이지 초기화
     * @param
     * @return
     */
    function pageInit() {
        
    }
    
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent() {
        
        $("#cancel").on("click", function() {
            closePOP();
            
            //그리드 조회
			searchResHistList();
        });
    }

    function drawExHistList(data){
        console.log(data)
//         var params = data.result.resultList;
        
        if(data.result.resultList!=null){
        	data = data.result.resultList;
        }
        
        $("#excResHistDetail").jsGrid({
            height : "auto"
          , width : "100%"
          , autoload: true
          , sorting : true
          , align : "center"
          , data : data
          , fields : [
        	  	{name: "jobsId"               , title : "아이디"         , type : "text"   , width : 0 , visible : false}
              , {name: "cmpnyNm"        , title : "회사"          , type : "text"   , width : 50}
              , {name: "processCd"        , title : "프로세스코드"          , type : "text"   , width : 50}
              , {name: "processNm"      , title : "프로세스명"        , type : "text"   , width : 150}
              , {name: "botNm"        , title : "로봇"           , type : "text"   , width : 90}
              , {name: "envrnNm"  , title : "환경"          , type : "text"   , width : 90}
              , {name: "sttus"        , title : "상태"          , type : "text"   , width : 50}
              , {name: "startDt"      , title : "시작시간"         , type : "text"   , width : 80}
              , {name: "endDt"        , title : "종료시간"         , type : "text"   , width : 80}
              , {name: "sourc"       , title : "소스"          , type : "text"   , width : 50}
         ]
        });  
    }
    
    function searchResHistList(data){
        console.log("@"+data);
        
      //alert(JSON.stringify(pageNo));
        var url = '/mntrng/excreshist/searchResHistList';
        
        var param = {
        	jobId: data
        };
        
        callAsyncAjax(url, param, "drawExHistList");
       	
     // 로딩 끝
        $('.dimmed').css({ display: 'none' });
        $('.loading').css({ display: 'none' });
        $('.loading').removeClass('show');
    }
    
 </script>