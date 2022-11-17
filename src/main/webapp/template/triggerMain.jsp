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
<title>템플릿화면</title>
<!-- Tell the browser to be responsive to screen width -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<jsp:include page="/template/script.jsp"></jsp:include>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
    <div class="wrapper">
        <div id="header">
            <!-- Navbar -->
            <nav
                class="main-header navbar navbar-expand border-bottom-0 navbar-dark navbar-primary text-sm">
                <ul class="navbar-nav">
                    <li class="nav-item"><a class="nav-link"
                        data-widget="pushmenu" href="#" role="button"><i
                            class="fas fa-bars"></i></a></li>
                </ul>
                <ul class="navbar-nav ml-auto">
                    <!-- Messages Dropdown Menu -->
                    <li class="nav-item"></a></li>
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
                            <h1 class="m-0 text-dark">트리거(UA)</h1>
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">자원관리 / 트리거관리</li>
                            </ol>
                        </div>
                        <!-- /.col -->
                    </div>
                    <!-- /.row -->
                </div>
                <!-- /.container-fluid -->
            </div>
            <!-- /.content-header -->


            <!-- Main content -->
            <section class="content">
                <div id="content">
                    <!--  템플릿 바디 -->
                    <div id="packageLibraryMainDiv" class="container-fluid wrap">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-header">
                                        <form class="form-inline">                                         
                                            <div class="form-group col-md-12">
                                                 <label id=""class="col-sm-2" >이름</label>
                                                 <div class="col-sm-10">
                                                   <input type="text" class="form-control  float-left" id="txtSearchKwrd" name="searchKwrd" style="min-width:210px;" value="" />
                                                 </div>
                                            </div>
                                            
                                            <div class="form-group col-md-6">
                                                 <label id="name" class="col-sm-4">상태</label>
                                                 <div class="col-sm-8">
                                                  <select class="form-control float-left" id="cmpnyCd" style="width:60%;max-width:210px;">
                                                  </select>
                                               </div>
                                            </div>
                                            <div class="form-group col-md-6">
                                                 <label id="name" class="col-sm-4">형식</label>
                                                 <div class="col-sm-8 float-left">
                                                  <select class="form-control float-left" id="cmpnyCd" style="width:60%;max-width:210px;">
                                                  </select>
                                                  <button type="button" id="btnSearch" class="btn btn-info float-left">조회</button>
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
                                        <button type="button" id="" class="btn btn-primary float-right" style="margin:5px 0 15px 2px;">즉시시작</button>
                                         <button type="button" id="btnReg" class="btn btn-primary float-right" style="margin:5px 0 15px 2px;">등록</button>
                                        <div id="unmanagtErrorGrid"></div>
                                        <div id="unmanagtErrorGridPager" class="portal-pager"></div>                                        
                                    </div>
                                    <!-- 20201124 추가 -->
                                    <div class="tip_more-wrap">
									    <!-- button -->
									    <a href="javascript:;" class="download_txt">
									        <input type="button" class="btn-tip btn btn-outline-success" id="" name="" value=":" style="padding: 0 5px 3px 4px;width:22px;line-height: 18px;">
									    </a>
									    <!-- menu -->
									    <div class="add_file_list"style=" position: relative;display: none;left:0px;top:0px"><!-- 버튼 클릭시 .active 추가 -->
									        <ul>
									            <li>
									                <a class="btn-txt" href="javascript:">편집</a>
									            </li>
									            <li>
									                <a class="btn-txt disabled" href="javascript:">작업보기</a><!-- 비활성화 .disabled 추가 -->
									            </li>
									            <li>
									                <a class="btn-txt" href="javascript:">사용</a>
									            </li>
									            <li>
									                <a class="btn-txt" href="javascript:">사용안함</a>
									            </li>
									            <li>
									                <a class="btn-txt" href="javascript:">제거</a>
									            </li>
									        </ul>
									    </div>
									</div>
                                    <!-- //20201124 추가 -->
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
                                        'unmanagtSn' : 'trig_time_naverDataLab',
                                        'errorCn' : 'proc_naverDatalab',
                                        'cmpnyNm' : 'env_echorpa4',
                                        'occrrncSeNm' : '시간',
                                        'tyNm' : '시간 06:20 오후, 수요일 ..',
                                        'unmanagtDe' : '2020-12-31 11 :22 33',
                                        'processSn' : '0초',
                                        'managtTyNm' : '<input type="button" class="btn btn-outline-primary icon" style="padding:3px 2px 4px 4px;margin:0px;line-height: 0.9;font-size:8px;" value="▶">',
                                        'managtTyNm2' : '<div><input type="button" onclick="viewSubMenu(this)" class="btn btn-outline-success" id="" name="" value=":" style="padding: 0 5px 3px 4px;width:22px;line-height: 18px;"></div>'
                                        
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
                                      {name: "unmanagtSn"         , title : "이름"       , type : "text"    , width : 90, align : "center"} 
                                    , {name: "errorCn"            , title : "프로세스"    , type : "text"    , width : 80, align : "center"}
                                    , {name: "cmpnyNm"            , title : "환경"       , type : "text"    , width : 80, align : "center"}
                                    , {name: "occrrncSeNm"        , title : "형식"    , type : "text"    , width : 35, align : "center"}
                                    , {name: "tyNm"               , title : "트리거세부정보"       , type : "text"    , width : 110, align : "center"}
                                    , {name: "unmanagtDe"          , title : "다음런타임"    , type : "text"    , width : 80, align : "center"}
                                    , {name: "processSn"            , title : "다음이후 중지"       , type : "text"    , align : "center"}
                                    , {name: "managtTyNm"         , title : "즉시시작"        , type : "text"    , width : 50, align : "center"}
                                    , {name: "managtTyNm2"         , title : ""        , type : "text"    , width : 40, align : "center"}
                                ]
                            });
                            
                        }
                        
                        /*
                         * 상세페이지 pop
                         * @param
                         * @return
                         */
                        function unManagtErrorDetail() {
                            appendDetailPopup("unmanagtErrorMainDiv", "/task/idea/taskideaDetailPop");
                        };
                        
                        /*
                         * 등록페이지 pop
                         * @param
                         * @return
                         */
                        function unManagtErrorReg() {
                            appendDetailPopup("unmanagtErrorMainDiv", "/task/idea/taskideaRegPop");
                        };
                        
                        /*
                         * popup창 닫기
                         * @param
                         * @return
                         */
                        function closePop() {
                            $(".over").remove();
                        }
                        
                        function viewSubMenu(obj){
                            const oObj = $(obj);
                            //console.log(oObj.offset().top);
                            //console.log(oObj.offset().left);
                            //console.log(oObj.position().top);
                            if(oObj.hasClass("jq_click")){
                                oObj.removeClass("jq_click");
                                $(".add_file_list").hide()
                                return false;
                            }else{
                                oObj.addClass("jq_click")
                            }
                            
                            const windowHeight = $(window).height();
                            $(".add_file_list").show();
                            if(oObj.offset().top + 170 < windowHeight){
                                $(".add_file_list").offset({top: oObj.offset().top + 23, left: oObj.offset().left - 91});
                            }
                            else{
                                $(".add_file_list").offset({top: oObj.offset().top - 114, left: oObj.offset().left - 91});
                            }
                            
                            oObj.addClass("jq_click")
                            return false;
                        }    

                        

                        $(document).click(function(e) {
                            if(!$(e.target).hasClass("btn-outline-success") && $(e.target).closest(".add_file_list").length < 1) 
                            { 
                                $(".add_file_list").hide() 
                                $(".jq_click").removeClass("jq_click");
                                //console.log("hide")
                            } 
                        });
                    </script>
                    
                        <!--  템플릿 바디 끝 -->    
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