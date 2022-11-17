<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- SEARCH FORM -->
<div class="container-fluid wrap">  
    <div class="row">
          <div class="col-md-12">
               <div class="card card-default">
                  <div class="card-header" style="height:auto;" >
                      <form name="searchForm"id="searchForm" class="form-inline">       
                        <div class="form-group col-sm-4">
                             <label for="cmpnyCd" class="col-sm-2 col-form-label">회사</label>
                             <div class="col-sm-10">
                                 <div style="padding-left:15px;">
                                       <select id="cmpnyCd" class="form-control"  style="width:60%;max-width:200px;">
                                            <option value=""></option>
                                        </select>
                                  </div>
                             </div>
                         </div>
                                                     
                        <div class="form-group col-sm-4">
                             <label for="inputUserId" class="col-sm-3 col-form-label">사용자아이디</label>
                             <div class="col-sm-9">
                                <input type="text" class="form-control" style="width:60%;max-width:200px;" id="inputUserId" placeholder="사용자아이디" />
                             </div>
                         </div>
                      
                          <div class="form-group col-sm-4">
                              <label for="inputEmpNm" class="col-sm-2 col-form-label">사용자명</label>
                              <div class="col-sm-10">
                                  <input type="text" class="form-control float-left"style="width:60%;max-width:200px;" id="inputEmpNm" placeholder="사용자명" />
                                  <input type="button" id="searchBtn" class="btn btn-info  float-left" value="조회" />
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
                    <div id="userSearchGrid"></div>
                    <div id="paging" class="portal-pager"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- page script -->
<script>

var currentPageNo = 1;

