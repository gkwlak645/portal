<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- MAIN TYPE2 -->
<div class="container-fluid">
    <!-- Small boxes (Stat box) -->
    <div class="content row">
        <section class="col-lg-8">

            <div class="col-md-12" style="margin: 0; padding: 0;">
                <!-- 부분별 프로세스 현황 -->
                <div class="card direct-chat direct-chat-warning jqCardInfo" id="viewCard1_1" data-card-type="1" data-card-position="1" data-card-sn="1" style="min-height: 220px;"></div>
                <!-- // 부분별 프로세스 현황 -->
           </div>
            <div class="row">
                <div class="col-md-6"  style="padding-left:0;">
                    <div class="card direct-chat direct-chat-warning jqCardInfo" id="viewCard2_1" style="min-height: 220px;" data-card-type="2" data-card-position="1" data-card-sn="1"></div>
                    <div class="card direct-chat direct-chat-warning jqCardInfo" id="viewCard2_3" style="min-height: 220px;" data-card-type="2" data-card-position="3" data-card-sn="3"></div>
                    <!-- // RPA 담당자 -->
                </div>

                <div class="col-md-6" style="padding-right:0;">
                    <div class="card direct-chat direct-chat-warning jqCardInfo" id="viewCard2_2" style="min-height: 220px;" data-card-type="2" data-card-position="2" data-card-sn="2"></div>
                    <div class="card direct-chat direct-chat-warning jqCardInfo" id="viewCard2_4" style="min-height: 220px;" data-card-type="2" data-card-position="4" data-card-sn="4"></div>
                </div>
            </div>
        </section>

        <section class="col-lg-4">
            <div class="card direct-chat direct-chat-warning jqCardInfo" id="viewCard3_1" data-card-type="3" data-card-position="1" data-card-sn="1" style="min-height: 400px; max-width: 100%;"></div>
            <div class="card direct-chat direct-chat-warning jqCardInfo" id="viewCard2_5" data-card-type="2" data-card-position="5" data-card-sn="5" style="height: 220px; max-width: 100%;"></div>
        </section>
    </div>
</div>
<script type="text/javascript">

//초기값
var ln_aCardType1 = [{cardSn:1, viewName:"RPA현황"}, {cardSn:2, viewName:"1-2"}];
var ln_aCardType2 = [
    {cardSn:1, viewName:"나의 프로세스"}, {cardSn:2, viewName:"게시/헬프데스크"}
    , {cardSn:3, viewName:"Automation index"}, {cardSn:4, viewName:"시스템 작업공지"}
    , {cardSn:5, viewName:"실핼결과"}, {cardSn:6, viewName:"2-6"}];
var ln_aCardType3 = [{cardSn:1, viewName:"3-1"}];

//일반: 1, 임원: 2 구분
var ln_iUserType = 1;  

$(document.body).ready(function () {
   for(var i =0; i< 1; i++){
       var oaCardType = ln_aCardType1[i];
       var sDivID = "viewCard1_" + (i+1);
       appendCardDiv(sDivID, "/main/type" + ln_iUserType + "SiteMainCard1_" + oaCardType.cardSn);
   }
   
   for(var i =0; i< 5; i++){
       var oaCardType = ln_aCardType2[i];
       var sDivID = "viewCard2_" + (i+1);
       appendCardDiv(sDivID, "/main/type" + ln_iUserType + "SiteMainCard2_" + oaCardType.cardSn);
   }
   
   for(var i =0; i< 1; i++){
       var oaCardType = ln_aCardType3[i];
       var sDivID = "viewCard3_" + (i+1);
       appendCardDiv(sDivID, "/main/type" + ln_iUserType + "SiteMainCard3_" + oaCardType.cardSn);
   }
});

