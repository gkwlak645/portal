<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>템플릿화면</title>
<!-- Tell the browser to be responsive to screen width -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<jsp:include page="/template/script.jsp"></jsp:include>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
    <div class="wrapper">
       <div id="header">
            <!-- Navbar -->
            <nav class="main-header navbar navbar-expand border-bottom-0 navbar-dark navbar-primary text-sm">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" data-widget="pushmenu" href="#" role="button">
                            <i class="fas fa-bars"></i>
                        </a>
                    </li>
                </ul>
                <ul class="navbar-nav ml-auto">
                    <!-- Messages Dropdown Menu -->
                    <li class="nav-item">
                        <a></a>
                    </li>  
                </ul>
            </nav>
            <!-- / Navbar -->
        </div>

        <jsp:include page="/template/menu.jsp"></jsp:include>

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Content Header (Page header) -->
            <div class="content-header">
                <!-- .container-fluid -->
                <div class="container-fluid">
                    <div class="row mb-0">
                        <div class="col-sm-6">
                            <h1 class="m-0 text-dark">프로세스 운영 현황</h1>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">통계 > 프로세스 운영 현황</li>
                            </ol>
                        </div>
                    </div>
                </div>
                <!-- /.container-fluid -->
            </div>
            <!-- /.content-header -->


            <!-- Main content -->
            <section class="content">
                <div id="content">
                
                
                
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
                        <table class="cus_table2">
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
                            <tbody>
                                 <tr>
                                     <th>동원1</th>
                                     <td>73</td>
                                     <td>44</td>
                                     <td>734</td>
                                     <td>1978</td>
                                     <td>165</td>
                                     <td>11</td>
                                     <td>91.70%</td>
                                     <td>-5.34%</td>
                                 </tr>
                                 <tr>
                                     <th>동원2</th>
                                     <td>73</td>
                                     <td>44</td>
                                     <td>734</td>
                                     <td>1978</td>
                                     <td>165</td>
                                     <td>11</td>
                                     <td>91.70%</td>
                                     <td>-5.34%</td>
                                 </tr>
                                 <tr>
                                     <th>동원3</th>
                                     <td>73</td>
                                     <td>44</td>
                                     <td>734</td>
                                     <td>1978</td>
                                     <td>165</td>
                                     <td>11</td>
                                     <td>91.70%</td>
                                     <td>-5.34%</td>
                                 </tr>
                                 <tr>
                                     <th>동원4</th>
                                     <td>73</td>
                                     <td>44</td>
                                     <td>734</td>
                                     <td>1978</td>
                                     <td>165</td>
                                     <td>11</td>
                                     <td>91.70%</td>
                                     <td>-5.34%</td>
                                 </tr>
                                 <tr>
                                     <th>동원5</th>
                                     <td>73</td>
                                     <td>44</td>
                                     <td>734</td>
                                     <td>1978</td>
                                     <td>165</td>
                                     <td>11</td>
                                     <td>91.70%</td>
                                     <td>-5.34%</td>
                                 </tr>
                                 <tr>
                                     <th>동원6</th>
                                     <td>73</td>
                                     <td>44</td>
                                     <td>734</td>
                                     <td>1978</td>
                                     <td>165</td>
                                     <td>11</td>
                                     <td>91.70%</td>
                                     <td>-5.34%</td>
                                 </tr>
                                 <tr>
                                     <th>합계</th>
                                     <td>73</td>
                                     <td>44</td>
                                     <td>734</td>
                                     <td>1978</td>
                                     <td>165</td>
                                     <td>11</td>
                                     <td>91.70%</td>
                                     <td>-5.34%</td>
                                 </tr>
                            </tbody>
                         </table>
                         <br>
                         
                        <h5 class="text-success float-left">⊙  최근 4주 주차별 성공율 추이</h5><br>
                         <div class="col-md-12 row">
                             <div class="form-group col-md-6 py-sm-2">
                                 <canvas id="lineChart" style="min-height: 250px; height: 200px; max-height: 200px; max-width: 100%; display: block; width: 411px;" width="411" height="200" class="chartjs-render-monitor"></canvas>
                             </div>
                             
                             <div class="form-group col-md-6 py-sm-2">
                                 <table class="table"  style="padding:0">
                                     <colgroup>
                                         <col width="40%">
                                         <col width="60%">                                                
                                     </colgroup>
                                     <thead>
                                         <tr>
                                             <th style="text-align:center; height:20px;">프로세스코드</th>
                                             <th style="text-align:center; height:20px;">프로세스명</th>
                                         </tr>
                                     </thead>
                                     <tbody>
                                         <tr>
                                             <th>A01000</th>
                                             <td>급식운영중단</td>
                                         </tr>
                                          <tr>
                                             <th>A01200</th>
                                             <td>매출속보</td>
                                         </tr>
                                          <tr>
                                             <th>A04200</th>
                                             <td>매출기표</td>
                                         </tr> 
                                     </tbody>   
                                 </table>
                             </div>
                          <br>
                         <h5 class="text-success float-left">⊙  프로세스 실행결과</h5><br>
                         <table class="table"  style="padding:0">
                             <colgroup>
                                 <col width="20%">
                                 <col width="20%"> 
                                 <col width="30%">
                                 <col>                                               
                             </colgroup>
                             <thead>
                                 <tr>
                                     <th style="text-align:center; height:20px;">프로세스코드</th>
                                     <th style="text-align:center; height:20px;">프로세스명</th>
                                     <th style="text-align:center; height:20px;">조치</th>
                                     <th style="text-align:center; height:20px;">원인</th>
                                 </tr>
                             </thead>
                             <tbody>
                                 <tr>
                                     <th>A01000</th>
                                     <td>급식운영중단</td>
                                     <td>소스수정</td>
                                     <td>태그명 변경됨</td>
                                 </tr>
                                  <tr>
                                     <th>A01200</th>
                                     <td>매출속보</td>
                                     <td>소스수정</td>
                                     <td>태그명 변경됨</td>
                                 </tr>
                                  <tr>
                                     <th>A04200</th>
                                     <td>매출기표</td>
                                     <td>소스수정</td>
                                     <td>태그명 변경됨</td>
                                 </tr> 
                             </tbody>   
                         </table>          
                    </div>                    
                </div>               
            </div>            
        </div>        
    </div>
</div>



<!--  템플릿 바디 끝 -->    

<script>
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


</script>



                    </div>
            </section>
            <!-- /.Main content -->
        </div>
        
        <div id="footer">
            <footer class="main-footer">Copyright &copy; 2020 <a href="http://www.echoit.co.kr">에코아이티</a>&nbsp;.&nbsp;All rights reserved.</footer>
        </div>
        
    </div>
</body>
</html>



