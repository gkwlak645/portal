<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>템플릿index화면</title>
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
                    <li class="nav-item"><a class="nav-link"
                        data-widget="pushmenu" href="#" role="button"><i
                            class="fas fa-bars"></i></a></li>
                </ul>                
                <ul class="navbar-nav ml-auto">
                    <!-- Messages Dropdown Menu -->
                    <li class="nav-item"></li>  
                </ul>
            </nav>
            <!-- /.navbar -->
        </div>
    
        <jsp:include page="/template/menu.jsp"></jsp:include>
        
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Content Header (Page header) -->
            <div class="content-header">
                <div class="container-fluid">
                    <div class="row mb-0">
                        <div class="col-sm-6">
                            <h1 class="m-0 text-dark">템플릿index화면</h1>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main content -->
            <section class="content">
                <div id="content">
                  <div class="card" id="">  
                    
                    
<!--  템플릿 바디 -->    
                    
    <table class="table table-bordered">
        <tr>            
            <th colspan="3">(공통)로딩바</th>
            <td><a href="/template/loading.jsp">loading.jsp</a></td>
        </tr>
        <tr>            
            <th colspan="3">로그인</th>
            <td><a href="/template/login.jsp">login.jsp</a></td>
        </tr>
        <tr>
            <th rowspan="3">메인</td>
            <td colspan="2">대시보드A</td>
            <td><a href="/template/siteMain.jsp">siteMain.jsp</a></td>
        </tr>
        <tr>
            <td colspan="2">대시보드B</td>
            <td><a href="/template/siteMain2.jsp">siteMain2.jsp</a></td>
        </tr>
        <tr>
            <td colspan="2">임원대시보드</td>
            <td><a href="/template/siteMain_owner.jsp">siteMain_owner.jsp</a></td>
        </tr>
        <tr>
            <th width="18%" rowspan="16">과제</th>
            <td width="22%" rowspan="3">과제아이디어</td>
            <td width="12%">메인</td>
            <td><a href="/template/taskIdeaMain.jsp">taskIdeaMain.jsp</a></td>
        </tr>
        <tr>
            <td>과제아이디어상세</td>
            <td><a href="/template/taskideaDetailPop.jsp">taskideaDetailPop.jsp</a></td>
        </tr>
        <tr>
           <td>과제아이디어등록</td>
            <td><a href="/template/taskideaRegPop.jsp">taskideaRegPop.jsp</a></td>
        </tr>
        <tr>
            <td rowspan="6">과제개발</td>
            <td>메인</td>                        
            <td><a href="/template/taskdevelopMain.jsp">taskdevelopMain.jsp</a></td>
        </tr>
         <tr>
            <td>과제개발상세</td>
            <td><a href="/template/taskdevelopDetailPop.jsp">taskdevelopDetailPop.jsp</a></td>
        </tr>
        <tr>
           <td>과제개발등록</td>
            <td><a href="/template/taskdevelopRegPop.jsp">taskdevelopRegPop.jsp</a></td>
        </tr>
         <tr>
            <td>프로세스상세</td>
            <td><a href="/template/taskprocessDetailPop.jsp">taskprocessDetailPop.jsp</a></td>
        </tr>
        <tr>
           <td>프로세스등록</td>
            <td><a href="/template/taskprocessRegPop.jsp">taskprocessRegPop.jsp</a></td>
        </tr>
        <tr>
           <td>연관시스템</td>
            <td><a href="/template/relatedSystem.jsp">relatedSystem.jsp</a></td>
        </tr>
        <tr>
            <td rowspan="7">과제운영</td>
            <td>메인</td>
            <td><a href="/template/taskmanageMain.jsp">taskmanageMain.jsp</a></td>
        </tr>
        <tr>
            <td>과제 운영상세</td>
            <td><a href="/template/taskmanageDetailPop.jsp">taskmanageDetailPop.jsp</a></td>
        </tr>
        <tr>
           <td>과제 운영취소</td>
            <td><a href="/template/taskmanageCancelPop.jsp">taskmanageCancelPop.jsp</a></td>
        </tr>
        <tr>
           <td>프로세스운영상세</td>
            <td><a href="/template/taskmanageprocessDetailPop.jsp">taskmanageprocessDetailPop.jsp</a></td>
        </tr>
        <tr>
           <td>프로세스정기실행</td>
            <td><a href="/template/taskroutine.jsp">taskroutine.jsp</a></td>
        </tr>
        <tr>
           <td>프로세스예약실행</td>
            <td><a href="/template/taskreserve.jsp">taskreserve.jsp</a></td>
        </tr>
        <tr>
           <td>정기실행 계획</td>
            <td><a href="/template/taskroutineRegplan.jsp">taskroutineRegplan.jsp</a></td>
        </tr>
        <tr>
            <th rowspan="14">모니터링</th>
            <td rowspan="2">JOB오류관리</td>
            <td>메인</td>
            <td><a href="/template/jobErrorMain.jsp">jobErrorMain.jsp</a></td>
        </tr>
        <tr>
            <td>상세</td>
            <td><a href="/template/jobErrorDetailPop.jsp">jobErrorDetailPop.jsp</a></td>
        </tr>
        <tr>
            <td rowspan="3">Transaction오류관리</td>
            <td>메인</td>
            <td><a href="/template/trnscErrorMain.jsp">trnscErrorMain.jsp</a></td>
        </tr>
        <tr>
            <td>중복오류통합</td>
             <td><a href="/template/overTrnscErrorDetailPop.jsp">overTrnscErrorDetailPop.jsp</a></td>
        </tr>
        <tr>
            <td>상세</td>
             <td><a href="/template/trnscErrorDetailPop.jsp">trnscErrorDetailPop.jsp</a></td>
        </tr>
        <tr>
           <td rowspan="3">일일미조치현황</td>
            <td>메인</td>
            <td><a href="/template/unmanagtErrorMain.jsp">unmanagtErrorMain.jsp</a></td>
        </tr>
        <tr>
            <td>등록</td>
            <td><a href="/template/unmanagtErrorSavePop.jsp">unmanagtErrorSavePop.jsp</a></td>
        </tr>
        <tr>
            <td>상세</td>
            <td><a href="/template/unmanagtErrorDetailPop.jsp">unmanagtErrorDetailPop.jsp</a></td>
        </tr>
        <tr>
           <td rowspan="2">실행중단이미지</td>
            <td>메인</td>
            <td><a href="/template/executDscntcImgMain.jsp">executDscntcImgMain.jsp</a></td>
        </tr>
        <tr>
            <td>상세</td>
            <td><a href="/template/executDscntcImgDetailPop.jsp">executDscntcImgDetailPop.jsp</a></td>
        </tr>
        <tr>
           <td rowspan="4">BOT별 동작현황</td>
            <td>메인</td>
            <td><a href="/template/taskBotMain.jsp">taskBotMain.jsp</a></td>
        </tr>
        <tr>
            <td>프로세스상태정보</td>
            <td><a href="/template/taskBotProcess.jsp">taskBotProcess.jsp</a></td>
        </tr>
        <tr>
            <td>로그목록</td>
            <td><a href="/template/taskBotLogMain.jsp">taskBotLogMain.jsp</a></td>
        </tr>
        <tr>
            <td>로그상세</td>
            <td><a href="/template/taskBotLogDetailPop.jsp">taskBotLogDetailPop.jsp</a></td>
        </tr>
        <tr>
            <th rowspan="34">자원관리</th>
            <td rowspan="3">디바이스관리</td>
            <td>메인</td>
            <td><a href="/template/deviceMngMain.jsp">deviceMngMain.jsp</a></td>
        </tr>
        <tr>
            <td>등록</td>
            <td><a href="/template/deviceRegisterPagePop.jsp">deviceRegisterPagePop.jsp</a></td>
        </tr>
        <tr>
            <td>상세</td>
            <td><a href="/template/deviceDetailPagePop.jsp">deviceDetailPagePop.jsp</a></td>
        </tr>
        <tr>
            <td rowspan="3">로봇관리</td>
            <td>메인</td>
            <td><a href="/template/robotMngMain.jsp">robotMngMain.jsp</a></td>
        </tr>
        <tr>
            <td>등록</td>
            <td><a href="/template/robotRegisterPagePop.jsp">robotRegisterPagePop.jsp</a></td>
        </tr>
        <tr>
            <td>상세</td>
            <td><a href="/template/robotDetailPagePop.jsp">robotDetailPagePop.jsp</a></td>
        </tr>
        <tr>
            <td rowspan="4">환경관리</td>
            <td>메인</td>
            <td><a href="/template/envrnMngMain.jsp">envrnMngMain.jsp</a></td>
        </tr>
        <tr>
            <td>등록</td>
            <td><a href="/template/envrnRegisterPagePop.jsp">envrnRegisterPagePop.jsp</a></td>
        </tr>
        <tr>
            <td>상세</td>
            <td><a href="/template/envrnDetailPop.jsp">envrnDetailPop.jsp</a></td>
        </tr>
        <tr>
            <td>관리</td>
            <td><a href="/template/envrnRobotRegisterPagePop.jsp">envrnRobotRegisterPagePop.jsp</a></td>
        </tr>
        <tr>
            <td rowspan="6">패키지관리</td>
            <td>메인</td>
            <td><a href="/template/packageInfoMain.jsp">packageInfoMain.jsp</a></td>
        </tr>
        <tr>
            <td>패키지등록</td>
            <td><a href="/template/taskDevelopPackPop.jsp">taskDevelopPackPop.jsp</a></td>
        </tr>
        <tr>
            <td>패키지등록2</td>
            <td><a href="/template/taskDevelopPackPop2.jsp">taskDevelopPackPop2.jsp</a></td>
        </tr>
         <tr>
            <td>라이브러리등록</td>
            <td><a href="/template/taskDevelopLibPop.jsp">taskDevelopLibPop.jsp</a></td>
        </tr>
        <tr>
            <td>버전상세</td>
            <td><a href="/template/packageVerMng.jsp">packageVerMng.jsp</a></td>
        </tr>
        <tr>
            <td>이력상세</td>
            <td><a href="/template/HistInqire.jsp">HistInqire.jsp</a></td>
        </tr>
        <tr>
            <td rowspan="2">큐관리</td>
            <td>메인</td>
            <td><a href="/template/queMngMain.jsp">queMngMain.jsp</a></td>
        </tr>
        <tr>
            <td>등록</td>
            <td><a href="/template/queueRegisterPagePop.jsp">queueRegisterPagePop.jsp</a></td>
        </tr>
        <tr>
            <td rowspan="4">프로세스관리</td>
            <td>메인</td>
            <td><a href="/template/processMngMain.jsp">processMngMain.jsp</a></td>
        </tr>
        <tr>
            <td>설정</td>
            <td><a href="/template/processEstbsPop.jsp">processEstbsPop.jsp</a></td>
        </tr>
         <tr>
            <td>등록</td>
            <td><a href="/template/processRegPagePop.jsp">processRegPagePop.jsp</a></td>
        </tr>
        <tr>
            <td>상세</td>
            <td><a href="/template/processDetailPagePop.jsp">processDetailPagePop.jsp</a></td>
        </tr>
        <tr>
            <td rowspan="3">라이센스관리</td>
            <td>메인</td>
            <td><a href="/template/licenseMngMain.jsp">licenseMngMain.jsp</a></td>
        </tr>
        <tr>
            <td>상세</td>
            <td><a href="/template/licenseDetailPagePop.jsp">licenseDetailPagePop.jsp</a></td>
        </tr>
        <tr>
            <td>편집</td>
            <td><a href="/template/licenseEditPagePop.jsp">licenseEditPagePop.jsp</a></td>
        </tr>   
        <tr>
            <td rowspan="5">트리거(UA)</td>
            <td>메인</td>
            <td><a href="/template/triggerMain.jsp">triggerMain.jsp</a></td>
        </tr>
        <tr>
            <td>등록</td>
            <td><a href="/template/triggerRegisterPop.jsp">triggerRegisterPop.jsp</a></td>
        </tr>
        <tr>
            <td>실행</td>
            <td><a href="/template/triggerEditPop.jsp">triggerEditPop.jsp</a></td>
        </tr>
        <tr>
            <td>상세_시간</td>
            <td><a href="/template/triggerDetailTimePop.jsp">triggerDetailTimePop.jsp</a></td>
        </tr>
        <tr>
            <td>상세_큐</td>
            <td><a href="/template/triggerDetailQueuePop.jsp">triggerDetailQueuePop.jsp</a></td>
        </tr>
        <tr>
            <td rowspan="4">트리거(AT)</td>
            <td>메인</td>
            <td><a href="/template/triggerMainAt.jsp">triggerMainAt.jsp</a></td>
        </tr>
        <tr>
            <td>즉시실행</td>
            <td><a href="/template/triggerMainAt_Direct.jsp">triggerMainAt_Direct.jsp</a></td>
        </tr>
        <tr>
            <td>예약실행</td>
            <td><a href="/template/triggerMainAt_reserve.jsp">triggerMainAt_reserve.jsp</a></td>
        </tr>
         <tr>
            <td>정기실행</td>
            <td><a href="/template/triggerMainAt_routine.jsp">triggerMainAt_routine.jsp</a></td>
        </tr>
        <tr>
            <th rowspan="11">기준정보</th>
            <td rowspan="3">과제템플릿관리</td>
            <td>메인</td>
            <td><a href="/template/taskTmplatMngMain.jsp">taskTmplatMngMain.jsp</a></td>
        </tr>
        <tr>
            <td>등록</td>
            <td><a href="/template/taskTmplatMngRegPop.jsp">taskTmplatMngRegPop.jsp</a></td>
        </tr>
        <tr>
            <td>상세</td>
            <td><a href="/template/taskTmplatMngDetailPop.jsp">taskTmplatMngDetailPop.jsp</a></td>
        </tr>
        <tr>
            <td rowspan="2">Asset관리</td>
            <td>메인</td>
            <td><a href="/template/assetMngMain.jsp">assetMngMain.jsp</a></td>
        </tr>
        <tr>
            <td>등록/상세</td>
            <td><a href="/template/assetRegistPop.jsp">assetRegistPop.jsp</a></td>
        </tr>        
        <tr>
            <td>휴일관리</td>
            <td>메인</td>
            <td><a href="/template/dayoffMngMain.jsp">dayoffMngMain.jsp</a></td>
        </tr>
        <tr>
            <td>공통코드관리</td>
            <td>메인</td>
            <td><a href="/template/cmmnCdModifyMain.jsp">cmmnCdModifyMain.jsp</a></td>    
        </tr>
        <tr>
            <td>시간당인건비단가등록</td>
            <td>메인</td>
            <td><a href="/template/pymhrUpdtMain.jsp">pymhrUpdtMain.jsp</a></td>
        </tr>
        <tr>
            <td rowspan="3">연계시스템관리</td>
            <td>메인</td>
            <td><a href="/template/cntcSysMain.jsp">cntcSysMain.jsp</a></td>
        </tr>
        <tr>
            <td>등록</td>
            <td><a href="/template/cntcSysRegister.jsp">cntcSysRegister.jsp</a></td>
        </tr>
        <tr>
            <td>상세</td>
            <td><a href="/template/cntcDetailPagePop.jsp">cntcDetailPagePop.jsp</a></td>
        </tr>
        <tr>
            <th rowspan="6">통계</th>
            <td>프로세스별 실행현황</td>
            <td>메인</td>
            <td><a href="/template/statistProcess.jsp">statistProcess.jsp</a></td>
        </tr>
        <tr>
            <td>로봇별 실행현황</td>
            <td>메인</td>
            <td><a href="/template/statistRobot.jsp">statistRobot.jsp</a></td>
        </tr>
        <tr>
            <td>실적계획입력</td>
            <td>메인</td>
            <td><a href="/template/statistPlan.jsp">statistPlan.jsp</a></td>
        </tr>
        <tr>
            <td>인원 및 봇수 현황</td>
            <td>메인</td>
            <td><a href="/template/statistVolum.jsp">statistVolum.jsp</a></td>
        </tr>
        <tr>
            <td>계획대비실적 형황</td>
            <td>메인</td>
            <td><a href="/template/statistResult.jsp">statistResult.jsp</a></td>
        </tr>
        <tr>
            <td>프로세스 운영 현황</td>
            <td>메인</td>
            <td><a href="/template/preocessOperStatusMain.jsp">preocessOperStatusMain.jsp</a></td>
        </tr>
        <tr>
            <th rowspan="5">HelpDesk</th>
            <td rowspan="3">처리요청</td>
            <td>메인</td>
            <td><a href="/template/hlpdskMain.jsp">hlpdskMain.jsp</a></td>
        </tr>
        <tr>
            <td>등록</td>
            <td><a href="/template/hlpdskCreate.jsp">hlpdskCreate.jsp</a></td>
        </tr>
        <tr>
            <td>상세</td>
            <td><a href="/template/hlpdskDetail.jsp">hlpdskDetail.jsp</a></td>
        </tr>
        <tr>
            <td rowspan="2">접수처리</td>
            <td>메인</td>
            <td><a href="/template/hlpdskReceiptMain.jsp">hlpdskReceiptMain.jsp</a></td>
        </tr>
        <tr>
            <td>상세</td>
            <td><a href="/template/hlpdskReceiptDetail.jsp">hlpdskReceiptDetail.jsp</a></td>
        </tr>
        <tr>
            <th rowspan="15">커뮤니티</th>
            <td rowspan="4">시스템작업공지</td>
            <td>메인</td>
            <td><a href="/template/systemnoticeMain.jsp">systemnoticeMain.jsp</a></td>
        </tr>
        <tr>
            <td>상세</td>
            <td><a href="/template/systemnoticeDetailPop.jsp">systemnoticeDetailPop.jsp</a></td>
        </tr>
        <tr>
            <td>등록</td>
            <td><a href="/template/systemnoticeRegPop.jsp">systemnoticeRegPop.jsp</a></td>
        </tr>
        <tr>
            <td>연계시스템선택</td>
            <td><a href="/template/systemchoicePop.jsp">systemchoicePop.jsp</a></td>
        </tr>
        <tr>
            <td rowspan="2">명예의전당</td>
            <td>메인</td>
            <td><a href="/template/winnerListMain.jsp">winnerListMain.jsp</a></td>
        </tr>
        <tr>
            <td>상세</td>
            <td><a href="/template/winnerListDetailPop.jsp">winnerListDetailPop.jsp</a></td>
        </tr>
        <tr>
            <td rowspan="3">게시판관리</td>
            <td>메인</td>
            <td><a href="http://localhost:8080/template/">bbsMngMain</a></td>
        </tr>
        <tr>
            <td>등록</td>
            <td><a href="http://localhost:8080/template/">bbsMngReg</a></td>
        </tr>
        <tr>
            <td>상세</td>
            <td><a href="http://localhost:8080/template/">bbsMngDetail</a></td>
        </tr>
        <tr>
            <td rowspan="3">공지사항</td>
            <td>메인</td>
            <td><a href="http://localhost:8080/template/">noticeMain</a></td>
        </tr>
        <tr>
            <td>등록</td>
            <td><a href="http://localhost:8080/template/">noticeReg</a></td>
        </tr>
        <tr>
            <td>상세</td>
            <td><a href="http://localhost:8080/template/">noticeDetail</a></td>
        </tr>
        <tr>
            <td rowspan="3">일반게시판</td>
            <td>메인</td>
            <td><a href="http://localhost:8080/template/">bbsNomalMain</a></td>
        </tr>
        <tr>
            <td>등록</td>
            <td><a href="http://localhost:8080/template/">bbsNomalReg</a></td>
        </tr>
        <tr>
            <td>상세</td>
            <td><a href="http://localhost:8080/template/">bbsNomalDetail</a></td>
        </tr>
        <tr>
            <th rowspan="7">시스템관리</th>
            <td rowspan="3">사용자관리</td>
            <td>메인</td>
            <td><a href="/template/userManageListMain.jsp">userManageListMain.jsp</a></td>
        </tr>
        <tr>
            <td>등록</td>
            <td><a href="/template/userRegisterPagePop.jsp">userRegisterPagePop.jsp</a></td>
        </tr>
        <tr>
            <td>상세</td>
            <td><a href="/template/userDetailPagePop.jsp">userDetailPagePop.jsp</a></td>
        </tr>
        <tr>
            <td>메뉴관리</td>
            <td>메인</td>
            <td><a href="http://localhost:8080/template/">menuMngMain</a></td>
        </tr>
        <tr>
            <td>역할관리</td>
            <td>메인</td>
            <td><a href="http://localhost:8080/template/">roleMngListMain</a></td>
        </tr>
        <tr>
            <td>권한관리</td>
            <td>메인</td>
            <td><a href="http://localhost:8080/template/">authorRoleMain</a></td>
        </tr>
        <tr>
            <td>사용자역할관리</td>
            <td>메인</td>
            <td><a href="http://localhost:8080/template/">userRoleListMain</a></td>
        </tr>        
    </table>


<!--  템플릿 바디 끝 -->    
                    </div>
                </div>
            </section>
            <!-- /.Main content -->
        </div>
        <div id="footer">
            <footer class="main-footer">
                Copyright &copy; 2020 <a href="http://www.echoit.co.kr">에코아이티</a>&nbsp;.&nbsp;All
                rights reserved.    >
            </footer>
        </div>
    </div>
</body>
</html>