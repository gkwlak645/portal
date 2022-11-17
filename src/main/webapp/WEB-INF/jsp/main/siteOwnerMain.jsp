<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!-- 관리자 화면 -->
<div class="container-fluid">
    <div class="content row">
        <section class="col-lg-12">
            <div class="card">
                <div class="card-body">
                    <!-- 관리자 대시보드  -->
                    <div class="board-wrap">
                        <!-- 버튼 -->
                        <div class="board-btns-wrap">
                            <div class="board-btns">
                                <a id="btnWeek"  class="board-btn">Week</a>
                                <a id="btnMonth" class="board-btn">Month</a>
                                <a id="btnYear"  class="board-btn">Year</a>
                                <a id="btnTotal" class="board-btn active">Total</a>
                            </div>
                        </div>
                        <!-- 테이블 -->
                        <div class="board-container">
                            <table>
                                <caption></caption>
                                <colgroup>
                                    <col style="width: 9.5%;">
                                    <col style="width: 9.5%">
                                    <col style="width: 9%;">
                                    <col style="width: 9%;">
                                    <col style="width: 9%;">
                                    <col style="width: 9%;">
                                    <col style="width: 9%;">
                                    <col style="width: 9%;">
                                    <col style="width: 9%;">
                                    <col style="width: 9%;">
                                    <col style="width: 9%;">
                                </colgroup>
                                <thead>
                                    <tr class="board-row">
                                        <th colspan="2" scope="col">구분</th>
                                        <th scope="col">그룹 計</th>
                                        <th scope="col">산업</th>
                                        <th scope="col">로엑스</th>
                                        <th scope="col">F&B</th>
                                        <th scope="col">홈푸드</th>
                                        <th scope="col">시스템즈</th>
                                        <th scope="col">건설산업</th>
                                        <th scope="col">테크팩솔루션</th>
                                        <th scope="col">엔터</th>
                                    </tr>
                                </thead>
                                <tbody id="ownerList"></tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>
<!-- // 관리자 화면 -->

<!-- 로딩바  -->
<div class="dimmed" style="display:none"></div>
<div class="loading" style="display:none">
    <div class="loading-bar"><div></div><div></div><div></div><div></div></div>
    <span class="loading-text">데이터 로딩중...</span>
</div>

<script>

