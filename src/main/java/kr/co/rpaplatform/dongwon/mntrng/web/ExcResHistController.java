package kr.co.rpaplatform.dongwon.mntrng.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.common.util.PaginationUtil;
import kr.co.rpaplatform.dongwon.mntrng.service.ExcResHistService;
import kr.co.rpaplatform.rpaapi.uipath.common.RestApi;

/**
 * 작업 컨트롤러
 * @author LSH
 *
 */
@Controller
@RequestMapping("/mntrng/excreshist")
public class ExcResHistController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(ExcResHistController.class);
	
	/**
	 * 작업 서비스
	 */
	@Resource(name="excResHistService")
	private ExcResHistService excResHistService;
	
	@Resource(name="restApi")
	private RestApi restApi;
	
	/**
	 * 작업모니터링 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/excResHistMain")
	public ModelAndView jobMntrngMngMain(HttpServletRequest request) throws Exception {
		
		ModelAndView mav = new ModelAndView("/mntrng/excreshist/excResHistMain");
		
		return mav;
	}

	/**
	 * 작업 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getExcResList")
	@ResponseBody
	public ResponseVO getExcResList(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();

		//디바이스 리스트 카운트 조회
		int totalRecordCount = excResHistService.getExcResCount(map);
		
		if (totalRecordCount > 0) {
		
			//페이징 정보 조회
			PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, totalRecordCount);
			
			//조회조건에 페이징 정보 설정
			map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, totalRecordCount));
	
			//디바이스 리스트 조회
			List<Map<String, Object>> resultList = excResHistService.getExcResList(map);
	
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

	/**
	 * 작업모니터링 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/excResDetailPop")
	public ModelAndView excResDetailPop(HttpServletRequest request) throws Exception {
		
		ModelAndView mav = new ModelAndView("/mntrng/excreshist/excResHistDetailPop");
		
		return mav;
	}
	
	/**
	 * 작업 재실행
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/reExcute")
	@ResponseBody
	public ResponseVO reExcute(@RequestBody Map<String, Object> params) throws Exception {
		
    	JSONObject jsonObject = new JSONObject();
    	JSONObject jsonObj1 = new JSONObject();
    	JSONArray bot_array = new JSONArray();
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		// 재시동 정보 조회
		Map<String, Object> reExcInfoList = excResHistService.selectReExcInfo(params);
		
		String msg = "";
		String targetId = "";
		String processCd = reExcInfoList.get("processCd").toString();
		String inputArguments = reExcInfoList.get("inputArguments").toString();
		//String inputArguments = "{}"; // 과제 성공을 위한 테스트 데이터
		String botNo = reExcInfoList.get("botNo").toString();
		String cmpnyCd = reExcInfoList.get("cmpnyCd").toString();
		String releasesId = reExcInfoList.get("releaseId").toString();
		String releasesKey = reExcInfoList.get("releaseKey").toString();
		String botType = reExcInfoList.get("botType").toString();
		//String botType = "1"; AR TEST용 데이터
		String releasesName = reExcInfoList.get("releaseNm").toString();
		String processKey = reExcInfoList.get("processKey").toString();
		
    	bot_array.add(Integer.parseInt(botNo));
    	jsonObject.put("InputArguments",inputArguments);
    	jsonObject.put("JobsCount",0);
    	jsonObject.put("ReleaseKey",releasesKey);
    	jsonObject.put("RobotIds",bot_array);
    	jsonObject.put("Strategy","Specific");
    	jsonObj1.put("startInfo", jsonObject);
    	jsonObj1.put("cmpnyCd",cmpnyCd);
    	String url = "/odata/Jobs/UiPath.Server.Configuration.OData.StartJobs";
    	
		//재실행 대상 여부 조회    	
		Map<String, Object> trgetMap = excResHistService.selectTrgetAt(params);
		
		if("0".equals(trgetMap.get("trgetAt").toString())) {
			msg = "재실행 대상이 아닙니다.";
			returnMap.put("msg", msg);
			return new ResponseVO(returnMap);
		}
		
		if("1".equals(botType)) { // Attended  table insert

			// AR 해당과제 실행중 여부 조회
			Map<String, Object> arjobExcAt = excResHistService.selectARJobExcAt(params);
			
			if(arjobExcAt!=null) {
				if((Integer)arjobExcAt.get("retryApplyAt") == 0){
					msg = "이미 재실행되고 있는 과제입니다.";
					returnMap.put("msg", msg);
					return new ResponseVO(returnMap);
				}
			}
			Map<String, Object> map = new HashMap<String, Object>();
			
			map.put("cmpnyCd", cmpnyCd);
			map.put("processCd", processCd);
			map.put("botNo", botNo);
			map.put("inputArguments", inputArguments);
			map.put("releasesName", releasesName);
			map.put("processKey", processKey);
			map.put("cmpnyCd", cmpnyCd);
			map.put("targetId", params.get("id"));
			
			
			excResHistService.insertTaskAttendedReserve(map);
			msg = "Attended Bot에 전송 하였습니다.";
			
		}else if("2".equals(botType)) { // Unattended 2   api call
			// UR 해당과제 실행중 여부 조회
			Map<String, Object> jobExcAt = excResHistService.selectURJobExcAt(params);

			if(jobExcAt!=null) { // NULL이 아닌경우, 0이나 1 혹은 데이터
				if("0".equals(jobExcAt.get("applyAt").toString())){
					msg = "이미 재실행되고 있는 과제입니다.";
					returnMap.put("msg", msg);
					return new ResponseVO(returnMap);
				}
			}
			
			ResponseEntity<Map> response = restApi.post(url, jsonObj1);
			params.put("response", response.toString());
			msg = "Unattended Bot에 전송 하였습니다.";
			
			String[] getKey = response.getBody().get("value").toString().split(", Id=");
			String[] getJobsId = getKey[1].split("}");
			
			returnMap.put("targetId", params.get("id"));
			returnMap.put("jobId", getJobsId[0]);
			returnMap.put("txUserId", MDC.get("txUserId"));

			// 재실행 정보 남기기
			excResHistService.insertReExcInfo(returnMap);
		}else if("3".equals(botType)) { // Studio 3 api call
			// Studio 해당과제 실행중 여부 조회
			Map<String, Object> jobExcAt = excResHistService.selectURJobExcAt(params);
			
			if(jobExcAt!=null) {
				if("0".equals(jobExcAt.get("applyAt").toString())){
					msg = "이미 재실행되고 있는 과제입니다.";
					returnMap.put("msg", msg);
					return new ResponseVO(returnMap);
				}
			}
			
			ResponseEntity<Map> response = restApi.post(url, jsonObj1);
			params.put("response", response.toString());
			msg = "Studio에 전송 하였습니다.";

			String[] getKey = response.getBody().get("value").toString().split(", Id=");
			String[] getJobsId = getKey[1].split("}");
			
			returnMap.put("targetId", params.get("id"));
			returnMap.put("jobId", getJobsId[0]);
			returnMap.put("txUserId", MDC.get("txUserId"));
			
			// 재실행 정보 남기기
			excResHistService.insertReExcInfo(returnMap);
		}
		
		params.putAll(reExcInfoList);
		// 히스토리 저장===========================
		excResHistService.insertTaskSendHistory(params);
		// 히스토리 저장===========================
		returnMap.put("msg", msg);
		
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 상세 이력 추적 리스트
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/searchResHistList")
	@ResponseBody
	public ResponseVO searchResHistList(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();

		//디바이스 리스트 카운트 조회
		int totalRecordCount = excResHistService.selectResHistCount(map);
		
		if (totalRecordCount > 0) {
		
			//페이징 정보 조회
			PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, totalRecordCount);
			
			//조회조건에 페이징 정보 설정
			map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, totalRecordCount));
	
			//디바이스 리스트 조회
			List<Map<String, Object>> resultList = excResHistService.selectResHistList(map);
	
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
}
