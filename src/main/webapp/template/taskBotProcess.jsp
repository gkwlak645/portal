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
                            <h1 class="m-0 text-dark">BOT별 동작현황</h1>
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">모니터링 / BOT별 동작현황</li>
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
 <div class="card card-primary" id="unmanagtErrorRegDiv">                   
    <div class="card-header">
        <h3 class="card-title">프로세스 상태 정보</h3>
    </div>
    <div class="card-body">
        <div class="row" ><!-- style="min-height:674px;" -->
            <div class="col-md-12">
                 <form class="form-inline" id="unmanagtErrorDetail">                                                              
                    <div class="row">
                        <div class="form-group col-md-12 py-sm-2"> 
                            <div id="unmanagtErrorGrid"></div>
                        </div>
                    </div>
                    
                    <div class="form-group col-md-12 py-sm-2">                        
                        <table class="table float-left" style="padding:0;margin-top:10px;">
                            <colgroup>
                              <col width="25%">
                              <col width="*">
                            </colgroup>
                            <thead>                             
                                <tr>
                                    <th>프로세스명</th>
                                    <th>로그</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="text-success">AA-402-M_AgencySalesManagement</td>
                                    <td class="text-left">WARN : org.springframework.web.servlet.PageNotFound - No mapping found for HTTP request with URI 로그내용이 뿌려집니다</td>
                                  </tr>                                  
                              </tbody>
                         </table>
                     </div>  
                </form>
                <div class="float-right py-sm-3">
                    <button type="button" class="btn btn-primary" id="unmanagtErrorDetailCancelBtn">취소</button>
                </div>
                <div id="divSearchUser" class="modal fade" tabindex="-1" role="dialog"></div>
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

        for(var i = 0 ; i < 4 ; i++){
            params[i] = {
                    'unmanagtSn' : '<img src="/resources/images/dist/color_green.gif" alt="color_green">',
                    'errorCn' : 'AA-402-M_AgencySalesManagement',
                    'cmpnyNm' : '2020-08-11 10:08:01',
                    'occrrncSeNm' : '2020-08-11 11:08:01',
                    'tyNm' : '74:14',
                    'unmanagtDe' : '<button class="btn btn-outline-primary"style="padding:2px;min-width:74px;">실시간</button> <button class="btn btn-outline-secondary"style="padding:2px;min-width:74px;">BATCH</button>',
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
                  {name: "unmanagtSn"         , title : "결과"       , type : "text"    , width : 30, align : "center"} 
                , {name: "errorCn"            , title : "프로세스명"          , type : "text"   }
                , {name: "cmpnyNm"         , title : "시작시간"       , type : "text"    , width : 60, align : "center"}
                , {name: "occrrncSeNm"        , title : "종료시간"    , type : "text"    , width : 60, align : "center"}
                , {name: "tyNm"               , title : "처리시간(분:초)"       , type : "text"    , width : 50, align : "center"}
                , {name: "unmanagtDe"          , title : "로그"    , type : "text"    , width : 80, align : "center"}
            ]
        });
        
    }
        
    /*
     * popup창 닫기
     * @param
     * @return
     */
    function closePop() {
        $(".over").remove();
    }

</script>
 </div>

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
</body>
</html>