package kr.co.rpaplatform.rpaapi.uipath.api;

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
public class RobotApi {

	private final Logger logger = LoggerFactory.getLogger(RobotApi.class);
	String url = "/odata/Robots";
	/**
	 * RestApi
	 */
	@Resource(name="restApi")
	private RestApi restApi;
	
	/**
	 * 로봇 등록
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> registerRobot(Map<String, Object> map) throws Exception {
		logger.debug("RobotApi registerRobot start!!!!!!");
		
		
		int MachineId = Integer.parseInt(map.get("MachineId").toString());
		map.put("MachineId", MachineId);
		
		ResponseEntity<Map> response = restApi.post(url, map);
		
		Map<String, Object> returnMap = null;
		logger.debug("response.getStatusCode() : " + response.getStatusCode());
		if (response.getStatusCode() == HttpStatus.CREATED) {
			
			returnMap = response.getBody();
			
			logger.debug("response.getBody()@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ : " + response.getBody());
			
		} else {
			throw new RpaException("E201");
		}

		logger.debug("RobotApi registerRobot end!!!!!!");
		
		return returnMap;
	}
	
	/**
	 * 로봇 삭제
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> deleteRobot(Map<String, Object> map) throws Exception {
		String id =  map.get("Id").toString();;
		String deleteUrl = url+"("+id+")";
		
		ResponseEntity<Map> response = restApi.delete(deleteUrl, map);
		
		Map<String, Object> returnMap = null;
		if (response.getStatusCode() == HttpStatus.NO_CONTENT) {
			returnMap = response.getBody();
		} else {
			throw new RpaException("E201");
		}
		
		
		return returnMap;
	}
	/**
	 * 로봇 수정
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> updateRobot(Map<String, Object> map) throws Exception {
		
//		String id =  map.get("Id").toString();
		String id = String.valueOf( map.get("Id"));
		String updateUrl = url+"("+id+")";
		
		int MachineId = Integer.parseInt(map.get("MachineId").toString());
		map.put("MachineId", MachineId);
		
		int Id = Integer.parseInt(map.get("Id").toString());
		map.put("Id", Id);
		
		ResponseEntity<Map> response = restApi.patch(updateUrl, map);
		
		logger.debug(response.getStatusCode()+"");
		
		Map<String, Object> returnMap = null;
		if (response.getStatusCode() == HttpStatus.OK) {
			returnMap = response.getBody();
		} else {
			throw new RpaException("E201");
		}
		
		return returnMap;
	}
	
}