$(document.body).ready(function () {    
	
	 var params = [];
     if("${txScreenAuthor.untenantAuthor}" == 'Y'){
         params.push({"id" : "cmpnyCd", "clsCd" : "0024"});    //회사
     }else{
         params.push({"id" : "cmpnyCd", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
     } 
     requestCmmnCd(params);
	
});

    var searchId = "";
    var searchNm = "";
    var userList = "";
    var cudPage = 1;
    
    function pageInit() { 
    	ajaxGridComm();
        //drawGrid("");
    };
    
    function bindEvent(){
        $("#searchBtn").on("click",function(){
        	ajaxGridComm(); 
        });
        
        $("#inputUserId, #inputEmpNm").keyup(function(e){

            if(e.keyCode == 13){
                ajaxGridComm(); 
            }
        });

        $("#regBtn").on("click",function(){
            var url = "/orgnzt/user/userRegisterPagePop";
            appendDivReg(url);
        });          
    }
    
    function ajaxGridComm(pageNo){ 
        var url = '/orgnzt/user/userManageList';
        currentPageNo = 1;
        if (pageNo != null && pageNo != undefined && pageNo != "") {
            currentPageNo = pageNo;
        }
        
        var param = {
                userId: $("#inputUserId").val(),
                empNm: $("#inputEmpNm").val(),
                cmpnyCd: $('#cmpnyCd').val()
                , currentPageNo         : currentPageNo
                , recordCountPerPage    :   10
                , pageSize              :   10
        };
        
        callAsyncAjax(url, param, "drawGrid");
    }
    
    function drawGrid(data){   	 	
    	var params = {};
        if (data != null && data != undefined) {
            if (data.result != null && data.result.resultList != null) {
                params = data.result.resultList;

            }
                     
            drawPager("paging", data.result.paginationInfo, "ajaxGridComm");
        }       
        
        $("#userSearchGrid").jsGrid({
            height : "auto",
            width : "100%",
            autoload: true,
            sorting : true,
            paging : true,
            scroll : true,
            rowClick: function(arg){
                detailPageMove(arg.item.userId);
            },
            data: params,
    
            fields : [ 
            	{name: "cmpnyNm" ,title : "회사", align : "left", type : "text", width : 80},
                {name: "userId" ,title : "아이디", align : "left", type : "text", width : 70}, 
                {name: "empNm" ,title : "사용자명", align : "left", type : "text", width : 60}, 
//              {name: "empNo" ,title : "사원번호", align : "center", type : "text", width : 60} 
//                {name: "pstNm" ,title : "직급", align : "center", type : "text", width : 50}, 
                {name: "deptNm" ,title : "부서", align : "left", type : "text", width : 100}, 
                /* {name: "telno" ,title : "전화번호", align : "center", 
                    itemTemplate:function(value){
                           return $("<span>").text(dashPlus(value));
                    }},  */
                {name: "emailAdr" ,title : "이메일주소", align : "left",  type : "text", width : 125}, 
                {name: "useAt" ,title : "사용여부", align : "left", type : "text", width : 50} 
            ]
        });
    }
    
    function appendDivDetailGet(url){
        var html = "";
        html += '<div id="overPage2" class="over"></div>';
        $(".wrap").append(html);
        $.ajax({
            url : url,
            dataType : "html",
            type : "GET",
            async : false,
            success : function(result){
                $("#overPage2").html(result);
            }
        });
    }
    
    function appendDivDetailPost(url,id){
        var param = {"userId" : id};
         callAsyncAjax(url, param, "drawValue");
    }
    
    function drawValue(data){
        var userListValue = data.result.userDetailSelect.items;
        
        if(userListValue.cmpnyNm != null && userListValue.cmpnyNm != "") {
        	$('#cmpny').html('<option value="'+userListValue.cmpnyCd+' selected">'+userListValue.cmpnyNm+'</option>');
        }
        
        $("#userId").val(userListValue.userId);
        $("#empNo").val(userListValue.empNo);
        $("#empNm").val(userListValue.empNm);
        $("#pstCd").append('<option value="'+userListValue.pstCd+' selected">'+userListValue.pstNm+'</option>');
        $("#deptNm").val(userListValue.deptNm);
        $("#deptCd").val(userListValue.deptCd);
        $("#emailAdr").val(userListValue.emailAdr);
        $("#telno").val(dashPlus(userListValue.telno));
        $("#mbtlnum").val(dashPlus(userListValue.mbtlnum));
        $('#userCls').val(userListValue.userCls).prop("selected", true);
              
        if(userListValue.editAt == "Y"){
        	$("#useAt").val(userListValue.useAt);
        	
        }
        else{
        	$("#useAt").val("N");
        	$("#useAt").prop('disabled',true);
        }        
    }
    
    function appendDivReg(url){
        var html = "";
        html += '<div id="overPage" class="over"></div>';
        $(".wrap").append(html);
        
        $.ajax({
            url : url,
            dataType : "html",
            type : "get",
            success : function(result){
                $("#overPage").html(result);
            }
        });
    }
    
    function backList(){
        $(".over").remove();
    }
    
    function cudBackList(){
        $(".over").remove();
        ajaxGridComm(searchId,searchNm,cudPage);
    }
    
    function dashPlus(value){   	
    	if(value == null || value == ""){
    		return "";
    	}
    	
        var tel = "";
        var number = value.replace(/[^0-9]/g, "");
        
        if(number.lengh < 5){
            return number;
        }else if(number.length < 9){
            var preLength = number.length-4;
            tel += number.substr(0,preLength);
            tel += "-";
            tel += number.substr(prelength);
            return tel;
        }else if(number.length == 9){
            tel += number.substr(0,2);
            tel += "-";
            tel += number.substr(2,3);
            tel += "-";
            tel += number.substr(5);
            return tel;
        }else if(number.length == 10){
            if(number.substr(0,2).equals("02")){
                tel += number.substr(0,2);
                tel += "-";
                tel += number.substr(2,4);
                tel += "-";
                tel += number.substr(6);
                return tel;
            }else{
                tel += number.substr(0,3);
                tel += "-";
                tel += number.substr(3,3);
                tel += "-";
                tel += number.substr(6);
                return tel;
            }
        }else if(number.length > 10){
            tel += number.substr(0,3);
            tel += "-";
            tel += number.substr(3,4);
            tel += "-";
            tel += number.substr(7);
            return tel;
        }
    }
    
    function detailPageMove(value){
        var url = "/orgnzt/user/userDetailPagePop";
        var id = value;
        appendDivDetailGet(url);
        appendDivDetailPost(url,id);      
    };
    
    function pagingGrid(param,id){
        var result = "";
        if(param.currentPageNo > param.pageSize){
            result += '<a class="'+id+'Class" href="#">처음</a>&nbsp;&nbsp;';
        }
        if(param.currentPageNo != 1){
            result += '<a class="'+id+'Class" href="#">이전</a>&nbsp;&nbsp;';
        }
        for(var i = param.firstPageNoOnPageList ; i <= param.lastPageNoOnPageList ; i++){
            if(param.currentPageNo == i){
                result += '<a class="'+id+'Class" href="#"><strong>'+i+'</strong></a>&nbsp;&nbsp;';
            }else{
                result += '<a class="'+id+'Class" href="#">'+i+'</a>&nbsp;&nbsp;';
            }
        }
        if(param.currentPageNo != param.totalPageCount){
            result += '<a class="'+id+'Class" href="#">다음</a>&nbsp;&nbsp;';
        }
        if(param.currentPageNo <= (param.totalPageCount - (param.totalPageCount % param.pageSize))){
            result += '<a class="'+id+'Class" href="#">마지막</a>';
        }
            
        $("#"+id).html(result);
    };
    
</script>