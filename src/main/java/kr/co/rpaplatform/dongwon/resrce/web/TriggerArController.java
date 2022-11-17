/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 5.         LSH
 */
package kr.co.rpaplatform.dongwon.resrce.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.quartz.CronExpression;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.microsoft.sqlserver.jdbc.SQLServerBulkCopy;
import com.microsoft.sqlserver.jdbc.SQLServerBulkCopyOptions;

import kr.co.rpaplatform.common.exception.RpaException;
import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.common.vo.ResponseVO;

import kr.co.rpaplatform.dongwon.common.util.PaginationUtil;
import kr.co.rpaplatform.dongwon.common.vo.CmmnUserVO;
import kr.co.rpaplatform.dongwon.resrce.service.RobotService;
import kr.co.rpaplatform.dongwon.resrce.service.TriggerArService;
import kr.co.rpaplatform.dongwon.resrce.service.TriggerUrService;
import kr.co.rpaplatform.dongwon.resrce.vo.RobotVO;
import kr.co.rpaplatform.dongwon.task.service.TaskManageService;
import kr.co.rpaplatform.rpaapi.uipath.api.TriggerUrApi;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * 로봇 컨트롤러
 * @author LSH
 * 2020. 6. 5.
 */
@Controller
@RequestMapping("/resrce/triggerAr")
public class TriggerArController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(TriggerArController.class);
	
	/**
	 *  Trgger(AR) 서비스
	 */
	@Resource(name="triggerArService")
	private TriggerArService triggerArService;
	
	@Resource(name="triggerUrService")
	private TriggerUrService triggerUrService;
	
	@Resource(name="taskManageService")
	private TaskManageService taskManageService;
	
	/*
	 * jdbc.mssql.driverType=mssql
	 * jdbc.mssql.driverClassName=net.sf.log4jdbc.sql.jdbcapi.DriverSpy
	 * jdbc.mssql.url=jdbc:log4jdbc:sqlserver://172.16.6.91;databaseName=rpa_potal
	 * jdbc.mssql.username=rpa_potal
	 * jdbc.mssql.password=tal?gus12#$
	 * 
	 */
	
	@Value("${jdbc.mssql.driverType}")
	private String dbDriverType;
	
	@Value("${jdbc.mssql.driverClassName}")
	private String dbDriverClassName;
	
	@Value("${jdbc.mssql.url}")
	private String dbUrl;
	
	@Value("${jdbc.mssql.username}")
	private String dbUsername;
	
	@Value("${jdbc.mssql.password}")
	private String dbPassword;
	
	
	/**
	 *  메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/triggerArMain")
	public ModelAndView triggerArMain() throws Exception {
		return new ModelAndView("/resrce/triggerAr/triggerArMain");
	}
	
	@RequestMapping(value = "/selectTriggerArList")
	@ResponseBody
	public ResponseVO selectTriggerArList(HttpServletRequest request, @RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		CmmnUserVO cmmnUserVO = (CmmnUserVO)request.getSession().getAttribute("sessionUserInfo");
		map.put("cmpnyCd", cmmnUserVO.getTxCmpnyCd());

		//디바이스 리스트 카운트 조회
		int totalRecordCount = triggerArService.getTriggerArListCount(map);
		
		if (totalRecordCount > 0) {
		
			//페이징 정보 조회
			PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, totalRecordCount);
			
			//조회조건에 페이징 정보 설정
			map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, totalRecordCount));
	
			//디바이스 리스트 조회
			List<Map<String, Object>> resultList = triggerArService.selectTriggerArList(map);
	
			//결과값 설정
			returnMap.put("resultList", resultList);
			returnMap.put("paginationInfo", paginationInfo);
			
		} else {
			
			//결과값 설정
			returnMap.put("resultList", null);
			returnMap.put("paginationInfo", PaginationUtil.getPaginationInfo(map, 0));
			
		}
		
		return new ResponseVO(returnMap);
	}
	
	@RequestMapping(value = "/triggerArInstantStartPop")
	public ModelAndView triggerArInstantStartPop() throws Exception {
		return new ModelAndView("/resrce/triggerAr/triggerArInstantStartPop");
	}
	
	@RequestMapping(value = "/triggerArInstantSearchReleases")
	@ResponseBody
	public ResponseVO triggerArInstantSearchReleases(@RequestBody Map<String, Object> map, HttpServletRequest request) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		CmmnUserVO cmmnUserVO = (CmmnUserVO)request.getSession().getAttribute("sessionUserInfo");
		map.put("cmpnyCd", cmmnUserVO.getTxCmpnyCd());
		
		List<Map<String, Object>> mResult = triggerArService.triggerArInstantSearchReleases(map);
		returnMap.put("resultList", mResult);
		
		return new ResponseVO(returnMap);
	}
	
	@RequestMapping(value = "/triggerArInstantSearchRobot")
	@ResponseBody
	public ResponseVO triggerArInstantSearchRobot(@RequestBody Map<String, Object> map, HttpServletRequest request) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		CmmnUserVO cmmnUserVO = (CmmnUserVO)request.getSession().getAttribute("sessionUserInfo");
		map.put("cmpnyCd", cmmnUserVO.getTxCmpnyCd());
		
		List<Map<String, Object>> mResult = triggerArService.triggerArInstantSearchRobot(map);
		returnMap.put("resultList", mResult);
		
		return new ResponseVO(returnMap);
	}
	
	@RequestMapping(value = "/insertInstantStart")
	@ResponseBody
	public ResponseVO insertInstantStart(@RequestBody Map<String, Object> map, HttpServletRequest request) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		triggerArService.insertInstantStart(map);
		return new ResponseVO();
	}
	
	@RequestMapping(value = "/triggerArResveStartPop")
	public ModelAndView triggerArResveStartPop() throws Exception {
		return new ModelAndView("/resrce/triggerAr/triggerArResveStartPop");
	}

	
	@RequestMapping(value = "/insertResveStart")
	@ResponseBody
	public ResponseVO insertResveStart(@RequestBody Map<String, Object> map, HttpServletRequest request) throws Exception {
		map.put("resveTime", (map.get("dateYmshm"))+":000");
		String compareTimeResult = triggerArService.getCompareTime(map);
		
		if(compareTimeResult.equals("Y")) {
			throw new RpaException("ECST", "예약 시간은 현재 시간보다 최소 1분 이후여야 합니다.");
		}
		
		CmmnUserVO cmmnUserVO = (CmmnUserVO)request.getSession().getAttribute("sessionUserInfo");
		map.put("cmpnyCd", cmmnUserVO.getTxCmpnyCd());
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		triggerArService.insertResveStart(map);
		return new ResponseVO();
	}
	
	// Trigger AR 등록 창
	@RequestMapping(value = "/triggerArTriggerPop")
	public ModelAndView triggerArTriggerPop() throws Exception {
		return new ModelAndView("/resrce/triggerAr/triggerArTriggerPop");
	}
	
	// Trigger AR 수정 창
	@RequestMapping(value = "/triggerArTriggerUpdatePop")
	public ModelAndView triggerArTriggerUpdatePop() throws Exception {
		return new ModelAndView("/resrce/triggerAr/triggerArTriggerUpdatePop");
	}
		
		
	
	@RequestMapping(value = "/searchCalendars")
	@ResponseBody
	public ResponseVO searchCalendars(@RequestBody Map<String, Object> map, HttpServletRequest request) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		CmmnUserVO cmmnUserVO = (CmmnUserVO)request.getSession().getAttribute("sessionUserInfo");
		map.put("cmpnyCd", cmmnUserVO.getTxCmpnyCd());
		
		Map<String, Object> mResult = triggerUrService.searchCalendars(map);
		returnMap.put("paginationInfo", PaginationUtil.getPaginationInfo(map, Integer.parseInt(mResult.get("@odata.count").toString())));
		returnMap.put("resultList", mResult.get("value"));
		return new ResponseVO(returnMap);
	}
	
	@RequestMapping(value = "/isValidExpression")
	@ResponseBody
	public ResponseVO isValidExpression(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
    	Map<String, Object> returnMap = new HashMap<String, Object>();

		if(!CronExpression.isValidExpression(params.get("cronExp").toString())) {
			returnMap.put("isValidExpression", false);	
			return new ResponseVO(returnMap);
		}
		
		returnMap.put("isValidExpression", true);	
		return new ResponseVO(returnMap);
	}

	/**
	 * 과제운영 > 과제운영 > 프로세스 정기운영 등록
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveRoutinePlan")
	@ResponseBody
	public ResponseVO saveRoutinePlan(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TriggerArController.saveRoutinePlan start!!");
		long start = System.currentTimeMillis(); 
		
		if(params.get("schduleData") != null) {
			Map<String, Object> aSaveRoutine = (Map<String, Object>)params.get("schduleData");
			String logInId = MDC.get("txUserId");
			
			String executMinute = "";
			String result_minut = "";
			String everyHour = "";
			String executHour = "";
			
			if(aSaveRoutine.get("executMinute") != null) {
				executMinute = aSaveRoutine.get("executMinute").toString();
				int minut = Integer.parseInt(executMinute);
				result_minut = String.format("%02d", minut);
				aSaveRoutine.put("executMinute", result_minut);				
			}
			
			if(aSaveRoutine.get("everyHour") != null) {
				everyHour = aSaveRoutine.get("everyHour").toString();
				int eveHour = Integer.parseInt(everyHour);
				String temp_eveHour = String.format("%02d", eveHour);
				aSaveRoutine.put("everyHour", temp_eveHour);				
			}

			
			if(aSaveRoutine.get("executHour") != null) {
				executHour = aSaveRoutine.get("executHour").toString();
				int exHour = Integer.parseInt(executHour);
				String temp_exHour = String.format("%02d", exHour);
				aSaveRoutine.put("executHour", temp_exHour);				
			}


			aSaveRoutine.put("logInId", logInId);
			aSaveRoutine.put("processCd", params.get("processCd"));
			aSaveRoutine.put("cmpnyCd", params.get("cmpnyCd"));
			aSaveRoutine.put("botNo", params.get("botNo"));
			aSaveRoutine.put("releasesId", params.get("releasesId"));
			aSaveRoutine.put("releasesKey", params.get("releasesKey"));
			aSaveRoutine.put("botType", params.get("botType"));
			aSaveRoutine.put("releasesName", params.get("releasesName"));
			aSaveRoutine.put("processKey", params.get("processKey"));
			aSaveRoutine.put("inputArguments", params.get("inputArguments"));
			
			Map<String, Object> schdule = taskManageService.getTaskManageschduleNo(aSaveRoutine);
			String schduleNo = schdule.get("schduleNo").toString();
			aSaveRoutine.put("schduleNo", Integer.parseInt(schduleNo));
			
			taskManageService.insertTaskRoutinePlan(aSaveRoutine);
			
			if(aSaveRoutine.get("schduleType1").toString().equals("6")) {
		        makeARSched maekARSchd = new makeARSched(dbDriverType, dbDriverClassName,dbUrl, dbUsername, dbPassword);	
				long startTime = System.currentTimeMillis(); 
		        logger.debug("TriggerArController makeArSchedule START : =================");
		        
		        maekARSchd.makeTriggerARSched(params, aSaveRoutine);
		        
		        long endTime = System.currentTimeMillis(); //프로그램이 끝나는 시점 계산
		        logger.debug("TriggerArController makeArSchedule END : " + (endTime - startTime)/1000.0 + "초 =================");

		        
				Map<String, Object> returnMap = new HashMap<String, Object>();
				returnMap.put("isEndInsert", true);	

				return new ResponseVO(returnMap);
			}
						
			taskManageService.insertTaskManageProcessPlan(aSaveRoutine);
			
			// Orchestrator 스케쥴 발송을 위한 작업 준비중============================================================
	    	/*JSONObject jsonObject = new JSONObject();
	    	JSONObject jsonObj1 = new JSONObject();
	    	JSONArray bot_array = new JSONArray();
			
			String url = "/odata/ProcessSchedules";
	    	bot_array.add(Integer.parseInt(params.get("botNo").toString()));
	    	jsonObject.put("Name","~~~~ing");
	    	jsonObject.put("InputArguments",params.get("inputArguments"));	    	
	    	jsonObject.put("Enabled",true);
	    	jsonObject.put("UseCalendar",true);
	    	jsonObject.put("CalendarId","~~ing");
	    	
	    	jsonObj1.put("","~~ing");
	    	
	    	jsonObject.put("StartProcessCronDetails",jsonObj1);
	    	
	    	jsonObject.put("StartProcessCron",params.get("schduleCrontab"));
	    	jsonObject.put("ExecutorRobots",bot_array);
	    	jsonObject.put("StopStrategy",null);
	    	jsonObject.put("StopProcessExpression","");
	    	jsonObject.put("ReleaseId",params.get("releasesId"));
	    	jsonObject.put("ReleaseName",params.get("releasesName"));
	    	jsonObject.put("TimeZoneId","Korea Standard Time");
	    	jsonObject.put("StartStrategy",0);
	    	jsonObject.put("StopProcessDate",null);
	    	jsonObject.put("ExternalJobKey","");*/
	    	
	    	// Orchestrator 스케쥴 발송을 위한 작업 준비중============================================================		
			
		}
		return new ResponseVO(new HashMap<String, Object>());
	}
	
	@RequestMapping(value = "/deleteRoutinePlan")
	@ResponseBody
	public ResponseVO deleteRoutinePlan(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TriggerArController.deleteRoutinePlan start!!");
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		taskManageService.deleteTaskManageProcessPlan(params);  // TB_TEMP_RESRVE_BOT 삭제
		
		taskManageService.deleteTaskManageProcessSchdule(params);  // TB_TASK_DEVLOP_PROCESS_SCHDULE 삭제
		
		returnMap.put("msg", "삭제 처리 하였습니다.");
		
		logger.debug("TriggerArController.deleteRoutinePlan End!!");		
		return new ResponseVO(returnMap);
	}
	
	// Disable이 아닌 상태  → Disable 
	@RequestMapping(value = "/convertTodisable")
	@ResponseBody
	public ResponseVO convertTodisable(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TriggerArController.convertTodisable start!!");		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		try {
			triggerArService.convertTodisableSchdule(params); // TB_TEMP_RESRVE_BOT 수정
			triggerArService.convertTodisableInfo(params);  // TB_TASK_DEVLOP_PROCESS_SCHDULE 수정
		} catch (Exception e) {
			// TODO: handle exception
			returnMap.put("isError", "Disable로 변환 중에 오류가 발생하였습니다.");
		}
		
		logger.debug("TriggerArController.convertTodisable End!!");		
		return new ResponseVO(returnMap);
	}
	
	// Disable  → Disable이 아닌 상태
	@RequestMapping(value = "/convertToNotdisable")
	@ResponseBody
	public ResponseVO convertToNotdisable(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TriggerArController.convertToNotdisable start!!");
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		try {
			triggerArService.convertToNotdisableSchdule(params); // TB_TEMP_RESRVE_BOT 수정
			triggerArService.convertToNotdisableInfo(params);  // TB_TASK_DEVLOP_PROCESS_SCHDULE 수정
		} catch (Exception e) {
			// TODO: handle exception
			returnMap.put("isError", "Disable 상태를 해제하는 도중에 오류가 발생하였습니다.");
		}
		
		logger.debug("TriggerArController.convertToNotdisable End!!");		
		return new ResponseVO(returnMap);
	}
	
	// Trigger AR 수정 팝업창(해당 스케줄) 데이터 SELECT
	@RequestMapping(value = "/triggerArSelectInfoForUpdate")
	@ResponseBody
	public ResponseVO triggerArSelectInfoForUpdate(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TriggerArController.triggerArSelectInfoForUpdate start!!");
		Map<String, Object> returnMap = new HashMap<String, Object>();

		List<Map<String, Object>> getInfo = triggerArService.triggerArSelectInfoForUpdate(params);
		returnMap.put("resultList", getInfo);

		logger.debug("TriggerArController.triggerArSelectInfoForUpdate End!!");		
		return new ResponseVO(returnMap);
	}
	
	// 프로세스 코드로 프로세스와 실행 가능한 로봇 조회
	@RequestMapping(value = "/searchProcessRobot")
	@ResponseBody
	public ResponseVO searchProcessRobot(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TriggerArController.searchProcessRobot start!!");
		Map<String, Object> returnMap = new HashMap<String, Object>();

		List<Map<String, Object>> getInfo = triggerArService.triggerArSelectProcessForUpdate(params);
		returnMap.put("resultList", getInfo);

		List<Map<String, Object>> mResult = triggerArService.triggerArInstantSearchRobot(params);
		returnMap.put("robotList", mResult);
		
		logger.debug("TriggerArController.searchProcessRobot End!!");		
		return new ResponseVO(returnMap);
	}
}

