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
<title>템플릿화면ㅇ</title>
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
                            <h1 class="m-0 text-dark">Dashboard</h1>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">Dashboard</li>
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
                
<!-- MAIN TYPE1 -->
<div class="container-fluid" id="dashboard">
    <!-- Small boxes (Stat box) -->
    <div class="content row">
        <section class="col-lg-8">
            <div class="col-md-12" style="margin: 0; padding: 0;">
                <div class="card direct-chat direct-chat-warning" style="min-height: 240px;">
                    <div class="card-header">
                        <h3 class="card-title">RPA현황</h3>
                         <!-- 20201016 ja -  셋팅 팝업 버튼 추가 -->
                         <div class="card-tools">
                             <button type="button" class="btn btn-tool" title="Contacts" data-widget="chat-pane-toggle">
                                 <i class="fas fa-cog"></i>
                             </button>
                         </div>
                         <!-- // 20201016 ja -  셋팅 팝업 버튼 추가 -->
                    </div>
                    <div class="card-body">
                        <!-- 20201214 수정 -->
                        <div class="rpa_circle">
                            <div class="rpa_circle_wrap">
                                <div class="rpa_circle_item bg-navy">
                                    <div class="circle_innr">
                                        <i class="icon fas fa-2x fa-funnel-dollar"></i>
                                        <h6>ROI</h6>
                                        <h4>360,000</h4>
                                    </div>
                                </div>
                                <div class="radio_wrap">
                                    <div>
                                        <input type="radio" name="chkRoi" id="roiWeek" checked>
                                        <label for="roiWeek">Week</label>
                                    </div>
                                    <div>
                                        <input type="radio" name="chkRoi" id="roiMon">
                                        <label for="roiMon">Month</label>
                                    </div>
                                    <div>
                                        <input type="radio" name="chkRoi" id="roiYear">
                                        <label for="roiYear">Year</label>
                                    </div>
                                    <div class="text-secondary"style="font-size: 13px;">
                                        (단위: 천원)
                                    </div>
                                </div>
                                <div class="rpa_circle_item bg-danger">
                                    <div class="circle_innr">
                                        <i class="icon fas fa-2x fa-envelope"></i>
                                        <h6>프로세스</h6>
                                        <h4>57</h4>
                                    </div>
                                </div>
                                <div class="rpa_circle_item bg-success">
                                    <div class="circle_innr">
                                        <i class="icon fas fa-2x fa-robot"></i>
                                        <h6>봇수</h6>
                                        <h4>3</h4>
                                    </div>
                                </div>
                                <div class="rpa_circle_item bg-gray">
                                    <div class="circle_innr">
                                        <i class="icon fas fa-2x fa-thumbs-up"></i>
                                        <h6>성공률</h6>
                                        <h4>99<span>%</span></h4>
                                    </div>
                                </div>
                                <div class="rpa_circle_item">
                                    <div class="circle_innr">
                                        <i class="icon fas fa-2x fa-chart-bar"></i>
                                        <h6>절감률</h6>
                                        <h4>50<span>%</span></h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- //20201214 수정 -->
                        <!-- 20201016 ja -  셋팅 팝업 추가 -->
                        <div class="direct-chat-contacts custom-popup">
                            <div class="pop-wrap">
                                <ul class="pop-list">
                                    <li class="pop-list-item">테스트 텍스트</li>
                                    <li class="pop-list-item">테스트 텍스트</li>
                                    <li class="pop-list-item">테스트 텍스트</li>
                                    <li class="pop-list-item">테스트 텍스트</li>
                                    <li class="pop-list-item">테스트 텍스트</li>
                                    <li class="pop-list-item">테스트 텍스트</li>
                                    <li class="pop-list-item">테스트 텍스트</li>
                                    <li class="pop-list-item">테스트 텍스트</li>
                                </ul>
                            </div>
                        </div>
                        <!-- // 20201016 - ja 셋팅 팝업 추가 -->
                    </div>
                </div>
           </div>
            <div class="row">
                <div class="col-md-6"  style="padding-left:0;">
                    <!-- 나의 프로세스 -->
                    <div class="card direct-chat direct-chat-warning" style="min-height: 217px;">
                        <div class="card-header">
                            <h3 class="card-title">나의 프로세스</h3>
                            <!-- 20201016 ja -  셋팅 팝업 버튼 추가 -->
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" title="Contacts" data-widget="chat-pane-toggle">
                                    <i class="fas fa-cog"></i>
                                </button>
                            </div>
                            <!-- // 20201016 ja -  셋팅 팝업 버튼 추가 -->
                        </div>
                        <div class="card-body">
                            <div class="card-body-wrap">
                                <div class="row">
                                    <div class="col-md-4">
                                        <dl class="process">
                                            <dt style="color: #0065bd;">
                                                <i class="fas fa-tv"></i>
                                                <span>운영</span>
                                            </dt>
                                            <dd>000</dd>
                                        </dl>
                                    </div>
                                    <div class="col-md-4">
                                        <dl class="process process-line">
                                            <dt style="color: #01b2f5;">
                                                <i class="fas fa-tools"></i>
                                                <span>개발</span>
                                            </dt>
                                            <dd>000</dd>
                                        </dl>
                                    </div>
                                    <div class="col-md-4">
                                        <dl class="process">
                                            <dt style="color: #ffb3b3;">
                                                <i class="fas fa-lightbulb"></i>
                                                <span>아이디어</span>
                                            </dt>
                                            <dd>000</dd>
                                        </dl>
                                    </div>
                                </div>
                            </div>
                            <!-- 20201016 ja -  셋팅 팝업 추가 -->
                            <div class="direct-chat-contacts custom-popup">
                                <div class="pop-wrap">
                                    <ul class="pop-list">
                                        <li class="pop-list-item">테스트 텍스트</li>
                                        <li class="pop-list-item">테스트 텍스트</li>
                                        <li class="pop-list-item">테스트 텍스트</li>
                                        <li class="pop-list-item">테스트 텍스트</li>
                                        <li class="pop-list-item">테스트 텍스트</li>
                                        <li class="pop-list-item">테스트 텍스트</li>
                                        <li class="pop-list-item">테스트 텍스트</li>
                                        <li class="pop-list-item">테스트 텍스트</li>
                                    </ul>
                                </div>
                            </div>
                            <!-- // 20201016 - ja 셋팅 팝업 추가 -->
                        </div>
                    </div>
                    <!-- // 나의 프로세스 -->

                    <!-- Automation index -->
                    <div class="card direct-chat direct-chat-warning" style="min-height: 217px;">
                        <div class="card-header">
                            <h3 class="card-title">Automation index</h3>
                            <!-- 20201016 ja -  셋팅 팝업 버튼 추가 -->
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" title="Contacts" data-widget="chat-pane-toggle">
                                    <i class="fas fa-cog"></i>
                                </button>
                            </div>
                            <!-- // 20201016 ja -  셋팅 팝업 버튼 추가 -->
                        </div>
                        <div class="card-body">
                            <div class="card-body-wrap">
                                <div class="board_ty3">
                                    <div class="board">
                                        <i class="board-icon fas fa-clock"></i>
                                        <div class="board-text">
                                            <div class="board-tit">절감시간</div>
                                            <div class="board-point">
                                                <strong class="text-warning">560</strong>
                                                <span class="text-secondary"style="font-size: 13px;">H/年</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="board">
                                        <i class="board-icon fas fa-chart-pie"></i>
                                        <div class="board-text">
                                            <div class="board-tit">개선지수</div>
                                            <div class="board-point">
                                                <strong class="text-warning">2.1</strong>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- <div class="row">
                                    <div class="col-md-6" style="overflow: hidden;">
                                        <i class="fas fa-4x fa-clock float-left" style="color: grey;"></i>
                                        <div class="float-left">
                                            <h6>절감시간</h6>
                                            <div class="text-secondary"style="font-size: 13px;"><strong class="text-warning" style="margin-right: 4px; font-size: 25px;">560</strong>H/年</div>
                                        </div>
                                    </div>
                                    <div class="col-md-6" style="overflow: hidden;">
                                        <i class="fas fa-4x fa-chart-pie float-left" style="color: grey;"></i>
                                        <div class="float-left">
                                            <h6>개선지수</h6>
                                            <div><strong class="text-warning" style="font-size: 25px;">2.1</strong></div>
                                        </div>
                                    </div>
                                </div> -->
                            </div>
                            <!-- 20201016 ja -  셋팅 팝업 추가 -->
                            <div class="direct-chat-contacts custom-popup">
                                <div class="pop-wrap">
                                    <ul class="pop-list">
                                        <li class="pop-list-item">테스트 텍스트</li>
                                        <li class="pop-list-item">테스트 텍스트</li>
                                        <li class="pop-list-item">테스트 텍스트</li>
                                        <li class="pop-list-item">테스트 텍스트</li>
                                        <li class="pop-list-item">테스트 텍스트</li>
                                        <li class="pop-list-item">테스트 텍스트</li>
                                        <li class="pop-list-item">테스트 텍스트</li>
                                        <li class="pop-list-item">테스트 텍스트</li>
                                    </ul>
                                </div>
                            </div>
                            <!-- // 20201016 - ja 셋팅 팝업 추가 -->
                        </div>
                    </div>
                    <!-- // Automation index -->
                </div>

                <div class="col-md-6" style="padding-right:0;">
                    <!-- 게시판 헬프 데스크 -->
                    <div class="card direct-chat direct-chat-warning" style="height:217px;">
                        <div class="card-header">
                            <h3 class="card-title">게시/헬프데스크</h3>
                            <!-- 20201016 ja -  셋팅 팝업 버튼 추가 -->
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" title="Contacts" data-widget="chat-pane-toggle">
                                    <i class="fas fa-cog"></i>
                                </button>
                            </div>
                            <!-- // 20201016 ja -  셋팅 팝업 버튼 추가 -->
                        </div>
                        <div class="card-body">
                            <div class="card-body-wrap">
                                <div class="list_ty2">
                                    <div class="list-item">
                                        <div class="list-left">
                                            <div class="list-tit">오늘부터 성공률이 측정됩니다.</div>
                                        </div>
                                        <div class="list-right">
                                            <div class="text-secondary"style="font-size: 13px;">2019-04-24</div>
                                        </div>
                                    </div>
                                    <div class="list-item">
                                        <div class="list-left">
                                            <div class="list-tit">오늘부터 성공률이 측정됩니다.</div>
                                        </div>
                                        <div class="list-right">
                                            <div class="text-secondary"style="font-size: 13px;">2019-04-24</div>
                                        </div>
                                    </div>
                                    <div class="list-item">
                                        <div class="list-left">
                                            <div class="list-tit">월간보고를 준비해주세요</div>
                                        </div>
                                        <div class="list-right">
                                            <div class="text-secondary"style="font-size: 13px;">2019-04-24</div>
                                        </div>
                                    </div>
                                    <div class="list-item">
                                        <div class="list-left">
                                            <div class="list-tit">코드번호 F00101점검 부탁드립니다.</div>
                                        </div>
                                        <div class="list-right">
                                            <div class="text-secondary"style="font-size: 13px;">2019-04-24</div>
                                        </div>
                                    </div>
                                    <div class="list-item">
                                        <div class="list-left">
                                            <div class="list-tit">리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역</div>
                                        </div>
                                        <div class="list-right">
                                            <div class="text-secondary"style="font-size: 13px;">2019-04-24</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- 20201016 ja -  셋팅 팝업 추가 -->
                            <div class="direct-chat-contacts custom-popup">
                                <div class="pop-wrap">
                                    <ul class="pop-list">
                                        <li class="pop-list-item">오늘부터 성공률이 측정됩니다.</li>
                                        <li class="pop-list-item">월간보고를 준비해주세요</li>
                                        <li class="pop-list-item">코드번호 F00101점검 부탁드립니다.</li>
                                        <li class="pop-list-item">리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역</li>
                                    </ul>
                                </div>
                            </div>
                            <!-- // 20201016 - ja 셋팅 팝업 추가 -->
                        </div>
                    </div>
                    <!-- // 게시판 헬프 데스크 -->

                    <!-- 시스템작업공지 -->
                    <div class="card direct-chat direct-chat-warning" style="height: 217px;">
                        <div class="card-header">
                            <h3 class="card-title">시스템작업공지</h3>
                            <!-- 20201016 ja -  셋팅 팝업 버튼 추가 -->
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" title="Contacts" data-widget="chat-pane-toggle">
                                    <i class="fas fa-cog"></i>
                                </button>
                            </div>
                            <!-- // 20201016 ja -  셋팅 팝업 버튼 추가 -->
                        </div>
                        <div class="card-body">
                            <div class="card-body-wrap">
                                <div class="list_ty3">
                                    <div class="list-item">
                                        <div class="list-left">
                                            <div class="list-tit">리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역</div>
                                        </div>
                                        <div class="list-right">
                                            <span class="list-time text-secondary"  style="font-size: 13px;">2019-04-24 08:00 ~ 23:00</span>
                                            <span class="text-success" style="display: inline-block; width: 75px; text-align: center;">홈푸드</span>
                                        </div>
                                    </div>
                                    <div class="list-item">
                                        <div class="list-left">
                                            <div class="list-tit">리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역</div>
                                        </div>
                                        <div class="list-right">
                                            <span class="list-time text-secondary"  style="font-size: 13px;">2019-04-24 08:00 ~ 23:00</span>
                                            <span class="text-success" style="display: inline-block; width: 75px; text-align: center;">홈푸드</span>
                                        </div>
                                    </div>
                                    <div class="list-item">
                                        <div class="list-left">
                                            <div class="list-tit">리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역</div>
                                        </div>
                                        <div class="list-right">
                                            <span class="list-time text-secondary"  style="font-size: 13px;">2019-04-24 08:00 ~ 23:00</span>
                                            <span class="text-success" style="display: inline-block; width: 75px; text-align: center;">홈푸드</span>
                                        </div>
                                    </div>
                                    <div class="list-item">
                                        <div class="list-left">
                                            <div class="list-tit">리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역</div>
                                        </div>
                                        <div class="list-right">
                                            <span class="list-time text-secondary"  style="font-size: 13px;">2019-04-24 08:00 ~ 23:00</span>
                                            <span class="text-success" style="display: inline-block; width: 75px; text-align: center;">홈푸드</span>
                                        </div>
                                    </div>
                                    <div class="list-item">
                                        <div class="list-left">
                                            <div class="list-tit">리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역</div>
                                        </div>
                                        <div class="list-right">
                                            <span class="list-time text-secondary"  style="font-size: 13px;">2019-04-24 08:00 ~ 23:00</span>
                                            <span class="text-success" style="display: inline-block; width: 75px; text-align: center;">홈푸드</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- 20201016 ja -  셋팅 팝업 추가 -->
                            <div class="direct-chat-contacts custom-popup">
                                <div class="pop-wrap">
                                    <ul class="pop-list">
                                        <li class="pop-list-item">테스트 텍스트</li>
                                        <li class="pop-list-item">테스트 텍스트</li>
                                        <li class="pop-list-item">테스트 텍스트</li>
                                        <li class="pop-list-item">테스트 텍스트</li>
                                        <li class="pop-list-item">테스트 텍스트</li>
                                        <li class="pop-list-item">테스트 텍스트</li>
                                        <li class="pop-list-item">테스트 텍스트</li>
                                        <li class="pop-list-item">테스트 텍스트</li>
                                    </ul>
                                </div>
                            </div>
                            <!-- // 20201016 - ja 셋팅 팝업 추가 -->
                        </div>
                    </div>
                    <!-- // 시스템작업공지 -->
                </div>
            </div>
        </section>

        <section class="col-lg-4">
            <!-- 오늘의 작업일정 -->
            <div class="card direct-chat direct-chat-warning" style="height: 477px; max-width: 100%;">
                <div class="card-header">
                    <h3 class="card-title">오늘의 작업일정</h3>
                     <!-- 20201016 ja -  셋팅 팝업 버튼 추가 -->
                     <div class="card-tools">
                         <button type="button" class="btn btn-tool" title="Contacts" data-widget="chat-pane-toggle">
                             <i class="fas fa-cog"></i>
                         </button>
                     </div>
                     <!-- // 20201016 ja -  셋팅 팝업 버튼 추가 -->
                </div>
                <div class="card-body">
                    <div class="card-body-wrap">
                        <div class="list_ty4">
                            <div class="list-item">
                                <i class="list-icon fas fa-redo-alt" style="background-color: #0065bd;"></i>
                                <div class="list-left">
                                    <div class="list-tit">리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역</div>
                                    <div class="text-secondary"style="font-size: 13px;">2019-04-24 08:00:00</div>
                                </div>
                                <div class="list-right list-item">
                                    <div class="list-left" style="width: 60%">
                                        <div class="text-warning" style="font-size: 16px;">73%</div>
                                        <div class="list-tit text-secondary" style="font-size: 13px;">line 33 of 68 Delay</div>
                                    </div>
                                    <div class="list-right text-center" style="width: 40%; height: 3em; overflow: hidden;">user0123456789</div>
                                </div>
                            </div>
                            <div class="list-item">
                                <i class="list-icon fas fa-ban" style="background-color: #eb661a;"></i>
                                <div class="list-left">
                                    <div class="list-tit">리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역</div>
                                    <div class="text-secondary"style="font-size: 13px;">2019-04-24 08:00:00</div>
                                </div>
                                <div class="list-right list-item">
                                    <div class="list-left" style="width: 60%">
                                        <div class="text-warning" style="font-size: 16px;">73%</div>
                                        <div class="list-tit text-secondary" style="font-size: 13px;">line 33 of 68 Delay</div>
                                    </div>
                                    <div class="list-right text-center" style="width: 40%; height: 3em; overflow: hidden;">user01</div>
                                </div>
                            </div>
                            <div class="list-item">
                                <i class="list-icon fas fa-pause" style="color: #6c757d; background-color: #ddd;"></i>
                                <div class="list-left">
                                    <div class="list-tit">리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역</div>
                                    <div class="text-secondary"style="font-size: 13px;">2019-04-24 08:00:00</div>
                                </div>
                                <div class="list-right list-item">
                                    <div class="list-left" style="width: 60%">
                                        <div class="text-warning" style="font-size: 16px;">73%</div>
                                        <div class="list-tit text-secondary"style="font-size: 13px;">line 33 of 68 Delay</div>
                                    </div>
                                    <div class="list-right text-center" style="width: 40%; height: 3em; overflow: hidden;">user01</div>
                                </div>
                            </div>
                            <div class="list-item">
                                <i class="list-icon fas fa-redo-alt" style="background-color: #0065bd;"></i>
                                <div class="list-left">
                                    <div class="list-tit">리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역</div>
                                    <div class="text-secondary"style="font-size: 12px;">2019-04-24 08:00:00</div>
                                </div>
                                <div class="list-right list-item">
                                    <div class="list-left" style="width: 60%">
                                        <div class="text-warning" style="font-size: 16px;">73%</div>
                                        <div class="list-tit text-secondary"style="font-size: 13px;">line 33 of 68 Delay</div>
                                    </div>
                                    <div class="list-right text-center" style="width: 40%; height: 3em; overflow: hidden;">user01</div>
                                </div>
                            </div>
                            <div class="list-item">
                                <i class="list-icon fas fa-ban" style="background-color: #eb661a;"></i>
                                <div class="list-left">
                                    <div class="list-tit">리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역</div>
                                    <div class="text-secondary"style="font-size: 13px;">2019-04-24 08:00:00</div>
                                </div>
                                <div class="list-right list-item">
                                    <div class="list-left" style="width: 60%">
                                        <div class="text-warning" style="font-size: 16px;">73%</div>
                                        <div class="list-tit text-secondary"style="font-size: 13px;">line 33 of 68 Delay</div>
                                    </div>
                                    <div class="list-right text-center" style="width: 40%; height: 3em; overflow: hidden;">user01</div>
                                </div>
                            </div>
                            <div class="list-item">
                                <i class="list-icon fas fa-pause" style="color: #6c757d; background-color: #ddd;"></i>
                                <div class="list-left">
                                    <div class="list-tit">리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역</div>
                                    <div class="text-secondary"style="font-size: 13px;">2019-04-24 08:00:00</div>
                                </div>
                                <div class="list-right list-item">
                                    <div class="list-left" style="width: 60%">
                                        <div class="text-warning" style="font-size: 16px;">73%</div>
                                        <div class="list-tit text-secondary"style="font-size: 13px;">line 33 of 68 Delay</div>
                                    </div>
                                    <div class="list-right text-center" style="width: 40%; height: 3em; overflow: hidden;">user01</div>
                                </div>
                            </div>
                            <div class="list-item">
                                <i class="list-icon fas fa-pause" style="color: #6c757d; background-color: #ddd;"></i>
                                <div class="list-left">
                                    <div class="list-tit">리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역</div>
                                    <div class="text-secondary"style="font-size: 13px;">2019-04-24 08:00:00</div>
                                </div>
                                <div class="list-right list-item">
                                    <div class="list-left" style="width: 60%">
                                        <div class="text-warning" style="font-size: 16px;">73%</div>
                                        <div class="list-tit text-secondary"style="font-size: 13px;">line 33 of 68 Delay</div>
                                    </div>
                                    <div class="list-right text-center" style="width: 40%; height: 3em; overflow: hidden;">user01</div>
                                </div>
                            </div>
                            <div class="list-item">
                                <i class="list-icon fas fa-pause" style="color: #6c757d; background-color: #ddd;"></i>
                                <div class="list-left">
                                    <div class="list-tit">리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역</div>
                                    <div class="text-secondary"style="font-size: 13px;">2019-04-24 08:00:00</div>
                                </div>
                                <div class="list-right list-item">
                                    <div class="list-left" style="width: 60%">
                                        <div class="text-warning" style="font-size: 16px;">73%</div>
                                        <div class="list-tit text-secondary"style="font-size: 13px;">line 33 of 68 Delay</div>
                                    </div>
                                    <div class="list-right text-center" style="width: 40%; height: 3em; overflow: hidden;">user01</div>
                                </div>
                            </div>
                            
                             <div class="list-item">
                                <i class="list-icon fas fa-pause" style="color: #6c757d; background-color: #ddd;"></i>
                                <div class="list-left">
                                    <div class="list-tit">리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역리스트타이틀영역</div>
                                    <div class="text-secondary"style="font-size: 13px;">2019-04-24 08:00:00</div>
                                </div>
                                <div class="list-right list-item">
                                    <div class="list-left" style="width: 60%">
                                        <div class="text-warning" style="font-size: 16px;">73%</div>
                                        <div class="list-tit text-secondary"style="font-size: 13px;">line 33 of 68 Delay</div>
                                    </div>
                                    <div class="list-right text-center" style="width: 40%; height: 3em; overflow: hidden;">user01</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 20201016 ja -  셋팅 팝업 추가 -->
                    <div class="direct-chat-contacts custom-popup">
                        <div class="pop-wrap">
                            <ul class="pop-list">
                                <li class="pop-list-item">테스트 텍스트</li>
                                <li class="pop-list-item">테스트 텍스트</li>
                                <li class="pop-list-item">테스트 텍스트</li>
                                <li class="pop-list-item">테스트 텍스트</li>
                                <li class="pop-list-item">테스트 텍스트</li>
                                <li class="pop-list-item">테스트 텍스트</li>
                                <li class="pop-list-item">테스트 텍스트</li>
                                <li class="pop-list-item">테스트 텍스트</li>
                            </ul>
                        </div>
                    </div>
                    <!-- // 20201016 - ja 셋팅 팝업 추가 -->
                </div>
            </div>
            <!-- // 오늘의 작업일정 -->

            <!-- 실행결과 -->
            <div class="card direct-chat direct-chat-warning" style="height: 217px; max-width: 100%;">
                <!-- card-header -->
                <div class="card-header">
                    <h3 class="card-title">실행결과</h3>
                    <!-- 20201016 ja -  셋팅 팝업 버튼 추가 -->
                    <div class="card-tools">
                        <button type="button" class="btn btn-tool" title="Contacts" data-widget="chat-pane-toggle">
                            <i class="fas fa-cog"></i>
                        </button>
                    </div>
                    <!-- // 20201016 ja -  셋팅 팝업 버튼 추가 -->
                </div>
                <!-- /card-header -->
                <!-- card-body -->
                <div class="card-body" style="padding: 0;">
                    <div class="stepbox">
                        <div class="stepbox-item step_succ">
                            <strong class="step-txt">성공</strong>
                            <i class="step-icon fas fa-2x fa-redo-alt" style="background-color: #0065bd;"></i>
                            <span  class="step-num">12</span>
                        </div>
                        <div class="stepbox-item step_fals">
                            <strong class="step-txt">실패</strong>
                            <i class="step-icon fas fa-2x fa-ban" style="background-color: #eb661a;"></i>
                            <span  class="step-num">12</span>
                        </div>
                        <div class="stepbox-item step_hold">
                            <strong class="step-txt">보류</strong>
                            <i class="step-icon fas fa-2x fa-pause" style="background-color: grey;"></i>
                            <span  class="step-num">12</span>
                        </div>
                    </div>
                     <!-- 20201016 ja -  셋팅 팝업 추가 -->
                     <div class="direct-chat-contacts custom-popup">
                         <div class="pop-wrap">
                             <ul class="pop-list">
                                 <li class="pop-list-item">테스트텍스트테스트텍스트테스트텍스트테스트텍스트테스트텍스트테스트텍스트테스트텍스트테스트텍스트테스트텍스트테스트텍스트테스트텍스트테스트텍스트테스트텍스트테스트텍스트</li>
                                 <li class="pop-list-item">트텍스트테스트텍스트테스트텍스트</li>
                                 <li class="pop-list-item">테스트텍스트테스트텍스트테스트텍스트테스트텍스트테스트텍스트테스트텍스트테스트텍스트테스트텍스트테스트텍스트테스트텍스트테스트텍스트테스트텍스트테스트텍스트테스트텍스트</li>
                             </ul>
                         </div>
                     </div>
                     <!-- // 20201016 - ja 셋팅 팝업 추가 -->
                </div>
                <!-- /card-body -->
            </div>
            <!-- 실행결과 -->
            
        </section>
    </div>
</div>
<!-- // MAIN TYPE1 -->



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



