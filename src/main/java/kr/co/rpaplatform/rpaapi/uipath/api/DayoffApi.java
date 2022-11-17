package kr.co.rpaplatform.rpaapi.uipath.api;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

import kr.co.rpaplatform.common.exception.RpaException;
import kr.co.rpaplatform.rpaapi.uipath.common.RestApi;

@Component
public class DayoffApi {
		
	private final Logger logger = LoggerFactory.getLogger(RobotApi.class);
	String url = "/odata/Calendars";

	/**
	 * RestApi
	 */
	@Resource(name="restApi")
	private RestApi restApi;

	/**
	 * 휴무일 등록
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> registDayoff(Map<String, Object> map) throws Exception {
		logger.debug("dayoffApi registDayoff Start!!!!!!!!!!!!!");
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		ResponseEntity<Map> response = restApi.post(url, map);
		
		returnMap = response.getBody();	
		
		
		logger.debug("dayoffApi registDayoff end!!!!!!!!!!!!!");
		
		return returnMap;
	}

	/**
	 * 휴무일 수정
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> editDayoff(Map<String, Object> map) throws Exception {
	    logger.debug("dayoffApi editDayoff Start!!!!!!!!!!!!!");
	    
	    Map<String, Object> returnMap = new HashMap<String, Object>();
		
	    String id =  map.get("Id").toString();
	    String updateUrl = url+"("+id+")";
	
		ResponseEntity<Map> response = restApi.put(updateUrl, map);
		
		returnMap = response.getBody();
		
		logger.debug("dayoffApi editDayoff end!!!!!!!!!!!!!");
		return returnMap;
	}

	/**
	 * 휴무일 가져오기
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> getoffDay(Map<String, Object> map) throws Exception{
		logger.debug("dayoffApi getoffDay Start!!!!!!!!!!!!!");
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		String updateUrl = "";
		if(map.get("Id").toString() != null) {
			String id =  map.get("Id").toString();
			updateUrl = url+"("+id+")";
		} else {
			updateUrl = url;
		}
					
		ResponseEntity<Map> response = restApi.get(updateUrl, map);
		
		returnMap = response.getBody();
		
		logger.debug("dayoffApi getoffDay Start!!!!!!!!!!!!!");
		
		return returnMap;
	}

	/**
	 * 휴무일 삭제
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> deleteDayoff(Map<String, Object> map) throws Exception {
		logger.debug("dayoffApi deleteDayoff Start!!!!!!!!!!!!!");
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		String id =  map.get("Id").toString();
	    String updateUrl = url+"("+id+")";
	    
		ResponseEntity<Map> response = restApi.delete(updateUrl, map);
		
		returnMap = response.getBody();
		
		logger.debug("dayoffApi deleteDayoff end!!!!!!!!!!!!!");
		
		return returnMap;
	}

	
	
	
	
}
