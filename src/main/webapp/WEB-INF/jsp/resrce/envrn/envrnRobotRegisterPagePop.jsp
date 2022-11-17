<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<div class="card card-primary" id = "cardDiv">
		<div class="card-header">
			<h3 class="card-title">등록</h3>
		</div>
		<div class="card-body" style="height:560px; overflow:auto;">
			<div class="row">
		        <div class="col-md-12">
		            <div class="card">
		                <div class="form-group">
		                    <div id="envrnRobotGrid"></div>
		                    <div id="envrnRobotGridPager" style="text-align:center"></div>
                         </div>
                    </div>
                    
	                <div class="float-right" style="margin:15px 0 15px 2px;">
                        <button type="button" class="btn btn-primary"  id="addRobot">등록</button>
                        <button type="button" class="btn btn-primary" id="cancel">취소</button>
                    </div>
		        </div>
		    </div>
		</div>
	</div>
	
	<script>
	var cmpnyCd = "";
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
		}

	    /*
	     * 이벤트 바인딩
	     * @param
	     * @return
	     */
		function bindEvent() {
			$("#addRobot").on("click", function() {
				addRobotToEnvrn();
			});

			$("#cancel").on("click", function() {
// 				alert("취소");
				$(".over").remove();
// 				detailPageMove(registerEnvrnId);
				popupEnvrnDetail(registerEnvrnId);
			});
		        
		}
		
        /*
         * 로봇 환경 추가
         * @param
         * @return
         */
		function addRobotToEnvrn() {
			var selectedItems = [];
			var unselectedItems = [];
			
		    $('input[name=gridCheckbox]').each(function(){
		    	var robotId = parseInt($(this).val());
		    	if($(this).is(':checked')){
		    		selectedItems.push(robotId);
		    	}else {
		    		unselectedItems.push(robotId);
		    	}
		    })
		    
			url = '/resrce/envrn/addRobotToEnvrn'
		    var param = new Object();
		    param.cmpnyCd = cmpnyCd;
		    param.addedRobotIds = selectedItems;
		    param.removedRobotIds = unselectedItems;
		    param.id = registerEnvrnId;
		    console.log(param);
			callSyncAjax(url, param, 'closePOP'); 
		};
	
		/*
	     * 상세페이지 pop
	     * @param
	     * @return
	     */
	    function popupEnvrnDetail(id) {
	        appendDetailPopup("envrnMainDiv", "/resrce/envrn/envrnDetailPop");
	        getEnvrnDetail("/resrce/envrn/getEnvrnDetail", id); 
	    };
	</script>