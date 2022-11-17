<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/template/script.jsp"></jsp:include>
<body>
	url:<br>
	<input type="text" id="url" size="100" value="/task/botSchedule/getBotSchedule || /task/botSchedule/setBotScheduleSttus" /><br>
	<br>
	<p />
	
	
	json text:<br>
	<textarea id="jsonText" cols="100" rows="10">
-- 실행요청
{
    "tanantNm"  : "Default"
     , "robotNm"  : "Tbot07"
}

-- 실행응답
{
  "tanantNm"  : "Default"
  , "robotNm"  : "Tbot07"
  , "sn": 1
  , "sttus":  "EXCEPTION"
  , "exceptionMssage": "에러 메시지"
  , "startDt":  "2020-01-01 10:11:22"
  , "endDt":  "2020-01-01 17:22:33" 
}

	</textarea><br /><p />

reponseText:<br>
	<textarea id="responseText" cols="100" rows="10"></textarea><br/><br/>

	<button id="exec">실행</button>
	
	
</body>
<script type="text/javascript">
$(document.body).ready(function () {
	$("#exec").on('click', function(){
		var params = JSON.parse($("#jsonText").val());
		//var url = "/task/botSchedule/getBotSchedule";
		url = $("#url").val();
        callAsyncAjax(url, params, "getBotScheduleCallback");
	});
});

function getBotScheduleCallback(data){
	$("#responseText").val((JSON.stringify(data)).replace(/\\/gi, ""));
	
	
}
</script>
