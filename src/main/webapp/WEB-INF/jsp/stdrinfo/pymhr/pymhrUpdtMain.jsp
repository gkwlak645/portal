<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <div class="row">
        <div class="col-md-12" alt="기준정보 > 임율관리">
            <div class="card">            
                <div class="card-body">
                    <button type="button"  id="btnRateReg" class="btn btn-primary float-right"  style="margin:5px 0 15px 3px;">저장</button>
	                <button type="button" id="btnRateDel" class="btn btn-primary float-right"  style="margin:5px 0 15px 3px;">삭제</button>
	                <button type="button" id="btnRateAdit" class="btn btn-primary float-right"  style="margin:5px 0 15px 3px;">추가</button>
                
                    <div id="rateGrid" class="jsGridRate"></div>
                    <div id="rateGridPager" class="portal-pager"></div>
                </div>
            </div>
        </div>
    </div>

<script>

    var getYear = "";
    var delPymhrYy = "";
    var delPymhrAmt = "";

    function pageInit() {
    	rateDrawGrid();
    	//년도 가져오기
        getYear = getToYear();
    	//삭제버튼 disable
        btnRateDelController(delPymhrYy, delPymhrAmt);
     
    };
    
    function bindEvent(){
        //추가 버튼클릭시 
        $("#btnRateAdit").on("click", function(){
        	$(".jsgrid-edit-row").remove();
        	$(".jsgrid-row, .jsgrid-alt-row").show();
        	insertRowController();
            btnRateDelController(delPymhrYy, delPymhrAmt);
        });
        
        //저장버튼 클릭시
        $("#btnRateReg").on("click", function(){
        	var Amt="";
        	var Yy="";
        	if($(".jsgrid-insert-row").css("display") == "table-row"){
        		Yy = $("#insertPymhrYy").val();
        		Amt = $("#insertAmt").val();
        		
        		if(Yy == null){
        			alert("년도를 선택하세요.");
        			return false;
        		}else if(Amt == null || Amt == ""){
        			alert("시급을 입력해 주세요.");
        			return false;
        		}
        	}else {
        		Yy = $("#updtPymhrYy").val();
                Amt = $("#updtAmt").val();
        	}
            Amt = uncommify(Amt);
        	updtRate(Yy, Amt);
            btnRateDelController(delPymhrYy, delPymhrAmt);
        });
        
        //삭제버튼 클릭시 
        $("#btnRateDel").on("click", function(){
          	deleteRate(delPymhrYy, delPymhrAmt);
        });
        
        //시급 세자리 마다 ,붙이기
        $(document).on("keyup", "#updtAmt, #insertAmt", function(){
        	var updtAmt = $("#updtAmt").val();
        	var insertAmt = $("#insertAmt").val();
        	var res = ""
            if(updtAmt == "" || updtAmt == null){
                res = insertAmt;
                var result = commify(res);
                $("#insertAmt").val(result);
            }else{
            	res = updtAmt;
            	var result = commify(res);
            	$("#updtAmt").val(result);
            }
        });
        
      //jsGrid영역 외 클릭시 추가, 수정 금지
        $("body").on("click", function(e){
            if($(e.target).hasClass("content-wrapper")){
                $('.jsgrid-insert-row').css({ display: 'none' });
                $(".jsgrid-row, .jsgrid-alt-row").removeClass("highlight");
                $(".jsgrid-edit-row").remove();
                $(".jsgrid-row, .jsgrid-alt-row").show();
                btnRateDelController(delPymhrYy, delPymhrAmt);
            }
        });

    }
    
    
    //insertRow 컨트롤
    function insertRowController(){
    	if ($('.jsgrid-insert-row').css('display') == "none") {
            //Add 버튼 보이기, Show Add Button
            $('.jsgrid-insert-row').css({ display: 'table-row' });
            return true;
        }
        if ($('.jsgrid-insert-row').css('display') == "table-row") {
            //Add 버튼 숨기기, Hide Add Button 
            $('.jsgrid-insert-row').css({ display: 'none' });
            $("#insertPymhrYy").val("선택").attr("selected", "selected");
            $("#insertAmt").val("");
            return true;
        }
    }
    //임율관리 ajax 통하여 List가져오기
    function rateDrawGrid(){
    	var url = "/stdrinfo/pymhr/getPymhrList";
    	param = {};
    	callAsyncAjax(url, param, "drawGrid");
    }
    
    
    //현재 년도 가져오기
    function getToYear(){
    	var date = new Date()
    	return date.getFullYear();
    }
    
     //selectField 커스텀 하기
    var selectField = function(config){
        jsGrid.Field.call(this, config);
    };
    selectField.prototype = new jsGrid.Field({
    	//기본 탬플릿
    	itemTemplate : function(value){
    		    return value;
    	},
        //insert탬플릿
        insertTemplate : function(){
        	return "<select id='insertPymhrYy'><option disabled selected>선택</option><option value="+getYear+">"+getYear+"</option><option value="+(getYear+1)+">"+(getYear+1)+"</option></select>";
        },
        //edit탬플릿
        editTemplate : function(value){
        	var result = "";
            if(value >= getYear){
            	if(value == getYear){
            	result = "<select id='updtPymhrYy'><option value="+getYear+" selected>"+getYear+"</option><option value="+(getYear+1)+">"+(getYear+1)+"</option></select>";
            	}else{
            	result = "<select id='updtPymhrYy'><option value="+getYear+">"+getYear+"</option><option value="+(getYear+1)+" selected>"+(getYear+1)+"</option></select>";
            	}
                return result;              
            }
        },
        //editvalue
        editValue: function() {
            return this.editControl.val();
        }
    });
    
    
    
    //textField 커스텀 하기
    var textField = function(config){
        jsGrid.Field.call(this, config);
    };
    textField.prototype = new jsGrid.Field({
        //기본 탬플릿
        itemTemplate : function(value){
                return commify(value)+" 원";
        },
        //insert탬플릿
        insertTemplate : function(){
            return "<input type ='text' id='insertAmt'>";
        },
        //edit탬플릿
        editTemplate : function(value){
            return "<input type ='text' id='updtAmt' value='"+value+"'>";
        },

    });
      
    //jsGrid에 커스텀 필드 적용
    jsGrid.fields.select = selectField;
    jsGrid.fields.text = textField;
    
    //jsGrid그리기
    function drawGrid(data){
        var params = {};
        params = data.result.rateUpdt;
       /*  if (data != null && data != undefined) {
            params = data.result.rateUpdt;
            drawPager("rateGridPager", data.result.paginationInfo, "searchEnvrnList");
        }*/
        $("#rateGrid").jsGrid({
              height : "auto"
            , width : "100%"
            , autoload: true
            , sorting : true
            , align : "center"
            , data : params 
            , inserting: false
            , selectData : false
            , editing : true
            , rowClick: function(args){
            	var selectedYear = args.item.pymhrYy;            		
            		selectData = args.item;
            	if(selectedYear >= getYear){
            		this.editItem($(args.event.target).closest("tr"));
            		delPymhrAmt = args.item.pymhrAmt;
            	    delPymhrYy = selectedYear;
            		$("#btnRateDel").attr("disabled", false);
            		$(".jsgrid-row, .jsgrid-alt-row").removeClass("highlight");

            		//addrow 숨기기
            		if ($('.jsgrid-insert-row').css('display') == "table-row") {
                        $('.jsgrid-insert-row').css({ display: 'none' });
                        return true;
                    }
             	}else{
                    $("#btnRateDel").attr("disabled", true);
                    $(".jsgrid-row, .jsgrid-alt-row").removeClass("highlight");
                    var gRow = this.rowByItem(args.item);
                    gRow.addClass("highlight");
                    $(".jsgrid-edit-row").remove();
                    $(".jsgrid-row, .jsgrid-alt-row").show();
                }
            }
            , fields : [
                 {name: "txUserId"   , title : "아이디"  , type : "text"   , width : 0     , visible : false}
                ,{name: "pymhrYy"    , title : "년도"   , type : "select" , width : 80    , align : "center"}
                ,{name: "pymhrAmt"   , title : "시급"   , type : "text"   , width : 250 , align : "right"}
            ]
        }); 
    }
    
    //추가 및 업데이트
    function updtRate(yy, amt){
    	var url = "/stdrinfo/pymhr/updtPymhrList";
        var param = { "pymhrYy" : yy
                     ,"pymhrAmt" : amt};
        callAsyncAjax(url, param, "rateDrawGrid");
        return alert("저장되었습니다.");
    };
    
    //삭제
    function deleteRate(delPymhrYy, delPymhrAmt){
    	var url = "/stdrinfo/pymhr/deletePymhr";
    	var param = { "pymhrYy" : delPymhrYy
                ,"pymhrAmt" : delPymhrAmt};
    	callAsyncAjax(url, param, "rateDrawGrid");
    	btnRateDelController(delPymhrYy, delPymhrAmt)
    	return alert("삭제되었습니다.");
    }
    
    //삭제버튼 컨트롤
    function btnRateDelController(delPymhrYy, delPymhrAmt){
    	delPymhrYy="";
        delPymhrAmt="";
        $("#btnRateDel").attr("disabled", true);
    }

</script>
