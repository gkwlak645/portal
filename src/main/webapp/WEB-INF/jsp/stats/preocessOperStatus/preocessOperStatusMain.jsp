<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!--  템플릿 바디 -->
<div id="unmanagtErrorMainDiv" class="container-fluid wrap">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <form class="form-inline">                        
                        <div class="form-group col-md-12">
                             <div class="form-group col-md-9">                                               
                                <label for="usr" class="col-form-label col-sm-2">운영일자</label>                                                
                                <div class="col-sm-3"> 
                                    <div class="input-group date" id="startDeDiv" data-target-input="nearest" style="min-width:124px;margin: 0 0 0 3px;">
                                        <input type="text" id="startDe" name="startDe" class="form-control datetimepicker-input" data-target="#startDeDiv"/>
                                        <div class="input-group-append" data-target="#startDeDiv" data-toggle="datetimepicker">
                                            <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="col-sm-3">
                                    <div class="input-group date" id="endDeDiv" data-target-input="nearest" style="min-width:124px;margin: 0 0 0 3px;">
                                        <input type="text" id="endDe" name="endDe" class="form-control datetimepicker-input"  data-target="#endDeDiv"/>
                                        <div class="input-group-append" data-target="#endDeDiv" data-toggle="datetimepicker">
                                            <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="form-group col-sm-2 float-right">
                                    <button type="button" id="btnSearch" class="btn btn-info float-right">조회</button>
                                </div> 
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-body">
                    <div class="cus_table-wrap">
                        <h5 class="text-success float-left">⊙  프로세스 운영현황 </h5><br>
                        <table class="cus_table2" id="preocessOperDiv">
                            <colgroup>
                                <col style="width: 20%">
                                <col style="width: 9%">
                                <col style="width: 8%">
                                <col style="width: 9%">
                                <col style="width: 9%">
                                <col style="width: 11%">
                                <col style="width: 11%">
                                <col style="width: 11%">
                                <col>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th scope="col" rowspan="3">회사명</th>
                                    <th scope="col" rowspan="3">개발완료 프로세스</th>
                                    <th scope="col" rowspan="3">실행된 프로세스</th>
                                    <th scope="col" rowspan="3">프로세스 실행횟수</th>
                                    <th scope="col" rowspan="3">실행횟수</th>
                                    <th scope="col" colspan="4">트렌젝션</th>
                                </tr>
                                <tr>
                                    <th scope="col" colspan="2">조치</th>
                                    <th scope="col" ></th>
                                    <th scope="col" ></th>
                                </tr>
                                <tr>
                                    <th scope="col">조치횟수</th>
                                    <th scope="col">조치 프로세스수</th>
                                    <th scope="col">성공율</th>
                                    <th scope="col">목표(97%) 대비</th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                         </table>
                         <br>
                         
                        <h5 class="text-success float-left">⊙  최근 4주 주차별 성공율 추이</h5><br>
                         <div class="col-md-12 row" id="chart_div">
                             <div>
                                 <canvas id="lineChart" style="min-height: 750px; height: 200px; max-height: 200px; max-width: 100%; display: block; width: 411px;" width="411" height="200" class="chartjs-render-monitor"></canvas>
                             </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!--  템플릿 바디 끝 -->
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/1.0.2/Chart.min.js"></script> -->
<script src="https://www.gstatic.com/charts/loader.js"></script>
<script>
$(document.body).ready(function () {
	searchList();
});

function bindEvent(){
  //감섹영역 > 등록일자 > 시작일 
    $('#startDeDiv').datetimepicker({
        format: 'YYYY-MM-DD', defaultDate: getMonthGapDate(-1)
    });
  
  //감섹영역 > 등록일자 > 종료일
    $("#endDeDiv").datetimepicker({
	    format: 'YYYY-MM-DD', defaultDate: (new Date())
    });
  
    //검색
    $('#btnSearch').on('click', function() {
        searchList();
    });
}





function searchList(){
    var startDe = $("#startDe").val();
    var endDe = $("#endDe").val();
    
    if(startDe == null && startDe == ""){
    	
        $('#startDeDiv').datetimepicker({
            format: 'YYYY-MM-DD', defaultDate: getMonthGapDate(-1)
        });
      //감섹영역 > 등록일자 > 종료일
        $("#endDeDiv").datetimepicker({
            format: 'YYYY-MM-DD', defaultDate: (new Date())
        });
        startDe = $("#startDe").val();
        endDe = $("#endDe").val();
    }
    
    
    if(startDe > endDe ){
    	alert("시작일 / 종료일을 확인 하세요.");
    }else{
        var url = '/stats/preocessOperStatus/preocessOperStatusList';
        var param = {startDe:startDe, endDe:endDe }; 
        callAsyncAjax(url, param, "divDrawData");
    }

}


