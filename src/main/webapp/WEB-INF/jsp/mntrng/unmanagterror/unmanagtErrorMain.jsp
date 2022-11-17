<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div id="unmanagtErrorMainDiv" class="container-fluid wrap">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <form class="form-inline">
                        <div class="form-group col-md-5 py-sm-2">
                          <label for="cmpnyCd" class="col-sm-3 col-form-label">회사</label>
                          <div class="col-sm-8">
                              <select id="cmpnyCd" class="form-control" >
                                  <option value=""></option>
                              </select>
                          </div>
                        </div>
                        <div class="form-group col-md-5 py-sm-2">
                               <label class="col-sm-3 col-form-label">미조치일</label>
<!--                           <input type="radio" name="chkDe" id="occrrncDe" value="occrrncDe" checked>발생일 &nbsp;&nbsp;&nbsp; -->
<!--                           <input type="radio" name="chkDe" id="managtDe" value="managtDe">조치일 -->
                          <div class="col-sm-4">
                              <div class="input-group date" id="startDeDiv" data-target-input="nearest">
                                  <input type="text" id="startDe" name="startDe" class="form-control datetimepicker-input" data-target="#startDeDiv"/>
                                  <div class="input-group-append" data-target="#startDeDiv" data-toggle="datetimepicker">
                                      <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                  </div>
                              </div>
                          </div>
                          <div class="col-sm-4">
                              <div class="input-group date" id="endDeDiv" data-target-input="nearest">
                                  <input type="text" id="endDe" name="endDe" class="form-control datetimepicker-input" data-target="#endDeDiv"/>
                                  <div class="input-group-append" data-target="#endDeDiv" data-toggle="datetimepicker">
                                      <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                  </div>
                              </div>
                          </div>
                        </div>
                        <div class="form-group col-md-5 py-sm-2">
                          <label for="processCd" class="col-sm-3 col-form-label">프로세스코드</label>
                          <div class="col-sm-8">
                              <select id="processCd" class="form-control">
                                  <option value=""></option>
                              </select>
                          </div>
                        </div>                        
                        <div class="form-group col-md-5 py-sm-2">
                          <label for="occrrncSeCd" class="col-sm-3 col-form-label">오류발생구분</label>
                          <div class="col-sm-8">
                              <select id="occrrncSeCd" class="form-control">
                                  <option value=""></option>
                              </select>
                          </div>
                        </div>
                        <div class="form-group col-md-5 py-sm-2">
                          <label for="tyCd" class="col-sm-3 col-form-label">오류유형</label>
                          <div class="col-sm-8">
                              <select id="tyCd" class="form-control">
                                  <option value=""></option>
                              </select>
                          </div>
                        </div>
                        <div class="form-group col-md-2">
                            <button type="button" id="btnSearch" class="btn btn-info float-right">조회</button>
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
                    <div id="unmanagtErrorGridPager" style="text-align:center"></div>
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
                , {name: "unmanagtDe"         , title : "미조치일"       , type : "text"    , width : 80}
                , {name: "occrrncSeNm"        , title : "오류발생구분"    , type : "text"    , width : 80}
                , {name: "tyNm"               , title : "오류유형"       , type : "text"    , width : 100}
                , {name: "processSn"          , title : "프로세스코드"    , type : "text"    , width : 80}
                , {name: "errorCn"            , title : "오류내용"       , type : "text"    , width : 200}
                , {name: "managtCn"           , title : "조치내용"       , type : "text"    , width : 200}
                , {name: "managtTyNm"         , title : "현상태"        , type : "text"    , width : 70}
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