var targetRow = '#tableRowTotal';

	$(document).ready(function() { 
		getOwnerMainList(); 
	});


    $(document).on('click','.board-btn',function(){ 
        var btnName = $(this).attr('id');
        var targetName = btnName.substring(3);
        targetRow = '#tableRow' + targetName;
        
        //버튼 활성화 효과
        $(this).addClass('active');
        $(this).siblings().removeClass('active');

        getOwnerMainList(targetName);
    });
    
    
    //list불러오기
    function getOwnerMainList(btnName){        
        
    	var url = "/main/main/getOwnerMainList";
        var param = {};
        
        param.chkDay = btnName == null || btnName == '' || btnName == undefined ? 'Total' : btnName;

        callAsyncAjax(url, param, "drawOwnerMainList");
        
        //결재 로딩바 
        $('.dimmed').css({ display: 'block' });
        $('.loading').css({ display: 'block' });
        $('.loading').addClass('show');
    }
    
    
    function drawOwnerMainList(data){
    	
    	var ownerMainList = data.result.resultList;
    	
    	var tmp = "";
    	
    	if(ownerMainList.length > 0){
    		
    		
    		$.each(ownerMainList, function(idx,item){
    			
    				if(item.GBN2 == "TT"){
    		        	//누적
    					tmp += '<tr id="tableRowTotal" class="board-row">';
    					tmp += '<th rowspan="4" scope="row">절감시간(Hr)</th>';
    					tmp += '<td class="board-row-name">누적</td>';
    					tmp += '<td>'+addCommas(item.Z)+'</td>';
    					tmp += '<td>'+addCommas(item.I)+'</td>';
    					tmp += '<td>'+addCommas(item.X)+'</td>';
    					tmp += '<td>'+addCommas(item.F)+'</td>';
    					tmp += '<td>'+addCommas(item.H)+'</td>';
    					tmp += '<td>'+addCommas(item.C)+'</td>';
    					tmp += '<td>'+addCommas(item.A)+'</td>';
    					tmp += '<td>'+addCommas(item.T)+'</td>';
    					tmp += '<td>'+addCommas(item.E)+'</td>';
    					tmp += '</tr>';
    		        	
    		        }else if(item.GBN2 == "YY"){
                        //누계
                        tmp += '<tr id="tableRowYear" class="board-row">';
                        tmp += '<td class="board-row-name">누계</td>';
                        tmp += '<td>'+addCommas(item.Z)+'</td>';
                        tmp += '<td>'+addCommas(item.I)+'</td>';
                        tmp += '<td>'+addCommas(item.X)+'</td>';
                        tmp += '<td>'+addCommas(item.F)+'</td>';
                        tmp += '<td>'+addCommas(item.H)+'</td>';
                        tmp += '<td>'+addCommas(item.C)+'</td>';
                        tmp += '<td>'+addCommas(item.A)+'</td>';
                        tmp += '<td>'+addCommas(item.T)+'</td>';
                        tmp += '<td>'+addCommas(item.E)+'</td>';
                        tmp += '</tr>';
    		        	
    		        }else if(item.GBN2 == "MM"){
                        //당월
                        tmp += '<tr id="tableRowMonth" class="board-row">';
                        tmp += '<td class="board-row-name">당월</td>';
                        tmp += '<td>'+addCommas(item.Z)+'</td>';
                        tmp += '<td>'+addCommas(item.I)+'</td>';
                        tmp += '<td>'+addCommas(item.X)+'</td>';
                        tmp += '<td>'+addCommas(item.F)+'</td>';
                        tmp += '<td>'+addCommas(item.H)+'</td>';
                        tmp += '<td>'+addCommas(item.C)+'</td>';
                        tmp += '<td>'+addCommas(item.A)+'</td>';
                        tmp += '<td>'+addCommas(item.T)+'</td>';
                        tmp += '<td>'+addCommas(item.E)+'</td>';
                        tmp += '</tr>';
                        
    		        }else if(item.GBN2 == "WW"){
    		        	//주간
                        tmp += '<tr id="tableRowWeek" class="board-row">';
                        tmp += '<td class="board-row-name">주간</td>';
                        tmp += '<td>'+addCommas(item.Z)+'</td>';
                        tmp += '<td>'+addCommas(item.I)+'</td>';
                        tmp += '<td>'+addCommas(item.X)+'</td>';
                        tmp += '<td>'+addCommas(item.F)+'</td>';
                        tmp += '<td>'+addCommas(item.H)+'</td>';
                        tmp += '<td>'+addCommas(item.C)+'</td>';
                        tmp += '<td>'+addCommas(item.A)+'</td>';
                        tmp += '<td>'+addCommas(item.T)+'</td>';
                        tmp += '<td>'+addCommas(item.E)+'</td>';
                        tmp += '</tr>';
    		        }else if(item.GBN2 == "PC"){
    		        	//개발과제 (건수)
    		        	tmp += '<tr>';
                        tmp += '<th colspan="2" scope="row">개발과제 (건수)</th>';
                        tmp += '<td>'+addCommas(item.Z)+'</td>';
                        tmp += '<td>'+addCommas(item.I)+'</td>';
                        tmp += '<td>'+addCommas(item.X)+'</td>';
                        tmp += '<td>'+addCommas(item.F)+'</td>';
                        tmp += '<td>'+addCommas(item.H)+'</td>';
                        tmp += '<td>'+addCommas(item.C)+'</td>';
                        tmp += '<td>'+addCommas(item.A)+'</td>';
                        tmp += '<td>'+addCommas(item.T)+'</td>';
                        tmp += '<td>'+addCommas(item.E)+'</td>';
                        tmp += '</tr>';
    		        }else if(item.GBN2 == "PH"){
    		        	//환산인원 (명)
    		        	tmp += '<tr>';
                        tmp += '<th colspan="2" scope="row">환산인원 (명)</th>';
                        tmp += '<td>'+addCommas(item.Z)+'</td>';
                        tmp += '<td>'+addCommas(item.I)+'</td>';
                        tmp += '<td>'+addCommas(item.X)+'</td>';
                        tmp += '<td>'+addCommas(item.F)+'</td>';
                        tmp += '<td>'+addCommas(item.H)+'</td>';
                        tmp += '<td>'+addCommas(item.C)+'</td>';
                        tmp += '<td>'+addCommas(item.A)+'</td>';
                        tmp += '<td>'+addCommas(item.T)+'</td>';
                        tmp += '<td>'+addCommas(item.E)+'</td>';
                        tmp += '</tr>';
    		        }else if(item.GBN2 == "JT"){
    		        	//가동룰 (%)
    		        	tmp += '<tr>';
                        tmp += '<th colspan="2" scope="row">가동룰 (%)</th>';
                        tmp += '<td>'+addCommas(item.Z)+'%</td>';
                        tmp += '<td>'+addCommas(item.I)+'%</td>';
                        tmp += '<td>'+addCommas(item.X)+'%</td>';
                        tmp += '<td>'+addCommas(item.F)+'%</td>';
                        tmp += '<td>'+addCommas(item.H)+'%</td>';
                        tmp += '<td>'+addCommas(item.C)+'%</td>';
                        tmp += '<td>'+addCommas(item.A)+'%</td>';
                        tmp += '<td>'+addCommas(item.T)+'%</td>';
                        tmp += '<td>'+addCommas(item.E)+'%</td>';
                        tmp += '</tr>';
    		        }else if(item.GBN2 == "CR"){
    		        	//개발자수 (명)
    		        	tmp += '<tr class="row-line">';
                        tmp += '<th colspan="2" scope="row">개발자수 (명)</th>';
                        tmp += '<td>'+addCommas(item.Z)+'</td>';
                        tmp += '<td>'+addCommas(item.I)+'</td>';
                        tmp += '<td>'+addCommas(item.X)+'</td>';
                        tmp += '<td>'+addCommas(item.F)+'</td>';
                        tmp += '<td>'+addCommas(item.H)+'</td>';
                        tmp += '<td>'+addCommas(item.C)+'</td>';
                        tmp += '<td>'+addCommas(item.A)+'</td>';
                        tmp += '<td>'+addCommas(item.T)+'</td>';
                        tmp += '<td>'+addCommas(item.E)+'</td>';
                        tmp += '</tr>';
    		        }else if(item.GBN2 == "BOT"){
                        //봇수 (대수)
                        tmp += '<tr class="board-row-border">';
                        tmp += '<th colspan="2" scope="row">봇수 (대수) (팜스 '+item.S+'건 포함)</th>';
                        tmp += '<td>'+addCommas(item.Z)+'</td>';
                        tmp += '<td>'+addCommas(item.I)+'</td>';
                        tmp += '<td>'+addCommas(item.X)+'</td>';
                        tmp += '<td>'+addCommas(item.F)+'</td>';
                        tmp += '<td>'+addCommas(item.H)+'</td>';
                        tmp += '<td>'+addCommas(item.C)+'</td>';
                        tmp += '<td>'+addCommas(item.A)+'</td>';
                        tmp += '<td>'+addCommas(item.T)+'</td>';
                        tmp += '<td>'+addCommas(item.E)+'</td>';
                        tmp += '</tr>';
                    }else{}
    		});
    		
    	}else{
    		tmp += "<tr>";
    		tmp += "<td colspan='10'>조회된 내용이 없습니다.</td>";
    		tmp += "</tr>";
    	}
    	
    	$('#ownerList').html(tmp);

    	$(targetRow).addClass('active');
        $(targetRow).siblings('.board-row').removeClass('active');
        
        
        $('.dimmed').css({ display: 'none' });
        $('.loading').css({ display: 'none' });
        $('.loading').removeClass('show');
    }
    
    
</script>