//page 그리기
function divDrawData(data){
	
	 var aResult = data.result.resultList
	 var totList = data.result.totList
	 var chartList = data.result.chartList
	 
	 $("#preocessOperDiv tbody tr").remove();
	 var str = "";
	 for(var j = 0; j < aResult.length ; j++){
		 str += '<tr>';
	     str += '  <th>'+aResult[j].cmpnyNm+'</th>';
	     str += '  <td>'+aResult[j].devCnt+'</td>';
	     str += '  <td>'+aResult[j].prcCnt+'</td>';
	     str += '  <td>'+aResult[j].prcRunCnt+'</td>';
	     str += '  <td>'+aResult[j].runCnt+'</td>';
	     str += '  <td>'+aResult[j].solCnt+'</td>';
	     str += '  <td>'+aResult[j].solPrcCnt+'</td>';
	     str += '  <td>'+aResult[j].sucPer+' %</td>';
	     str += '  <td>'+aResult[j].tgVs+' %</td>';
	     str += '</tr>';
	 }
     str += '<tr>';
     str += '  <th>합계</th>';
     str += '  <td>'+totList[0].devCnt+'</td>';
     str += '  <td>'+totList[0].prcCnt+'</td>';
     str += '  <td>'+totList[0].prcRunCnt+'</td>';
     str += '  <td>'+totList[0].runCnt+'</td>';
     str += '  <td>'+totList[0].solCnt+'</td>';
     str += '  <td>'+totList[0].solPrcCnt+'</td>';
     str += '  <td>'+totList[0].sucPer+' %</td>';
     str += '  <td>'+totList[0].tgVs+' %</td>';
     str += '</tr>';
	 
	 $("#preocessOperDiv tbody").append(str);
	 
	 
     google.charts.load('current', {'packages':['corechart']});
     google.charts.setOnLoadCallback(drawVisualization);

     function drawVisualization() {
       // Some raw data (not necessarily accurate)
       var data = google.visualization.arrayToDataTable([
    	   
         ['Month', 
        	   chartList[0].cmpnyNm
        	 , chartList[1].cmpnyNm
        	 , chartList[2].cmpnyNm
        	 , chartList[3].cmpnyNm
        	 , chartList[4].cmpnyNm
        	 , chartList[5].cmpnyNm
        	 , chartList[6].cmpnyNm
        	 , chartList[7].cmpnyNm
        	 , chartList[8].cmpnyNm
        	 ],
         ['1주',  
        	 chartList[0].wkSucPer
        	 , chartList[1].wkSucPer
        	 , chartList[2].wkSucPer
        	 , chartList[3].wkSucPer
        	 , chartList[4].wkSucPer
        	 , chartList[5].wkSucPer
        	 , chartList[6].wkSucPer
        	 , chartList[7].wkSucPer
        	 , chartList[8].wkSucPer
        	 ],
         ['2주',  
             chartList[0].wkSucPer
             , chartList[1].wwkSucPer
             , chartList[2].wwkSucPer
             , chartList[3].wwkSucPer
             , chartList[4].wwkSucPer
             , chartList[5].wwkSucPer
             , chartList[6].wwkSucPer
             , chartList[7].wwkSucPer
             , chartList[8].wwkSucPer
        	 ],
         ['3주',
             chartList[0].wwwkSucPer
             , chartList[1].wwwkSucPer
             , chartList[2].wwwkSucPer
             , chartList[3].wwwkSucPer
             , chartList[4].wwwkSucPer
             , chartList[5].wwwkSucPer
             , chartList[6].wwwkSucPer
             , chartList[7].wwwkSucPer
             , chartList[8].wwwkSucPer
        	 ],
         ['4주',  
             chartList[0].wwwwkSucPer
             , chartList[1].wwwwkSucPer
             , chartList[2].wwwwkSucPer
             , chartList[3].wwwwkSucPer
             , chartList[4].wwwwkSucPer
             , chartList[5].wwwwkSucPer
             , chartList[6].wwwwkSucPer
             , chartList[7].wwwwkSucPer
             , chartList[8].wwwwkSucPer
        	 ],
         
         
       ]);

       var options = {
         title : '최근 4주 주차별 성공률 추이',
//         vAxis: {title: 'Cups'},
//         hAxis: {title: 'Month'},
         seriesType: 'line',
         series: {}        };

       var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
       chart.draw(data, options);
     }	 
	 
	 
// chat 그리기	 
// 	    var data = {
// 	            labels: ["W1","W2","W3","W4"],
// 	            datasets: [
// 	                {
// 	                	label: chartList[0].cmpnyCd,
// 	                    fillColor: "rgba(220,220,220,0.2)",
// 	                    strokeColor: "rgba(220,220,220,1)",
// 	                    pointColor: "rgba(220,220,220,1)",
// 	                    pointStrokeColor: "#fff",
// 	                    pointHighlightFill: "#fff",
// 	                    pointHighlightStroke: "rgba(220,220,220,1)",
// 	                    data: [chartList[0].wkSucPer, chartList[0].wwkSucPer, chartList[0].wwwkSucPer, chartList[0].wwwkSucPer]
// 	                }
// 	                ,{
// 	                	label: chartList[1].cmpnyCd,
// 	                    fillColor: "rgba(151,187,205,0.2)",
// 	                    strokeColor: "rgba(151,187,205,1)",
// 	                    pointColor: "rgba(151,187,205,1)",
// 	                    pointStrokeColor: "#fff",
// 	                    pointHighlightFill: "#fff",
// 	                    pointHighlightStroke: "rgba(151,187,205,1)",
// 	                    data: [chartList[1].wkSucPer, chartList[1].wwkSucPer, chartList[1].wwwkSucPer, chartList[1].wwwkSucPer]
// 	                }
//                     ,{
//                     	label: chartList[2].cmpnyCd,
//                         fillColor: "rgba(151,187,205,0.2)",
//                         strokeColor: "rgba(151,187,205,1)",
//                         pointColor: "rgba(151,187,205,1)",
//                         pointStrokeColor: "#fff",
//                         pointHighlightFill: "#fff",
//                         pointHighlightStroke: "rgba(151,187,205,1)",
//                         data: [chartList[2].wkSucPer, chartList[2].wwkSucPer, chartList[2].wwwkSucPer, chartList[2].wwwkSucPer]
//                     }
//                     ,{
//                     	label: chartList[3].cmpnyCd,
//                         fillColor: "rgba(151,187,205,0.2)",
//                         strokeColor: "rgba(151,187,205,1)",
//                         pointColor: "rgba(151,187,205,1)",
//                         pointStrokeColor: "#fff",
//                         pointHighlightFill: "#fff",
//                         pointHighlightStroke: "rgba(151,187,205,1)",
//                         data: [chartList[3].wkSucPer, chartList[3].wwkSucPer, chartList[3].wwwkSucPer, chartList[3].wwwkSucPer]
//                     }
//                     ,{
//                         label: chartList[4].cmpnyCd,
//                         fillColor: "rgba(151,187,205,0.2)",
//                         strokeColor: "rgba(151,187,205,1)",
//                         pointColor: "rgba(151,187,205,1)",
//                         pointStrokeColor: "#fff",
//                         pointHighlightFill: "#fff",
//                         pointHighlightStroke: "rgba(151,187,205,1)",
//                         data: [chartList[4].wkSucPer, chartList[4].wwkSucPer, chartList[4].wwwkSucPer, chartList[4].wwwkSucPer]
//                     }
//                     ,{
//                         label: chartList[5].cmpnyCd,
//                         fillColor: "rgba(151,187,205,0.2)",
//                         strokeColor: "rgba(151,187,205,1)",
//                         pointColor: "rgba(151,187,205,1)",
//                         pointStrokeColor: "#fff",
//                         pointHighlightFill: "#fff",
//                         pointHighlightStroke: "rgba(151,187,205,1)",
//                         data: [chartList[5].wkSucPer, chartList[5].wwkSucPer, chartList[5].wwwkSucPer, chartList[5].wwwkSucPer]
//                     }
//                     ,{
//                         label: chartList[6].cmpnyCd,
//                         fillColor: "rgba(151,187,205,0.2)",
//                         strokeColor: "rgba(151,187,205,1)",
//                         pointColor: "rgba(151,187,205,1)",
//                         pointStrokeColor: "#fff",
//                         pointHighlightFill: "#fff",
//                         pointHighlightStroke: "rgba(151,187,205,1)",
//                         data: [chartList[6].wkSucPer, chartList[6].wwkSucPer, chartList[6].wwwkSucPer, chartList[6].wwwkSucPer]
//                     }
//                     ,{
//                         label: chartList[7].cmpnyCd,
//                         fillColor: "rgba(151,187,205,0.2)",
//                         strokeColor: "rgba(151,187,205,1)",
//                         pointColor: "rgba(151,187,205,1)",
//                         pointStrokeColor: "#fff",
//                         pointHighlightFill: "#fff",
//                         pointHighlightStroke: "rgba(151,187,205,1)",
//                         data: [chartList[7].wkSucPer, chartList[7].wwkSucPer, chartList[7].wwwkSucPer, chartList[7].wwwkSucPer]
//                     }
//                     ,{
//                         label: chartList[8].cmpnyCd,
//                         fillColor: "rgba(151,187,205,0.2)",
//                         strokeColor: "rgba(151,187,205,1)",
//                         pointColor: "rgba(151,187,205,1)",
//                         pointStrokeColor: "#fff",
//                         pointHighlightFill: "#fff",
//                         pointHighlightStroke: "rgba(151,187,205,1)",
//                         data: [chartList[8].wkSucPer, chartList[8].wwkSucPer, chartList[8].wwwkSucPer, chartList[8].wwwkSucPer]
//                     }
// 	            ]
// 	        };

// 	        var ctx = document.getElementById("lineChart").getContext("2d");
// 	        var options = { };
// 	        var lineChart = new Chart(ctx).Line(data, options);

	     // chat 그리기 END
	        
	 requestCmmnCd(params);
}




