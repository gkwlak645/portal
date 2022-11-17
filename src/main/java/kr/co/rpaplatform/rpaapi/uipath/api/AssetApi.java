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
public class AssetApi {
	
	private final Logger logger = LoggerFactory.getLogger(TokenMng.class);
	String url = "/odata/Assets";
	
	@Resource(name="restApi")
	private RestApi restApi;
	
	/**
	 * Asset 등록
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> registerAsset(Map<String, Object> map) throws Exception {
		logger.debug("AssetApi registerAsset start!!!!!!");

		MultiValueMap<String, Object> multiMap = new LinkedMultiValueMap<>();
		multiMap.setAll(map);
		
		ResponseEntity<Map> response = restApi.post(url, map);
		
		Map<String, Object> returnMap = null;
		if (response.getStatusCode() == HttpStatus.CREATED) {
			returnMap = response.getBody();
		} else {
			throw new RpaException("E201");
		}

		logger.debug("AssetApi registerAsset end!!!!!!");
		return returnMap;
	}
	
	/**
	 * Asset 삭제
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> deleteAsset(Map<String, Object> map) throws Exception {
		logger.debug("AssetApi deleteAsset start!!!!!!");
		//String id = (String)map.get("assetId");
		String id = String.valueOf( map.get("id"));
		String deleteUrl = url+"("+id+")";
		
		ResponseEntity<Map> response = restApi.delete(deleteUrl, map);
		
		Map<String, Object> returnMap = null;
		if (response.getStatusCode() == HttpStatus.NO_CONTENT) {
			returnMap = response.getBody();
		} else {
			throw new RpaException("E201");
		}
		
		logger.debug("AssetApi deleteAsset end!!!!!!");
		
		return returnMap;
	}
	/**
	 * Asset 수정
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> updateAsset(Map<String, Object> map) throws Exception {
		logger.debug("AssetApi updateAsset start!!!!!!");
		

		MultiValueMap<String, Object> multiMap = new LinkedMultiValueMap<>();
		multiMap.setAll(map);
		//String id = (String)map.get("id");
		String id = String.valueOf( map.get("Id"));
		String updateUrl = url+"("+id+")";
		
		ResponseEntity<Map> response = restApi.put(updateUrl, map);
		
		Map<String, Object> returnMap = null;
		if (response.getStatusCode() == HttpStatus.OK) {
			returnMap = response.getBody();
		} else {
			throw new RpaException("E201");
		}
		
		logger.debug("AssetApi updateAsset end!!!!!!");
		return returnMap;
	}
}
