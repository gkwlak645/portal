<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 관리자 화면 -->
<div class="container-fluid">
	<div class="row">
	    <div class="col-lg-12" style="margin: 0;">
	        <!-- section 1 - 그룹 현황 -->
	        <section class="card direct-chat direct-chat-warning jqCardInfo" data-card-type="1" data-card-position="1" data-card-sn="1" id="viewCard1_1">
	        </section>
	        <!-- // section 1 - 그룹 현황 -->
	    </div>
	</div>
	<div class="row">
	    <div class="col-lg-6">
	        <!-- section 2 - 가동률 -->
	        <section class="card direct-chat direct-chat-warning jqCardInfo" data-card-type="2" data-card-position="1" data-card-sn="1" style="margin-bottom: 0;" id="viewCard2_1">
	        </section>
	        <!-- // section 2 - 가동률 -->
	    </div>
	    <div class="col-lg-6">
	        <!-- section 2 - 성공률 -->
	        <section class="card direct-chat direct-chat-warning jqCardInfo" data-card-type="2" data-card-position="2" data-card-sn="2" style="margin-bottom: 0;" id="viewCard2_2">
	        </section>
	        <!-- // section 2 - 성공률 -->
	    </div>
	</div>
</div>
<!-- // 관리자 화면 -->


<script type="text/javascript">
var lc_loading_id = 0;

//초기값
var ln_aCardType1 = [{cardSn:1, viewName:"그룹현황"}];
var ln_aCardType2 = [{cardSn:1, viewName:"가동률"} , {cardSn:2, viewName:"성공률"}];
    
$(document.body).ready(function () {
	
	var iln_aCardType1 = ln_aCardType1.length;
	
	for(var i =0; i< iln_aCardType1; i++){
	      var oaCardType = ln_aCardType1[i];
	      var sDivID = "viewCard1_" + (i+1);
	      appendCardDiv(sDivID, "/main/type2SiteMainCard1_" + oaCardType.cardSn);
	}
	   
	var iln_aCardType2 = ln_aCardType2.length;
	   
	for(var i =0; i< iln_aCardType2; i++){
	    var oaCardType = ln_aCardType2[i];
	    var sDivID = "viewCard2_" + (i+1);
		appendCardDiv(sDivID, "/main/type2SiteMainCard2_" + oaCardType.cardSn);
	}
});

//변경할 카드 목록 표시
$(document)
.on("click", ".jqCardInfo .btn-tool", function() {
console.log("변경할 카드 목록 표시")
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
        
        
        //목록 만들기
        var iaCard = aCard.length;
        var sHtml = "";
        for(var i = 0; i < iaCard; i++){
            var oaCard = aCard[i];
            console.log("aTempViewCard[oaCard.cardSn]: " + aTempViewCard[oaCard.cardSn])
            if(aTempViewCard[oaCard.cardSn] == undefined){
                console.log("표시:" + oaCard.cardSn)
//              oObj.attr("data-card-sn", oaCard.cardSn);
//              var sDivID = "viewCard" + sCardType + "_" + sCardPosition;
//              appendCardDiv(sDivID, "/main/type" + ln_iUserType + "SiteMainCard" + sCardType + "_" + oaCard.cardSn);
                sHtml += "<li class='pop-list-item' data-card-click-sn='"+ oaCard.cardSn + "' style='cursor:Pointer'>" + oaCard.viewName + "</li>";
                console.log("sHtml:" + sHtml);
                //break;
            }
        }

        if(iaCard == iaCurViewCard) {
        	oObj.removeClass("direct-chat-contacts-open").end()
            alert("변경할 목록이 없습니다.");
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
});


//변경할 카드 목록 클릭 시 동작
$(document)
.on("click", ".jqCardInfo .direct-chat-contacts .pop-list li", function() {
    //console.log("li click");
    var oObj = $(this);
    
    var oParentObj = $(this).closest(".jqCardInfo");
    var sParentCardType = oParentObj.attr("data-card-type");
    var sParentPosition = oParentObj.attr("data-card-position");
    var sClickCardSn = oObj.attr("data-card-click-sn")
    
    oParentObj.removeClass("direct-chat-contacts-open").end()
    oParentObj.attr("data-card-sn", sClickCardSn);
    var sDivID = "viewCard" + sParentCardType + "_" + sParentPosition;
    //appendCardDiv(sDivID, "/main/type" + ln_iUserType + "SiteMainCard" + sParentCardType + "_" + sClickCardSn);
    appendCardDiv(sDivID, "/main/type2SiteMainCard" + sParentCardType + "_" + sClickCardSn);
    
});
</script>