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
                            <h1 class="m-0 text-dark">공통코드관리</h1>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="/main/siteMain">Home</a></li>
                                <li class="breadcrumb-item">기준정보 / 공통코드관리</li>
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
                <div>
					<div class="container-fluid">
						<div class="row">
							<div class="col-md-6" alt="기준정보 > 공통코드관리">
								<div class="card card-primary">
									<div class="card-body">
		                                <form class="form-inline">
                                           <div class="form-group col-sm-6"style="min-width:330px;">
                                              <label for="schClsCd" class="col-sm-4 col-form-label">분류코드</label>
                                              <div class="col-sm-8">
                                                <input type="text" class="form-control"style="width:126px;" id="schClsCd" maxlength="4" placeholder="분류코드"/>
                                               </div>
                                            </div>
                                        
                                        
                                            <div class="form-group col-sm-6"style="min-width:330px;">
                                                <label for="schQueName" class="col-sm-4 col-form-label">분류코드명</label>
                                                <div class="col-sm-8 float-left">
                                                    <input type="text" class="form-control float-left"style="width:40%; min-width:126px;" id="schClsNm" maxlength="20" placeholder="분류코드명" />
                                                    <button type="button" id="searchClsBtn" class="btn btn-info float-left">조회</button>
                                                </div>
                                            </div>
                                        </form>  
		                                 
		                                 
										<div id="cmmnClsCdGrid"></div>
										
										<div class="form-group" style="margin: 1.25rem 0.1rem 1rem 0.1rem;">
				                            <label for="inputDescription">분류코드<b style="color: red;"> *</b></label>
				                            <input type="text" id="inputClsCd" class="form-control" maxlength="4" disabled>
				                        </div>
				                        <div class="form-group" style="margin: 0.25rem 0.1rem 1rem 0.1rem;">
				                            <label for="inputDescription">분류코드명<b style="color: red;"> *</b></label>
				                            <input type="text" id="inputClsCdNm" maxlength="20" class="form-control" >
				                        </div>
				                        <div class="form-group" style="margin: 0.25rem 0.1rem 1rem 0.1rem;">
				                            <label for="inputDescription">분류코드 설명</label>
				                            <input type="text" id="inputClsCdDc" maxlength="60" class="form-control" >
				                        </div>
				                        <div class="form-group" style="margin: 0.25rem 0.1rem 1rem 0.1rem;">
				                            <label for="inputDescription">사용여부<b style="color: red;"> *</b></label>
				                            <select class="form-control custom-select" id="inputUseAt">
				                                <option value="" selected disabled>선택</option>
				                                <option value="Y">사용</option>
				                                <option value="N">미사용</option>
				                            </select>
				                        </div>
				                         <div class="float-right" style="margin: 0.25rem 0.1rem 0 0.1rem;">
				                            <c:if test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
				                                <button type="button" class="btn btn-primary"  style="margin:5px 0 15px 0;" id="btnInsertClsCd" >추가</button>
				                                <button type="button" class="btn btn-primary"  style="margin:5px 0 15px 0;" id="btnUpdateClsCd">저장</button>
				                                <button type="button" class="btn btn-primary"  style="margin:5px 0 15px 0;" data-toggle="modal" data-target="#modal-lg-clsCd" id="btnDeleteClsCdCheck">삭제</button>
				                            </c:if>
				                        </div>
				                        
									</div>
								</div>
							</div>
							<div class="col-md-6">
								<div class="card card-info">
									<div class="card-body">
				                         <form class="form-inline">
                                           <div class="form-group col-sm-6"style="min-width:330px;">
                                              <label for="schCd" class="col-sm-4 col-form-label">코드</label>
                                              <div class="col-sm-8">
                                                <input type="text" class="form-control"style="width:126px;" id="schCd" maxlength="4" placeholder="코드" />
                                               </div>
                                            </div>
                                        
                                        
                                            <div class="form-group col-sm-6"style="min-width:330px;">
                                                <label for="schQueName" class="col-sm-4 col-form-label">코드명</label>
                                                <div class="col-sm-8 float-left">
                                                    <input type="text" class="form-control float-left"style="width:40%; min-width:126px;" id="schCdNm" maxlength="20" placeholder="코드명" />
                                                    <button type="button" id="searchCdBtn" class="btn btn-info float-left">조회</button>
                                                </div>
                                            </div>
                                        </form>  
									    <div id="cmmnCdGrid"></div>
				                        <div class="form-group" style="margin: 1.25rem 0.1rem 1rem 0.1rem;">
				                            <label for="inputDescription">코드<b style="color: red;"> *</b></label>
				                            <input type="text" id="inputCd" class="form-control" maxlength="4" disabled>
				                        </div>
				                        <div class="form-group"style="margin: 0.25rem 0.1rem 1rem 0.1rem;">
				                            <label for="inputDescription">코드명<b style="color: red;"> *</b></label>
				                            <input type="text" id="inputCdNm" maxlength="20" class="form-control" >
				                        </div>
				                        <div class="form-group"style="margin: 0.25rem 0.1rem 1rem 0.1rem;">
				                            <label for="inputDescription">코드 설명</label>
				                            <input type="text" id="inputCdDc" maxlength="60" class="form-control" >
				                        </div>
				                        <div class="form-group"style="margin: 0.25rem 0.1rem 1rem 0.1rem;">
				                            <label for="inputDescription">사용여부<b style="color: red;"> *</b></label>
				                            <select class="form-control custom-select" id="inputUseAt2">
				                                <option value="" selected disabled>선택</option>
				                                <option value="Y">사용</option>
				                                <option value="N">미사용</option>
				                            </select>
				                        </div>
				                        <div class="float-right" style="margin: 0.25rem 0.1rem 0 0.1rem;">
				                            <c:if test="${txScreenAuthor.wrtngAuthor eq 'Y'}">
				                            <button type="button" class="btn btn-primary"  style="margin:5px 0 15px 0;" id="btnInsertCd">추가</button>
				                            <button type="button" class="btn btn-primary"  style="margin:5px 0 15px 0;" id="btnUpdateCd">저장</button>
				                            <button type="button" class="btn btn-primary"  style="margin:5px 0 15px 0;" id="btnDeleteCd">삭제</button>
				                            </c:if>
				                        </div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="modal fade-dept" id="modal-lg-clsCd">
				    <div class="modal-dialog modal-lg">
				        <div class="modal-content">
				            <div class="modal-header"></div>
				            <div class="modal-body" >
				                                    하위 코드가 모두 삭제 됩니다. 진행하시겠습니까? 
				            </div>
				            <div class="modal-footer justify-content-between">
				                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				                <button type="button" class="btn btn-primary" id="btnDeleteClsCd" data-dismiss="modal">확인</button>
				            </div>
				        </div>
				   </div>
				</div>
				
				<div class="modal fade-dept" id="modal-lg-useAt">
				    <div class="modal-dialog modal-lg">
				        <div class="modal-content">
				            <div class="modal-header"></div>
				            <div class="modal-body" >
				                                    하위 코드가 모두 비활성화 됩니다. 진행하시겠습니까? 
				            </div>
				            <div class="modal-footer justify-content-between">
				                <button type="button" class="btn btn-default" data-dismiss="modal" id="btnUseAtCancel">취소</button>
				                <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
				            </div>
				        </div>
				   </div>
				</div>
				
				<script>
					var userList = "";
					var chekClsCd ="";
				
					function pageInit() {
						cmmnCdClsDrawGrid();
						drawCdGrid("");
						 if($("#inputClsCd").val("")){
				             $("#btnDeleteClsCdCheck").attr("disabled", true);
				         }
						 if($("#inputCd").val("")){
				             $("#btnDeleteCd").attr("disabled", true);
				         }
					}
				
					function bindEvent() {
						
						$("#schClsCd, #inputClsCd, #schCd, #inputCd").on("blur keyup", function() {
					        $(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
					        $(this).val( $(this).val().replace(/(\s*)/g, '' ) );
					    });
						
						$("#schClsCd, #schClsNm").keyup(function(e){
				            if(e.keyCode == 13){
				            	cmmnCdClsDrawGrid();
				            	cmmnCdDrawGrid("");
				            	$("#inputClsCd").attr("disabled", false);
				                setCmmnClsCd();
				            }
				        });
						
						$("#schCd, #schCdNm").keyup(function(e){
				            if(e.keyCode == 13){
				            	cmmnCdDrawGrid($("#inputClsCd").val());
				            	$("#inputCd").attr("disabled", false);
				                setCmmnCd();
				            }
				        });
						
						$("#searchClsBtn").on("click",function(){ 
							cmmnCdClsDrawGrid();
							drawCdGrid("");
							$("#inputClsCd").attr("disabled", false);
				            setCmmnClsCd();
				        });
						
						$("#searchCdBtn").on("click",function(){ 
							cmmnCdDrawGrid($("#inputClsCd").val());
				            $("#inputCd").attr("disabled", false);
				            setCmmnCd();
				        });
				        
						
						$("#btnInsertCd").on("click", function(){
							$("#inputCd").attr("disabled", false);
							setCmmnCd();
						});
						
						$("#btnInsertClsCd").on("click", function(){
							$("#inputClsCd").attr("disabled", false);
				            setCmmnClsCd();
				        });
						
						$("#btnUpdateCd").on("click", function(){
							var clsCd = $("#inputClsCd").val();
							var cd = $("#inputCd").val();
					        var cdNm = $("#inputCdNm").val();
					        var cdDc = $("#inputCdDc").val();
					        var useAt = $("#inputUseAt2").val();
					        if(clsCd == "" || clsCd == null){
					        	clsCd = chekClsCd;
					        }
					        if(clsCd == "" || clsCd == null){
					        	alert("분류코드를 선택해 주세요!");
					        	return false;
					        }
					        if(cd == null || cd == ""){
					        	alert("코드를  입력해주세요.");
					        	$("#inputCd").focus();
					        	return false;
					        }else if(cdNm == null || cdNm == ""){
				                alert("코드명을  입력해주세요.");
				                $("#inputCdNm").focus();
				                return false;
				            }else if(useAt == null || useAt == ""){
				                alert("사용여부를 선택해주세요");
				                $("#inputUseAt2").focus();
				                return false;
				            }else{
					        	inputCmmnCd(clsCd, cd, cdNm, cdDc, useAt);
					        	cmmnCdDrawGrid(clsCd);
					            $("#inputCd").attr("disabled", true);
					            $("#inputClsCd").attr("disabled", true);
					           /*  setCmmnCd(); */
					        }
						});
						
						$("#btnUpdateClsCd").on("click", function(){
				            var clsCd = $("#inputClsCd").val();
				            var clsCdNm = $("#inputClsCdNm").val();
				            var clsCdDc = $("#inputClsCdDc").val();
				            var useAt = $("#inputUseAt").val();
				            if(clsCd == null || clsCd == ""){
				            	alert("분류코드를  입력해주세요.");
				            	return false;
				            }else if(clsCdNm == null || clsCdNm == ""){
				            	alert("분류코드명을  입력해주세요.");
				                $("#inputClsCdNm").focus();
				                return false;
				            }else if(useAt == null || useAt == ""){
				            	alert("사용여부를 선택해주세요");
				            	$("#inputUseAt").focus();
				            	return false;
				            }else{
				            	inputCmmnClsCd(clsCd, clsCdNm, clsCdDc, useAt);
				            	$("#inputCd").attr("disabled", true);
				            	$("#inputClsCd").attr("disabled", true);
				                setCmmnClsCd();
				            }
				        });
						
						$("#btnDeleteCd").on("click", function(){
							var clsCd = $("#inputClsCd").val();
							var cd = $("#inputCd").val();
							if(clsCd == "" || clsCd == null){
								clsCd=chekClsCd;
							}
							deleteCmmnCd(clsCd, cd);
							cmmnCdDrawGrid(clsCd);
				 			/* setCmmnCd(); */ 
						});
						
						$("#btnDeleteClsCd").on("click", function(){
				            var clsCd = $("#inputClsCd").val();
				            deleteCmmnClsCd(clsCd);
				            setCmmnClsCd();
				        });
						
						$("#inputUseAt").on("change", function(){
							var useAt = $("#inputUseAt").val();
							if(useAt == "N"){
							    $("#modal-lg-useAt").modal("show");
							}
						});
						
						$("#btnUseAtCancel").on("click", function(){
							$("#inputUseAt").val("Y");
						});
					}
					
					function cmmnCdClsDrawGrid() {
						var url = "/stdrinfo/cmmncd/getCmmnClsCdList";
						var param ={
								 clsCd    : $("#schClsCd").val()
							    ,clsCdNm : $("#schClsNm").val()
						}; 
						callAsyncAjax(url, param, "drawClsCdGrid");
					}
					
					function drawClsCdGrid(data) {
						if (data != "") {
							userList = data.result.cmmnCdList;
						}
						if($("#inputClsCd").val("")){
				            $("#btnDeleteClsCdCheck").attr("disabled", true);
				        }
						$("#cmmnClsCdGrid").jsGrid({
							height : "260",
							width : "100%",
							autoload : true,
							sorting : true,
							scroll : true,
							rowClick : function(args) {
							    $(".jsgrid-row, .jsgrid-alt-row").removeClass("highlight");
								chekClsCd = args.item.clsCd;
							    var gRow = this.rowByItem(args.item);
								gRow.addClass("highlight");
								var clsCdDc = args.item.clsCdDc;
								$("#btnDeleteClsCdCheck").attr("disabled", false);
								setCmmnCd();
								/* setCmmnClsCd(); */
								$("#inputClsCd").attr("disabled", true);
								cmmnClsCdValue(args.item.clsCd, args.item.clsCdNm, args.item.useAt, clsCdDc); 
								cmmnCdDrawGrid(args.item.clsCd); 
							},
							data : userList.items,
							fields : [ {
							    name : "clsCd",
								title : "분류코드",
								type : "text",
								align : "center",
								width : 50
							    }, {
								name : "clsCdNm",
								title : "분류코드명",
								type : "text",
								align : "center",
								width : 100
							    }, {
								name : "useAt",
								title : "사용여부",
								type : "text",
								align : "center",
								width : 50
							    } ]
							});   
						
					}
				
					function cmmnClsCdValue(clsCd, clsCdNm, useAt, clsCdDc) {
						$("#inputClsCd").val(clsCd);
						$("#inputClsCdNm").val(clsCdNm);
						$("#inputClsCdDc").val(clsCdDc);
					    $("#inputUseAt").val(useAt).attr("selected", "selected");
					}
					
					
					function cmmnCdDrawGrid(value) {
						/* if(value == "" || value == null){
							alert('분류코드를 선택해 주세요.');
							return false;
						} */
				        var url = "/stdrinfo/cmmncd/getCmmnCdList";
				        var param = {
				        		 clsCd   : value
				        		,cd      : $("#schCd").val()
				                ,cdNm    : $("#schCdNm").val()
				        };
				        
				        callSyncAjax(url, param, "drawCdGrid"); //동기로 바꿔봄 => 비동기로 움직이다 보니 그리드를 그리기전에 다른 일을 처리하여 그리드가 나타나지 않음
				    }
					
				    function drawCdGrid(data) {
				    	var userCdList = "";
				        if (data != "") {
				            var userCdList = data.result.cmmnCdList;
				        }
				        if($("#inputCd").val("")){
				            $("#btnDeleteCd").attr("disabled", true);
				        }
				        $("#cmmnCdGrid").jsGrid({
				            height : "260",
				            width : "100%",
				            autoload : true,
				            sorting : true,
				            scroll : true,
				            rowClick : function(args) {
				                $(".jsgrid-row, .jsgrid-alt-row").removeClass("highlightSec");
				                var gRow = this.rowByItem(args.item);
				                gRow.addClass("highlightSec");
				                var cdDc = args.item.clsCdDc;
				               cmmnCdValue(args.item.cd, args.item.cdNm,args.item.useAt, cdDc);
				               $("#inputCd").attr("disabled", true);
				               $("#btnDeleteCd").attr("disabled", false);
				            },
				            data : userCdList.items,
				            fields : [ {
				                name : "cd",
				                title : "코드",
				                type : "text",
				                align : "center",
				                width : 50
				                }, {
				                name : "cdNm",
				                title : "코드명",
				                type : "text",
				                align : "center",
				                width : 100
				                }, {
				                name : "useAt",
				                title : "사용여부",
				                type : "text",
				                align : "center",
				                width : 50
				                } ],
				                onRefreshed: function(args) {
				                    if (args.grid.data.length) {
				                        var gridBody = $("#cmmnCdGrid").find('.jsgrid-grid-body');
				                        gridBody.find('.jsgrid-table tr:first-child').trigger('click');
				                        
				                    }else{
				                        setCmmnCd();
				                    }
				                }
				            });
				    }
				    
				    function cmmnCdValue(cd, cdNm, useAt, cdDc) {
				    	$("#inputCd").val(cd);
				    	$("#inputCdNm").val(cdNm);
				    	$("#inputCdDc").val(cdDc);
				        $("#inputUseAt2").val(useAt).attr("selected", "selected");
				    }
				    
				    function setCmmnCd(){
				    	$("#inputCd").val("");
				        $("#inputCdNm").val("");
				        $("#inputCdDc").val("");
				        $("#inputUseAt2").val("").attr("selected", "selected"); 
				    }
				   
				     function setCmmnClsCd(){
				     	$("#inputClsCd").val("");
				    	$("#inputClsCdNm").val("");
				    	$("#inputClsCdDc").val("");
				        $("#inputUseAt").val("").attr("selected", "selected");
				    	/* var gridBody = $("#cmmnClsCdGrid").find('.jsgrid-grid-body');
				        console.log(gridBody);
				        gridBody.find('jsgrid-table tr:first-child').trigger('click'); */
				    }
				    
				    
				    function inputCmmnCd(clsCd, cd, cdNm, cdDc, useAt){
				        var clsCd2 = clsCd;
				        var url = "/stdrinfo/cmmncd/inputCmmnCd";
				        var params = {
				        		 "clsCd" : clsCd2
				        		,"cd" : cd
				        		,"cdNm" : cdNm
				        		,"cdDc" : cdDc
				        		,"useAt" : useAt
				        };
				        callSyncAjax(url, params, "reLoad");
				    }
				    
				    function inputCmmnClsCd(clsCd, clsCdNm, clsCdDc, useAt){
				         var url = "/stdrinfo/cmmncd/inputCmmnClsCd";
				         var params = {
				                  "clsCd" : clsCd
				                 ,"clsCdNm" : clsCdNm
				                 ,"clsCdDc" : clsCdDc
				                 ,"useAt" : useAt
				         };
				         callAsyncAjax(url, params, "reLoadCls");
				    }
				    
				    function reLoad(){
				    	$("#inputCd").attr("disabled", true);
				    	cmmnCdDrawGrid();
				    }
				    
				    function reLoadCls(data){
				        $("#inputClsCd").attr("disabled", true);
				        cmmnCdClsDrawGrid();
				        cmmnCdDrawGrid(); 
				    }
				    
				    function deleteCmmnCd(clsCd, cd){
				    	var url = "/stdrinfo/cmmncd/deleteCmmnCd";
				    	var params = {
				    			"clsCd" : clsCd,
				    			"cd" : cd
				    	};
				    	callSyncAjax(url, params, "reLoad");
				    }
				    
				    function deleteCmmnClsCd(clsCd){
				        var url = "/stdrinfo/cmmncd/deleteCmmnClsCd";
				        var params = {
				                "clsCd" : clsCd
				        };
				        callAsyncAjax(url, params, "reLoadCls");
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