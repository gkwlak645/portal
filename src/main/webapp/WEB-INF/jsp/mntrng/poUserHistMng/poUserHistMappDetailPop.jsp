<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="card card-primary" id = "cardDiv">
    <div class="card-header">
        <h3 class="card-title">상세페이지</h3>
    </div>
    <div class="card-body">
        <div class="row">
            <div id="poUserHistDetail"></div>
                <div class="col-md-6">
                
                <div class="float-right">
                    <button type="button" class="btn btn-primary" id="cancel">닫기</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>

    $(document).ready(function() {
        //이벤트 바인딩
        bindEvent();
        
        searchPoUserHistList(jobsId);
    });
    
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent() {
        
        $("#cancel").on("click", function() {
            closePOP();
        });
    }

    function drawPoUserHistList(data){
    	
        console.log(data)
		var params = data.result;
        
        if(data.result.resultList!=null){
        	data = data.result.resultList;
        }
        
        $("#poUserHistDetail").jsGrid({
            height : "auto"
          , width : "100%"
          , autoload: true
          , sorting : true
          , align : "center"
          , data : params
          , fields : [
        	  	{name: "jobsId"               , title : "아이디"         , type : "text"   , width : 0 , visible : false}
              , {name: "processCd"        , title : "프로세스코드"          , type : "text"   , width : 50}
              , {name: "processNm"      , title : "프로세스명"        , type : "text"   , width : 150}
              , {name: "sttus"        , title : "상태"          , type : "text"   , width : 50}
              , {name: "startDt"      , title : "시작시간"         , type : "text"   , width : 80}
              , {name: "endDt"        , title : "종료시간"         , type : "text"   , width : 80}
         ]
        });  
    }
    
    function searchPoUserHistList(data){
        console.log("@"+data);
        
        var url = '/mntrng/pouserhistmng/getPoUserHistDetailList';
        var param = {
        	jobsId: data
        };
        
        callAsyncAjax(url, param, "drawPoUserHistList");
    }
    
 </script>