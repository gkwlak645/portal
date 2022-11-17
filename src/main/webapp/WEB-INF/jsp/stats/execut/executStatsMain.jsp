<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="/resources/iframe/iframeResizer.min.js"></script>
<div class="container-fluid wrap">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <form id="searchForm" name="searchForm" class="form-inline">
                        <div class="form-group col-md-5">
                            <label for="usr" class="col-sm-6 col-form-label">기간</label>
                            <div class="col-sm-3">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" id="rdoMonth" name="radio1" checked>
                                    <label class="form-check-label">월별</label>
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" id="rdoDate" name="radio1">
                                    <label class="form-check-label">일별</label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <div class="col-sm-4">
                            </div>
                            <div class="col-sm-4">
                                <select class="form-control" id="cmbYear" style="width:100%;">
                                    <option value="2020">2020</option>
                                    <option value="2019">2019</option>
                                </select>
                            </div>
                            <div class="col-sm-4">
								<select class="form-control" id="cmbMonth" style="width:100%;" disabled>
									<option value="01">01</option>
									<option value="02">02</option>
									<option value="03">03</option>
									<option value="04">04</option>
									<option value="05">05</option>
									<option value="06">06</option>
									<option value="07">07</option>
									<option value="08">08</option>
									<option value="09">09</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
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
                <div id="charDiv" class="card-body">
                    <iframe id="chartFrame" src="" style="width:100%;height:600px;border:0"></iframe>
                </div>
            </div>
        </div>
    </div>
	<script>
	
        var dailyChartUrl = "http://192.168.0.40:5601/app/kibana#/visualize/edit/6441a4d0-aec7-11ea-a1c8-d96a1e9bb41f?embed=true&_a=(filters:!(),linked:!f,query:(language:kuery,query:'@'),uiState:(),vis:(aggs:!((enabled:!t,id:'1',params:(customLabel:%EC%8B%A4%ED%96%89%EA%B1%B4%EC%88%98,field:cnt),schema:metric,type:sum),(enabled:!t,id:'2',params:(customLabel:%EC%9D%BC%EC%9E%90,field:stats_de.keyword,missingBucket:!t,missingBucketLabel:Missing,order:asc,orderBy:_key,otherBucket:!f,otherBucketLabel:Other,size:31),schema:segment,type:terms),(enabled:!t,id:'3',params:(field:state.keyword,missingBucket:!t,missingBucketLabel:Missing,order:desc,orderBy:_key,otherBucket:!f,otherBucketLabel:Other,size:7),schema:group,type:terms)),params:(addLegend:!t,addTimeMarker:!f,addTooltip:!t,categoryAxes:!((id:CategoryAxis-1,labels:(filter:!f,rotate:75,show:!t,truncate:100),position:bottom,scale:(type:linear),show:!t,style:(),title:(),type:category)),grid:(categoryLines:!f),labels:(show:!f),legendPosition:right,seriesParams:!((data:(id:'1',label:%EC%8B%A4%ED%96%89%EA%B1%B4%EC%88%98),drawLinesBetweenPoints:!t,lineWidth:2,mode:stacked,show:!t,showCircles:!t,type:histogram,valueAxis:ValueAxis-1)),thresholdLine:(color:%23E7664C,show:!f,style:full,value:10,width:1),times:!(),type:histogram,valueAxes:!((id:ValueAxis-1,labels:(filter:!f,rotate:0,show:!t,truncate:100),name:LeftAxis-1,position:left,scale:(mode:normal,type:linear),show:!t,style:(),title:(text:%EC%8B%A4%ED%96%89%EA%B1%B4%EC%88%98),type:value))),title:execut_daily_stats,type:histogram))&_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:now-15m,to:now))&indexPattern=03b12f50-aec7-11ea-a1c8-d96a1e9bb41f&type=histogram))";
        var monthlyChartUrl = "http://192.168.0.40:5601/app/kibana#/visualize/edit/fd54f5f0-aec7-11ea-a1c8-d96a1e9bb41f?embed=true&_a=(filters:!(),linked:!f,query:(language:kuery,query:'@'),uiState:(),vis:(aggs:!((enabled:!t,id:'1',params:(customLabel:%EC%8B%A4%ED%96%89%EA%B1%B4%EC%88%98,field:cnt),schema:metric,type:sum),(enabled:!t,id:'2',params:(customLabel:%EB%85%84%EC%9B%94,field:stats_ym.keyword,missingBucket:!t,missingBucketLabel:Missing,order:asc,orderBy:_key,otherBucket:!f,otherBucketLabel:Other,size:12),schema:segment,type:terms),(enabled:!t,id:'3',params:(field:state.keyword,missingBucket:!t,missingBucketLabel:Missing,order:asc,orderBy:_key,otherBucket:!f,otherBucketLabel:Other,size:7),schema:group,type:terms)),params:(addLegend:!t,addTimeMarker:!f,addTooltip:!t,categoryAxes:!((id:CategoryAxis-1,labels:(filter:!f,rotate:75,show:!t,truncate:100),position:bottom,scale:(type:linear),show:!t,style:(),title:(),type:category)),grid:(categoryLines:!f),labels:(show:!f),legendPosition:right,seriesParams:!((data:(id:'1',label:%EC%8B%A4%ED%96%89%EA%B1%B4%EC%88%98),drawLinesBetweenPoints:!t,lineWidth:2,mode:stacked,show:!t,showCircles:!t,type:histogram,valueAxis:ValueAxis-1)),thresholdLine:(color:%23E7664C,show:!f,style:full,value:10,width:1),times:!(),type:histogram,valueAxes:!((id:ValueAxis-1,labels:(filter:!f,rotate:0,show:!t,truncate:100),name:LeftAxis-1,position:left,scale:(mode:normal,type:linear),show:!t,style:(),title:(text:%EC%8B%A4%ED%96%89%EA%B1%B4%EC%88%98),type:value))),title:execut_monthly_stats,type:histogram))&_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:now-15m,to:now))&indexPattern=ac62c320-aec7-11ea-a1c8-d96a1e9bb41f&type=histogram))";
	
		/*
		 * 페이지 초기화
		 * @param
		 * @return
		 */
		function pageInit() {

			//콤보박스 초기화
			initComboBox();
		};
		
        /*
         * 콤보박스 초기화
         * @param
         * @return
         */
		function initComboBox() {
			
			var beforeYearMonth = getYearMonth(-1);
			var year = beforeYearMonth.substring(0, 4);
			var month = beforeYearMonth.substring(4, 6);
			
			$("#cmbYear").val(year);
			$("#cmbMonth").val(month);

		}
        
	    /*
	     * 이벤트 바인딩
	     * @param
	     * @return
	     */
	    function bindEvent(){
	        
	    	//라디오 버튼 변경 이벤트 처리
	        $("input[id^=rdo]").on("change",function(){
	            if ($("#rdoMonth").is(":checked")) {
	                $("#cmbMonth").prop("disabled", true);
	            } else {
	                $("#cmbMonth").prop("disabled", false);
	            }
	        });
	        
	        //조회버튼 클릭 이벤트 처리
	        $("#btnSearch").on("click", function(){
	        	retrieveChart();
	        });
	        
	    }
	    
        /*
         * 차트 조회
         * @param
         * @return
         */
	    function retrieveChart() {
        	
        	var chartUrl = "";
        	
	    	if ($("#rdoMonth").is(":checked")) {
	    		
	    		var startYm = $("#cmbYear").val() + "01";
	    		var endYm = $("#cmbYear").val() + "12";
	    		var query = "stats_ym >= " + startYm + " and stats_ym <= " + endYm;
	    		query = encodeURIComponent(query);
	    		
	    		chartUrl = monthlyChartUrl.replace("@", query);

	    	} else {
	    		
	    		//해당월의 첫날짜와 마지막 날짜 구하기
	    		var startDe = $("#cmbYear").val() + $("#cmbMonth").val() + "01";
	    		var lastDate = (new Date(Number($("#cmbYear").val()), Number($("#cmbMonth").val()), 0));
	    		var lastMonth = lastDate.getMonth() + 1;
	    		if (Number(lastMonth) < Number(10)) {
	    			lastMonth = "0" + lastMonth;
	    		}
	    		var endDe = lastDate.getFullYear() + lastMonth + lastDate.getDate();
	    		var query = "stats_de >= " + startDe + " and stats_de <= " + endDe;
	    		query = encodeURIComponent(query);
	    		
	    		chartUrl = dailyChartUrl.replace("@", query);
	    	}

	    	$("#charDiv").children("iframe").remove();
	    	$("#charDiv").append('<iframe id="chartFrame" src="" style="width:100%;height:600px;border:0"></iframe>');
	    	$("#chartFrame").attr("src", chartUrl);
	    	
	    	//iframe resize 적용
	    	resizeIFrame();
	    }

        /*
         * iframe resize 적용
         * @param
         * @return
         */
        function resizeIFrame() {
			$("iframe").iFrameSizer({
			    autoResize: true,
			    bodyBackground: null,
			    bodyMargin: null,
			    bodyMarginV1: 0,
			    bodyPadding: null,
			    checkOrigin: true,
			    enablePublicMethods: false,
			    heightCalculationMethod: 'offset',
			    interval: 32,
			    log: false,
			    maxHeight: Infinity,
			    maxWidth: Infinity,
			    minHeight: 0,
			    minWidth: 0,
			    scrolling: false,
			    sizeHeight: true,
			    sizeWidth: false,
			    tolerance: 0,
			    closedCallback: function () { },
			    initCallback: function () { },
			    messageCallback: function () { },
			    resizedCallback: function () { },
			    callback: function (messageData) {
			      return true;
			    }
			});
        }

	</script>
</div>