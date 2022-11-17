package kr.co.rpaplatform.dongwon.hub.web;

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

import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.hub.service.HubService;


@Controller
@RequestMapping("/hub")
public class HubController {
	
	
	/**
	 * logger
	 */
	
	private final Logger logger = LoggerFactory.getLogger(HubController.class);
	
	
	
	
	/**
	 * 보드 서비스
	 */
	
	@Resource(name="hubService")
	private HubService hubService;
	
	/**
	 * 메인화면 이동
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value= "/hubMain")
	public ModelAndView hubMain() throws Exception{	
		logger.debug("hubMain 도착");
		ModelAndView mav = new ModelAndView("/hub/hubMain"); 
		return mav;
				
	}
	
	/**
	 * 허브 리스트 조회
	 * @return
	 * @param map
	 * @throws Exception
	 */
	@RequestMapping(value = "/getHubList", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getHubList(@RequestBody Map<String, Object> map) throws Exception {
		logger.debug("getHubList 도착");
		for(String i : map.keySet()) {
			logger.debug(map.get(i).toString());
		}
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		List<Map<String, Object>> resultList = hubService.getHubList(map);
		returnMap.put("resultList", resultList);
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 허브 리스트 조회(평가)
	 * @return
	 * @param map
	 * @throws Exception
	 */
	@RequestMapping(value = "/getHub_1List", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getHub_1List(@RequestBody Map<String, Object> map) throws Exception {
		logger.debug("getHub_1List 도착");
		for(String i : map.keySet()) {
			logger.debug(map.get(i).toString());
		}
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		List<Map<String, Object>> resultList = hubService.getHub_1List(map);
		returnMap.put("resultList", resultList);
		return new ResponseVO(returnMap);
	}
	
	
	
	
	
	/**
	 * 아이디어 등록 화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/hubIdeaCreate")
	public ModelAndView hubIdeaCreate() throws Exception {
		logger.debug("boardController 도착");
		return new ModelAndView("/hub/hubIdeaCreate");
	}
	
	
	
	
	
	
	
}
