package kr.co.rpaplatform.crontab;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.quartz.CronExpression;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import kr.co.rpaplatform.crontab.service.CronSchedulService;
import kr.co.rpaplatform.dongwon.task.service.TaskManageService;
import kr.co.rpaplatform.rpaapi.uipath.common.RestApi;


@EnableAsync
@Component
public class Scheduler { 
	
	@Resource(name="restApi")
	private RestApi restApi;
	
	@Resource(name="taskManageService")
	private TaskManageService taskManageService;
	
	@Resource(name="cronSchedulService")
	private CronSchedulService cronSchedulService;
	
	@Value("${attend.schdule.run}")
	private String attendSchduleRun;
	
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
    
	//Logger log = Logger.getLogger(this.getClass());
	private final Logger log = LoggerFactory.getLogger(Scheduler.class);
	
	//private boolean bRunTest = false;

	/** * 초  분  시간   // 매시 9분 Send Prc 확인
	 * @throws Exception */ 
	
	@Scheduled(cron = "0/10 * * * * *")
	@Async("threadPoolTaskExecutor")
	public void resveExecut() throws Exception{
		log.debug("resveExecut START : ====================:" + attendSchduleRun);
		
		if(attendSchduleRun.equals("Y")) {
			log.debug("resveExecut: RUN");
			
			Map<String, Object> param = new HashMap<String, Object>();
	        int sendCount = cronSchedulService.selectResveExecutListCount(param);
	        log.debug("resveExecut : ====================sendCount: "+sendCount);
	        if(sendCount > 0) {
	            List<Map<String, Object>> resultList = cronSchedulService.selectResveExecutList(param);
	            log.debug("resultList : ====================resultList.size(): "+resultList.size());
	            int resultListSize = resultList.size();
		        for(int i = 0; i < resultListSize;i++) {
		        	String resvNo           = resultList.get(i).get("resvNo").toString();
		        	String dateYmd          = resultList.get(i).get("dateYmd").toString();
		        	String dateYmshm        = resultList.get(i).get("dateYmshm").toString();
		        	String botNo            = resultList.get(i).get("botNo").toString();
		        	String timeNo           = resultList.get(i).get("timeNo").toString();
		        	String processCd        = resultList.get(i).get("processCd").toString();
		        	String regGbn           = resultList.get(i).get("regGbn").toString();
		        	String sendYn           = resultList.get(i).get("sendYn").toString();
		        	String cmpnyCd          = resultList.get(i).get("cmpnyCd").toString();
		        	String botType          = resultList.get(i).get("botType").toString();
		        	String inputArguments   = resultList.get(i).get("inputArguments").toString();
		        	String releasesId       = resultList.get(i).get("releasesId").toString();
		        	String releasesKey      = resultList.get(i).get("releasesKey").toString();
		        	String releasesName     = resultList.get(i).get("releasesName").toString();
		        	String processKey       = resultList.get(i).get("processKey").toString();
		        	
		        	// api 호출 data set ============================================
		        	JSONObject jsonObject = new JSONObject();
		        	JSONObject jsonObj1 = new JSONObject();
		        	JSONArray bot_array = new JSONArray();
		        	bot_array.add(Integer.parseInt(botNo));
		        	jsonObject.put("InputArguments",inputArguments);
		        	jsonObject.put("JobsCount",0);
		        	jsonObject.put("ReleaseKey",releasesKey);
		        	jsonObject.put("RobotIds",bot_array);
		        	jsonObject.put("Strategy","Specific");
		        	jsonObj1.put("startInfo", jsonObject);
		        	jsonObj1.put("cmpnyCd",cmpnyCd);
		        	//=====================================================
		        	String url = "/odata/Jobs/UiPath.Server.Configuration.OData.StartJobs";
		        	param.put("resvNo", resvNo);
		        	param.put("dateYmd", dateYmd);
		        	param.put("dateYmshm", dateYmshm);
		        	param.put("botNo", botNo);
		        	param.put("timeNo", timeNo);
		        	param.put("processCd", processCd);
		        	param.put("regGbn", regGbn);
		        	param.put("sendYn", sendYn);
		        	param.put("cmpnyCd", cmpnyCd);
		        	param.put("botType", botType);
		        	param.put("inputArguments", inputArguments);
		        	param.put("releasesId", releasesId);
		        	param.put("releasesKey", releasesKey);
	    			param.put("releasesName", releasesName);
	    			param.put("processKey", processKey);
		        	
	    			int calCnt = 0;
	    			Map<String, Object> returnData = cronSchedulService.getCalendarChkVal(param);
	    			log.debug("returnData : ====================:"+returnData);
	    			if(returnData != null) {
		    			String chkVal = returnData.get("chkVal").toString();
		    			log.debug("chkVal : ====================:"+chkVal);
		    			param.put("chkVal", chkVal);
		    			calCnt = cronSchedulService.selectCalendarCount(param);
		    			log.debug("calCnt : ====================:"+calCnt);
	    			}    			
	    			if(calCnt == 0) {
	    				
	/*	기존 스케줄 AR 전용으로 변경함 
//			    		if("1".equals(botType)) { // Attended  table insert
//			    			taskManageService.insertTaskAttendedReserve(param);
//			    		}else if("2".equals(botType)) { // Unattended 2   api call
//			    			ResponseEntity<Map> response = restApi.post(url, jsonObj1);
//			    			param.put("response", response.toString());
//			    		}else if("3".equals(botType)) { // Studio 3   api call
//			    			ResponseEntity<Map> response = restApi.post(url, jsonObj1);
//			    			param.put("response", response.toString());
			    		}
	*/
	    				
	/* AR 전용*/
	    				taskManageService.insertTaskAttendedReserve(param);
		            	// 처리 후 update
		            	cronSchedulService.updateCronSchedul(param);
		            	// history 저장
		            	taskManageService.insertTaskSendHistory(param);
	    			}
		        }
	        }
		}
		else {
			log.debug("resveExecut: NOT RUN");
		} 
        
        log.debug("resveExecut END : ====================");
	}
	
	
	/** * 초  분  시간   // 매시 45분 Send Prc 확인
	 * @throws Exception */ 
	@Scheduled(cron = "0 45 * * * *")
	@Async("threadPoolTaskExecutor")
	public void cronStsOne() throws Exception{
		log.debug("cronStsOne START : =================");
		Map<String, Object> map = new HashMap<String, Object>();
		cronSchedulService.insertDailyStsTotLog(map);
        log.debug("cronStsOne END : ===================");
	}
	
