<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="container-fluid">
    <!-- Small boxes (Stat box) -->
    <div class="content row">
        <section class="col-lg-8 connectedSortable" >
    
            <div class="col-md-12" style="margin:0;padding:0;">
                <div class=card>
	                <div class="card-body" style="height: 250px;">
	                <h3 class="card-title">
	                        <i class="fas fa-chart-pie mr-1"></i>RPA현황2
	                    </h3>
			            <!-- small box 
			            <div class="col-lg-4 col-6">
				            <div class="small-box bg-navy">
				                <div class="inner">                  
				                    <h5>ROI</h5>
				                    <h2>98,881<span>천원</span></h2>
				                </div>  
				            </div>
				        </div>
				        <div class="col-lg-4 col-6">
				            <div class="small-box bg-danger">
				                <div class="inner">
				                    <h5>사용율</h5>
				                    <h2>10.1<span>%</span></h2>
				                </div>  
				            </div>
				        </div>
				        <div class="col-lg-4 col-6">
				            <div class="small-box bg-success">
				                <div class="inner">
				                    <h5>성공율</h5>
				                    <h2>74.5<span>%</span></h2>
				                </div>  
				            </div>
				        </div>
				        <div class="col-lg-4 col-6">
				            <div class="small-box bg-gray">
				                <div class="inner">
				                    <h5>진행과제</h5>
				                    <h2>10<span>건</span></h2>
				                </div>  
				            </div>
				        </div>-->
				    </div>
				</div>
	       </div><!-- /.card-body --> 
	       
	       <div class="row" >
		          <div class="col-md-6"  style="padding-left:0;">
		             <div class=card>
		              <div class="card-body"  style="height: 230px;">
		                <h3 class="card-title">
		                        <i class="fas fa-chart-pie mr-1"></i>나의 프로세스
                        </h3>
                       </div>
                     </div>  
                  </div>
               
                  <div class="col-md-6" style="padding-right:0;">
                     <div class=card>
                      <div class="card-body"  style="height: 230px;">
                        <h3 class="card-title">
                                <i class="fas fa-chart-pie mr-1"></i>게시/헬프데스크
                        </h3>
                       </div>
                     </div>  
                  </div>
            </div>
            <div class="row" >
                  <div class="col-md-6"  style="padding-left:0;">
                     <div class=card>
                      <div class="card-body"  style="height: 230px;">
                        <h3 class="card-title">
                                <i class="fas fa-chart-pie mr-1"></i>Automation index
                        </h3>
                       </div>
                     </div>  
                  </div>
               
                  <div class="col-md-6" style="padding-right:0;">
                     <div class=card>
                      <div class="card-body"  style="height: 230px;">
                        <h3 class="card-title">
                                <i class="fas fa-chart-pie mr-1"></i>시스템작업공지
                        </h3>
                       </div>
                     </div>  
                  </div>
            </div>
	    </section>            
         
        <section class="col-lg-4 connectedSortable">
    
            <!-- TO DO List -->
            <div class="card"  style="height: 496px;  max-width: 100%;">
                <div class="card-header">
                    <h3 class="card-title">
                        <i class="fas fa-chart-pie mr-1"></i>오늘의 작업일정
                    </h3>
                   <canvas id="barChart"></canvas>
                   
                </div><!-- /.card-header -->
                <div class="card-body">
                
              </div>
            </div>
            <div class="card"  style="height: 230px; max-width: 100%;">
                <div class="card-header">
                    <h3 class="card-title">
                        <i class="fas fa-chart-pie mr-1"></i>실행결과
                    </h3>
                     <canvas id="donutChart"></canvas>
                   
                </div><!-- /.card-header -->
                <div class="card-body">
                    <div class="tab-content p-0">
                     
                    </div>
                </div><!-- /.card-body -->
            </div>
            <!-- TO DO List -->      
        </section>
    </div>
</div>

<script>
//--------------
//- AREA CHART -
//--------------

// Get context with jQuery - using jQuery's .get() method.
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

// This will get the first returned node in the jQuery collection.
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

//-------------
//- DONUT CHART -
//-------------
// Get context with jQuery - using jQuery's .get() method.
var donutChartCanvas = $('#donutChart').get(0).getContext('2d');
var donutData        = {
  labels: [
      'Chrome', 
      'IE',
      'FireFox', 
      'Safari', 
      'Opera', 
      'Navigator', 
  ],
  datasets: [
    {
      data: [700,500,400,600,300,100],
      backgroundColor : ['#01b2f5', '#ffb3b3', '#f85f5f', '#0065bd', '#f8915f', '#919191'],
    }
  ]
}
var donutOptions     = {
  maintainAspectRatio : false,
  responsive : true,
}
//Create pie or douhnut chart
// You can switch between pie and douhnut using the method below.
var donutChart = new Chart(donutChartCanvas, {
  type: 'doughnut',
  data: donutData,
  options: donutOptions      
})

//-------------
//- PIE CHART -
//-------------
// Get context with jQuery - using jQuery's .get() method.
/* var pieChartCanvas = $('#pieChart').get(0).getContext('2d') */
var pieData        = donutData;
var pieOptions     = {
  maintainAspectRatio : false,
  responsive : true,
}
//Create pie or douhnut chart
// You can switch between pie and douhnut using the method below.
/* var pieChart = new Chart(pieChartCanvas, {
  type: 'pie',
  data: pieData,
  options: pieOptions      
}) */

//-------------
//- BAR CHART -
//-------------
var barChartCanvas = $('#barChart').get(0).getContext('2d')
var barChartData = jQuery.extend(true, {}, areaChartData)
var temp0 = areaChartData.datasets[0]
var temp1 = areaChartData.datasets[1]
barChartData.datasets[0] = temp1
barChartData.datasets[1] = temp0

var barChartOptions = {
  responsive              : true,
  maintainAspectRatio     : false,
  datasetFill             : false
}

var barChart = new Chart(barChartCanvas, {
  type: 'bar', 
  data: barChartData,
  options: barChartOptions
})

//---------------------
//- STACKED BAR CHART -
//---------------------
//var stackedBarChartCanvas = $('#stackedBarChart').get(0).getContext('2d')
var stackedBarChartData = jQuery.extend(true, {}, barChartData)

var stackedBarChartOptions = {
  responsive              : true,
  maintainAspectRatio     : false,
  scales: {
    xAxes: [{
      stacked: true,
    }],
    yAxes: [{
      stacked: true
    }]
  }
}

/* var stackedBarChart = new Chart(stackedBarChartCanvas, {
  type: 'bar', 
  data: stackedBarChartData,
  options: stackedBarChartOptions
}); */
</script>