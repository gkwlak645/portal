<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="card card-primary" id = "cardDiv" style="height:auto; min-height:620px">
    <div class="card-header">
        <h3 class="card-title">등록</h3>
    </div>
    <div class="card-body" alt="조직 > 사용자관리 등록 ">
        <div class="row">
            <div class="col-md-12">
                <div class="form-inline" >
		            <div class="form-group col-md-6 py-sm-2"  style="margin: 0.25rem 0 0.3rem 0;">
		                <label class="col-sm-4 col-form-label">사용자 아이디 <b style="color: red;">*</b></label>
		                <div class="col-sm-8">
		                   <input type="text" id="userId" class="form-control" style="width:60%;margin-right: 3px;" >
		                </div>
		            </div>
	                <div class="form-group col-md-6 py-sm-2"  style="margin: 0.25rem 0 0.3rem 0;">
	                    <label class="col-sm-4 col-form-label">이메일 주소</label>
	                    <div class="col-sm-8">
	                        <input type="email" id="emailAdr" class="form-control" style="width:80%;margin-right: 3px;" placeholder="Email 끝까지 작성해 주세요">
	                    </div>
	                </div>
	                <div class="form-group col-md-6 py-sm-2"  style="margin: 0.25rem 0 0.3rem 0;">
	                    <label class="col-sm-4 col-form-label">직위</label>
	                    <div class="col-sm-8">
	                        <select class="form-control" id="pstCd" style="width:60%;margin-right: 3px;" ></select>
	                    </div>
	                </div>
	                <div class="form-group col-md-6 py-sm-2"  style="margin: 0.25rem 0 0.3rem 0;">
	                    <label class="col-sm-4 col-form-label">사용 여부</label> 
	                    <div class="col-sm-8">
	                        <select class="form-control" id="useAt" style="width:60%;margin-right: 3px;" >
	                            <option selected disabled>사용여부선택</option>
	                            <option value="Y">사용</option>
	                            <option value="N">미사용</option>
	                        </select>
	                    </div>
	                </div>
	             </div>
	        </div>
            <div class="col-md-12">
                <div class="form-inline" >
	                <div class="form-group col-md-6 py-sm-2"  style="margin: 0.25rem 0 0.5rem 0;">
	                    <label class="col-sm-4 col-form-label">사용자 명<b style="color: red;">*</b></label>
	                    <div class="col-sm-8">
                             <input type="text" id="empNm" class="form-control" style="width:60%;margin-right: 3px;">
	                    </div>
	                </div>
	                <div class="form-group col-md-6 py-sm-2"  style="margin: 0.25rem 0 0.5rem 0;">
	                    <label class="col-sm-4 col-form-label">사원 번호<b style="color: red;">*</b></label>
	                    <div class="col-sm-8">
                            <input type="text" id="empNo" class="form-control float-left" style="width:60%;margin: 6px 5px 0 0;">
	                        <button type="button" class="btn btn-outline-primary float-left" data-toggle="modal" data-target="#modal-lg" id="empSearch">사원 검색</button>
	                    </div>
	                </div>
	   			</div>
				<div>
					<div class="float-right" style="margin:15px 0 15px 0;">
						<button type="button" class="btn btn-primary" id="userRegister">저장</button>
						<button type="button" class="btn btn-primary" id="cancel">취소</button>
					</div>
			     </div>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="modal-lg">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">사원검색</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body" >
				<form name="searchForm" class="form-horizontal">
					<div class="col-sm-12 row">
						<div class="col-sm-5" style="margin: 0.25rem 0 0.3rem 0;">
							<div class="form-group row">
								<label for="inputUserId" class="col-sm-5 col-form-label">사원번호</label>
								<div class="col-sm-7">
									<input type="text" class="form-control" id="inputEmpNo"	style="width:80%;" placeholder="사원번호" />
								</div>
							</div>
						</div>
						<div class="col-sm-7" style="margin: 0.25rem 0 0.3rem 0;">
							<div class="form-group row">
								<label for="inputEmpNm2" class="col-sm-3 col-form-label">사원명</label>
								<div class="col-sm-9">
									<input type="text" class="form-control float-left" id="inputEmpNm2" style="width:50%;" placeholder="사원명" />
									<input type="button" id="searchBtn2" class="btn btn-info float-left" value="검색" />
								</div>
							</div>	
						</div>
					</div>
				</form>
				<div class="card-body">
					<div id="userSearchGrid2"></div>
					<div id="paging2" style="text-align: center"></div>
				</div>
			</div>
			<div class="modal-footer justify-content-between">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary" id="choBtn" data-dismiss="modal">선택</button>
			</div>
		</div>
	</div>
</div>