	// BOT별 동작현황 
	// 0/10 : 0초부터 10초마다
	// 10 : 10초'만'
	@Scheduled(cron = "0/30 * * * * ?") 
	@Async("threadPoolTaskExecutor")
	public void botMntrng() throws Exception{
		log.debug("botMntrng START : ====================");		
		log.debug("botMntrng: RUN");		
		cronSchedulService.insertOrUpdateBotMntrng();	
		cronSchedulService.botMntrngBatchResult();	
        log.debug("botMntrng: END : ====================");
	}
	
	// 절감시간 이슈관리
	// 매월 1일 오전 1시
	@Scheduled(cron = "0 0 1 1 * ?") 
	@Async("threadPoolTaskExecutor")
	public void savingTimeIssueMng() throws Exception{
		log.debug("savingTimeIssueMng START : ====================");		
		log.debug("savingTimeIssueMng: RUN");		
		
		int insertCnt = cronSchedulService.insertSavingTimeIssueMng();		
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(insertCnt > 0) {
			map.put("cnt", insertCnt);
			// 배치 테이블에 추가된 데이터들을 다시 TB_TASK_DEVLOP_PROCESS_OPER_SUCCES_RESN에 INSERT
			cronSchedulService.insertSavingTimeIssueMngResn(map);
		}
		
		cronSchedulService.savingTimeIssueMngBatchResult();	
		
        log.debug("savingTimeIssueMng: END : ====================");
	}
	
	
	// BATCH_RESULT 테이블 로그 삭제
	// 매월 1일 오전 2시
	@Scheduled(cron = "0 0 2 1 * ?")
	@Async("threadPoolTaskExecutor")
	public void deleteBatchResult() throws Exception{
		log.debug("deleteBatchResult START : ====================");		
		log.debug("deleteBatchResult: RUN");		

		cronSchedulService.deleteBatchResult();
		
        log.debug("deleteBatchResult: END : ====================");
	}
	
	/** * 초  분  시간   // 매시 9분 Send Prc 확인
	 * @throws Exception */ 
	
//	@Scheduled(cron = "0 9 * * * *") 
//	public void cronSerchOne() throws Exception{
//		log.debug("cronSerchOne START : ====================1");
//        Map<String, Object> param = new HashMap<String, Object>();
//        int sendCount = cronSchedulService.selectSendScheduleCount(param);
//        log.debug("sendCount : ====================:"+sendCount);
//        if(sendCount > 0) {
//            List<Map<String, Object>> resultList = cronSchedulService.selectSendScheduleList(param);
//            log.debug("resultList : ====================:"+resultList);
//            
//	        for(int i = 0; i < resultList.size();i++) {
//	        	String resvNo           = resultList.get(i).get("resvNo").toString();
//	        	String dateYmd          = resultList.get(i).get("dateYmd").toString();
//	        	String dateYmshm        = resultList.get(i).get("dateYmshm").toString();
//	        	String botNo            = resultList.get(i).get("botNo").toString();
//	        	String timeNo           = resultList.get(i).get("timeNo").toString();
//	        	String processCd        = resultList.get(i).get("processCd").toString();
//	        	String regGbn           = resultList.get(i).get("regGbn").toString();
//	        	String sendYn           = resultList.get(i).get("sendYn").toString();
//	        	String cmpnyCd          = resultList.get(i).get("cmpnyCd").toString();
//	        	String botType          = resultList.get(i).get("botType").toString();
//	        	String inputArguments   = resultList.get(i).get("inputArguments").toString();
//	        	String releasesId       = resultList.get(i).get("releasesId").toString();
//	        	String releasesKey      = resultList.get(i).get("releasesKey").toString();
//	        	String releasesName     = resultList.get(i).get("releasesName").toString();
//	        	String processKey       = resultList.get(i).get("processKey").toString();
//	        	
//	        	// api 호출 data set ============================================
//	        	JSONObject jsonObject = new JSONObject();
//	        	JSONObject jsonObj1 = new JSONObject();
//	        	JSONArray bot_array = new JSONArray();
//	        	bot_array.add(Integer.parseInt(botNo));
//	        	jsonObject.put("InputArguments",inputArguments);
//	        	jsonObject.put("JobsCount",0);
//	        	jsonObject.put("ReleaseKey",releasesKey);
//	        	jsonObject.put("RobotIds",bot_array);
//	        	jsonObject.put("Strategy","Specific");
//	        	jsonObj1.put("startInfo", jsonObject);
//	        	jsonObj1.put("cmpnyCd",cmpnyCd);
//	        	//=====================================================
//	        	String url = "/odata/Jobs/UiPath.Server.Configuration.OData.StartJobs";
//	        	param.put("resvNo", resvNo);
//	        	param.put("dateYmd", dateYmd);
//	        	param.put("dateYmshm", dateYmshm);
//	        	param.put("botNo", botNo);
//	        	param.put("timeNo", timeNo);
//	        	param.put("processCd", processCd);
//	        	param.put("regGbn", regGbn);
//	        	param.put("sendYn", sendYn);
//	        	param.put("cmpnyCd", cmpnyCd);
//	        	param.put("botType", botType);
//	        	param.put("inputArguments", inputArguments);
//	        	param.put("releasesId", releasesId);
//	        	param.put("releasesKey", releasesKey);
//    			param.put("releasesName", releasesName);
//    			param.put("processKey", processKey);
//	        	
//    			int calCnt = 0;
//    			Map<String, Object> returnData = cronSchedulService.getCalendarChkVal(param);
//    			log.debug("returnData : ====================:"+returnData);
//    			if(returnData != null) {
//	    			String chkVal = returnData.get("chkVal").toString();
//	    			log.debug("chkVal : ====================:"+chkVal);
//	    			param.put("chkVal", chkVal);
//	    			calCnt = cronSchedulService.selectCalendarCount(param);
//	    			log.debug("calCnt : ====================:"+calCnt);
//    			}    			
//    			if(calCnt == 0) {
//		    		if("1".equals(botType)) { // Attended  table insert
//		    			taskManageService.insertTaskAttendedReserve(param);
//		    		}else if("2".equals(botType)) { // Unattended 2   api call
//		    			ResponseEntity<Map> response = restApi.post(url, jsonObj1);
//		    			param.put("response", response.toString());
//		    		}else if("3".equals(botType)) { // Studio 3   api call
//		    			ResponseEntity<Map> response = restApi.post(url, jsonObj1);
//		    			param.put("response", response.toString());
//		    		}
//	            	// 처리 후 update
//	            	cronSchedulService.updateCronSchedul(param);
//	            	// history 저장
//	            	taskManageService.insertTaskSendHistory(param);
//    			}
//	        }
//        }
//        log.debug("BATCH END : ====================");
//	}
	
