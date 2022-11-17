package kr.co.rpaplatform.dongwon.resrce.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.common.util.PaginationUtil;
import kr.co.rpaplatform.dongwon.resrce.service.QueService;
import kr.co.rpaplatform.rpaapi.uipath.common.RestApi;
import kr.co.rpaplatform.rpaapi.uipath.token.TokenMng;

/**
 * @author LSH
 */
@Controller
@RequestMapping("/resrce/que")
public class QueController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(QueController.class);
	
	/**
	 * que 서비스
	 */
	@Resource(name="queService")
	private QueService queService;
	
	@Resource(name="restApi")
	private RestApi restApi;
	
	
	/**
	 * que 관리 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/queMngMain")
	public ModelAndView queMngMain() throws Exception {
		ModelAndView mav = new ModelAndView("/resrce/que/queMngMain");
		return mav;
	}
	
	
	/**
	 * que 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/getQueList")
	@ResponseBody
	public ResponseVO getQueList(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();

		//que 리스트 카운트 조회
		int totalRecordCount = queService.getQueCount(map);
		
		if (totalRecordCount > 0) {
		
			//페이징 정보 조회
			PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, totalRecordCount);
			
			//조회조건에 페이징 정보 설정
			map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, totalRecordCount));
	
			//디바이스 리스트 조회
			List<Map<String, Object>> resultList = queService.getQueList(map);
	
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
	 * que 등록 페이지
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/queRegistPop")
	public ModelAndView queRegistPop() throws Exception {
		return new ModelAndView("/resrce/que/queRegistPop");
	}

	/**
	 * que 조회
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/getQueDetail")
	@ResponseBody
	public ResponseVO getQue(@RequestBody Map<String, Object> map) throws Exception {
		logger.debug("queController getQueDetail started !!!");
		
		Map<String, Object> resultMap = queService.getQueDetail(map);

		logger.debug("queController getQueDetail end !!!");
		
		return new ResponseVO(resultMap);
		
	}
	
	
	/**
	 * que 등록
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/registQue")
	@ResponseBody
	public ResponseVO registQue(@RequestBody Map<String, Object> map) throws Exception {
		logger.debug("queController registQue started !!!");
		
		Map<String, Object> resultMap = queService.registQue(map);

		logger.debug("queController registQue end !!!");
		
		return new ResponseVO(resultMap);
		
	}
	
	/**
	 * que 수정
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/updateQue")
	@ResponseBody
	public ResponseVO updateQue(@RequestBody Map<String, Object> map) throws Exception {
		logger.debug("queController updateQue started !!!");
		
		Map<String, Object> resultMap = queService.updateQue(map);

		logger.debug("queController updateQue end !!!");
		
		return new ResponseVO(resultMap);
		
	}
	
	/**
	 * que 삭제
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteQue")
	@ResponseBody
	public ResponseVO deleteQue(@RequestBody Map<String, Object> map) throws Exception {
		logger.debug("queController deleteQue started !!!");
		
		Map<String, Object> resultMap = queService.deleteQue(map);

		logger.debug("queController deleteQue end !!!");
		
		return new ResponseVO(resultMap);
		
	}
	
	
	
	@RequestMapping(value="/getRlseList")
	@ResponseBody
	public ResponseVO getRlseList(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();

			//디바이스 리스트 조회
			List<Map<String, Object>> resultList = queService.getRlseList(map);
	
			//결과값 설정
			returnMap.put("rlseList", resultList);
			
		
		return new ResponseVO(returnMap);
	}
	
	
	

}
