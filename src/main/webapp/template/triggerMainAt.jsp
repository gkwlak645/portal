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

<!-- CSS 추가 -->
<style>
.card-top_btn {margin: 5px 0 15px; text-align: right;}
.card-top_btn .btn {display: inline-block;}
/* .card-top_btn .btn + .btn {margin-left: 2px;} */
</style>
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
                            <h1 class="m-0 text-dark">트리거(AT)</h1>
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">자원관리 / 트리거</li>
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
                                            <div class="form-group col-lg-12">
                                                 <label class="col-lg-1" for="trigAtName">이름</label>
                                                 <div class="col-lg-5 input_ty2"><!-- 확인버튼 같이 있는 인풋 유형 .input_ty2 추가 -->
                                                    <input type="text" class="form-control float-left" id="trigAtName"/>
                                                    <button type="button" class="btn btn-info float-left">검색</button>
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
                                        <div class="card-top_btn"><!-- 상단 버튼 위치 div 추가 -->
                                            <button type="button" class="btn btn-primary">삭제</button>
                                            <button type="button" class="btn btn-primary">즉시시작</button>
                                            <button type="button" class="btn btn-primary">예약시작</button>
                                            <button type="button" class="btn btn-primary">정기실행등록</button>
                                        </div>
                                        <div id="GridTrggerAt"></div>
                                        <div id="GridTrggerAtPager" class="portal-pager"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <script>
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
                                'trgCheck' : '<input type="radio" name="radio choice" class="custom-radio" style="width:18px;height:18px;">',
                                'trgType' : '예약',
                                'trgName' : 'F90500_유가공_주문집계현',
                                'trgProcess' : 'F90500_유가공_주문집계',
                                'trgSet' : 'F_002',
                                'trgInfo' : '2020-12-12 5:30:00 PM',
                                'trgTime' : '2020-12-31 11:22:33'
                            };
                        }
                        
                        $("#GridTrggerAt").jsGrid({
                            height : "auto",
                            width : "100%",
                            autoload: true,
                            sorting : true,
                            align : "center",
                            data : params ,
                            rowClick: function(arg){
                                unManagtErrorDetail();
                            },
                            fields : [
                                {name: "trgCheck"         , title : ""        , type : "text"    , width : 20, align : "center"},
                                {name: "trgType"          , title : "구분"        , type : "text"    , width : 20, align : "center"},
                                {name: "trgName"          , title : "이름"        , type : "text"    , width : 90, align : "center"},
                                {name: "trgProcess"       , title : "프로세스"        , type : "text"    , width : 90, align : "center"},
                                {name: "trgSet"           , title : "환경"        , type : "text"    , width : 40, align : "center"},
                                {name: "trgInfo"          , title : "트리거세부정보"        , type : "text"    , width : 100, align : "center"},
                                {name: "trgTime"          , title : "다음런타임"        , type : "text"    , width : 80, align : "center"}
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
            <footer class="main-footer"> Copyright &copy; 2020 <a href="http://www.echoit.co.kr">에코아이티</a>&nbsp;.&nbsp;All rights reserved.</footer>
        </div>
    </div>