	/** * 초  분  시간   // 매시 19분 Send Prc 확인
	 * @throws Exception */ 
	
//	@Scheduled(cron = "0 19 * * * *") 
//	public void cronSerchTwo() throws Exception{
//		log.debug("cronSerchTwo START : ====================2");
//        Map<String, Object> param = new HashMap<String, Object>();
//        int sendCount = cronSchedulService.selectSendScheduleCount(param);
//        log.debug("sendCount : ====================:"+sendCount);
//        if(sendCount > 0) {
//            List<Map<String, Object>> resultList = cronSchedulService.selectSendScheduleList(param);
//            log.debug("resultList : ====================:"+resultList);
//            
//	        for(int i = 0; i < resultList.size();i++) {
//	        	String resvNo           = resultList.get(i).get("resvNo").toString();
//	        	String dateYmd          = resultList.get(i).get("dateYmd").toString();
//	        	String dateYmshm        = resultList.get(i).get("dateYmshm").toString();
//	        	String botNo            = resultList.get(i).get("botNo").toString();
//	        	String timeNo           = resultList.get(i).get("timeNo").toString();
//	        	String processCd        = resultList.get(i).get("processCd").toString();
//	        	String regGbn           = resultList.get(i).get("regGbn").toString();
//	        	String sendYn           = resultList.get(i).get("sendYn").toString();
//	        	String cmpnyCd          = resultList.get(i).get("cmpnyCd").toString();
//	        	String botType          = resultList.get(i).get("botType").toString();
//	        	String inputArguments   = resultList.get(i).get("inputArguments").toString();
//	        	String releasesId       = resultList.get(i).get("releasesId").toString();
//	        	String releasesKey      = resultList.get(i).get("releasesKey").toString();
//	        	String releasesName     = resultList.get(i).get("releasesName").toString();
//	        	String processKey       = resultList.get(i).get("processKey").toString();
//	        	
//	        	// api 호출 data set ============================================
//	        	JSONObject jsonObject = new JSONObject();
//	        	JSONObject jsonObj1 = new JSONObject();
//	        	JSONArray bot_array = new JSONArray();
//	        	bot_array.add(Integer.parseInt(botNo));
//	        	jsonObject.put("InputArguments",inputArguments);
//	        	jsonObject.put("JobsCount",0);
//	        	jsonObject.put("ReleaseKey",releasesKey);
//	        	jsonObject.put("RobotIds",bot_array);
//	        	jsonObject.put("Strategy","Specific");
//	        	jsonObj1.put("startInfo", jsonObject);
//	        	jsonObj1.put("cmpnyCd",cmpnyCd);
//	        	//=====================================================
//	        	String url = "/odata/Jobs/UiPath.Server.Configuration.OData.StartJobs";
//	        	param.put("resvNo", resvNo);
//	        	param.put("dateYmd", dateYmd);
//	        	param.put("dateYmshm", dateYmshm);
//	        	param.put("botNo", botNo);
//	        	param.put("timeNo", timeNo);
//	        	param.put("processCd", processCd);
//	        	param.put("regGbn", regGbn);
//	        	param.put("sendYn", sendYn);
//	        	param.put("cmpnyCd", cmpnyCd);
//	        	param.put("botType", botType);
//	        	param.put("inputArguments", inputArguments);
//	        	param.put("releasesId", releasesId);
//	        	param.put("releasesKey", releasesKey);
//    			param.put("releasesName", releasesName);
//    			param.put("processKey", processKey);
//	        	
//    			int calCnt = 0;
//    			Map<String, Object> returnData = cronSchedulService.getCalendarChkVal(param);
//    			log.debug("returnData : ====================:"+returnData);
//    			if(returnData != null) {
//	    			String chkVal = returnData.get("chkVal").toString();
//	    			log.debug("chkVal : ====================:"+chkVal);
//	    			param.put("chkVal", chkVal);
//	    			calCnt = cronSchedulService.selectCalendarCount(param);
//	    			log.debug("calCnt : ====================:"+calCnt);
//    			}    			
//    			if(calCnt == 0) {
//		    		if("1".equals(botType)) { // Attended  table insert
//		    			taskManageService.insertTaskAttendedReserve(param);
//		    		}else if("2".equals(botType)) { // Unattended 2   api call
//		    			ResponseEntity<Map> response = restApi.post(url, jsonObj1);
//		    			param.put("response", response.toString());
//		    		}else if("3".equals(botType)) { // Studio 3   api call
//		    			ResponseEntity<Map> response = restApi.post(url, jsonObj1);
//		    			param.put("response", response.toString());
//		    		}
//	            	// 처리 후 update
//	            	cronSchedulService.updateCronSchedul(param);
//	            	// history 저장
//	            	taskManageService.insertTaskSendHistory(param);
//    			}
//	        }
//        }
//        log.debug("BATCH END : ====================");
//	}
	
