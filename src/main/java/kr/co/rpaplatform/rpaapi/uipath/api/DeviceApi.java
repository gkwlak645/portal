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

/**
 * 디바이스 API
 * @author LSH
 *
 */
@Component
public class DeviceApi {

	private final Logger logger = LoggerFactory.getLogger(DeviceApi.class);
	String url = "/odata/Machines";
	
	/**
	 * RestApi
	 */
	@Resource(name="restApi")
	private RestApi restApi;
	
	/**
	 * 디바이스 등록
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> registerDevice(Map<String, Object> map) throws Exception {
		
		//MultiValueMap<String, Object> multiMap = new LinkedMultiValueMap<>();
		//multiMap.setAll(map);
		//multiMap.add("Type", "Standard");
		
		ResponseEntity<Map> response = restApi.post(url, map);
		
		Map<String, Object> returnMap = null;
		if (response.getStatusCode() == HttpStatus.CREATED) {
			returnMap = response.getBody();
		} else {
			throw new RpaException("E201");
		}
		return returnMap;
	}
	
	/**
	 * 디바이스 삭제
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> deleteDevice(Map<String, Object> map) throws Exception {
		
		String id =  map.get("Id").toString();
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
	 * 디바이스 수정
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> updateDevice(Map<String, Object> map) throws Exception {
		//MultiValueMap<String, Object> multiMap = new LinkedMultiValueMap<>();
		//multiMap.setAll(map);
		String id =  map.get("Id").toString();
		String updateUrl = url+"("+id+")";
		
		int Id = Integer.parseInt(map.get("Id").toString());
		map.put("Id", Id);
		
		ResponseEntity<Map> response = restApi.patch(updateUrl, map);
		
		Map<String, Object> returnMap = null;
		if (response.getStatusCode() == HttpStatus.OK) {
			returnMap = response.getBody();
		} else {
			throw new RpaException("E201");
		}
		
		return returnMap;
	}
}
