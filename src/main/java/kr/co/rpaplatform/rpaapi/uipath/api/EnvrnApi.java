package kr.co.rpaplatform.rpaapi.uipath.api;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import kr.co.rpaplatform.common.exception.RpaException;
import kr.co.rpaplatform.rpaapi.uipath.common.RestApi;
import kr.co.rpaplatform.rpaapi.uipath.vo.AddRobotEnvrnVO;

@Component
public class EnvrnApi {

	private final Logger logger = LoggerFactory.getLogger(EnvrnApi.class);
	String url = "/odata/Environments";
	
	/**
	 * API 
	 */
	@Resource(name="restApi")
	private RestApi restApi;


	/**
	 * 환경 조회
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> selectEnvrnList(Map<String, Object> map) throws Exception{
		logger.debug("EnvrnApi selectEnvrnList Start!!!!!!!!!!!!!");
		  
		String filterUrl = url;
			
		ResponseEntity<Map> response = restApi.get(filterUrl, map);
		Map<String, Object> returnMap = response.getBody();
		
		logger.debug("EnvrnApi selectEnvrnList End!!!!!!!!!!!!!");
		
		return returnMap;
	}
	
	
	/**
	 * 환경 등록
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> registerEnvrn(Map<String, Object> map) throws Exception {
		
/*		MultiValueMap<String, Object> multiMap = new LinkedMultiValueMap<>();
		multiMap.setAll(map);*/
		
		String cmpnyCd = "";
		if(map.containsKey("cmpnyCd")) {
			cmpnyCd = (String)map.get("cmpnyCd");
		}
		
		ResponseEntity<Map> response = restApi.post(url, map);
		
		map.put("cmpnyCd", cmpnyCd);
		//filterUrl 하드 코딩 : 수정 필요
		String filterUrl = url+"?$filter=Name%20eq%20'"+map.get("Name")+"'"; 
		ResponseEntity<Map> getResponse = restApi.get(filterUrl, map);
		
		logger.debug(getResponse.toString());
		
		Map<String, Object> returnMap = null;
		if (response.getStatusCode() == HttpStatus.CREATED) {
			returnMap = response.getBody();
			returnMap = getResponse.getBody();
		} else {
			throw new RpaException("E201");
		}

		logger.debug(returnMap.toString());
		return returnMap;
	}
	/**
	 * 환경 등록 - 로봇 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> addRobotToEnvrn(Map<String, Object> map) throws Exception  {

		String id = map.get("id").toString();
		String addRobotUrl = url+"("+id+")/UiPath.Server.Configuration.OData.SetRobots";
		
		
		List<Integer> addedRobotIds = new ArrayList<Integer>();
		for (Integer addedRobot : (List<Integer>)map.get("addedRobotIds")) {
			addedRobotIds.add(addedRobot);
		}
		
		List<Integer> removedRobotIds = new ArrayList<Integer>();
		for (Integer removedRobot : (List<Integer>)map.get("removedRobotIds")) {
			removedRobotIds.add(removedRobot);
		}

		AddRobotEnvrnVO addRobotEnvrnVO = new AddRobotEnvrnVO();
		addRobotEnvrnVO.setAddedRobotIds(addedRobotIds);
		addRobotEnvrnVO.setRemovedRobotIds(removedRobotIds);
		
		logger.debug("addRobotEnvrnVO : {}" + addRobotEnvrnVO.toString());

		ResponseEntity<Map> response = restApi.postObject(addRobotUrl, addRobotEnvrnVO,  map);
		
		Map<String, Object> returnMap = null;
		if (response.getStatusCode() == HttpStatus.NO_CONTENT || response.getStatusCode().toString() == "0") {
			if(response.getBody() != null) {
				returnMap = response.getBody();
			}else {
				logger.debug("response null");
			}
		} else {
			throw new RpaException("E201");
		}
		
		return returnMap;
		
	}
	/**
	 * 환경 삭제
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> deleteEnvrn(Map<String, Object> map) throws Exception {
		
		String id = map.get("Id").toString();
		String deleteUrl = url+"("+id+")";
		
		int Id = Integer.parseInt(map.get("Id").toString());
		map.put("Id", Id);
		
		
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
	 * 환경 수정
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> updateEnvrn(Map<String, Object> map) throws Exception {
		MultiValueMap<String, Object> multiMap = new LinkedMultiValueMap<>();
		multiMap.setAll(map);
		String id = map.get("Id").toString();
		String updateUrl = url+"("+id+")";
		
		int Id = Integer.parseInt(map.get("Id").toString());
		map.put("Id", Id);
		
		ResponseEntity<Map> response = restApi.put(updateUrl, map);
		
		Map<String, Object> returnMap = null;
		if (response.getStatusCode() == HttpStatus.OK) {
			returnMap = response.getBody();
		} else {
			throw new RpaException("E201");
		}
		
		return returnMap;
	}

}
