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
                            <h1 class="m-0 text-dark">실적계획 입력</h1>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">통계 > 실적계획 입력</li>
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
                        <div class="form-group col-md-6">
                            <label class="col-sm-2 col-form-label">회사</label>
                            <div class="col-sm-10">
                               <select class="form-control" style="width:60%;">
                                    <option></option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-md-6">
                             <label class="col-sm-2 col-form-label">날짜</label>
                             <div class="col-sm-10">
                                <select class="form-control cus_dataing-year" style="margin-right:5px;min-width:74px;width:25%">
                                     <option value="">2020</option>
                                 </select>년 &nbsp; 
                                 <select class="form-control cus_dataing-month" style="margin-right:5px;min-width:58px;width:20%">
                                     <option value="">00</option>
                                 </select>월 
                                 <button type="button" id="btnSearch" class="btn btn-info">검색</button>
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
	                    <table class="cus_table">
	                        <colgroup>
	                            <col style="width: 3%">
	                            <col style="width: *">
                                <col style="width: 4%">
                                <col style="width: 3.8%;">
                                <col style="width: 3.8%">
                                <col style="width: 3.8%">
                                <col style="width: 3.8%">
                                <col style="width: 3.8%">
                                <col style="width: 3.8%">
                                <col style="width: 3.8%">
                                <col style="width: 3.8%">
                                <col style="width: 3.8%">
                                <col style="width: 3.8%">
                                <col style="width: 3.8%">
                                <col style="width: 3.8%">
                                <col style="width: 3.8%">
                                <col style="width: 3.8%">
                                <col style="width: 3.8%">
                                <col style="width: 3.8%">
                                <col style="width: 3.8%">
                                <col style="width: 3.8%">
                                <col style="width: 3.8%">
                                <col style="width: 3.8%">
                                <col style="width: 3.8%">
                                <col style="width: 3.8%">
                                <col style="width: 3.8%">
                                <col style="width: 3.8%">
	                        </colgroup>
	                        <thead>
	                            <tr>
	                                <th scope="col" rowspan="2" colspan="2">구분</th>
                                    <th scope="col" rowspan="2"style="min-width:90px;">2020년<br>연간목표</th>
                                    <th scope="col" colspan="2">1월</th>
                                    <th scope="col" colspan="2">2월</th>
                                    <th scope="col" colspan="2">3월</th>
                                    <th scope="col" colspan="2">4월</th>
                                    <th scope="col" colspan="2">5월</th>
                                    <th scope="col" colspan="2">6월</th>
                                    <th scope="col" colspan="2">7월</th>
                                    <th scope="col" colspan="2">8월</th>
                                    <th scope="col" colspan="2">9월</th>
                                    <th scope="col" colspan="2">10월</th>
                                    <th scope="col" colspan="2">11월</th>
                                    <th scope="col" colspan="2">12월</th>
	                            </tr>
                                <tr>
                                    <th scope="col"style="min-width:74px;">과제계획</th>
                                    <th scope="col"style="min-width:74px;">PI</th>
                                    <th scope="col"style="min-width:74px;">과제계획</th>
                                    <th scope="col"style="min-width:74px;">PI</th>
                                    <th scope="col"style="min-width:74px;">과제계획</th>
                                    <th scope="col"style="min-width:74px;">PI</th>
                                    <th scope="col"style="min-width:74px;">과제계획</th>
                                    <th scope="col"style="min-width:74px;">PI</th>
                                    <th scope="col"style="min-width:74px;">과제계획</th>
                                    <th scope="col"style="min-width:74px;">PI</th>
                                    <th scope="col"style="min-width:74px;">과제계획</th>
                                    <th scope="col"style="min-width:74px;">PI</th>
                                    <th scope="col"style="min-width:74px;">과제계획</th>
                                    <th scope="col"style="min-width:74px;">PI</th>
                                    <th scope="col"style="min-width:74px;">과제계획</th>
                                    <th scope="col"style="min-width:74px;">PI</th>
                                    <th scope="col"style="min-width:74px;">과제계획</th>
                                    <th scope="col"style="min-width:74px;">PI</th>
                                    <th scope="col"style="min-width:74px;">과제계획</th>
                                    <th scope="col"style="min-width:74px;">PI</th>
                                    <th scope="col"style="min-width:74px;">과제계획</th>
                                    <th scope="col"style="min-width:74px;">PI</th>
                                    <th scope="col"style="min-width:74px;">과제계획</th>
                                    <th scope="col"style="min-width:74px;">PI</th>
                                </tr>
	                        </thead>
	                        <tbody>
	                            <tr>
	                                <th scope="row" rowspan="3"style="min-width:90px;">회사명</th>
                                    <th style="min-width:70px;">과제개수</th>
                                    <td><input type="text" class="form-control"  value="100"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
	                            </tr>
                                <tr>
                                    <th scope="row">절감시간</th>
                                    <td><input type="text" class="form-control"  value="20000"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
                                </tr>
                                <tr>
                                    <th scope="row">과제당 절감시간</th>
                                    <td><input type="text" class="form-control"  value="5000"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
                                    <td><input type="text" class="form-control"  value="56"></td>
                                    <td><input type="text" class="form-control"  value="10"></td>
                                </tr>
	                        </tbody>
	                     </table>
                    </div>
                    <div class="float-right">
                        <button type="button" class="btn btn-primary" id="runtimeRegister">저장</button>
                    </div>
                </div>               
            </div>            
        </div>        
    </div>
</div>


<script>

var valueCheckYear = $('#periYear').is(':checked'); // 연도별 체크 여부
var valueCheckMonth = $('#periMoth').is(':checked'); // 월별 체크 여부

//check 초기화 
function radioReset(){
	$('input:radio[name=chkPer]').removeAttr('checked');
	$('.cus_dataing > select').removeAttr('readonly');
}

// test 
function sortTest(){
    console.log('year: ' + valueCheckYear);
    console.log('month: ' + valueCheckMonth);	
};

// 연도별
$('#periYear').on('click', function() {
	radioReset();
    $(".periYear").attr('checked', true);
    if(valueCheckYear == true) {
        $('.cus_dataing-month').attr('readonly', true); // 비활성화
    } else {
        $('.cus_dataing-month').attr('readonly', false); // 활성화
    }
});

//월별
$('#periMoth').on('click', function() {
	radioReset();
 $(".periMoth").attr('checked', true);
 if(valueCheckYear == true) {
     $('.cus_dataing-year').attr('readonly', true); // 비활성화
 } else {
     $('.cus_dataing-year').attr('readonly', false); // 활성화
 }  
});

</script>


<!--  템플릿 바디 끝 -->    





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



