package kr.co.rpaplatform.dongwon.stdrinfo.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.stdrinfo.service.DayoffService;



/**
 * @author jyj
 */

@Controller
@RequestMapping("/stdrinfo/dayoff")
public class DayoffController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(AssetController.class);
	
	/**
	 * dayoff 서비스
	 */
	@Resource(name="dayoffService")
	private DayoffService dayoffService;
	
	/**
	 * dayoff 관리 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/dayoffMngMain")
	public ModelAndView dayoffMngMain() throws Exception {
		ModelAndView mav = new ModelAndView("/stdrinfo/dayoff/dayoffMngMain");
		return mav;
	}
	
	
	/**
	 * dayoff 등록API
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/registDayoff")
    @ResponseBody
    public ResponseVO registDayoff(@RequestBody Map<String, Object> map) throws Exception{
    	logger.debug("DayoffController registDayoff start!! ");
    	
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	resultMap = dayoffService.registDayoff(map);
    	
    	logger.debug("DayoffController registDayoff end!! ");
    	return new ResponseVO(resultMap);
    }
    
    /**
     * dayoff 휴무일 리스트 조회
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/getoffDayList")
    @ResponseBody
    public ResponseVO getoffDayList(@RequestBody Map<String, Object> map) throws Exception{
    	logger.debug("DayoffController getoffDay start!! ");
    	
    	Map<String, Object> returnMap = new HashMap<String, Object>();
    	
    	List<Map<String, Object>> resultList =  dayoffService.getoffDayList(map);
    	
    	returnMap.put("resultList", resultList );
    	
    	logger.debug("DayoffController getoffDay end!! ");
    	return new ResponseVO(returnMap);
    }
    
    /**
	 * dayoff 휴무일 가져오기API
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/getoffDay")
    @ResponseBody
    public ResponseVO getoffDay(@RequestBody Map<String, Object> map) throws Exception{
    	logger.debug("DayoffController getoffDay start!! ");
    	
    	Map<String, Object> returnMap = new HashMap<String, Object>();
    	
    	Map<String, Object> resultList =  dayoffService.getoffDay(map);
    	
    	returnMap.put("resultList", resultList );
    	
    	logger.debug("DayoffController getoffDay end!! ");
    	return new ResponseVO(returnMap);
    }
    
	/**
	 * dayoff 수정API
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/editDayoff")
    @ResponseBody
    public ResponseVO editDayoff(@RequestBody Map<String, Object> map) throws Exception{
    	logger.debug("DayoffController editDayoff start!! ");
    	
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	
    	resultMap = dayoffService.editDayoff(map);
    	
    	logger.debug("DayoffController editDayoff end!! ");
    	return new ResponseVO(resultMap);
    }
    
    @RequestMapping(value="/getTenantInfo")
    @ResponseBody
    public ResponseVO getTenantInfo(@RequestBody Map<String, Object> map) throws Exception{
    	logger.debug("DayoffController getTenantInfo start!! ");
    	
    	List<Map<String, Object>> resultMap = dayoffService.getTenantInfo(map);
    	
    	logger.debug("DayoffController getTenantInfo end!! ");
    	return new ResponseVO(resultMap);
    }
    
    /**
	 * dayoff 삭제API
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/deleteDayOff")
    @ResponseBody
    public ResponseVO deleteDayoff(@RequestBody Map<String, Object> map) throws Exception{
    	logger.debug("DayoffController deleteDayoff start!! ");
    	
    	dayoffService.deleteDayoff(map);
    	
    	logger.debug("DayoffController deleteDayoff end!! ");
    	return new ResponseVO();
    }
    
    
    
    

}
