<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="menu">

            <!-- Main Sidebar Container -->
            <aside class="main-sidebar elevation-4 sidebar-light-primary">

                <!-- Brand Logo -->
                <a href="/main/siteMain" class="brand-link navbar-primary text-sm">
                    <img src="/resources/images/dist/AdminLTELogo.png"
                    alt="AdminLTE Logo" class="brand-image" style="opacity: 1"> <span
                    class="brand-text font-weight-bold">RPA Portal</span>
                </a>

                <!-- Sidebar -->
                <div class="sidebar">

                    <!-- Sidebar Menu -->
                    <nav class="mt-2">
                        <ul
                            class="nav nav-pills nav-sidebar flex-column nav-flat nav-child-indent"
                            data-widget="treeview" role="menu" data-accordion="false">
                            <!-- Add icons to the links using the .nav-icon class with font-awesome or any other icon font library -->

                            <li class="nav-item has-treeview menu-open"><a href="#"
                                class="nav-link active"> <i class="nav-icon fas fa-tasks"></i>
                                    <p>
                                        과제<i class="fas fa-angle-left right"></i>
                                    </p>
                            </a>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a href="/task/idea/taskIdeaMain"
                                        class="nav-link active"> <i class="far fa-circle nav-icon"></i>
                                            <p>과제아이디어등록</p>
                                    </a></li>
                                </ul>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a href="" class="nav-link"> <i
                                            class="far fa-circle nav-icon"></i>
                                            <p>과제개발</p>
                                    </a></li>
                                </ul>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a href="" class="nav-link"> <i
                                            class="far fa-circle nav-icon"></i>
                                            <p>과제운영</p>
                                    </a></li>
                                </ul>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a href="/task/requst/taskRequstMain"
                                        class="nav-link"> <i class="far fa-circle nav-icon"></i>
                                            <p>과제요청(임시)</p>
                                    </a></li>
                                </ul>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a href="/task/review/taskReviewMain"
                                        class="nav-link"> <i class="far fa-circle nav-icon"></i>
                                            <p>과제검토(임시)</p>
                                    </a></li>
                                </ul></li>
                            <li class="nav-item has-treeview"><a href="#"
                                class="nav-link"> <i class="nav-icon fas fa-binoculars"></i>
                                    <p>
                                        모니터링<i class="right fas fa-angle-left"></i>
                                    </p>
                            </a>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a
                                        href="/mntrng/joberror/jobErrorMain" class="nav-link"> <i
                                            class="far fa-circle nav-icon"></i>
                                            <p>JOB오류관리</p>
                                    </a></li>
                                </ul>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a
                                        href="/mntrng/trnscerror/trnscErrorMain" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>Transaction오류관리</p>
                                    </a></li>
                                </ul>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a
                                        href="/mntrng/unmanagterror/unmanagtErrorMain"
                                        class="nav-link"> <i class="far fa-circle nav-icon"></i>
                                            <p>일일미조치현황</p>
                                    </a></li>
                                </ul>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a
                                        href="/mntrng/executdscntc/executDscntcImgMain"
                                        class="nav-link"> <i class="far fa-circle nav-icon"></i>
                                            <p>실행중단이미지</p>
                                    </a></li>
                                </ul>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a
                                        href="/mntrng/jobmntrng/jobMntrngMain" class="nav-link"> <i
                                            class="far fa-circle nav-icon"></i>
                                            <p>Job로그(임시)</p>
                                    </a></li>
                                </ul>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a
                                        href="/mntrng/logmntrng/logMntrngMain" class="nav-link"> <i
                                            class="far fa-circle nav-icon"></i>
                                            <p>로그(임시)</p>
                                    </a></li>
                                </ul></li>
                            <li class="nav-item has-treeview"><a href="#"
                                class="nav-link"> <i class="nav-icon fas fa-cubes"></i>
                                    <p>
                                        자원관리<i class="right fas fa-angle-left"></i>
                                    </p>
                            </a>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a
                                        href="/resrce/device/deviceMngMain" class="nav-link"> <i
                                            class="far fa-circle nav-icon"></i>
                                            <p>디바이스관리</p>
                                    </a></li>
                                </ul>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a href="/resrce/robot/robotMngMain"
                                        class="nav-link"> <i class="far fa-circle nav-icon"></i>
                                            <p>로봇관리</p>
                                    </a></li>
                                </ul>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a href="/resrce/envrn/envrnMngMain"
                                        class="nav-link"> <i class="far fa-circle nav-icon"></i>
                                            <p>환경관리</p>
                                    </a></li>
                                </ul>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a
                                        href="/resrce/package/packageInfoMain" class="nav-link"> <i
                                            class="far fa-circle nav-icon"></i>
                                            <p>패키지관리</p>
                                    </a></li>
                                </ul>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a href="" class="nav-link"> <i
                                            class="far fa-circle nav-icon"></i>
                                            <p>큐관리</p>
                                    </a></li>
                                </ul>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a
                                        href="/resrce/process/processMngMain" class="nav-link"> <i
                                            class="far fa-circle nav-icon"></i>
                                            <p>프로세스관리</p>
                                    </a></li>
                                </ul>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a
                                        href="/resrce/license/licenseMngMain" class="nav-link"> <i
                                            class="far fa-circle nav-icon"></i>
                                            <p>라이선스관리</p>
                                    </a></li>
                                </ul></li>
                            <li class="nav-item has-treeview"><a href="#"
                                class="nav-link"> <i class="nav-icon fas fa-book"></i>
                                    <p>
                                        기준정보<i class="right fas fa-angle-left"></i>
                                    </p>
                            </a>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a
                                        href="/stdrinfo/tmplat/taskTmplatMngMain" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>과제템플릿관리</p>
                                    </a></li>
                                </ul>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a href="" class="nav-link"> <i
                                            class="far fa-circle nav-icon"></i>
                                            <p>Credential관리</p>
                                    </a></li>
                                </ul>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a
                                        href="/stdrinfo/asset/assetMngMain" class="nav-link"> <i
                                            class="far fa-circle nav-icon"></i>
                                            <p>Asset관리</p>
                                    </a></li>
                                </ul>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a
                                        href="/stdrinfo/dayoff/dayoffMngMain" class="nav-link"> <i
                                            class="far fa-circle nav-icon"></i>
                                            <p>휴일관리</p>
                                    </a></li>
                                </ul>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a
                                        href="/stdrinfo/cmmncd/cmmnCdModifyMain" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>공통코드관리</p>
                                    </a></li>
                                </ul>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a
                                        href="/stdrinfo/pymhr/pymhrUpdtMain" class="nav-link"> <i
                                            class="far fa-circle nav-icon"></i>
                                            <p>시간당인건비단가등록</p>
                                    </a></li>
                                </ul>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a
                                        href="/stdrinfo/cntcsys/cntcSysMain " class="nav-link"> <i
                                            class="far fa-circle nav-icon"></i>
                                            <p>연계시스템관리</p>
                                    </a></li>
                                </ul></li>
                            <li class="nav-item has-treeview"><a href="#"
                                class="nav-link"> <i class="nav-icon fas fa-chart-pie"></i>
                                    <p>
                                        통계<i class="right fas fa-angle-left"></i>
                                    </p>
                            </a>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a href="" class="nav-link"> <i
                                            class="far fa-circle nav-icon"></i>
                                            <p>로봇별실행현황</p>
                                    </a></li>
                                </ul>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a href="" class="nav-link"> <i
                                            class="far fa-circle nav-icon"></i>
                                            <p>실적계획입력</p>
                                    </a></li>
                                </ul>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a href="" class="nav-link"> <i
                                            class="far fa-circle nav-icon"></i>
                                            <p>인원 및 봇수 현황</p>
                                    </a></li>
                                </ul>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a href="" class="nav-link"> <i
                                            class="far fa-circle nav-icon"></i>
                                            <p>계획대비실적 현황</p>
                                    </a></li>
                                </ul>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a href="" class="nav-link"> <i
                                            class="far fa-circle nav-icon"></i>
                                            <p>프로세스 운영 현황</p>
                                    </a></li>
                                </ul></li>
                            <li class="nav-item has-treeview"><a href="#"
                                class="nav-link"> <i class="nav-icon fas fa-dizzy"></i>
                                    <p>
                                        HelpDesk<i class="right fas fa-angle-left"></i>
                                    </p>
                            </a>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a href="/hlpdsk/requst/hlpdskMain"
                                        class="nav-link"> <i class="far fa-circle nav-icon"></i>
                                            <p>처리요청</p>
                                    </a></li>
                                </ul>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a
                                        href="/hlpdsk/requst/hlpdskReceiptMain" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>접수처리</p>
                                    </a></li>
                                </ul></li>
                            <li class="nav-item has-treeview"><a href="#"
                                class="nav-link"> <i class="nav-icon fas fa-volume-up"></i>
                                    <p>
                                        커뮤니티<i class="right fas fa-angle-left"></i>
                                    </p>
                            </a>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a href="" class="nav-link"> <i
                                            class="far fa-circle nav-icon"></i>
                                            <p>시스템작업공지</p>
                                    </a></li>
                                </ul>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a href="" class="nav-link"> <i
                                            class="far fa-circle nav-icon"></i>
                                            <p>명예의전당</p>
                                    </a></li>
                                </ul>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a href="/cmmnty/bbsmng/bbsMngMain"
                                        class="nav-link"> <i class="far fa-circle nav-icon"></i>
                                            <p>게시판관리</p>
                                    </a></li>
                                </ul>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a
                                        href="/cmmnty/notice/noticeMain?boardNo=1" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>공지사항</p>
                                    </a></li>
                                </ul>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a
                                        href="/cmmnty/nomal/bbsNomalMain?boardNo=4" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>일반게시판</p>
                                    </a></li>
                                </ul></li>
                            <li class="nav-item has-treeview"><a href="#"
                                class="nav-link"> <i class="nav-icon fas fa-tools"></i>
                                    <p>
                                        시스템관리<i class="right fas fa-angle-left"></i>
                                    </p>
                            </a>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a
                                        href="/orgnzt/user/userManageListMain" class="nav-link"> <i
                                            class="far fa-circle nav-icon"></i>
                                            <p>사용자관리</p>
                                    </a></li>
                                </ul>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a href="/menu/menumng/menuMngMain"
                                        class="nav-link"> <i class="far fa-circle nav-icon"></i>
                                            <p>메뉴관리</p>
                                    </a></li>
                                </ul>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a
                                        href="/author/rolemng/roleMngListMain" class="nav-link"> <i
                                            class="far fa-circle nav-icon"></i>
                                            <p>역할관리</p>
                                    </a></li>
                                </ul>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a
                                        href="/author/authormng/authorRoleMain" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>권한관리</p>
                                    </a></li>
                                </ul>
                                <ul class="nav nav-treeview">
                                    <li class="nav-item"><a
                                        href="/author/userrole/userRoleListMain" class="nav-link">
                                            <i class="far fa-circle nav-icon"></i>
                                            <p>사용자역할관리</p>
                                    </a></li>
                                </ul></li>
                        </ul>
                    </nav>
                    <!-- /.sidebar-menu -->
                </div>
                <!-- /.sidebar -->
            </aside>

        </div>