<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="card card-primary" id = "cardDiv">
    <div class="card-header" alt="자원>환경관리 등록 ">
        <h3 class="card-title">등록</h3>
    </div>
    <div class="card-body" style="height:560px; overflow:auto;">
            <div class="row">
                <div class="col-md-12">
                <form>
                
                    <div class="form-inline">
                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label for="name" class="col-sm-4 col-form-label">회사 <b style="color:red;padding-left:10px;">*</b></label>
                            <div class="col-sm-8">
                                <select class="form-control" id="cmpnyCd" style="width:50%;margin-right: 3px;">
                                </select>
                            </div>
                         </div>
                    </div>
                    <div class="form-inline"> 
                         <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label class="col-sm-4 col-form-label" for="envrnName">이름 <b style="color:red;padding-left:10px;">*</b></label>
                            <div class="col-sm-8">
                                <input style="width:50%;margin-right: 3px;"type="text" id="envrnName" class="form-control" required>
                            </div>
                        </div>
                        <div class="form-group col-md-6 py-sm-2" style="margin: 0.25rem 0 0.5rem 0;">
                            <label class="col-sm-4 col-form-label" for="envrnDescription">설명</label>
                            <div class="col-sm-8">
                                <input style="width:80%;margin-right: 3px;"type="text" id="envrnDescription" class="form-control">
                            </div>
                        </div>                      
                    </div>
                    <div class="float-right" style="margin:15px 0 15px 2px;">
                        <button type="button" class="btn btn-primary" id="envrnRegister">등록</button>
                        <button type="button" class="btn btn-primary" id="cancel">취소</button>
                    </div>                   
                   
                </form>
            </div>
        </div>
    </div>
</div>

<script>

    $(document).ready(function() {

        //페이지 초기화
        pageInit();

        //이벤트 바인딩
        bindEvent();

    });

    /*
     * 페이지 초기화
     * @param
     * @return
     */
    function pageInit() {

    	var params = [];
        if("${txScreenAuthor.untenantAuthor}" == 'Y'){
            params.push({"id" : "cmpnyCd", "clsCd" : "0024"});    //회사
        }else{
        	params.push({"id" : "cmpnyCd", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
        }
//       params.push({"id" : "cmpnyCd", "clsCd" : "0024"});    //회사

        requestCmmnCd(params);
    	
    }

       
    /*
     * 이벤트 바인딩
     * @param
     * @return
     */
    function bindEvent() {
    	
    	$("#envrnName").on('keyup', function(){
            if($(this).val().length > 100){
                $(this).val($(this).val().substring(0, 100));
                alert("최대 입력 글자 수는 100입니다.");
            }
        });
        
        $("#envrnDescription").on('keyup', function(){
            if($(this).val().length > 500){
                $(this).val($(this).val().substring(0, 500));
                alert("최대 입력 글자 수는 500입니다.");
            }
        });
    	
        $("#envrnRegister").on("click", function() {
            if($("#cmpnyCd").val() == null || $("#cmpnyCd").val() == ''){
            	alert("회사를 선택해주세요.");
            } else if($("#envrnName").val() == null || $("#envrnName").val() == ''){
        		alert("이름을 입력해주세요.");
        	} else {
        		envrnRegister();
        	}
        });

        $("#cancel").on("click", function() {
            $(".over").remove();
        });
            
    } 
    
    /*
     * 환경 등록
     * @param
     * @return
     */
    function envrnRegister() {
        var url = "/resrce/envrn/registerEnvrn";
        var param = new Object();
        
        param.cmpnyCd              = $("#cmpnyCd").val();
        param.Name                 = $("#envrnName").val();
        param.Description          = $("#envrnDescription").val();
        console.log(param);
        callAsyncAjax(url, param, 'getRobotList');
    }
    
    
          
</script>