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
                <!-- 부분별 프로세스 현황 -->
                <div class="card direct-chat direct-chat-warning" style="min-height: 240px;">
                    <div class="card-header">
                        <h3 class="card-title">부분별 프로세스 현황</h3>
                         <!-- 20201016 ja -  셋팅 팝업 버튼 추가 -->
                         <div class="card-tools">
                             <button type="button" class="btn btn-tool" title="Contacts" data-widget="chat-pane-toggle">
                                 <i class="fas fa-cog"></i>
                             </button>
                         </div>
                         <!-- // 20201016 ja -  셋팅 팝업 버튼 추가 -->
                    </div>
                    <div class="card-body">
                        <div class="form-group board_ty1">
                        <div class="board-wrap">
                            <div class="board">
                                <div class="circle_ty1">
                                    <div class="circle">00</div>
                                    <div class="text-corn">영업</div>
                                </div>
                                <div class="circle_ty1">
                                    <div class="circle">00</div>
                                    <div class="text-corn">영업</div>
                                </div>
                                <div class="circle_ty1">
                                    <div class="circle">00</div>
                                    <div class="text-corn">영업</div>
                                </div>
                                <div class="circle_ty1">
                                    <div class="circle">00</div>
                                    <div class="text-corn">영업</div>
                                </div>
                            </div>
                             <div class="board">
                                <div class="circle_ty1">
                                    <div class="circle">00</div>
                                    <div class="text-corn">영업</div>
                                </div>
                                <div class="circle_ty1">
                                    <div class="circle">00</div>
                                    <div class="text-corn">영업</div>
                                </div>
                                <div class="circle_ty1">
                                    <div class="circle">00</div>
                                    <div class="text-corn">영업</div>
                                </div>
                                <div class="circle_ty1">
                                    <div class="circle circle-color1">00</div>
                                    <div class="text-corn2">영업</div>
                                </div>
                            </div>
                        </div>
                        <div class="board-score">프로세스<strong>59</strong>
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
           </div>
            <div class="row">
                <div class="col-md-6"  style="padding-left:0;">
                    <!-- 나의 프로세스 -->
                    <div class="card direct-chat direct-chat-warning" style="min-height: 217px;">
                        <div class="card-header">
                            <h3 class="card-title">명예의 전당(절감시간)</h3>
                            <!-- 20201016 ja -  셋팅 팝업 버튼 추가 -->
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" title="Contacts" data-widget="chat-pane-toggle">
                                    <i class="fas fa-cog"></i>
                                </button>
                            </div>
                            <!-- // 20201016 ja -  셋팅 팝업 버튼 추가 -->
                        </div>
                        <div class="card-body">
                            <div class="card-body-wrap" style="padding-top:7px;">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="list_ty5">
                                            <div class="list-item">
                                                <div class="list-left">
                                                    <i class="fas fa-trophy" style="color: #eb661a;"></i>
                                                    <span style="padding: 0 4px;">김동원</span>
                                                    <span class="text-secondary">홈푸드</span>
                                                </div>
                                                <div class="list-right">
                                                    <div class="text-success">1,500</div>
                                                </div>
                                            </div>
                                            <div class="list-item">
                                                <div class="list-left">
                                                    <i class="fas fa-trophy" style="color: #eb661a;"></i>
                                                    <span style="padding: 0 4px;">김동원</span>
                                                    <span class="text-secondary">홈푸드</span>
                                                </div>
                                                <div class="list-right">
                                                    <div class="text-success">1,500</div>
                                                </div>
                                            </div>
                                            <div class="list-item">
                                                <div class="list-left">
                                                    <i class="fas fa-trophy" style="color: #eb661a;"></i>
                                                    <span style="padding: 0 4px;">김동원</span>
                                                    <span class="text-secondary">홈푸드</span>
                                                </div>
                                                <div class="list-right">
                                                    <div class="text-success">1,500</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="list_ty5">
                                            <div class="list-item">
                                                <div class="list-left">
                                                    <i class="fas fa-trophy" style="color: #63d1ae;"></i>
                                                    <span style="padding: 0 4px;">김동원</span>
                                                    <span class="text-secondary">홈푸드</span>
                                                </div>
                                                <div class="list-right">
                                                    <div class="text-success">1,500</div>
                                                </div>
                                            </div>
                                            <div class="list-item">
                                                <div class="list-left">
                                                    <i class="fas fa-trophy" style="color: #63d1ae;"></i>
                                                    <span style="padding: 0 4px;">김동원</span>
                                                    <span class="text-secondary">홈푸드</span>
                                                </div>
                                                <div class="list-right">
                                                    <div class="text-success">1,500</div>
                                                </div>
                                            </div>
                                            <div class="list-item">
                                                <div class="list-left">
                                                    <i class="fas fa-trophy" style="color: #63d1ae;"></i>
                                                    <span style="padding: 0 4px;">김동원</span>
                                                    <span class="text-secondary">홈푸드</span>
                                                </div>
                                                <div class="list-right">
                                                    <div class="text-success">1,500</div>
                                                </div>
                                            </div>
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
                    <!-- // 나의 프로세스 -->

                    <!-- Automation index -->
                    <div class="card direct-chat direct-chat-warning" style="min-height: 217px;">
                        <div class="card-header">
                            <h3 class="card-title">RPA 담당자</h3>
                            <!-- 20201016 ja -  셋팅 팝업 버튼 추가 -->
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" title="Contacts" data-widget="chat-pane-toggle">
                                    <i class="fas fa-cog"></i>
                                </button>
                            </div>
                            <!-- // 20201016 ja -  셋팅 팝업 버튼 추가 -->
                        </div>
                        <div class="card-body">
                            <div class="card-body-wrap" >
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="profile">
                                            <div class="profile-img">
                                                <img src="https://adminlte.io/themes/v3/dist/img/user8-128x128.jpg" alt="User Image Test">
                                            </div>
                                            <div class="profile-txt">
                                                <strong>김동원</strong>
                                                <span>대리</span>
                                            </div>
                                        </div>
                                        <div class="profile-add">리더 / 영업지원팀</div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="profile">
                                            <div class="profile-img">
                                                <img src="https://adminlte.io/themes/v3/dist/img/user7-128x128.jpg" alt="User Image Test">
                                            </div>
                                            <div class="profile-txt">
                                                <strong>김동원</strong>
                                                <span>대리</span>
                                            </div>
                                        </div>
                                        <div class="profile-add">팀장 / 영업지원팀</div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="profile">
                                            <div class="profile-img">
                                                <img src="https://adminlte.io/themes/v3/dist/img/user6-128x128.jpg" alt="User Image Test">
                                            </div>
                                            <div class="profile-txt">
                                                <strong>김동원</strong>
                                                <span>대리</span>
                                            </div>
                                        </div>
                                        <div class="profile-add">매니저 / 영업지원팀</div>
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
                    <!-- // Automation index -->
                </div>

                <div class="col-md-6" style="padding-right:0;">
                    <!-- 게시판 헬프 데스크 -->
                    <div class="card direct-chat direct-chat-warning" style="min-height:217px;">
                        <div class="card-header">
                            <h3 class="card-title">명예의 전당(개선지수)</h3>
                            <!-- 20201016 ja -  셋팅 팝업 버튼 추가 -->
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" title="Contacts" data-widget="chat-pane-toggle">
                                    <i class="fas fa-cog"></i>
                                </button>
                            </div>
                            <!-- // 20201016 ja -  셋팅 팝업 버튼 추가 -->
                        </div>
                        <div class="card-body">
                            <div class="card-body-wrap" style="padding-top:7px;">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="list_ty5">
                                            <div class="list-item">
                                                <div class="list-left">
                                                    <i class="fas fa-trophy" style="color: #eb661a;"></i>
                                                    <span style="padding: 0 4px;">김동원</span>
                                                    <span class="text-secondary">테크팩솔루션</span>
                                                </div>
                                                <div class="list-right">
                                                    <div class="text-success">0.9</div>
                                                </div>
                                            </div>
                                            <div class="list-item">
                                                <div class="list-left">
                                                    <i class="fas fa-trophy" style="color: #eb661a;"></i>
                                                    <span style="padding: 0 4px;">김동원</span>
                                                    <span class="text-secondary">홈푸드</span>
                                                </div>
                                                <div class="list-right">
                                                    <div class="text-success">0.8</div>
                                                </div>
                                            </div>
                                            <div class="list-item">
                                                <div class="list-left">
                                                    <i class="fas fa-trophy" style="color: #eb661a;"></i>
                                                    <span style="padding: 0 4px;">김동원</span>
                                                    <span class="text-secondary">홈푸드</span>
                                                </div>
                                                <div class="list-right">
                                                    <div class="text-success">0.7</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="list_ty5">
                                            <div class="list-item">
                                                <div class="list-left">
                                                    <i class="fas fa-trophy" style="color: #63d1ae;"></i>
                                                    <span style="padding: 0 4px;">김동원</span>
                                                    <span class="text-secondary">홈푸드</span>
                                                </div>
                                                <div class="list-right">
                                                    <div class="text-success">0.6</div>
                                                </div>
                                            </div>
                                            <div class="list-item">
                                                <div class="list-left">
                                                    <i class="fas fa-trophy" style="color: #63d1ae;"></i>
                                                    <span style="padding: 0 4px;">김동원</span>
                                                    <span class="text-secondary">홈푸드</span>
                                                </div>
                                                <div class="list-right">
                                                    <div class="text-success">0.5</div>
                                                </div>
                                            </div>
                                            <div class="list-item">
                                                <div class="list-left">
                                                    <i class="fas fa-trophy" style="color: #63d1ae;"></i>
                                                    <span style="padding: 0 4px;">김동원</span>
                                                    <span class="text-secondary">홈푸드</span>
                                                </div>
                                                <div class="list-right">
                                                    <div class="text-success">0.4</div>
                                                </div>
                                            </div>
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
                    <div class="card direct-chat direct-chat-warning" style="min-height: 217px;">
                        <div class="card-header">
                            <h3 class="card-title">절감시간  Top3</h3>
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
                                <div class="row" >
                                    <div class="col-md-4">
                                        <div class="ranking3">
                                            <i class="fas fa-4x fa-award float-left" style="color: #e6d333;margin-bottom:8px;"></i>
                                            <div class="float-left" style="margin-left: 4px;">
                                                <strong>영업관리부</strong>
                                                <div class="savetime text-success"><strong>15,000H</strong></div>
                                            </div>
                                        </div>
                                        <div class="text-secondary">일매출 실적입력 일매출 실적입력</div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="ranking3">
                                            <i class="fas fa-4x fa-award float-left" style="color: #a1a1a1;margin-bottom:8px;"></i>
                                            <div class="float-left" style="margin-left: 4px;">
                                                <strong>재무</strong>
                                                <div class="savetime text-success"><strong>11,000H</strong></div>
                                            </div>
                                        </div>
                                        <div class="text-secondary">전자잔액대사</div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="ranking3">
                                            <i class="fas fa-4x fa-award float-left" style="color: #daa182;margin-bottom:8px;"></i>
                                            <div class="float-left" style="margin-left: 4px;">
                                                <strong>생산</strong>
                                                <div class="savetime text-success"><strong>9,400H</strong></div>
                                            </div>
                                        </div>
                                        <div class="text-secondary">온라인주문자동화온라인주문자동화</div>
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
                    <h3 class="card-title">신규등록 프로세스</h3>
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
                        <div class="list_ty1">
                            <div class="list-item">
                                <div class="list-left">
                                    <div class="list-tit">[영업]리스트제목입니다</div>
                                    <div class="text-muted">2020.12.01 / 홍길동 대리</div>
                                </div>
                                <div class="list-right">
                                    <div class="text-success"><strong>1,200 H</strong></div>
                                    <div class="text-muted">영업본부/영업지원팀</div>
                                </div>
                            </div>
                            <div class="list-item">
                                <div class="list-left">
                                    <div class="list-tit">[재무]리스트제목입니다</div>
                                    <div class="text-muted">2020.12.01 / 홍길동 대리</div>
                                </div>
                                <div class="list-right">
                                    <div class="text-success"><strong>1,200 H</strong></div>
                                    <div class="text-muted">영업본부/영업지원팀</div>
                                </div>
                            </div>
                            <div class="list-item">
                                <div class="list-left">
                                    <div class="list-tit">[물류]리스트제목입니다</div>
                                    <div class="text-muted">2020.12.01 / 홍길동 대리</div>
                                </div>
                                <div class="list-right">
                                    <div class="text-success"><strong>1,200 H</strong></div>
                                    <div class="text-muted">영업본부/영업지원팀</div>
                                </div>
                            </div>
                            <div class="list-item">
                                <div class="list-left">
                                    <div class="list-tit">[영업]리스트제목입니다</div>
                                    <div class="text-muted">2020.12.01 / 홍길동 대리</div>
                                </div>
                                <div class="list-right">
                                    <div class="text-success"><strong>1,200 H</strong></div>
                                    <div class="text-muted">영업본부/영업지원팀</div>
                                </div>
                            </div>
                            <div class="list-item">
                                <div class="list-left">
                                    <div class="list-tit">[영업]리스트제목입니다리스트제목입니다리스트제목입니다리스트제목입니다리스트제목입니다리스트제목입니다리스트제목입니다리스트제목입니다리스트제목입니다</div>
                                    <div class="text-muted">2020.12.01 / 홍길동 대리</div>
                                </div>
                                <div class="list-right">
                                    <div class="text-success"><strong>1,200 H</strong></div>
                                    <div class="text-muted">영업본부/영업지원팀</div>
                                </div>
                            </div>
                            <div class="list-item">
                                <div class="list-left">
                                    <div class="list-tit">[영업]리스트제목입니다리스트</div>
                                    <div class="text-muted">2020.12.01 / 홍길동 대리</div>
                                </div>
                                <div class="list-right">
                                    <div class="text-success"><strong>1,200 H</strong></div>
                                    <div class="text-muted">영업본부/영업지원팀</div>
                                </div>
                            </div>
                            <div class="list-item">
                                <div class="list-left">
                                    <div class="list-tit">[영업]리스트제목입니다</div>
                                    <div class="text-muted">2020.12.01 / 홍길동 대리</div>
                                </div>
                                <div class="list-right">
                                    <div class="text-success"><strong>1,200 H</strong></div>
                                    <div class="text-muted">영업본부/영업지원팀</div>
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


<script>
/* 

20201015 ja - 원형 디자인
*/

function circle(){
    var circleWid = $('.circle').width();
    
    $('.circle').height(circleWid);
    $('.circle').css('line-height',circleWid + 'px')
}

circle();

$('.nav-link').on('click', function(){
    circle();
    var circleWid = $('.circle').width();
    
    $('.circle').width(circleWid);
})

$(window).on('resize', function(){
    circle();
})


</script>
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



