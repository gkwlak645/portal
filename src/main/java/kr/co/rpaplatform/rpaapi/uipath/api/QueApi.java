package kr.co.rpaplatform.rpaapi.uipath.api;

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
import kr.co.rpaplatform.rpaapi.uipath.token.TokenMng;

@Component
public class QueApi {
	
	private final Logger logger = LoggerFactory.getLogger(TokenMng.class);
	
	//Queue 정의
	String urlQD = "/odata/QueueDefinitions";
	//Queue item
	String urlQI = "/odata/QueueItems";
	
	@Resource(name="restApi")
	private RestApi restApi;
	
	
	/**
	 * que 가져오기
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> getQue(Map<String, Object> map) throws Exception{
		logger.debug("QueApi getQue Start!!!!!!!!!!!!!");
		  
		String id =  map.get("Id").toString();
		String updateUrl = urlQD+"("+id+")";
			
		ResponseEntity<Map> response = restApi.get(updateUrl, map);
		Map<String, Object> returnMap = response.getBody();
		
		logger.debug("QueApi getQue End!!!!!!!!!!!!!");
		
		return returnMap;
	}
	
	
	/**
	 * queue 아이템 가져오기
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> getQueItm(Map<String, Object> map) throws Exception{
		logger.debug("QueApi getQueItm Start!!!!!!!!!!!!!");
		  
		String id =  map.get("Id").toString();
		
		String updateUrl = urlQI+"?$filter=QueueDefinitionId%20eq%20"+id+"&$top=1";
			
		ResponseEntity<Map> response = restApi.get(updateUrl, map);
		Map<String, Object> returnMap = response.getBody();
		
		logger.debug("QueApi getQueItm End!!!!!!!!!!!!!");
		
		return returnMap;
	}
	
	
	/**
	 * Que 등록
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> registerQue(Map<String, Object> map) throws Exception {
		logger.debug("QueApi registerQue start!!!!!!");

		MultiValueMap<String, Object> multiMap = new LinkedMultiValueMap<>();
		multiMap.setAll(map);
		
		ResponseEntity<Map> response = restApi.post(urlQD, map);
		
		Map<String, Object> returnMap = null;
		if (response.getStatusCode() == HttpStatus.CREATED) {
			returnMap = response.getBody();
		} else {
			throw new RpaException("E201");
		}

		logger.debug("QueApi registerQue end!!!!!!");
		return returnMap;
	}
	
	/**
	 * Que 삭제
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> deleteQue(Map<String, Object> map) throws Exception {
		logger.debug("QueApi deleteQue start!!!!!!");
		//String id = (String)map.get("QueId");
		String id = String.valueOf( map.get("id"));
		String deleteUrl = urlQD+"("+id+")";
		
		ResponseEntity<Map> response = restApi.delete(deleteUrl, map);
		
		Map<String, Object> returnMap = null;
		if (response.getStatusCode() == HttpStatus.NO_CONTENT) {
			returnMap = response.getBody();
		} else {
			throw new RpaException("E201");
		}
		
		logger.debug("QueApi deleteQue end!!!!!!");
		
		return returnMap;
	}
	/**
	 * Que 수정
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> updateQue(Map<String, Object> map) throws Exception {
		logger.debug("QueApi updateQue start!!!!!!");
		

		MultiValueMap<String, Object> multiMap = new LinkedMultiValueMap<>();
		multiMap.setAll(map);
		//String id = (String)map.get("id");
		String id = String.valueOf( map.get("Id"));
		String updateUrl = urlQD+"("+id+")";
		
		ResponseEntity<Map> response = restApi.put(updateUrl, map);
		
		Map<String, Object> returnMap = null;
		if (response.getStatusCode() == HttpStatus.OK) {
			returnMap = response.getBody();
		} else {
			throw new RpaException("E201");
		}
		
		logger.debug("QueApi updateQue end!!!!!!");
		return returnMap;
	}
}