//--------------
//- AREA CHART -
//--------------

//Get context with jQuery - using jQuery's .get() method.
var areaChartCanvas = $('#areaChart').get(0).getContext('2d');

var areaChartData = {
labels  : ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
datasets: [
  {
    label               : 'Digital Goods',
    backgroundColor     : 'rgba(1,178,245,0.9)',
    borderColor         : 'rgba(1,178,245,0.8)',
    pointRadius          : false,
    pointColor          : '#f85f5f',
    pointStrokeColor    : 'rgba(1,178,245,1)',
    pointHighlightFill  : '#fff',
    pointHighlightStroke: 'rgba(0,101,189,1)',
    data                : [28, 48, 40, 19, 86, 27, 90]
  },
  {
    label               : 'Electronics',
    backgroundColor     : 'rgba(210, 214, 222, 1)',
    borderColor         : 'rgba(210, 214, 222, 1)',
    pointRadius         : false,
    pointColor          : 'rgba(210, 214, 222, 1)',
    pointStrokeColor    : '#c1c7d1',
    pointHighlightFill  : '#fff',
    pointHighlightStroke: 'rgba(220,220,220,1)',
    data                : [65, 59, 80, 81, 56, 55, 40]
  },
]
}

var areaChartOptions = {
maintainAspectRatio : false,
responsive : true,
legend: {
  display: false
},
scales: {
  xAxes: [{
    gridLines : {
      display : false,
    }
  }],
  yAxes: [{
    gridLines : {
      display : false,
    }
  }]
}
}