	/** * 초  분  시간   // 매시 29분 Send Prc 확인
	 * @throws Exception */ 
	
//	@Scheduled(cron = "0 29 * * * *") 
//	public void cronSerchThree() throws Exception{
//		log.debug("cronSerchThree START : ====================3");
//        Map<String, Object> param = new HashMap<String, Object>();
//        int sendCount = cronSchedulService.selectSendScheduleCount(param);
//        log.debug("sendCount : ====================:"+sendCount);
//        if(sendCount > 0) {
//            List<Map<String, Object>> resultList = cronSchedulService.selectSendScheduleList(param);
//            log.debug("resultList : ====================:"+resultList);
//            
//	        for(int i = 0; i < resultList.size();i++) {
//	        	String resvNo           = resultList.get(i).get("resvNo").toString();
//	        	String dateYmd          = resultList.get(i).get("dateYmd").toString();
//	        	String dateYmshm        = resultList.get(i).get("dateYmshm").toString();
//	        	String botNo            = resultList.get(i).get("botNo").toString();
//	        	String timeNo           = resultList.get(i).get("timeNo").toString();
//	        	String processCd        = resultList.get(i).get("processCd").toString();
//	        	String regGbn           = resultList.get(i).get("regGbn").toString();
//	        	String sendYn           = resultList.get(i).get("sendYn").toString();
//	        	String cmpnyCd          = resultList.get(i).get("cmpnyCd").toString();
//	        	String botType          = resultList.get(i).get("botType").toString();
//	        	String inputArguments   = resultList.get(i).get("inputArguments").toString();
//	        	String releasesId       = resultList.get(i).get("releasesId").toString();
//	        	String releasesKey      = resultList.get(i).get("releasesKey").toString();
//	        	String releasesName     = resultList.get(i).get("releasesName").toString();
//	        	String processKey       = resultList.get(i).get("processKey").toString();
//	        	
//	        	// api 호출 data set ============================================
//	        	JSONObject jsonObject = new JSONObject();
//	        	JSONObject jsonObj1 = new JSONObject();
//	        	JSONArray bot_array = new JSONArray();
//	        	bot_array.add(Integer.parseInt(botNo));
//	        	jsonObject.put("InputArguments",inputArguments);
//	        	jsonObject.put("JobsCount",0);
//	        	jsonObject.put("ReleaseKey",releasesKey);
//	        	jsonObject.put("RobotIds",bot_array);
//	        	jsonObject.put("Strategy","Specific");
//	        	jsonObj1.put("startInfo", jsonObject);
//	        	jsonObj1.put("cmpnyCd",cmpnyCd);
//	        	//=====================================================
//	        	String url = "/odata/Jobs/UiPath.Server.Configuration.OData.StartJobs";
//	        	param.put("resvNo", resvNo);
//	        	param.put("dateYmd", dateYmd);
//	        	param.put("dateYmshm", dateYmshm);
//	        	param.put("botNo", botNo);
//	        	param.put("timeNo", timeNo);
//	        	param.put("processCd", processCd);
//	        	param.put("regGbn", regGbn);
//	        	param.put("sendYn", sendYn);
//	        	param.put("cmpnyCd", cmpnyCd);
//	        	param.put("botType", botType);
//	        	param.put("inputArguments", inputArguments);
//	        	param.put("releasesId", releasesId);
//	        	param.put("releasesKey", releasesKey);
//    			param.put("releasesName", releasesName);
//    			param.put("processKey", processKey);
//	        	
//    			int calCnt = 0;
//    			Map<String, Object> returnData = cronSchedulService.getCalendarChkVal(param);
//    			log.debug("returnData : ====================:"+returnData);
//    			if(returnData != null) {
//	    			String chkVal = returnData.get("chkVal").toString();
//	    			log.debug("chkVal : ====================:"+chkVal);
//	    			param.put("chkVal", chkVal);
//	    			calCnt = cronSchedulService.selectCalendarCount(param);
//	    			log.debug("calCnt : ====================:"+calCnt);
//    			}    			
//    			if(calCnt == 0) {
//		    		if("1".equals(botType)) { // Attended  table insert
//		    			taskManageService.insertTaskAttendedReserve(param);
//		    		}else if("2".equals(botType)) { // Unattended 2   api call
//		    			ResponseEntity<Map> response = restApi.post(url, jsonObj1);
//		    			param.put("response", response.toString());
//		    		}else if("3".equals(botType)) { // Studio 3   api call
//		    			ResponseEntity<Map> response = restApi.post(url, jsonObj1);
//		    			param.put("response", response.toString());
//		    		}
//	            	// 처리 후 update
//	            	cronSchedulService.updateCronSchedul(param);
//	            	// history 저장
//	            	taskManageService.insertTaskSendHistory(param);
//    			}
//	        }
//        }
//        log.debug("BATCH END : ====================");
//	}
	
	/** * 초  분  시간   // 매시 39분 Send Prc 확인
	 * @throws Exception */ 
	
//	@Scheduled(cron = "0 39 * * * *") 
//	public void cronSerchFour() throws Exception{
//		log.debug("cronSerchFour START : ====================4");
//        Map<String, Object> param = new HashMap<String, Object>();
//        int sendCount = cronSchedulService.selectSendScheduleCount(param);
//        log.debug("sendCount : ====================:"+sendCount);
//        if(sendCount > 0) {
//            List<Map<String, Object>> resultList = cronSchedulService.selectSendScheduleList(param);
//            log.debug("resultList : ====================:"+resultList);
//        	
//	        for(int i = 0; i < resultList.size();i++) {
//	        	String resvNo           = resultList.get(i).get("resvNo").toString();
//	        	String dateYmd          = resultList.get(i).get("dateYmd").toString();
//	        	String dateYmshm        = resultList.get(i).get("dateYmshm").toString();
//	        	String botNo            = resultList.get(i).get("botNo").toString();
//	        	String timeNo           = resultList.get(i).get("timeNo").toString();
//	        	String processCd        = resultList.get(i).get("processCd").toString();
//	        	String regGbn           = resultList.get(i).get("regGbn").toString();
//	        	String sendYn           = resultList.get(i).get("sendYn").toString();
//	        	String cmpnyCd          = resultList.get(i).get("cmpnyCd").toString();
//	        	String botType          = resultList.get(i).get("botType").toString();
//	        	String inputArguments   = resultList.get(i).get("inputArguments").toString();
//	        	String releasesId       = resultList.get(i).get("releasesId").toString();
//	        	String releasesKey      = resultList.get(i).get("releasesKey").toString();
//	        	String releasesName     = resultList.get(i).get("releasesName").toString();
//	        	String processKey       = resultList.get(i).get("processKey").toString();
//	        	
//	        	// api 호출 data set ============================================
//	        	JSONObject jsonObject = new JSONObject();
//	        	JSONObject jsonObj1 = new JSONObject();
//	        	JSONArray bot_array = new JSONArray();
//	        	bot_array.add(Integer.parseInt(botNo));
//	        	jsonObject.put("InputArguments",inputArguments);
//	        	jsonObject.put("JobsCount",0);
//	        	jsonObject.put("ReleaseKey",releasesKey);
//	        	jsonObject.put("RobotIds",bot_array);
//	        	jsonObject.put("Strategy","Specific");
//	        	jsonObj1.put("startInfo", jsonObject);
//	        	jsonObj1.put("cmpnyCd",cmpnyCd);
//	        	//=====================================================
//	        	String url = "/odata/Jobs/UiPath.Server.Configuration.OData.StartJobs";
//	        	param.put("resvNo", resvNo);
//	        	param.put("dateYmd", dateYmd);
//	        	param.put("dateYmshm", dateYmshm);
//	        	param.put("botNo", botNo);
//	        	param.put("timeNo", timeNo);
//	        	param.put("processCd", processCd);
//	        	param.put("regGbn", regGbn);
//	        	param.put("sendYn", sendYn);
//	        	param.put("cmpnyCd", cmpnyCd);
//	        	param.put("botType", botType);
//	        	param.put("inputArguments", inputArguments);
//	        	param.put("releasesId", releasesId);
//	        	param.put("releasesKey", releasesKey);
//    			param.put("releasesName", releasesName);
//    			param.put("processKey", processKey);
//	        	
//    			int calCnt = 0;
//    			Map<String, Object> returnData = cronSchedulService.getCalendarChkVal(param);
//    			log.debug("returnData : ====================:"+returnData);
//    			if(returnData != null) {
//	    			String chkVal = returnData.get("chkVal").toString();
//	    			log.debug("chkVal : ====================:"+chkVal);
//	    			param.put("chkVal", chkVal);
//	    			calCnt = cronSchedulService.selectCalendarCount(param);
//	    			log.debug("calCnt : ====================:"+calCnt);
//    			}    			
//    			if(calCnt == 0) {
//		    		if("1".equals(botType)) { // Attended  table insert
//		    			taskManageService.insertTaskAttendedReserve(param);
//		    		}else if("2".equals(botType)) { // Unattended 2   api call
//		    			ResponseEntity<Map> response = restApi.post(url, jsonObj1);
//		    			param.put("response", response.toString());
//		    		}else if("3".equals(botType)) { // Studio 3   api call
//		    			ResponseEntity<Map> response = restApi.post(url, jsonObj1);
//		    			param.put("response", response.toString());
//		    		}
//	            	// 처리 후 update
//	            	cronSchedulService.updateCronSchedul(param);
//	            	// history 저장
//	            	taskManageService.insertTaskSendHistory(param);
//    			}
//	        }
//        }
//        log.debug("BATCH END : ====================");
//	}
	
