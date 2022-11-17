<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<div class="card card-primary" id = "cardDiv">
		<div class="card-header">
			<h3 class="card-title">등록</h3>
		</div>
		<div class="card-body">
			<div class="row">
				<div class="col-md-12">
				    <div class="form-group">
                        <label for="rgstCmpny">회사 <b style="color: red;">*</b></label>
                        <div class="col-sm-3">
                            <select class="form-control" id="rgstCmpny">
                             </select>
                        </div>
                    </div>
				    <div class="form-group">
                        <label for="deviceId">머신 <b style="color: red;">*</b></label>
                        <div class="col-sm-3">
                            <select class="form-control" id="deviceId" required>
                            </select>
                        </div>
                    </div>
					<div class="form-group">
						<label for="robotName">이름 <b style="color: red;">*</b></label>
						<div class="col-sm-3">
							<input type="text" id="robotName" class="form-control" required>
						</div>
					</div>
					<div class="form-group">
						<label for="robotDescription">설명</label>
						<div class="col-8">
						 <textarea id="robotDescription" class="form-control"  ></textarea>
						</div>
					</div>
					<div class="form-group">
						<label for="robotType">형식<b style="color: red;">*</b></label>
						<div class="col-sm-3">
							<select id="robotType" class="form-control">
							 </select>
						</div>
					</div>
					<div class="form-group">
                        <label for="userName">사용자명<b style="color: red;">*</b></label>
                        <div class="col-sm-3">
                             <input type="text" id="userName" class="form-control" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="robotPW">암호<b style="color: red;">*</b></label>
                        <div class="col-sm-3">
                             <input type="text" id="robotPW" class="form-control" onkeyup="fnChkByte(this, 100);">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="ip">아이피<b style="color: red;">*</b></label>
                        <div class="col-sm-3">
                             <input type="text" id="ip" class="form-control" onkeyup="fnChkByte(this, 60);" required>
                        </div>
                    </div>
					<div class="float-right">
						<button type="button" class="btn btn-primary" id="robotRegister">등록</button>
						&nbsp;
						<button type="button" class="btn btn-primary" id="cancel">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	