class makeARSched {	
	private String dbDriverType;
	private String dbDriverClassName;
	private String dbUrl;
	private String dbUsername;
	private String dbPassword;

	makeARSched (String dbDriverType, String dbDriverClassName, String dbUrl, String dbUsername, String dbPassword) {
		this.dbDriverType = dbDriverType;
		this.dbDriverClassName = dbDriverClassName;
		this.dbUrl = dbUrl;
		this.dbUsername = dbUsername;
		this.dbPassword = dbPassword;
	}
	
	//@Async("threadPoolTaskExecutor")
	public void makeTriggerARSched(Map<String, Object> params, Map<String, Object> aSaveRoutine) {

		Connection con = null;
        PreparedStatement pstmt = null ;
        int insertTotal = 0;
        String sql = "Insert Into [dbo].[TB_TEMP_RESRVE_BOT]" 
        + "([DATE_YMD], [DATE_YMSHM], [BOT_NO], [TIME_NO]" 
        + ", [PROCESS_CD] ,[REGISTER_ID], [REG_DT], [REG_GBN]" 
        + ", [SEND_YN], [CMPNY_CD], [BOT_TYPE], [INPUTARGUMENTS]"
        + ", [RELEASES_ID], [RELEASES_KEY], [RELEASES_NAME], [PROCESS_KEY]" 
        + ", [SCHDULE_NO], [DELETE_AT], [UPDUSR_ID], [UPDT_DT]) " 
        + "Values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)" ;
      
        try {	       	

			Class.forName(dbDriverClassName);
			con = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
			
			pstmt = con.prepareStatement(sql) ;
			
			Date today = new Date(); 
			SimpleDateFormat sdfhhmmss = new SimpleDateFormat("HH:mm:ss");
			String HHmmss = sdfhhmmss.format(today).toString();

			CronExpression ce = new CronExpression(params.get("cronExp").toString());
		
			String startDateToString = aSaveRoutine.get("startDe1").toString() + " " + HHmmss;

			String endDateToString = getLastDayAfterOneMonth();
			String endDateToString2 = aSaveRoutine.get("endDe").toString() + " 23:59:59";
			
			SimpleDateFormat transFormatStart = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date startDate = transFormatStart.parse(startDateToString);

			SimpleDateFormat transFormatEnd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date endDate = transFormatEnd.parse(endDateToString); // 1달 후의 마지막 날짜
			Date endDate2 = transFormatEnd.parse(endDateToString2); // Trigger AR 등록창에서 시간 설정한 끝 날짜

			if(endDate.compareTo(endDate2) >= 0) {
				endDate = endDate2;
				endDateToString = endDateToString2;
			}
			
			int insertCount = 0;

			while(true) {		
				startDate = ce.getTimeAfter(startDate);
				
				if(startDate.compareTo(endDate) >= 0) break;				
				String nextProcessSchd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(startDate);

				Calendar calendar = Calendar.getInstance(); // creates a new calendar instance
				calendar.setTime(startDate);   // assigns calendar to given date 
				int hour = calendar.get(Calendar.HOUR_OF_DAY); // gets hour in 24h format
				int minute = calendar.get(Calendar.MINUTE);			
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		        String strFutureSched = sdf.format(calendar.getTime());
				
				pstmt.setString(1, strFutureSched); // DATE_YMD
				
				pstmt.setTimestamp(2, new java.sql.Timestamp(new Date(calendar.getTimeInMillis()).getTime()));
				//pstmt.setDate(2, new java.sql.Date(calendar.getTimeInMillis())); // DATE_YMSHM
				
				pstmt.setLong(3,  Long.parseLong(aSaveRoutine.get("botNo").toString())); // BOT_NO
				pstmt.setInt(4, (hour*6 + minute/10 + 1)); // TIME_NO
				pstmt.setString(5, aSaveRoutine.get("processCd").toString());
				pstmt.setString(6, aSaveRoutine.get("logInId").toString());
				
				pstmt.setTimestamp(7, new java.sql.Timestamp(today.getTime()));
				//pstmt.setDate(7, new java.sql.Date(today.getTime())); // REG_DT
			
				pstmt.setString(8, "A"); // REG_GBN
				pstmt.setString(9, "N"); // SEND_YN
				pstmt.setString(10, aSaveRoutine.get("cmpnyCd").toString()); // CMPNY_CD
				pstmt.setString(11, aSaveRoutine.get("botType").toString()); // BOT_TYPE
				pstmt.setString(12, aSaveRoutine.get("inputArguments").toString()); // INPUTARGUMENTS
				pstmt.setString(13, aSaveRoutine.get("releasesId").toString()); // RELEASES_ID
				pstmt.setString(14, aSaveRoutine.get("releasesKey").toString()); // RELEASES_KEY
				pstmt.setString(15, aSaveRoutine.get("releasesName").toString()); // RELEASES_NAME
				pstmt.setString(16, aSaveRoutine.get("processKey").toString()); // PROCESS_KEY
				pstmt.setString(17, aSaveRoutine.get("schduleNo").toString()); // SCHDULE_NO
				pstmt.setInt(18, 0); // DELETE_AT
				pstmt.setString(19, null); // UPDUSR_ID
				
				pstmt.setDate(20, null); // UPDT_DT
									
				 // addBatch에 담기
                pstmt.addBatch();
                 
                // 파라미터 Clear
                pstmt.clearParameters() ;
                
                ++insertTotal;

                // OutOfMemory를 고려하여 만건 단위로 커밋
                if( (++insertCount % 10000) == 0){
                	insertCount = 0; 	                	
                    // Batch 실행
                    pstmt.executeBatch();	                     
                    // Batch 초기화
                    pstmt.clearBatch();	                     
                    // 커밋
                    con.commit();
                }
			}

			// 커밋되지 못한 나머지 구문에 대하여 커밋
           pstmt.executeBatch();
           con.commit();
			
           pstmt.close();
           con.close();
			
		} catch (Exception e) {
			// TODO: handle exception
			 e.printStackTrace();          
	         try {
	        	 con.rollback() ;
	         } catch (SQLException e1) {
	             // TODO Auto-generated catch block
	             e1.printStackTrace();
	         }
		} finally {
			if (pstmt != null) try {pstmt.close();pstmt = null;} catch(SQLException ex){}
            if (con != null) try {con.close();con = null;} catch(SQLException ex){}
		}
	}
	
	// 다음 달의 마지막 날짜 반환 → yyyy-MM-dd HH:mm:ss
	public static String getLastDayAfterOneMonth() {
		Date today = new Date(); 

		SimpleDateFormat sDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); // yyyy-MM-dd HH:mm:ss.SSS
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(today);
		calendar.add(Calendar.MONTH, 1);	
		
		int LastDayOfMonth = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
		calendar.set(Calendar.DAY_OF_MONTH, LastDayOfMonth);   

		calendar.set(Calendar.HOUR_OF_DAY, 23);
		calendar.set(Calendar.MINUTE, 59);
		calendar.set(Calendar.SECOND, 59);
		calendar.set(Calendar.MILLISECOND, 999);
		
		Date LastMonth = new Date(calendar.getTimeInMillis());
		String testDate = sDate.format(LastMonth);
		
		return testDate;
	}
}
