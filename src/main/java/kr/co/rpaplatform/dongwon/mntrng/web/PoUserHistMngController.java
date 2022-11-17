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
import kr.co.rpaplatform.dongwon.mntrng.service.PoUserHistMngService;

/**
 * 작업 컨트롤러
 * @author LSH
 *
 */
@Controller
@RequestMapping("/mntrng/pouserhistmng")
public class PoUserHistMngController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(PoUserHistMngController.class);
	
	/**
	 * 작업 서비스
	 */
	@Resource(name="poUserHistMngService")
	private PoUserHistMngService poUserHistMngService;
	
	/**
	 * 작업모니터링 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/poUserHistMngMain")
	public ModelAndView poUserHistMngMain(HttpServletRequest request) throws Exception {
		
		ModelAndView mav = new ModelAndView("/mntrng/poUserHistMng/poUserHistMngMain");
		
		return mav;
	}
	
	/**
	 * 프로세스 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getHistMngList")
	@ResponseBody
	public ResponseVO getHistMngList(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();

		//디바이스 리스트 카운트 조회
		int totalRecordCount = poUserHistMngService.getPoUserHistMngCount(map);
		
		if (totalRecordCount > 0) {
		
			//페이징 정보 조회
			PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, totalRecordCount);
			
			//조회조건에 페이징 정보 설정
			map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, totalRecordCount));
	
			//디바이스 리스트 조회
			List<Map<String, Object>> resultList = poUserHistMngService.getPoUserHistMngList(map);
			
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
	 * 이력관리 화면 팝업호출
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/poUserHistMngDetailPop")
	public ModelAndView poUserHistMngDetailPop(HttpServletRequest request) throws Exception {
		
		ModelAndView mav = new ModelAndView("/mntrng/poUserHistMng/poUserHistMngDetailPop");
		
		return mav;
	}
	
	/**
	 * 이력 관리 디테일 데이터 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getDetailMappData")
	@ResponseBody
	public ResponseVO getDetailMappData(@RequestBody Map<String, Object> map) throws Exception {

		//디테일 매핑 데이터 조회
		Map<String, Object> resultList = poUserHistMngService.getDetailMappData(map);
		
		return new ResponseVO(resultList);
	}
	
	/**
	 * 파워유저 프로세스 이력 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/poUserMapping")
	@ResponseBody
	public ResponseVO poUserMapping(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		map.put("txUserId", MDC.get("txUserId"));
		
		// 재시도 정보 등록
		poUserHistMngService.insertRetryInfo(map);
		
		// 재실행 데이터가 성공 데이터라면,
		if("성공".equals(map.get("sttus").toString())){
			// 원본 데이터 수정 , 만약 재실행 데이터가 성공이라면,
			poUserHistMngService.updateTargetInfo(map);			
		}
		// 재시도 데이터 수정 , 대상여부 , 재시도 대상 아이디, 원본 여부 변경
		poUserHistMngService.updateOriginalInfo(map);
		
		String msg = "등록되었습니다.";
		returnMap.put("msg", msg);
		
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 파워유저 프로세스 이력 삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/poUserHistMngDeleteMapp")
	@ResponseBody
	public ResponseVO poUserHistMngDeleteMapp(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		// 재실행 기록 삭제
		poUserHistMngService.deleteRetryInfo(map);

		if("성공".equals(map.get("sttus").toString())) {
			// 원본데이터 수정 -> 대상여부, 조회해서 선택 해봐야함
			poUserHistMngService.updateTargetJobInfo(map);
		}
		// 재실행 데이터 수정 -> 대상여부, 재시도 대상 아이디, 원본 여부 변경
		poUserHistMngService.updateJobInfo(map);
		
		
		String msg = "삭제되었습니다.";
		returnMap.put("msg", msg);
		
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 파워유저용 이력관리 상세페이지 조회
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/poUserHistMappDetailPop")
	public ModelAndView poUserHistMappDetailPop(HttpServletRequest request) throws Exception {
		
		ModelAndView mav = new ModelAndView("/mntrng/poUserHistMng/poUserHistMappDetailPop");
		
		return mav;
	}
	
	/**
	 * 매핑된 상세데이터 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getPoUserHistDetailList")
	@ResponseBody
	public ResponseVO getPoUserHistDetailList(@RequestBody Map<String, Object> map) throws Exception {
		
		//디바이스 리스트 조회
		List<Map<String, Object>> resultList = poUserHistMngService.getPoUserHistDetailList(map);
			
		return new ResponseVO(resultList);
	}
}
