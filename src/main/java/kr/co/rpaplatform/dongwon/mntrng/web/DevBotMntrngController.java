package kr.co.rpaplatform.dongwon.mntrng.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.common.util.PaginationUtil;
import kr.co.rpaplatform.dongwon.mntrng.service.DevBotMntrngService;

/**
 * 작업 컨트롤러
 * @author LSH
 *
 */
@Controller
@RequestMapping("/mntrng/devbotmntrng")
public class DevBotMntrngController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(DevBotMntrngController.class);
	
	/**
	 * 작업 서비스
	 */
	@Resource(name="devBotMntrngService")
	private DevBotMntrngService devBotMntrngService;
	
	/**
	 * 작업모니터링 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/devBotMntrngMain")
	public ModelAndView devBotMntrngMain(HttpServletRequest request) throws Exception {
		
		ModelAndView mav = new ModelAndView("/mntrng/devBotMntrng/devBotMntrngMain");
		
		return mav;
	}

	/**
	 * 작업 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	 
	@RequestMapping(value = "/selectMntrngList")
	@ResponseBody
	public ResponseVO selectMntrngList(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();

		//디바이스 리스트 카운트 조회
		int totalRecordCount = devBotMntrngService.getDevBotMntrngCount(map);
		
		
		if (totalRecordCount > 0) {
		
			//페이징 정보 조회
			PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, totalRecordCount);
			
			//조회조건에 페이징 정보 설정
			map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, totalRecordCount));
	
			//디바이스 리스트 조회
			List<Map<String, Object>> resultList = devBotMntrngService.getDevBotMntrngList(map);
	
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
