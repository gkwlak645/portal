package kr.co.rpaplatform.dongwon.mntrng.web;

import java.util.ArrayList;
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
import kr.co.rpaplatform.crontab.service.CronSchedulService;
import kr.co.rpaplatform.dongwon.common.util.PaginationUtil;
import kr.co.rpaplatform.dongwon.mntrng.service.PoUserMappService;

/**
 * 작업 컨트롤러
 * @author LSH
 *
 */
@Controller
@RequestMapping("/mntrng/pousermapp")
public class PoUserMappController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(PoUserMappController.class);
	
	/**
	 * 작업 서비스
	 */
	@Resource(name="poUserMappService")
	private PoUserMappService poUserMappService;
	
	@Resource(name="cronSchedulService")
	private CronSchedulService cronSchedulService;
	
	/**
	 * 작업모니터링 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/poUserMappMain")
	public ModelAndView poUserMappMain(HttpServletRequest request) throws Exception {
		
		ModelAndView mav = new ModelAndView("/mntrng/poUserMapp/poUserMappMain");
		
		return mav;
	}
	
	/**
	 * 프로세스 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getProMappList")
	@ResponseBody
	public ResponseVO getProMappList(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();

		if("01".equals(map.get("searchProcessState").toString())){
			map.put("searchProcessState", "O1");
		}else if("02".equals(map.get("searchProcessState").toString())) {
			map.put("searchProcessState", "N1"); 
		}else {
			map.put("searchProcessState", "");
		}
		//디바이스 리스트 카운트 조회
		int totalRecordCount = poUserMappService.getPoUserMappCount(map);
		
		if (totalRecordCount > 0) {
		
			//페이징 정보 조회
			PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, totalRecordCount);
			
			//조회조건에 페이징 정보 설정
			map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, totalRecordCount));
	
			//디바이스 리스트 조회
			List<Map<String, Object>> resultList = poUserMappService.getPoUserMappList(map);
			
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
	@RequestMapping(value = "/poUserMappDetailPop")
	public ModelAndView poUserMappDetailPop(HttpServletRequest request) throws Exception {
		
		ModelAndView mav = new ModelAndView("/mntrng/poUserMapp/poUserMappDetailPop");
		
		return mav;
	}
	
	/**
	 * ORC 프로세스 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getOrcProcessNm")
	@ResponseBody
	public ResponseVO getOrcProcessNm(@RequestBody Map<String, Object> map) throws Exception {
		
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
		
		int devcnt = cronSchedulService.isExistDevTableName();

		if("0".equals(map.get("divCd").toString())){ // DEV_MAPPER 정보 조회			
			if(devcnt > 0) resultList = poUserMappService.getDevMapperList(map); // 운영 서버
			else resultList = poUserMappService.getDevMapperListForDevServer(map); // 개발 서버(SY_DEV_ 없음)
		}else { // ORC 프로세스 조회
			if(devcnt > 0) resultList = poUserMappService.getOrcReleaseList(map); // 운영 서버
			else resultList = poUserMappService.getOrcReleaseListForDevServer(map);	// 개발 서버(SY_DEV_ 없음)
		}
		
		return new ResponseVO(resultList);
	}
	
	/**
	 * 파워유저 프로세스 매핑정보 삽입
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/regMapping")
	@ResponseBody
	public ResponseVO regMapping(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		int devcnt = cronSchedulService.isExistDevTableName();
		
		if(devcnt > 0) poUserMappService.insertMappInfo(map); // 운영 서버
		else poUserMappService.insertMappInfoForDevServer(map); // 개발 서버(SY_DEV_ 없음)
			
		String msg = "등록되었습니다.";
		returnMap.put("msg", msg);
		
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 파워유저 프로세스 매핑정보 삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/proDelete")
	@ResponseBody
	public ResponseVO proDelete(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		map.put("txUserId", MDC.get("txUserId"));
		poUserMappService.deleteMappInfo(map);
		
		String msg = "삭제되었습니다.";
		returnMap.put("msg", msg);
		
		return new ResponseVO(returnMap);
	}
	
}
