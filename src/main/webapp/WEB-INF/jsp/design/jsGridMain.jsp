<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			<div class="card">
				<div class="card-header">
					<form class="form-inline">
						<div class="form-group col-md-5 py-sm-2">
						  <label for="usr" class="col-sm-4 col-form-label">사용자아이디</label>
						  <div class="col-sm-8">
						      <input type="text" class="form-control" id="usr">
						  </div>
						</div>
                        <div class="form-group col-md-5 py-sm-2">
                          <label for="usr" class="col-sm-4 col-form-label">사용자명</label>
                          <div class="col-sm-8">
                              <input type="text" class="form-control" id="usr">
                          </div>
                        </div>
                        <div class="form-group col-md-5 py-sm-2">
                          <label for="usr" class="col-sm-4 col-form-label">사용자아이디</label>
                          <div class="col-sm-8">
                              <input type="text" class="form-control" id="usr">
                          </div>
                        </div>
                        <div class="form-group col-md-5 py-sm-2">
                          <label for="usr" class="col-sm-4 col-form-label">사용자명</label>
                          <div class="col-sm-8">
                              <input type="text" class="form-control" id="usr">
                          </div>
                        </div>
                        <div class="col-md-2">
                            <button type="button" id="regBtn" class="btn btn-info float-right">조회</button>
                        </div>
					</form>	
				</div>
			</div>
		</div>
	</div>
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <button type="button" id="regBtn" class="btn btn-info float-right">등록</button>
                </div>
                <div class="card-body">
                    <div id="userSearchGrid"></div>
                    <div id="paging" style="text-align:center"></div>
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
        drawGrid("");
    };
    
    function drawGrid(){
        $("#userSearchGrid").jsGrid({
            height : "auto",
            width : "100%",
            autoload: true,
            sorting : true,
            paging : true,
            pageSize: 10,
            data:"",
            fields : [ 
                {name: "userId" ,title : "사용자아이디",type : "text", width : 100}, 
                {name: "empNm" ,title : "사용자명", type : "text", width : 100}, 
                {name: "empNo" ,title : "사원번호", type : "text", width : 100}, 
                {name: "pstNm" ,title : "직급", type : "text", width : 50}, 
                {name: "deptNm" ,title : "부서", type : "text", width : 100}, 
                {name: "telNo" ,title : "전화번호", type : "text", width : 100}, 
                {name: "emailAdr" ,title : "이메일주소", type : "text"}, 
                {name: "useAt" ,title : "사용여부", type : "text", width : 50} 
            ]
        });
    }
    
</script>