	/** * 초  분  시간   // 매시 49분 Send Prc 확인
	 * @throws Exception */ 
	
//	@Scheduled(cron = "0 49 * * * *") 
//	public void cronSerchFive() throws Exception{
//		log.debug("cronSerchSix START : ====================5");
//        Map<String, Object> param = new HashMap<String, Object>();
//        int sendCount = cronSchedulService.selectSendScheduleCount(param);
//        log.debug("sendCount : ====================:"+sendCount);
//        if(sendCount > 0) {
//            List<Map<String, Object>> resultList = cronSchedulService.selectSendScheduleList(param);
//            log.debug("resultList : ====================:"+resultList);
//            
//        	
//	        for(int i = 0; i < resultList.size();i++) {
//	        	String resvNo           = resultList.get(i).get("resvNo").toString();
//	        	String dateYmd          = resultList.get(i).get("dateYmd").toString();
//	        	String dateYmshm        = resultList.get(i).get("dateYmshm").toString();
//	        	String botNo            = resultList.get(i).get("botNo").toString();
//	        	String timeNo           = resultList.get(i).get("timeNo").toString();
//	        	String processCd        = resultList.get(i).get("processCd").toString();
//	        	String regGbn           = resultList.get(i).get("regGbn").toString();
//	        	String sendYn           = resultList.get(i).get("sendYn").toString();
//	        	String cmpnyCd          = resultList.get(i).get("cmpnyCd").toString();
//	        	String botType          = resultList.get(i).get("botType").toString();
//	        	String inputArguments   = resultList.get(i).get("inputArguments").toString();
//	        	String releasesId       = resultList.get(i).get("releasesId").toString();
//	        	String releasesKey      = resultList.get(i).get("releasesKey").toString();
//	        	String releasesName     = resultList.get(i).get("releasesName").toString();
//	        	String processKey       = resultList.get(i).get("processKey").toString();
//	        	
//	        	// api 호출 data set ============================================
//	        	JSONObject jsonObject = new JSONObject();
//	        	JSONObject jsonObj1 = new JSONObject();
//	        	JSONArray bot_array = new JSONArray();
//	        	bot_array.add(Integer.parseInt(botNo));
//	        	jsonObject.put("InputArguments",inputArguments);
//	        	jsonObject.put("JobsCount",0);
//	        	jsonObject.put("ReleaseKey",releasesKey);
//	        	jsonObject.put("RobotIds",bot_array);
//	        	jsonObject.put("Strategy","Specific");
//	        	jsonObj1.put("startInfo", jsonObject);
//	        	jsonObj1.put("cmpnyCd",cmpnyCd);
//	        	//=====================================================
//	        	String url = "/odata/Jobs/UiPath.Server.Configuration.OData.StartJobs";
//	        	param.put("resvNo", resvNo);
//	        	param.put("dateYmd", dateYmd);
//	        	param.put("dateYmshm", dateYmshm);
//	        	param.put("botNo", botNo);
//	        	param.put("timeNo", timeNo);
//	        	param.put("processCd", processCd);
//	        	param.put("regGbn", regGbn);
//	        	param.put("sendYn", sendYn);
//	        	param.put("cmpnyCd", cmpnyCd);
//	        	param.put("botType", botType);
//	        	param.put("inputArguments", inputArguments);
//	        	param.put("releasesId", releasesId);
//	        	param.put("releasesKey", releasesKey);
//    			param.put("releasesName", releasesName);
//    			param.put("processKey", processKey);
//	        	
//    			int calCnt = 0;
//    			Map<String, Object> returnData = cronSchedulService.getCalendarChkVal(param);
//    			log.debug("returnData : ====================:"+returnData);
//    			if(returnData != null) {
//	    			String chkVal = returnData.get("chkVal").toString();
//	    			log.debug("chkVal : ====================:"+chkVal);
//	    			param.put("chkVal", chkVal);
//	    			calCnt = cronSchedulService.selectCalendarCount(param);
//	    			log.debug("calCnt : ====================:"+calCnt);
//    			}    			
//    			if(calCnt == 0) {
//		    		if("1".equals(botType)) { // Attended  table insert
//		    			taskManageService.insertTaskAttendedReserve(param);
//		    		}else if("2".equals(botType)) { // Unattended 2   api call
//		    			ResponseEntity<Map> response = restApi.post(url, jsonObj1);
//		    			param.put("response", response.toString());
//		    		}else if("3".equals(botType)) { // Studio 3   api call
//		    			ResponseEntity<Map> response = restApi.post(url, jsonObj1);
//		    			param.put("response", response.toString());
//		    		}
//	            	// 처리 후 update
//	            	cronSchedulService.updateCronSchedul(param);
//	            	// history 저장
//	            	taskManageService.insertTaskSendHistory(param);
//    			}
//	        }
//        }
//        log.debug("BATCH END : ====================");
//	}
	