//This will get the first returned node in the jQuery collection.
var areaChart       = new Chart(areaChartCanvas, { 
  type: 'line',
  data: areaChartData, 
  options: areaChartOptions
})

//-------------
//- LINE CHART -
//--------------
var lineChartCanvas = $('#lineChart').get(0).getContext('2d');
var lineChartOptions = jQuery.extend(true, {}, areaChartOptions);
var lineChartData = jQuery.extend(true, {}, areaChartData);
lineChartData.datasets[0].fill = false;
lineChartData.datasets[1].fill = false;
lineChartOptions.datasetFill = false

var lineChart = new Chart(lineChartCanvas, { 
  type: 'line',
  data: lineChartData, 
  options: lineChartOptions
})








      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawVisualization);

      function drawVisualization() {
        // Some raw data (not necessarily accurate)
        var data = google.visualization.arrayToDataTable([
          ['Month', '회사명A', '회사명B', '회사명C', '회사명D'],
          ['1주',  165,      938,      614.6,      714.6],
          ['2주',  135,      1120,      682,      714.6],
          ['3주',  157,      1167,      623,      714.6],
          ['4주',  139,      1110,      609.4,      714.6],
        ]);

        var options = {
//          title : 'Monthly Coffee Production by Country',
//          vAxis: {title: 'Cups'},
//          hAxis: {title: 'Month'},
          seriesType: 'line',
          series: {}        };

        var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
















</script>

<script type="text/javascript" src="www.gstatic.com_charts_loader.js"></script>





