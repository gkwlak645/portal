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
                            <h1 class="m-0 text-dark">일일미조치현황</h1>
                        </div>
                        <!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">모니터링/ 일일미조치현황</li>
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
				<div id="unmanagtErrorMainDiv" class="container-fluid wrap">
				    <div class="row">
				        <div class="col-md-12">
				            <div class="card">
				                <div class="card-header">
				                    <form class="form-inline">  
                                         <div class="form-group col-md-6 py-sm-1">
                                               <label for="usr" class="col-form-label col-sm-4" >미조치일</label>
                                               <div class="col-sm-8 float-left">
                                                   <div class="input-group date float-left" id="startDeDiv" data-target-input="nearest"style="min-width:140px;width:30%;margin-right:5px;">
                                                       <input type="text" id="startDe" name="startDe" class="form-control datetimepicker-input" data-target="#startDeDiv"/>
                                                       <div class="input-group-append" data-target="#startDeDiv" data-toggle="datetimepicker">
                                                           <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                                       </div>
                                                   </div>
                                                   <div class="input-group date  float-left" id="endDeDiv" data-target-input="nearest"style="min-width:140px;width:30%;">
                                                       <input type="text" id="endDe" name="endDe" class="form-control datetimepicker-input" data-target="#endDeDiv"/>
                                                       <div class="input-group-append" data-target="#endDeDiv" data-toggle="datetimepicker">
                                                           <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                                       </div>
                                                   </div>
                                              </div>
                                          </div>
                                          <div class="form-group col-md-6"></div>
                                          
                                          <div class="form-group col-md-6">
                                           <label for="usr" class="col-form-label col-sm-4" >회사</label>
                                           <div class="col-sm-8">
                                               <select id="cmpnyCd" class="form-control"  style="min-width: 160px;width:70%;">
                                                   <option value=""></option>
                                               </select>
                                           </div>
                                         </div>
                                         <div class="form-group col-md-6">
                                             <label for="processCd" class="col-sm-4 col-form-label">프로세스코드</label>
                                             <div class="col-sm-8">
                                                 <div class="form-group row">
                                                     <select id="processCd" class="form-control"class="form-control"  style="min-width: 160px;width:70%;">
                                                       <option value=""></option>
                                                     </select>
                                                 </div>
                                             </div>
                                         </div>
                                         
                                         <div class="form-group col-md-6">
                                           <label for="occrrncSeCd" class="col-sm-4 col-form-label">오류발생구분</label>
                                           <div class="col-sm-8">
                                               <select id="occrrncSeCd" class="form-control"  style="min-width: 160px;width:70%;">
                                                   <option value=""></option>
                                               </select>
                                           </div>
                                         </div>
                                         <div class="form-group col-md-6">
                                           <label for="tyCd" class="col-sm-4 col-form-label">오류유형</label>
                                           <div class="col-sm-8 float-left">
                                               <select id="tyCd" class="form-control float-left"  style="min-width: 160px;width:70%;">
                                                   <option value=''>선택</option>
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
				                    <button type="button" id="btnSave" class="btn btn-primary float-right" style="margin:5px 0 15px 2px;">등록</button>
				                    <div id="unmanagtErrorGrid"></div>
				                    <div id="unmanagtErrorGridPager" class="portal-pager"></div>
				                </div>
				            </div>
				        </div>
				    </div>
				</div>

				<script>
				
				//일일미조치_오류_일련번호
				var managtErrorSn;
				
				$(document.body).ready(function () { 
					searchUnmanagtErrorList();
				});
				    
				
				    /*
				     * 페이지 초기화
				     * @param
				     * @return
				     */
				    function pageInit() {
				    	//그리드 초기화
				        drawGrid();
				
				        var params = [];
				        params.push({"id" : "cmpnyCd"       , "clsCd" : "0024"});    //회사
				        params.push({"id" : "occrrncSeCd"   , "clsCd" : "0025"});    //오류발생구분
				        requestCmmnCd(params);
				        
				        getProcessCdListByClsCd('processCd');
				    };
				    
				    /*
				     * 이벤트 바인딩
				     * @param
				     * @return
				     */
				    function bindEvent(){
				
				        //조회버튼 클릭 이벤트 처리
				        $("#btnSearch").on("click",function(){
				        	searchUnmanagtErrorList();        	
				        });
				        
				        //등록버튼 클릭 이벤트 처리
				        $("#btnSave").on("click",function(){
				        	unmanagtErrorSave();
				        });        
				        
				        $('#startDeDiv').datetimepicker({
				            format: 'YYYY-MM-DD'
				          , defaultDate: (new Date()).setDate((new Date()).getDate() -7)
				        });
				        
				        $("#endDeDiv").datetimepicker({
				            format: 'YYYY-MM-DD'
				          , defaultDate: (new Date())
				        });
				        
				        //오류발생구분 change 이벤트
				        $("#occrrncSeCd").on("change",function(){
				            var occrrncSeCd = $('#occrrncSeCd').val(); 
				            var params = [];
				            if(occrrncSeCd == '01'){
				            	params.push({"id" : "tyCd" , "clsCd" : "0026"});	
				            }else if(occrrncSeCd == '02'){
				            	params.push({"id" : "tyCd" , "clsCd" : "0027"});
				            }else if(occrrncSeCd == '03'){
				            	params.push({"id" : "tyCd" , "clsCd" : "0028"});
				            }else if(occrrncSeCd == '04'){
				            	params.push({"id" : "tyCd" , "clsCd" : "0029"});
				            }else if(occrrncSeCd == '05'){
				            	params.push({"id" : "tyCd" , "clsCd" : "0030"});
				            }else{}
				            requestCmmnCd(params);
				        });
				        
				    }
				    
				    /*
				     * 그리드 초기화
				     * @param
				     * @return
				     */
				    function drawGrid(data){
				
				        var params = {};
				        if (data != null && data != undefined) {
				        	if (data.result != null && data.result.resultList != null) {
				                params = data.result.resultList;
				        	}
				            drawPager("unmanagtErrorGridPager", data.result.paginationInfo, "searchUnmanagtErrorList");
				        }
				
				        $("#unmanagtErrorGrid").jsGrid({
				              height : "auto"
				            , width : "100%"
				            , autoload: true
				            , sorting : true
				            , align : "center"
				            , data : params
				            , rowClick: function(arg){
				            	unManagtErrorDetail(arg.item.unmanagtSn);
				            }
				            , fields : [
				            	  {name: "unmanagtSn"         , title : "일련번호"       , type : "text"    , visible: false  , width : 80 }  
				            	, {name: "cmpnyNm"            , title : "회사"          , type : "text"    , width : 80}
				                , {name: "unmanagtDe"         , title : "미조치일"       , type : "text"    , width : 80, align : "center"}
				                , {name: "occrrncSeNm"        , title : "오류발생구분"    , type : "text"    , width : 80, align : "center"}
				                , {name: "tyNm"               , title : "오류유형"       , type : "text"    , width : 100, align : "center"}
				                , {name: "processSn"          , title : "프로세스코드"    , type : "text"    , width : 80, align : "center"}
				                , {name: "errorCn"            , title : "오류내용"       , type : "text"    , width : 200}
				                , {name: "managtCn"           , title : "조치내용"       , type : "text"    , width : 200}
				                , {name: "managtTyNm"         , title : "현상태"        , type : "text"    , width : 70, align : "center"}
				            ]
				        });
				        
				    }
				    
				    /*
				     * 검색
				     * @param 페이지번호
				     * @return
				     */
				    function searchUnmanagtErrorList(pageNo) {
				
				        var url = '/mntrng/unmanagterror/getUnmanagtErrorList';
				        var currentPageNo = 1;
				        if (pageNo != null && pageNo != undefined && pageNo != "") {
				            currentPageNo = pageNo;
				        }
				        
				        var param = {
				        	  cmpnyCd               : $("#cmpnyCd").val()
				            , startDe               : $("#startDe").val().replace(/-/g, "")
				            , endDe                 : $("#endDe").val().replace(/-/g, "")
				            , processSn             : $("#processCd").val()
				            , occrrncSeCd           : $("#occrrncSeCd").val()
				            , tyCd                  : $("#tyCd").val()
				            , currentPageNo         : currentPageNo
				            , recordCountPerPage    :   10
				            , pageSize              :   10
				        }; 
				        
				        callAsyncAjax(url, param, "drawGrid");
				    }
				    
				    
				    /*
				     * 검색
				     * @param 페이지번호
				     * @return
				     */
				    function unmanagtErrorSave() {
				        //등록페이지 호출
				        appendDetailPopup("unmanagtErrorMainDiv", "/mntrng/unmanagterror/unmanagtErrorSave");
				    }
				    
				    
				    /*
				     * 상세페이지 팝업
				     * @param 
				     * @return
				     */
				    function unManagtErrorDetail(id) {
				        //상세 페이지 div 생성
				        appendDetailPopup("unmanagtErrorMainDiv", "/mntrng/unmanagterror/unmanagtErrorDetailPop");
				        managtErrorSn = id; 
				    };
				    
				    /*
				     * popup창 닫기
				     * @param
				     * @return
				     */
				    function closePOP(){
				        $(".over").remove();
				        //searchUnmanagtErrorList();
				    }
				    
				    /*
				     * 저장 후 popup창 닫기
				     * @param
				     * @return
				     */
				    function saveClosePOP(){
				        $(".over").remove();
				        searchUnmanagtErrorList();
				    }
				    
				
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