	/** * 초  분  시간   // 매시 59분 Send Prc 확인
	 * @throws Exception */ 
	
//	@Scheduled(cron = "0 59 * * * *") 
//	public void cronSerchSix() throws Exception{
//		log.debug("cronSerchSix START : ====================6");
//        Map<String, Object> param = new HashMap<String, Object>();
//        int sendCount = cronSchedulService.selectSendScheduleCount(param);
//        log.debug("sendCount : ====================:"+sendCount);
//        if(sendCount > 0) {
//            List<Map<String, Object>> resultList = cronSchedulService.selectSendScheduleList(param);
//            log.debug("resultList : ====================:"+resultList);
//            
//	        for(int i = 0; i < resultList.size();i++) {
//	        	String resvNo           = resultList.get(i).get("resvNo").toString();
//	        	String dateYmd          = resultList.get(i).get("dateYmd").toString();
//	        	String dateYmshm        = resultList.get(i).get("dateYmshm").toString();
//	        	String botNo            = resultList.get(i).get("botNo").toString();
//	        	String timeNo           = resultList.get(i).get("timeNo").toString();
//	        	String processCd        = resultList.get(i).get("processCd").toString();
//	        	String regGbn           = resultList.get(i).get("regGbn").toString();
//	        	String sendYn           = resultList.get(i).get("sendYn").toString();
//	        	String cmpnyCd          = resultList.get(i).get("cmpnyCd").toString();
//	        	String botType          = resultList.get(i).get("botType").toString();
//	        	String inputArguments   = resultList.get(i).get("inputArguments").toString();
//	        	String releasesId       = resultList.get(i).get("releasesId").toString();
//	        	String releasesKey      = resultList.get(i).get("releasesKey").toString();
//	        	String releasesName     = resultList.get(i).get("releasesName").toString();
//	        	String processKey       = resultList.get(i).get("processKey").toString();
//	        	
//	        	// api 호출 data set ============================================
//	        	JSONObject jsonObject = new JSONObject();
//	        	JSONObject jsonObj1 = new JSONObject();
//	        	JSONArray bot_array = new JSONArray();
//	        	bot_array.add(Integer.parseInt(botNo));
//	        	jsonObject.put("InputArguments",inputArguments);
//	        	jsonObject.put("JobsCount",0);
//	        	jsonObject.put("ReleaseKey",releasesKey);
//	        	jsonObject.put("RobotIds",bot_array);
//	        	jsonObject.put("Strategy","Specific");
//	        	jsonObj1.put("startInfo", jsonObject);
//	        	jsonObj1.put("cmpnyCd",cmpnyCd);
//	        	//=====================================================
//	        	String url = "/odata/Jobs/UiPath.Server.Configuration.OData.StartJobs";
//	        	param.put("resvNo", resvNo);
//	        	param.put("dateYmd", dateYmd);
//	        	param.put("dateYmshm", dateYmshm);
//	        	param.put("botNo", botNo);
//	        	param.put("timeNo", timeNo);
//	        	param.put("processCd", processCd);
//	        	param.put("regGbn", regGbn);
//	        	param.put("sendYn", sendYn);
//	        	param.put("cmpnyCd", cmpnyCd);
//	        	param.put("botType", botType);
//	        	param.put("inputArguments", inputArguments);
//	        	param.put("releasesId", releasesId);
//	        	param.put("releasesKey", releasesKey);
//    			param.put("releasesName", releasesName);
//    			param.put("processKey", processKey);
//    			
//    			int calCnt = 0;
//    			Map<String, Object> returnData = cronSchedulService.getCalendarChkVal(param);
//    			log.debug("returnData : ====================:"+returnData);
//    			if(returnData != null) {
//	    			String chkVal = returnData.get("chkVal").toString();
//	    			log.debug("chkVal : ====================:"+chkVal);
//	    			param.put("chkVal", chkVal);
//	    			calCnt = cronSchedulService.selectCalendarCount(param);
//	    			log.debug("calCnt : ====================:"+calCnt);
//    			}    			
//    			if(calCnt == 0) {
//		    		if("1".equals(botType)) { // Attended  table insert
//		    			taskManageService.insertTaskAttendedReserve(param);
//		    		}else if("2".equals(botType)) { // Unattended 2   api call
//		    			ResponseEntity<Map> response = restApi.post(url, jsonObj1);
//		    			param.put("response", response.toString());
//		    		}else if("3".equals(botType)) { // Studio 3   api call
//		    			ResponseEntity<Map> response = restApi.post(url, jsonObj1);
//		    			param.put("response", response.toString());
//		    		}
//	            	// 처리 후 update
//	            	cronSchedulService.updateCronSchedul(param);
//	            	// history 저장
//	            	taskManageService.insertTaskSendHistory(param);
//    			}
//	        }
//        }
//        log.debug("BATCH END : ====================");
//	}


//	@Async TEST	
//	@Scheduled(cron = "0/2 * * * * *")
//	@Async("threadPoolTaskExecutor")
//	public void printWithAsync() throws Exception {
//		if(bRunTest) {
//			return;
//		}
//		
//		bRunTest = true;
//		
//		
//		String sName = Thread.currentThread().getName();
//		System.out.println("1-1, Name=" + sName + ":" + new Date());
//	    Thread.sleep(10000);
//	    System.out.println("1-2, Name=" + sName + ":" + new Date());
//	    
//	    bRunTest = false;
//	    //System.out.println("execute printWithAsync() of AsyncPrintTask at " + new Date());
//	    //log.info("Current Thread : {}", Thread.currentThread().getName());
//	    //log.info("1, Current Thread : {}", Thread.currentThread().getName());
//	}
//	
//		@Scheduled(cron = "0/2 * * * * *")
//	@Async("threadPoolTaskExecutor")
//	public void printWithArg() throws Exception {
//	    //System.out.println("execute printWithArg() of AsyncPrintTask at " + new Date());
//		String sName = Thread.currentThread().getName();
//		System.out.println("2, Name=" + sName + ":" + new Date());
//	    //log.info("2, Current Thread : {}", Thread.currentThread().getName());
//	}
//		
//	@Scheduled(cron = "0/2 * * * * *")
//	@Async("threadPoolTaskExecutor")
//	public void printWithAsync2() throws Exception {
//		String sName = Thread.currentThread().getName();
//		System.out.println("3-1, Name=" + sName + ":" + new Date());
//	    Thread.sleep(10000);
//	    System.out.println("3-2, Name=" + sName + ":" + new Date());
//	    //System.out.println("execute printWithAsync() of AsyncPrintTask at " + new Date());
//	    //System.out.println("execute printWithAsync() of AsyncPrintTask at " + new Date());
//	    //log.info("Current Thread : {}", Thread.currentThread().getName());
//	    //log.info("3, Current Thread : {}", Thread.currentThread().getName());
//	}
	
