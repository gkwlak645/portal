package kr.co.rpaplatform.dongwon.execut.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.common.util.PaginationUtil;
import kr.co.rpaplatform.dongwon.execut.service.SchdulService;

/**
 * 스케줄 컨트롤러
 * @author LSH
 *
 */
@Controller
@RequestMapping("/execut/schdul")
public class SchdulController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(SchdulController.class);
	
	/**
	 * 스케줄 서비스
	 */
	@Resource(name="schdulService")
	private SchdulService schdulService;
	
	/**
	 * 스케줄 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/schdulMngMain")
	public ModelAndView schdulMngMain() throws Exception {
		return new ModelAndView("/execut/schdul/schdulMngMain");
	}
	
	/**
	 * 스케줄 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getSchdulList", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getSchdulList(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();

		//프로세스 리스트 카운트 조회
		int totalRecordCount = schdulService.getSchdulCount(map);

		//페이징 정보 조회
		PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, totalRecordCount);
		
		//조회조건에 페이징 정보 설정
		map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, totalRecordCount));

		//프로세스 리스트 조회
		List<Map<String, Object>> resultList = schdulService.getSchdulList(map);

		//결과값 설정
		returnMap.put("resultList", resultList);
		returnMap.put("paginationInfo", paginationInfo);
		
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 스케줄 등록 팝업
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/triggerRegisterPop")
	public ModelAndView triggerRegisterPop() throws Exception {
		return new ModelAndView("/resrce/trigger/triggerRegisterPop");
	}

}