<script>

		$(document).ready(function() {
			
			pageInit();
			
			bindEvent();
			
		});

		function pageInit() {
			
			var params = [];
	        if("${txScreenAuthor.untenantAuthor}" == 'Y'){
	            params.push({"id" : "rgstCmpny", "clsCd" : "0024"});    //회사
	        }else{
	            params.push({"id" : "rgstCmpny", "clsCd" : "0024", "disable" : "Y", "selectValue": "${sessionUserInfo.txCmpnyCd}"});    //회사
	        }
//	         params.push({"id" : "rgstCmpny", "clsCd" : "0024"});    //회사

            params.push({"id" : "robotType", "clsCd" : "0006"});    //로봇유형
	        requestCmmnCd(params);
			
			getDeviceList();
		}

		function bindEvent() {
			
			$("#rgstCmpny").on('change', function(){
				if($("#rgstCmpny").val() != null){
					getDeviceList();
				}
			});
			
			$("#robotName").on('keyup', function(){
                if($(this).val().length > 255){
                    $(this).val($(this).val().substring(0, 255));
                    alert("최대 입력 글자 수는 255입니다.");
                }
            });
			
			$("#robotDescription").on('keyup', function(){
                if($(this).val().length > 500){
                    $(this).val($(this).val().substring(0, 500));
                    alert("최대 입력 글자 수는 500입니다.");
                }
            });
			
			$("#userName").on('keyup', function(){
                if($(this).val().length > 100){
                    $(this).val($(this).val().substring(0, 100));
                    alert("최대 입력 글자 수는 100입니다.");
                }
            });
			
			$("#robotRegister").on("click", function() {
			 	 if($("#deviceId").val() == null || $("#deviceId").val() == ''){
                    alert("디바이스를 선택해주세요.");
                    return
                } else if($("#rgstCmpny").val() == null || $("#rgstCmpny").val() == '') {
                    alert("회사를 선택해주세요.");
                    return
                } else if($("#robotName").val() == null || $("#robotName").val() == '') {
                    alert("로봇명을 입력해주세요.");
                    return
                } else if($("#robotType").val() == null || $("#robotType").val() == '') {
                    alert("로봇유형을 선택해주세요.");
                    return
                } else if($("#userName").val() == null || $("#userName").val() == '') {
                    alert("사용자명을 입력해주세요.");
                    return
                } else if($("#robotPW").val() == null || $("#robotPW").val() == '') {
                    alert("암호를 입력해주세요.");
                    return
                } else if($("#ip").val() == null || $("#ip").val() == '') {
                	alert("아이피를 입력해주세요.");
                    return
                } else {
                	idDplctCheck($("#robotName").val());   
                	
                } 
			 	
			});
			
			$("#cancel").on("click", function() {
				$(".over").remove();
			});
		        
		} 
		
		function fnChkByte(obj, max) {
            var maxByte = max; //최대 입력 바이트 수
            var str = obj.value;
            var str_len = str.length;
         
            var rbyte = 0;
            var rlen = 0;
            var one_char = "";
            var str2 = "";
         
            for (var i = 0; i < str_len; i++) {
                one_char = str.charAt(i);
         
                if (escape(one_char).length > 4) {
                    rbyte += 2; //한글2Byte
                } else {
                    rbyte++; //영문 등 나머지 1Byte
                }
         
                if (rbyte <= maxByte) {
                    rlen = i + 1; //return할 문자열 갯수
                }
            }
         
            if (rbyte > maxByte) {
                alert("최대 한글 " + (maxByte / 2) + "자, 영문 " + maxByte + "자를 초과 입력할 수 없습니다.");
                str2 = str.substr(0, rlen); //문자열 자르기
                obj.value = str2;
                fnChkByte(obj, maxByte);
            } else {
                document.getElementById(obj.id).innerText = rbyte;
            }
        }
		
		function robotRegister() {
			
			var url = "/resrce/robot/registerRobot";
			var pw  = $("#robotPW").val();
			var param = new Object();

			param.cmpnyCd      = $("#rgstCmpny").val();
			param.MachineId    = $("#deviceId").val();
			param.Name         = $("#robotName").val();
			param.HostingType  = 'Standard';
			param.Description  = $("#robotDescription").val();
			param.Type         = $("#robotType").val();
			param.TypeText     = document.getElementById("robotType").options[document.getElementById("robotType").selectedIndex].text;
			param.Username     = $("#userName").val();
			param.RobotIp      = $("#ip").val();
            param.Password = pw;
            
			console.log(param);
			callAsyncAjax(url, param, 'closePOP');
		}
		
		//device 리스트 가져오기
		function getDeviceList() {
			var url = "/resrce/device/getDeviceNameList"
			var param = {
		            "cmpnyCd" : $("#rgstCmpny").val()
			};
			callAsyncAjax(url, param, 'drawCombo');
        }
		
        //디바이스 콤보박스   
		function drawCombo(data){
            var deviceList = data.result;

            var resultCategory = "<option selected disabled>디바이스 선택</option>";	
            
            for(var i in deviceList){
	            resultCategory += "<option value=" + deviceList[i].id + ">"
					            +deviceList[i].name
					            + "</option>"; 
            }
            document.getElementById("deviceId").innerHTML = resultCategory;
		}
        
		function idDplctCheck(name){
            var url = "/resrce/robot/idDplctCheck";
            var param = {"name" : name};
            callAsyncAjax(url, param, 'idDplctCheckSuc');
        }
        
        function idDplctCheckSuc(data){
            console.log("데이터 넘어오는 값 1:" + data);
            console.log("데이터 넘어오는 값 chk:" + data.result.chk);
            console.log(data);
            if(data.result.chk == "N"){
                robotRegister();
            }else{
                alert("이미 존재하는 로봇명입니다.");
                $("#robotName").val("").focus();
                return false;               
            }
        }
</script>