	/** * 초  분  시간   // 매시 50분 마다 확인, 운영 프로세스 이력관리
	 * @throws Exception */ 
	@Scheduled(cron="0 50 * * * *")
	@Async("threadPoolTaskExecutor")
	public void cronReExecut() throws Exception{
		log.debug("RetryExecut START : =================");
		Map<String, Object> map = new HashMap<String, Object>();
		
		// SY_JOBS 과제 SELECT
		int insertCnt = cronSchedulService.insertDailyReExecutLog();
		
		// 배치에 등록된 데이터와 AR 스케줄에 등록된 데이터 매핑하기 위한 데이터 조회
		List<Map<String, Object>> schList = cronSchedulService.selectSchduleInfo();
		
		// AR스케줄에 작업할 데이터가 있을경우 , 원본아이디와 매핑
		if(schList.size() > 0) {
			for(int i=0; i<schList.size(); i++) {
				if(schList.get(i).get("endDt")!=null) {
					Map<String, Object> schMap = schList.get(i);
					// 매핑할 원본데이터 찾아오기
					int targetId = cronSchedulService.getTargetId(schMap);
					schMap.put("jobId", targetId);
					// 배치 테이블에 RETRY_TRGET_ID (원본데이터) 삽입
					cronSchedulService.updateTargetId(schMap);
					// 재실행 정보 기록
					cronSchedulService.insertArReExcInfo(schMap);
					// AR스케줄에 재실행 적용여부 (APPLY_AT) 1로 변경
					cronSchedulService.updateSchApplyAt(schMap);
				}
			}
		}
		if(insertCnt > 0) {
			map.put("cnt", insertCnt);
			// 배치 테이블에 추가된 데이터 조회
			List<Map<String, Object>> resultList = cronSchedulService.selectReExecutInfo(map);
			
			for(int i=0; i<resultList.size(); i++) {
				// 재실행된 데이터면, 재실행 여부 와 원본 여부 바꿔주기
				if(!"0".equals(resultList.get(i).get("retryTrgetId").toString())) {
					cronSchedulService.updateOriginTrgetAt(resultList.get(i));
					// 재실행 데이터가 상태가 성공이면, 원본데이터의 재실행 대상여부 N으로 변경
					if("5".equals(resultList.get(i).get("sttus").toString())) {
						cronSchedulService.updateRetryTrgetAt(resultList.get(i));
					}
					// UR 재등록 테이블 재실행 적용여부 (APPLY_AT) 1로 변경
					cronSchedulService.updateRetryApplyAt(resultList.get(i));
				}
			}
		}
		
		//종료 다음날 24시가 지나면 재사용 허용금지
		cronSchedulService.updateAfterdayRetryInfo();
		
        log.debug("RetryExecut END : ===================");
	}
	
	/** * 초  분  시간   // 매시 40분 마다 확인
	 * @throws Exception */ 
	@Scheduled(cron="0 40 * * * *")
	//@Scheduled(cron = "0 17 8 * * *")
	@Async("threadPoolTaskExecutor")
	public void cronPoUserExecutHist() throws Exception{
		log.debug("PoUserExecutHist START : =================");
		Map<String, Object> map = new HashMap<String, Object>();		
		
		int devcnt = cronSchedulService.isExistDevTableName();
		
		if(devcnt > 0) {
			// SY_DEV_JOBS 과제 SELECT
			// 운영 서버
			cronSchedulService.insertPoUserExecutHist();
		}
		else {
			// 개발 서버
			// 개발 서버에서는 SY_DEV가 아니라 SY_이다.
			cronSchedulService.insertPoUserExecutHistForDevServer();
		}
		
        log.debug("PoUserExecutHist END : ===================");
	}

	/** * 초  분  시간   // 매시 20분 Send Prc 확인 // 통계 배치 쿼리
	 * @throws Exception */ 
	@Scheduled(cron = "0 20 * * * *")
	@Async("threadPoolTaskExecutor")
	public void cronStsTotal() throws Exception{
		log.debug("cronStsTotal START : =================");
		Map<String, Object> map = new HashMap<String, Object>();
		
		cronSchedulService.insertStsProc(map);
		
		cronSchedulService.insertStsTask(map);
		
		cronSchedulService.insertStsBot(map);
		
	    log.debug("cronStsTotal END : ===================");
	}
	
	// JOB이력관리  - 배치 스케줄 매시 10분
	@Scheduled(cron = "0 10 * * * *")
	@Async("threadPoolTaskExecutor")
	public void insertBatchForJobsMng() throws Exception{
		log.debug("insertBatchForJobsMng START : =================");
		Map<String, Object> map = new HashMap<String, Object>();
		
		// JOBS이력관리 테이블의 JOB에 대한 MAX(ID)를 얻는다.
		//int getMaxJobId = cronSchedulService.selectJobsMngMaxJobId(map);
		
		// 위에서 구한 ID 초과인 JOB들을 Batch를 통해 insert 한다.
		//map.put("jobid", getMaxJobId);
		cronSchedulService.insertBatchForJobsMng(map);

		// BATCH_RESULT 테이블에 BATCH 성공을 기록한다.
        Map<String, Object> batchResult = new HashMap<String, Object>();
        Date now = new Date();
        Calendar currentDate = Calendar.getInstance();
        SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss"); //yyyy-MM-dd HH:mm:ss
        String currentDateToString = df.format(currentDate.getTime());
        batchResult.put("sn", currentDateToString);
        batchResult.put("batchName", "JOB이력관리");
		cronSchedulService.makeTriggerArScheduleBatchResult(batchResult);	

	    log.debug("insertBatchForJobsMng END : ===================");
	}
	

