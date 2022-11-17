package kr.co.rpaplatform.dongwon.task.web;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.exception.RpaException;
import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.dongwon.author.vo.AuthorVO;
import kr.co.rpaplatform.dongwon.common.service.PortalCommonService;
import kr.co.rpaplatform.dongwon.common.util.PaginationUtil;
import kr.co.rpaplatform.dongwon.orgnzt.service.UserService;
import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.task.service.TaskManageService;
import kr.co.rpaplatform.dongwon.task.service.TaskPaymentService;
import kr.co.rpaplatform.rpaapi.uipath.common.RestApi;

/**
 * @author LSH
 */
@Controller
@RequestMapping("/task/manage")
public class TaskManageController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(TaskManageController.class);
	
	/**
	 * 과제운영 서비스
	 */
	@Resource(name="taskManageService")
	private TaskManageService taskManageService;
	
	@Resource(name="userService")
	private UserService userService;
	
	@Resource(name="portalCommonService")
	private PortalCommonService portalCommonService;
	
	@Resource(name="taskPaymentService")
	private TaskPaymentService taskPaymentService;
	
	@Resource(name="restApi")
	private RestApi restApi;
	
	/**
	 * 과제운영 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/taskManageMain")
	public ModelAndView taskIdeaMain() throws Exception {
		return new ModelAndView("/task/manage/taskManageMain");
	}
	
	
	
	/**
	 * 과제운영 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectTaskManageList")
	@ResponseBody
	public ResponseVO getTaskIdeaList(HttpServletRequest req, @RequestBody Map<String, Object> map) throws Exception {
		
		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//읽기 권한이 있는지 확인
		if(!oAuthorVO.getRedngAuthor().equals("Y")) {
			return new ResponseVO("E202", "비정상 접근입니다.");
		}
		
		
		Map<String, Object> returnMap = new HashMap<String, Object>();

		//과제아이디어등록 리스트 카운트 조회
		int totalRecordCount = taskManageService.selectTaskManageListCount(map);
		
		//페이징 정보 조회
		PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, totalRecordCount);
		
		//조회조건에 페이징 정보 설정
		map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, totalRecordCount));

		//과제아이디어등록 리스트 조회
		List<Map<String, Object>> resultList = taskManageService.selectTaskManageList(map);

		//결과값 설정
		returnMap.put("resultList", resultList);
		returnMap.put("paginationInfo", paginationInfo);
		
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 과제운영 > 과제운영 Detail: get Data
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getTaskManageDetail")
	@ResponseBody
	public ResponseVO getTaskManageDetail(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TaskManageController.getTaskManageDetail start!!");

		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//읽기 권한자 인지 확인
		if(!oAuthorVO.getRedngAuthor().equals("Y")) {
			throw new RpaException("E202");//비정상 접근입니다.
		}
		
		Map<String, Object> returnData = taskManageService.getTaskManageDetail(params);
		
		logger.debug("TaskManageController.getTaskManageDetail end!!");
		return new ResponseVO(returnData);
	}

	
	/**
	 * 과제운영 > 과제운영 Detail Popup
	 * @return
	 * @throws Exception
	 */	
	@RequestMapping(value = "/taskManageDetailPop", method = RequestMethod.GET)
	public ModelAndView taskManageDetailPop(@RequestParam(value="registerId") String registerId) throws Exception {
		
		ModelAndView mav = new ModelAndView("/task/manage/taskManageDetailPop");
		//접속자와 게시자가 같은 사용자 인지 확인
		if(registerId.equals(MDC.get("txUserId"))) {
			mav.addObject("identityFlag", true); 
		}else {
			mav.addObject("identityFlag", false);
		}
		return mav;
	}

	/**
	 * 과제운영 > 프로세스 Detail: get Data
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getTaskManageProcessDetail")
	@ResponseBody
	public ResponseVO getTaskManageProcessDetail(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TaskManageController.getTaskManageProcessDetail start!!");

		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//읽기 권한자 인지 확인
		if(!oAuthorVO.getRedngAuthor().equals("Y")) {
			throw new RpaException("E202");//비정상 접근입니다.
		}
		
		Map<String, Object> returnData = taskManageService.getTaskManageProcessDetail(params);
		
		List<Map<String, Object>> chargerList = taskManageService.selectPrcChargerList(params);
		returnData.put("chargerList", chargerList);
		returnData.put("chargerCnt", chargerList.size());
		
		List<Map<String, Object>> redcnTmList = taskManageService.selectPrcRedcnTmList(params);
		returnData.put("redcnTmList", redcnTmList);
		returnData.put("redcnTmCnt", redcnTmList.size());
		
		List<Map<String, Object>> buteList = taskManageService.selectTaskPrcContribute(params);
		returnData.put("buteList", buteList);
		returnData.put("buteCnt", buteList.size());
		
		List<Map<String, Object>> cntclist = taskManageService.selectTaskPrcCntcList(params);
		returnData.put("cntclist", cntclist);
		returnData.put("cntclistcnt", cntclist.size());
		
		List<Map<String, Object>> schlist = taskManageService.selectTaskPrcSchlist(params);
		returnData.put("schlist", schlist);
		returnData.put("schlistcnt", schlist.size());
		
		List<Map<String, Object>> schtextlist = taskManageService.selectRoutineScheduleTextList(params);
		returnData.put("schtextlist", schtextlist);
		returnData.put("schtextlistcnt", schtextlist.size());

		List<Map<String, Object>> calendarlist = taskManageService.selectTaskManageCalendarList(params);
		returnData.put("calendarlist", calendarlist);
		
		logger.debug("TaskManageController.getTaskManageProcessDetail end!!");
		return new ResponseVO(returnData);
	}

	
	/**
	 * 과제운영 > 프로세스 Detail Popup
	 * @return
	 * @throws Exception
	 */	
	@RequestMapping(value = "/taskManageProcessDetailPop", method = RequestMethod.GET)
	public ModelAndView taskManageProcessDetailPop(HttpServletRequest req, @RequestParam(value="registerId") String registerId) throws Exception {
		
		ModelAndView mav = new ModelAndView("/task/manage/taskManageProcessDetailPop");
		//접속자와 게시자가 같은 사용자 인지 확인
		if(registerId.equals(MDC.get("txUserId"))) {
			mav.addObject("identityFlag", true); 
		}else {
			mav.addObject("identityFlag", false);
		}
		
		//다운로드 버튼 권한 여부 확인
		int oRoleCdCnt = portalCommonService.selectDownloadBtnUserRoleCount(req);
		if(oRoleCdCnt > 0) {
			mav.addObject("isDownloadBtnRoleAtFlag", true); 
		}else {
			mav.addObject("isDownloadBtnRoleAtFlag", false); 
		}
		
		return mav;
	}
	
	
	/**
	 * 과제운영 > 과제운영 > 프로세스 운영 취소 : get Data
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getTaskManageProcessCancel")
	@ResponseBody
	public ResponseVO getTaskManageProcessCancel(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TaskManageController.getTaskManageProcessCancel start!!");

		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//읽기 권한자 인지 확인
		if(!oAuthorVO.getRedngAuthor().equals("Y")) {
			throw new RpaException("E202");//비정상 접근입니다.
		}
		
		Map<String, Object> returnData = taskManageService.getTaskManageProcessDetail(params);
		
		logger.debug("TaskManageController.getTaskManageProcessCancel end!!");
		return new ResponseVO(returnData);
	}
	
	/**
	 * 과제운영 > 과제운영 > 프로세스 운영 취소 Popup
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/taskManageProcessCancelPop", method = RequestMethod.GET)
	public ModelAndView taskManageProcessCancelPop(@RequestParam(value="registerId") String registerId) throws Exception {
		
		ModelAndView mav = new ModelAndView("/task/manage/taskManageProcessCancelPop");
		//접속자와 게시자가 같은 사용자 인지 확인
		if(registerId.equals(MDC.get("txUserId"))) {
			mav.addObject("identityFlag", true); 
		}else {
			mav.addObject("identityFlag", false);
		}
		return mav;
	}
	
	/**
	 * 과제운영 > 과제운영 > 프로세스 운영 취소 update
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/taskManageProcUpdate")
	@ResponseBody
	public ResponseVO taskManageProcUpdate(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		
		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//쓰기/수정 권한자 인지 확인
		if(!oAuthorVO.getWrtngAuthor().equals("Y")) {
			throw new RpaException("E202");//비정상 접근입니다.
		}
		String sTxUserId = MDC.get("txUserId");
		int procSn = Integer.parseInt(params.get("procSn").toString());
		int procNo = Integer.parseInt(params.get("procNo").toString());
		params.put("devlopSn", procSn);
		params.put("processNo", procNo);
		params.put("logInId", sTxUserId);
		params.put("statusCh", "O6");  // 취소 코드 
		taskManageService.insertTaskManageProcHist(params);
		taskManageService.updateTaskManageProcUpdate(params);
		
		Map<String, Object> responseMap = new HashMap<String, Object>();
		//과제결재 호출
		responseMap = taskPaymentService.requestTaskPayment(params);
		return new ResponseVO(responseMap);
	}
	
	
	/**
	 * 과제운영 > 과제운영 > 예약실행 : get Data
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getTaskManageReserve")
	@ResponseBody
	public ResponseVO getTaskManageReserve(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TaskManageController.getTaskManageReserve start!!");

		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//읽기 권한자 인지 확인
		if(!oAuthorVO.getRedngAuthor().equals("Y")) {
			throw new RpaException("E202");//비정상 접근입니다.
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar c1 = Calendar.getInstance();
        String strToday = sdf.format(c1.getTime());
        String to_date = (String) params.get("startDe");
        if(to_date == null || to_date == "") {
        	params.put("startDe", strToday.replaceAll("-",""));
        }
		
		Map<String, Object> returnData = taskManageService.getTaskManageProcessDetail(params);

		List<Map<String, Object>> timeList = taskManageService.selectTaskTimeList(params);
		returnData.put("timeList", timeList);
		returnData.put("timeListcnt", timeList.size());

		List<Map<String, Object>> reservlist = taskManageService.selectTaskBotReservList(params);
		returnData.put("reservlist", reservlist);
		returnData.put("reservcnt", reservlist.size());
		
		List<Map<String, Object>> botCountList = taskManageService.selectTaskBotCountList(params);
		returnData.put("botCountList", botCountList );
		

        if(to_date == null || to_date == "") {
        	returnData.put("startDe", strToday);
        }else{
        	returnData.put("startDe", to_date);
        }
		logger.debug("TaskManageController.getTaskManageReserve end!!");
		return new ResponseVO(returnData);
	}
	
	/**
	 * 과제운영 > 과제운영 > 예약실행 Popup
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/taskManageReservePop", method = RequestMethod.GET)
	public ModelAndView taskManageReservePop(@RequestParam(value="registerId") String registerId) throws Exception {
		
		ModelAndView mav = new ModelAndView("/task/manage/taskManageReservePop");
		//접속자와 게시자가 같은 사용자 인지 확인
		if(registerId.equals(MDC.get("txUserId"))) {
			mav.addObject("identityFlag", true); 
		}else {
			mav.addObject("identityFlag", false);
		}
		return mav;
	}
	
	/**
	 * 과제운영 > 과제운영 > 정기실행 : get Data
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getTaskManageRoutine")
	@ResponseBody
	public ResponseVO getTaskManageRoutine(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TaskManageController.getTaskManageRoutine start!!");

		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//읽기 권한자 인지 확인
		if(!oAuthorVO.getRedngAuthor().equals("Y")) {
			throw new RpaException("E202");//비정상 접근입니다.
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar c1 = Calendar.getInstance();
        String strToday = sdf.format(c1.getTime());
        String to_date = (String) params.get("startDe");
        
        if(to_date == null || to_date == "") {
        	params.put("startDe", strToday.replaceAll("-",""));
        }
		
		Map<String, Object> returnData = taskManageService.getTaskManageProcessDetail(params);
		
		List<Map<String, Object>> timeList = taskManageService.selectTaskTimeList(params);
		returnData.put("timeList", timeList);
		returnData.put("timeListcnt", timeList.size());
		
		List<Map<String, Object>> reservlist = taskManageService.selectTaskBotReservList(params);
		returnData.put("reservlist", reservlist);
		returnData.put("reservcnt", reservlist.size());
		
		List<Map<String, Object>> botCountList = taskManageService.selectTaskBotCountList(params);
		returnData.put("botCountList", botCountList );
		
        if(to_date == null || to_date == "") {
        	returnData.put("startDe", strToday);
        }else{
        	returnData.put("startDe", to_date);
        }
		
		logger.debug("TaskManageController.getTaskManageRoutine end!!");
		return new ResponseVO(returnData);
	}
	
	
	/**
	 * 과제운영 > 과제운영 > 프로세스 정기운영 PopUp
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/taskManageRoutinePop", method = RequestMethod.GET)
	public ModelAndView taskManageRoutinePop(@RequestParam(value="registerId") String registerId) throws Exception {
		
		ModelAndView mav = new ModelAndView("/task/manage/taskManageRoutinePop");
		//접속자와 게시자가 같은 사용자 인지 확인
		if(registerId.equals(MDC.get("txUserId"))) {
			mav.addObject("identityFlag", true); 
		}else {
			mav.addObject("identityFlag", false);
		}
		return mav;
	}
	
	
	
	/**
	 * 과제운영 > 과제운영 > 프로세스 정기운영 설정 PopUp
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/taskManageRoutineExecutplanPop", method = RequestMethod.GET)
	public ModelAndView taskRoutineRegplan() throws Exception {
		return new ModelAndView("/task/manage/taskManageRoutineExecutplanPop");
	}
	
	
	/**
	 * 과제운영 > 과제운영 > 프로세스 정기운영 등록
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveRoutinePlan")
	@ResponseBody
	public ResponseVO saveRoutinePlan(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TaskManageController.saveRoutinePlan start!!");

		if(params.get("schduleData") != null) {
			Map<String, Object> aSaveRoutine = (Map<String, Object>)params.get("schduleData");
			String logInId = MDC.get("txUserId");
			String executMinute = aSaveRoutine.get("executMinute").toString();
			int minut = Integer.parseInt(executMinute);
			String result_minut = String.format("%02d", minut);

			aSaveRoutine.put("executMinute", result_minut);
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
			
			taskManageService.insertTaskManageProcessPlan(aSaveRoutine);
			
			// Orchestrator 스케쥴 발송을 위한 작업 준비중============================================================
	    	JSONObject jsonObject = new JSONObject();
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
	    	jsonObject.put("ExternalJobKey","");
	    	
//			{
//				"Name":"triggers test"
//				,"InputArguments":"{}"
//				,"Enabled":true
//					,"UseCalendar":true
//					,"CalendarId":20
//					,"StartProcessCronDetails":"{\"type\":4,\"minutely\":{},\"hourly\":{},\"daily\":{},\"weekly\":{\"weekdays\":[]},\"monthly\":{\"weekdays\":[{\"id\":\"MON\",\"weekly\":\"월요일\",\"monthly\":\"월요일\"}],\"atMinute\":0,\"atHour\":0,\"frequencyInMonths\":\"2\"},\"advancedCronExpression\":\"\"}"
//				,"StartProcessCron":"0 0 0 ? 1/2 MON *"
//				,"ExecutorRobots":[{"Id":295}]
//				,"StopStrategy":null
//				,"StopProcessExpression":""
//				,"ReleaseId":307
//				,"ReleaseName":"portal_success_E_Robot_Portal_Test"
//				,"TimeZoneId":"Korea Standard Time"
//				,"StartStrategy":0
//				,"StopProcessDate":null
//				,"ExternalJobKey":""
//				}
//
//
//				CalendarId: 20
//				Enabled: true
//				ExecutorRobots: [{Id: 295}]
//				0: {Id: 295}
//				ExternalJobKey: ""
//				InputArguments: "{}"
//				Name: "triggers test"
//				ReleaseId: 307
//				ReleaseName: "portal_success_E_Robot_Portal_Test"
//				StartProcessCron: "0 0 0 ? 1/2 MON *"
//				StartProcessCronDetails: "{"type":4,"minutely":{},"hourly":{},"daily":{},"weekly":{"weekdays":[]},"monthly":{"weekdays":[{"id":"MON","weekly":"월요일","monthly":"월요일"}],"atMinute":0,"atHour":0,"frequencyInMonths":"2"},"advancedCronExpression":""}"
//				StartStrategy: 0
//				StopProcessDate: null
//				StopProcessExpression: ""
//				StopStrategy: null
//				TimeZoneId: "Korea Standard Time"
//				UseCalendar: true
			
			
			
			
			
			
			
			
	    	// Orchestrator 스케쥴 발송을 위한 작업 준비중============================================================		
			
		}
		return new ResponseVO(new HashMap<String, Object>());
	}
	
	
	/**
	 * 과제운영 예약내용 런 타임 중복 조회
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getTaskManageReserveCheck")
	@ResponseBody
	public ResponseVO getTaskManageReserveCheck(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TaskManageController.getTaskManageReserveCheck start!!");
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		int cnt = taskManageService.selectTaskManageProcessReserveCount(params);
		returnMap.put("cnt", cnt);
		returnMap.put("params", params);
		
		logger.debug("TaskManageController.getTaskManageReserveCheck End!!");		
		return new ResponseVO(returnMap);
	}
		

	/**
	 * 과제운영 예약실행 저장
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/taskManageReserveSave")
	@ResponseBody
	public ResponseVO taskManageReserveSave(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TaskManageController.TaskManageReserveSave start!!");
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		String logInId = MDC.get("txUserId");
		params.put("logInId", logInId);
		String chkMode = params.get("gbn").toString();
		String msg = "";
		
		if("I".equals(chkMode)) {
			taskManageService.insertTaskManageProcessReserve(params);
			msg = "등록 처리 하였습니다.";
		}
		
		if("D".equals(chkMode)) {
			params.put("aChk", "Y");
			// 정기등록인지 확인 후 삭제 정기면 삭제 불가 msg
			int cnt = taskManageService.selectTaskManageProcessReserveDelChk(params);
			
			if(cnt != 0) {
				msg = "정기 실행 등록된 내용은 삭제 할 수 없습니다.";
			}else {
				taskManageService.deleteTaskManageProcessReserve(params);
				msg = "삭제 처리 하였습니다.";
			}
		}
		returnMap.put("msg", msg);
		logger.debug("TaskManageController.TaskManageReserveSave End!!");		
		return new ResponseVO(returnMap);
	}
	
	
	/**
	 * 과제운영 예약실행 즉시실행
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/taskManageReserveImmediateExecution")
	@ResponseBody
	public ResponseVO taskManageReserveImmediateExecution(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TaskManageController.taskManageReserveImmediateExecution start!!");

    	JSONObject jsonObject = new JSONObject();
    	JSONObject jsonObj1 = new JSONObject();
    	JSONArray bot_array = new JSONArray();
		Map<String, Object> returnMap = new HashMap<String, Object>();
		String msg = "";
		String processCd = params.get("processCd").toString();
		String inputArguments = params.get("inputArguments").toString();
		String botNo = params.get("botNo").toString();
		String cmpnyCd = params.get("cmpnyCd").toString();
		String releasesId = params.get("releasesId").toString();
		String releasesKey = params.get("releasesKey").toString();
		String botType = params.get("botType").toString();
		String releasesName = params.get("releasesName").toString();
		String processKey = params.get("processKey").toString();
		
    	bot_array.add(Integer.parseInt(botNo));
    	jsonObject.put("InputArguments",inputArguments);
    	jsonObject.put("JobsCount",0);
    	jsonObject.put("ReleaseKey",releasesKey);
    	jsonObject.put("RobotIds",bot_array);
    	jsonObject.put("Strategy","Specific");
    	jsonObj1.put("startInfo", jsonObject);
    	jsonObj1.put("cmpnyCd",cmpnyCd);
    	String url = "/odata/Jobs/UiPath.Server.Configuration.OData.StartJobs";
		
		if("1".equals(botType)) { // Attended  table insert
			
			Map<String, Object> map = new HashMap<String, Object>();
			
			map.put("cmpnyCd", cmpnyCd);
			map.put("processCd", processCd);
			map.put("botNo", botNo);
			map.put("inputArguments", inputArguments);
			map.put("releasesName", releasesName);
			map.put("processKey", processKey);
			map.put("cmpnyCd", cmpnyCd);
			taskManageService.insertTaskAttendedReserve(map);
			msg = "Attended Bot에 전송 하였습니다.";
		}else if("2".equals(botType)) { // Unattended 2   api call
			ResponseEntity<Map> response = restApi.post(url, jsonObj1);
			params.put("response", response.toString());
			
			msg = "Unattended Bot에 전송 하였습니다.";
		}else if("3".equals(botType)) { // Studio 3   api call
			ResponseEntity<Map> response = restApi.post(url, jsonObj1);
			params.put("response", response.toString());
			msg = "Studio에 전송 하였습니다.";
		}
		// 히스토리 저장===========================
		taskManageService.insertTaskSendHistory(params);
		// 히스토리 저장===========================
		returnMap.put("msg", msg);
		logger.debug("TaskManageController.TaskManageReserveSave End!!");		
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 과제운영 정기실행 삭제
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteRoutinePlan")
	@ResponseBody
	public ResponseVO deleteRoutinePlan(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TaskManageController.deleteRoutinePlan start!!");
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		taskManageService.deleteTaskManageProcessPlan(params);  // TB_TEMP_RESRVE_BOT 삭제
		
		taskManageService.deleteTaskManageProcessSchdule(params);  // TB_TASK_DEVLOP_PROCESS_SCHDULE 삭제

		returnMap.put("msg", "삭제 처리 하였습니다.");
		
		logger.debug("TaskManageController.deleteRoutinePlan End!!");		
		return new ResponseVO(returnMap);
	}
	
	
	/**
	 * 프로세스 휴일관리 수정
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateCalendarPlan")
	@ResponseBody
	public ResponseVO updateCalendarPlan(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TaskManageController.updateCalendarPlan start!!");
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		taskManageService.updateCalendarPlan(params);  // TB_TASK_DEVLOP_PROCESS_MAPPER 수정

		returnMap.put("msg", "수정 하였습니다.");
		
		logger.debug("TaskManageController.updateCalendarPlan End!!");		
		return new ResponseVO(returnMap);
	}
	
}
