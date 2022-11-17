package kr.co.rpaplatform.dongwon.mntrng.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.common.util.PaginationUtil;
import kr.co.rpaplatform.dongwon.mntrng.service.JobArService;
import kr.co.rpaplatform.dongwon.mntrng.service.JobService;

/**
 * 작업 컨트롤러
 * @author LSH
 *
 */
@Controller
@RequestMapping("/mntrng/jobAr")
public class JobArController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(JobArController.class);
	
	/**
	 * 작업 서비스
	 */
	@Resource(name="jobArService")
	private JobArService jobArService;
	
	
	/**
	 * 작업모니터링 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/jobArMain")
	public ModelAndView jobArMain(HttpServletRequest request) throws Exception {
		
		ModelAndView mav = new ModelAndView("/mntrng/jobAr/jobArMain");
		
		return mav;
	}
	
	/**
	 * 작업 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getArRobotList")
	@ResponseBody
	public ResponseVO getArRobotList(@RequestBody Map<String, Object> map) throws Exception {		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		// 해당 회사에 맞는 로봇 리스트 조회
		List<Map<String, Object>> robotList = jobArService.selectBotList(map); 				
		returnMap.put("robotList", robotList);
				
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 작업 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getJobArList")
	@ResponseBody
	public ResponseVO getJobArList(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();

		/*if(!MDC.get("txCmpnyCd").equals("") && MDC.get("txCmpnyCd") != null) {
			map.put("cmpnycd", (String)MDC.get("txCmpnyCd"));
		}*/	
		
		// 해당 회사에 맞는 로봇 리스트 조회
		List<Map<String, Object>> robotList = jobArService.selectBotList(map); 				
		returnMap.put("robotList", robotList);
		
		//디바이스 리스트 카운트 조회
		int totalRecordCount = jobArService.getJobArListCount(map);
	
		
		if (totalRecordCount > 0) {
		
			//페이징 정보 조회
			PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, totalRecordCount);
			
			//조회조건에 페이징 정보 설정
			map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, totalRecordCount));
	
			//디바이스 리스트 조회
			List<Map<String, Object>> resultList = jobArService.getJobArList(map);
	
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
	 * JOB 중지
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/stopJobAr")
	@ResponseBody
	public ResponseVO stopJobAr(@RequestBody Map<String, Object> map) throws Exception {
		jobArService.stopJobAr(map);
		return new ResponseVO();
	}
	
	
	/**
	 * '중지중'인 JOB의 상태를 '중지됨'으로 강제 변경
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/convertToStopped")
	@ResponseBody
	public ResponseVO convertToStopped(@RequestBody Map<String, Object> map) throws Exception {
		jobArService.convertToStopped(map);
		return new ResponseVO();
	}
	
	
	
}