$(document)
.on("click", ".jqCardInfo .btn-tool", function() {

	//클릭한 카드외 모두 선택창 닫기
	var oObj = $(this).closest(".jqCardInfo");
	var sClickCardType = oObj.attr("data-card-type");
	var sClickCardPosition = oObj.attr("data-card-position");
	
	var aCardList = $(".direct-chat-contacts-open");
	var iaCardList = aCardList.length;
	
	for(var i = 0; i < iaCardList; i++){
		var oTemp = $(aCardList[i]);
		if(sClickCardType != oTemp.attr("data-card-type") || sClickCardPosition != oTemp.attr("data-card-position")){
			oTemp
			 .removeClass("direct-chat-contacts-open").end()
			 .find(".direct-chat-contacts").hide().end();
		}
	}
	
	if(iaCardList > 0){
		//--변경 가능한 목록 표시 시작
	    var aCurViewCard = $(".jqCardInfo[data-card-type=" + sClickCardType + "]");
	    var iaCurViewCard = aCurViewCard.length;
	    
	    //현재 표시된 카드 목록
	    var aTempViewCard = []
	    for(var i = 0; i < iaCurViewCard; i++){
	        aTempViewCard[$(aCurViewCard[i]).attr("data-card-sn")] = 1
	    }
	    
	    var aCard;
	    if(sClickCardType == "1"){
	    	aCard = ln_aCardType1;
	    }
	    else if(sClickCardType == "2"){
	        aCard = ln_aCardType2;
	    }
	    else if(sClickCardType == "3"){
	    	aCard = ln_aCardType3;
	    }
	    
	    //목록 만들기
	    var iaCard = aCard.length;
	    var sHtml = "";
	    for(var i = 0; i < iaCard; i++){
	        var oaCard = aCard[i]
	        console.log("aTempViewCard[oaCard.cardSn]: " + aTempViewCard[oaCard.cardSn])
	        if(aTempViewCard[oaCard.cardSn] == undefined){
	            console.log("표시:" + oaCard.cardSn)
//	            oObj.attr("data-card-sn", oaCard.cardSn);
//	            var sDivID = "viewCard" + sCardType + "_" + sCardPosition;
//	            appendCardDiv(sDivID, "/main/type" + ln_iUserType + "SiteMainCard" + sCardType + "_" + oaCard.cardSn);
	            sHtml += "<li class='pop-list-item' data-card-click-sn='"+ oaCard.cardSn + "' style='cursor:Pointer'>" + oaCard.viewName + "</li>";
	            console.log("sHtml:" + sHtml);
	            break;
	        }
	    }

	    if(iaCard < 2) {
	    	oObj.find(".direct-chat-contacts").hide().end();
	    	console.log("hide");
	    	return false;
	    }
		oObj
		  .find(".direct-chat-contacts .pop-list").html(sHtml).end()
		  .find(".direct-chat-contacts").show().end();
		//--변경 가능한 목록 표시 종료
	}
	else{
		oObj.find(".direct-chat-contacts").hide().end();
	}
	
	//<div class="card direct-chat direct-chat-warning jqCardInfo" id="viewCard1_1" data-card-type="1" data-card-position="1" data-card-sn="1" style="min-height: 220px;"></div>
});

$(document)
.on("click", ".jqCardInfo .direct-chat-contacts .pop-list li", function() {
	console.log("li click");
    var oObj = $(this);
    
    var oParentObj = $(this).closest(".jqCardInfo");
    var sParentCardType = oParentObj.attr("data-card-type");
    var sParentPosition = oParentObj.attr("data-card-position");
    var sClickCardSn = oObj.attr("data-card-click-sn")
    
    oParentObj.removeClass("direct-chat-contacts-open").end()
    oParentObj.attr("data-card-sn", sClickCardSn);
    var sDivID = "viewCard" + sParentCardType + "_" + sParentPosition;
    appendCardDiv(sDivID, "/main/type" + ln_iUserType + "SiteMainCard" + sParentCardType + "_" + sClickCardSn);
    
});
//변경 가능한 목록




/*
var array = [1,2,3,4,5];
// 배열 중간에 원소 삭제 
// array.splice(인덱스, 인덱스부터 삭제할 원소개수)
var o = array.splice(2, 1);  
console.log(array); // [1, 2, 4, 5]
console.log(o); // [3]  // 삭제된 원소 반환
// 배열 중간에 원소 추가 
// array.splice(인덱스, 인덱스부터 삭제할 원소개수(추가시 0), 추가할 원소 ...)
array.splice(3, 0, 99, 99, 99);
console.log(array); // [1, 2, 4, 99, 99, 99, 5]
array = array.splice(0,5);  
console.log(array); // [1, 2, 4, 99, 99, 99, 5]
*/



</script>