<script>
	var searchNo2 = "";
	var searchNm2 = "";
	var userListPop = "";
	var selectValue ="";
	var selectEmpData = "";
	
	$(document).ready(function() {
		pageInit();
		bindEvent();
	});

	function pageInit() {
		ajaxCall();
		drawGrid2();
	}

	function bindEvent() {
		$("#cancel").on("click", function() {
			backList();
		});
		
		$("#userRegister").on("click", function() {
			if($("#userId").val() == "" || $("#empNm").val() == "" || $("#empNo").val() == ""){
				alert("필수 항목을 채워주세요");
				return false;
			}else if($("#emailAdr").val() == ""){
				alert("이메일을 입력해야 초기비밀번호가 보내집니다. 입력해주세요");
				return false;
			}else if ($("#useAt").val() == null){
				alert("사용 여부를 선택해 주세요!");
				return false;
			}
			userIdCheck($("#userId").val());
		});

		$("#empSearch").on("click",function(){
            $("#inputEmpNo").val("");
            $("#inputEmpNm2").val("");
            $("#userSearchGrid2").jsGrid("destroy");
            $(".paging2Class").remove();
        });
		
		$("#searchBtn2").on("click",function(){
	        searchNo2 = $("#inputEmpNo").val();
	        searchNm2 = $("#inputEmpNm2").val();
	        ajaxGridComm2(searchNo2, searchNm2, 1);
	    });
	    
		$("#inputEmpNo, #inputEmpNm2").keyup(function(e){
            if(e.keyCode == 13){
                searchNo2 = $("#inputEmpNo").val();
                searchNm2 = $("#inputEmpNm2").val();
                $(".paging2Class").remove();
                ajaxGridComm2(searchNo2,searchNm2,1);
            }
        });
        
	    $("#choBtn").on("click",function(){
	       	empSearchData();
        });
	    
	    $(document).on("click",".paging2Class",function(){
            if($(this).text() == "처음"){
                ajaxGridComm2(searchNo2,searchNm2,1);
            }else if($(this).text() == "이전"){
                ajaxGridComm2(searchNo2,searchNm2,userListPop.pageInfo.currentPageNo-1);
            }else if($(this).text() == "다음"){
                ajaxGridComm2(searchNo2,searchNm2,userListPop.pageInfo.currentPageNo+1);
            }else if($(this).text() == "마지막"){
                ajaxGridComm2(searchNo2,searchNm2,userListPop.pageInfo.totalPageCount);
            }else{
                ajaxGridComm2(searchNo2,searchNm2,$(this).text());
            }
        });
	} 
    
	function userIdCheck(data){
		var url ="/orgnzt/user/selectUserIdCheck";
		var param = {
				"userId" : data
		};
		callSyncAjax(url, param, "callBackCheckId");
	}
	
	function ajaxCall(){
		var url = "/orgnzt/user/userCategory";
		var param = {};
		callAsyncAjax(url, param, "callBackCategory");
	}
	
	function callBackCategory(data){
        var valCategory = data.result.list;
        $("#pstCd").append("<option selected disabled>직위선택</option>");
        $.each(valCategory, function(index, item){
            $("#pstCd").append("<option value = '" +item.cd+ "'> "+item.cdNm+"</option>"); 
        });
	}
	
	function userRegister() {
		var url = "/orgnzt/user/registerUser";
		var param = {
				"userId"    : $("#userId").val()
		      , "empNo"     : $("#empNo").val()
              , "empNm"     : $("#empNm").val()
              , "emailAdr"  : $("#emailAdr").val()
              , "useAt"     : $("#useAt").val()
		};
		callAsyncAjax(url, param, "goListPage");
	}
	function goListPage(){
		alert("사용자 등록이 완료되었습니다. 초기 비밀번호는 메일 주소 "+$("#emailAdr").val()+" 으로 전송하였습니다");
		cudBackList();
	}
	
	function ajaxGridComm2(num, name, pageNum){
	    var url = '/orgnzt/user/userSearchEmpNum';
	    var param = {
	         "empNo": num
	        ,"empNm": name
	        ,"pageInfo" : {
	        	"currentPageNo": pageNum
	          , "recordCountPerPage" : 5
             }
	    };
	    callAsyncAjax(url, param, "drawGrid2");
	}
	function drawGrid2(data){
		if(data != null){
             userListPop = data.result.userList;
             if (userListPop.pageInfo.totalRecordCount > 5) {
                pagingGrid(userListPop.pageInfo,"paging2");
            }
        }
        $("#userSearchGrid2").jsGrid({
            height : "auto",
            width : "100%",
            autoload: true,
            sorting : true,
            pageSize: 5,
            selecting : true,
            rowClick: function(args) {
                $(".jsgrid-row, .jsgrid-alt-row").removeClass("highlight");
                var gRow = this.rowByItem(args.item);
                gRow.addClass("highlight");
                selectEmpData = args.item;
            },                  
            data: userListPop.items,
            fields : [ 
                {name: "empNo" ,title : "사원번호", type : "text", align : "center", width : 70},
                {name: "empNm" ,title : "사용자명", type : "text", align : "center", width : 70},
                {name: "pstNm" ,title : "직급", type : "text", align : "center", width : 50}, 
                {name: "telno" ,title : "전화번호", align : "center", width : 80,
                    itemTemplate:function(value){
                        return $("<span>").text(dashPlus(value));
                }},
                {name: "emailAdr" ,title : "이메일주소", type : "text", align : "center", width:120}
            ]
        });
    }
	
    function empSearchData(){
    	$(".fade-empNo").modal("toggle");
        $("#empNm").val(selectEmpData.empNm);
        $("#emailAdr").val(selectEmpData.emailAdr);
        $("#empNo").val(selectEmpData.empNo);
        $("#pstCd").val(selectEmpData.pstCd);
    }
    
     function callBackCheckId(data){
    	var checkId = data.result.idCheck;
    	if(checkId > 0){
    		alert("존재하는 아이디 입니다.");
    		$("#userId").val("").focus();
    		return false;
    	}else{
    		userRegister();
    	}
    }
</script>