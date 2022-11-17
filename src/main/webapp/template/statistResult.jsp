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
                            <h1 class="m-0 text-dark">계획대비 실적 현황</h1>
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
                        <div class="form-group col-md-12">
	                        <input type="radio" name="chkPer" id="periYear" value="package" checked>당월 &nbsp;&nbsp;&nbsp;
	                        <input type="radio" name="chkPer" id="periSum" value="library">누계
                        </div>
                        <div class="form-group col-md-12">
                            <label class="col-form-label col-sm-2">기간</label>
                            <div class="col-sm-10 row float-left">
                                <select class="form-control cus_dataing-year" style="min-width:80px;width:17%;margin-right:5px;">
                                          <option value="">2020</option>
                                </select>년 &nbsp;&nbsp;&nbsp;
                                
                                <select class="form-control cus_dataing-month" style="min-width:60px;width:15%;margin-right:5px;">
                                    <option value="">00</option>
                                </select>월    &nbsp;&nbsp;
                                <button type="button" id="btnSearch" class="btn btn-info">조회</button>                             
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
	                            <col style="width: 15%">
	                            <col style="width: 15%">
                                <col style="width: 12%">
	                            <col style="width: 7%" >
	                            <col style="width: 7%">
	                            <col style="width: 7%" >
                                <col style="width: 7%">
	                            <col style="width: 7%">
	                            <col style="width: 7%">
	                            <col>
	                        </colgroup>
	                        <thead>
                                <tr>
                                    <th scope="col" rowspan="4" colspan="2">구분</th>
                                    <th scope="col" rowspan="4">2020년 연간목표</th>
                                    <th scope="col" colspan="8">7월 당월</th>
                                </tr>
	                            <tr>
                                    <th scope="col" rowspan="3">계획</th>
                                    <th scope="col" colspan="5">전망</th>
                                    <th scope="col" rowspan="3">차이</th>
                                    <th scope="col" rowspan="3">달성률</th>
	                            </tr>
                                <tr>
                                    <th scope="col" rowspan="2">합계</th>
                                    <th scope="col" rowspan="2">PI</th>
                                    <th scope="col" colspan="3">RPA</th>
                                </tr>
                                <tr>
                                    <th scope="col">합계</th>
                                    <th scope="col">상근</th>
                                    <th scope="col">파워유저</th>
                                </tr>
	                        </thead>
	                        <tbody>
	                             <tr>
	                                 <th rowspan="3">동원동원동원동원</th>
	                                 <th scope="row">과제개수</th>
                                     <th>400</th>
                                     <td>40</td>
                                     <td>40</td>
                                     <td>40</td>
                                     <td>40</td>
                                     <td>40</td>
                                     <td>40</td>
                                     <td>40</td>
                                     <td>110%</td>
	                             </tr>
                                 <tr>
                                     <th scope="row">절감시간</th>
                                     <th>400</th>
                                     <td>40</td>
                                     <td>40</td>
                                     <td>40</td>
                                     <td>40</td>
                                     <td>40</td>
                                     <td>40</td>
                                     <td>40</td>
                                     <td>110%</td>
                                 </tr>
                                 <tr>
                                     <th scope="row">과제당 절감시간</th>
                                     <th></th>
                                     <td></td>
                                     <td></td>
                                     <td></td>
                                     <td></td>
                                     <td></td>
                                     <td></td>
                                     <td></td>
                                     <td></td>
                                 </tr>
	                        </tbody>
	                     </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<script>

//일일미조치_오류_일련번호

$(document.body).ready(function () { 
});

    /*
     * 페이지 초기화
     * @param
     * @return
     */
    function pageInit() {
        //그리드 초기화
        drawGrid();
        
        $("#btnSave").on('click', function(){
            unManagtErrorReg();
        });

    };
    
    /*
     * 그리드 초기화
     * @param
     * @return
     */
    function drawGrid(data){

        var params = new Array();

        for(var i = 0 ; i < 10 ; i++){
            params[i] = {
                    'unmanagtSn' : 30,
                    'errorCn' : '법인카드 매출전표 정산',
                    'cmpnyNm' : '동원',
                    'occrrncSeNm' : '업무혁신팀',
                    'tyNm' : '홍길동',
                    'unmanagtDe' : '20200714',
                    'processSn' : '등록',
                    'managtTyNm' : '대상'
            };
        }
        
        $("#unmanagtErrorGrid").jsGrid({
              height : "auto"
            , width : "100%"
            , autoload: true
            , sorting : true
            , align : "center"
            , data : params
            , rowClick: function(arg){
                unManagtErrorDetail();
            }
            , fields : [
                  {name: "unmanagtSn"         , title : "등록번호"       , type : "text"    , width : 40, align : "center"} 
                , {name: "errorCn"            , title : "제목"          , type : "text"   }
                , {name: "cmpnyNm"         , title : "등록회사"       , type : "text"    , width : 40, align : "center"}
                , {name: "occrrncSeNm"        , title : "등록부서"    , type : "text"    , width : 70, align : "center"}
                , {name: "tyNm"               , title : "등록자"       , type : "text"    , width : 50, align : "center"}
                , {name: "unmanagtDe"          , title : "등록일"    , type : "text"    , width : 50, align : "center"}
                , {name: "processSn"            , title : "진행상태"       , type : "text"    , width : 40, align : "center"}
                , {name: "managtTyNm"         , title : "검토대상"        , type : "text"    , width : 40, align : "center"}
            ]
        });
        
    }

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