	// 매시 15분마다 회사코드 업데이트
	@Scheduled(cron = "0 15 * * * *")
	@Async("threadPoolTaskExecutor")
	public void updateCmpnyCd() throws Exception{
		log.debug("updateCmpnyCd START : =================");
		Map<String, Object> map = new HashMap<String, Object>();
		
		cronSchedulService.updateCmpnyCd();

	    log.debug("updateCmpnyCd END : ===================");
	}
	
	
	// trigger 트리거 스케줄 생성 Batch 배치
	// 매달 1일 00:00:00
	@Scheduled(cron="0 0 0 1 * ?") // = 매월 1일 00시에 실행
	// (테스트할 때) 0 x y * * * : 매일 y시  x분 수행, y = 0 ~ 23, x = 0 ~ 59
	//@Scheduled(cron = "0 28 13 * * *")
	@Async("threadPoolTaskExecutor")
	public void makeTriggerArSchedule() throws Exception {
		log.debug("Scheduler.java makeTriggerArSchedule START : =================");
		Map<String, Object> map = new HashMap<String, Object>();
			
		List<Map<String, Object> > processListForMakeTriggerARSchedule = cronSchedulService.makeTriggerArSchedule(map);

		long startTime = System.currentTimeMillis();         
        long insertTotal = 0;

		for(Map<String, Object> m : processListForMakeTriggerARSchedule) {
			
			Connection con = null;
	        PreparedStatement pstmt = null ;
	        String sql = "Insert Into [dbo].[TB_TEMP_RESRVE_BOT]" 
	        + "([DATE_YMD], [DATE_YMSHM], [BOT_NO], [TIME_NO]" 
	        + ", [PROCESS_CD] ,[REGISTER_ID], [REG_DT], [REG_GBN]" 
	        + ", [SEND_YN], [CMPNY_CD], [BOT_TYPE], [INPUTARGUMENTS]"
	        + ", [RELEASES_ID], [RELEASES_KEY], [RELEASES_NAME], [PROCESS_KEY]" 
	        + ", [SCHDULE_NO], [DELETE_AT], [UPDUSR_ID], [UPDT_DT], [DISABLE_AT]) " 
	        + "Values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)" ;
	        
	        
	        try {	       	

				Class.forName(dbDriverClassName);
				con = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
				
				pstmt = con.prepareStatement(sql) ;
				
				Date today = new Date(); 
				SimpleDateFormat sdfhhmmss = new SimpleDateFormat("HH:mm:ss");
				String HHmmss = sdfhhmmss.format(today).toString();

				CronExpression ce = new CronExpression(m.get("schduleCrontab").toString());

				String startDateToString = m.get("startDe").toString() + " " + HHmmss;
				String endDateToString = m.get("endDe").toString() + " " + HHmmss;
				
				SimpleDateFormat transFormatStart = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Date startDate = transFormatStart.parse(startDateToString);

				SimpleDateFormat transFormatEnd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Date endDate = transFormatEnd.parse(endDateToString); // 1달 후의 마지막 날짜
			
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
					
					pstmt.setLong(3,  Long.parseLong(m.get("botNo").toString())); // BOT_NO
					pstmt.setInt(4, (hour*6 + minute/10 + 1)); // TIME_NO
					pstmt.setString(5, m.get("processCd").toString());
					pstmt.setString(6, m.get("registerId").toString());
					
					pstmt.setTimestamp(7, new java.sql.Timestamp(today.getTime()));
					//pstmt.setDate(7, new java.sql.Date(today.getTime())); // REG_DT
				
					pstmt.setString(8, "A"); // REG_GBN
					pstmt.setString(9, "N"); // SEND_YN
					pstmt.setString(10, m.get("cmpnyCd").toString()); // CMPNY_CD
					pstmt.setString(11, m.get("botType").toString()); // BOT_TYPE
					pstmt.setString(12, m.get("inputArguments").toString()); // INPUTARGUMENTS
					pstmt.setString(13, m.get("releasesId").toString()); // RELEASES_ID
					pstmt.setString(14, m.get("releasesKey").toString()); // RELEASES_KEY
					pstmt.setString(15, m.get("releasesName").toString()); // RELEASES_NAME
					pstmt.setString(16, m.get("processKey").toString()); // PROCESS_KEY
					pstmt.setString(17, m.get("schduleNo").toString()); // SCHDULE_NO
					pstmt.setInt(18, 0); // DELETE_AT
					pstmt.setString(19, null); // UPDUSR_ID					
					pstmt.setDate(20, null); // UPDT_DT
					
					int disableAt = 0;
					if(m.containsKey("disableAt")) {
						disableAt = Integer.parseInt(m.get("disableAt").toString());
					}
					pstmt.setInt(21, disableAt); // DISABLE_AT
										
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
		         break;
			} finally {
				if (pstmt != null) try {pstmt.close();pstmt = null;} catch(SQLException ex){}
	            if (con != null) try {con.close();con = null;} catch(SQLException ex){}
			}	
		}

		Date now = new Date();
        Calendar currentDate = Calendar.getInstance();
        SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss"); //yyyy-MM-dd HH:mm:ss
        String currentDateToString = df.format(currentDate.getTime());
        String batchName = "Trigger AR 스케줄 생성_" + String.valueOf(insertTotal) + "행";
        
        // Trigger AR 스케줄 생성 Batch 기록 insert
        Map<String, Object> batchResult = new HashMap<String, Object>();
        batchResult.put("sn", currentDateToString);
        batchResult.put("batchName", batchName);

		cronSchedulService.makeTriggerArScheduleBatchResult(batchResult);	
		
        long endTime = System.currentTimeMillis(); //프로그램이 끝나는 시점 계산
	    log.debug("Scheduler.java makeTriggerArSchedule END : " + (endTime - startTime)/1000.0 + "초  ==== 삽입된 행 개수 :" + insertTotal + "===============");
	}
}