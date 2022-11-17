package kr.co.rpaplatform.rpaapi.uipath.api;

import java.util.HashMap;
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
 * 릴리즈 API
 * @author LSH
 *
 */
@Component
public class ReleasesApi {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(ReleasesApi.class);
	
	/**
	 * URL 공통부분
	 */
	private String urlPrefix = "/odata/Releases";
	
	/**
	 * RestApi
	 */
	@Resource(name="restApi")
	private RestApi restApi;
	
	
	
	/**
	 * 프로세스 조회
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> selectReleasesAPIList(Map<String, Object> map) throws Exception{
		logger.debug("ReleasesApi selectReleasesAPIList Start!!!!!!!!!!!!!");
		  
		ResponseEntity<Map> response = restApi.get(urlPrefix, map);
		Map<String, Object> returnMap = response.getBody();
		
		logger.debug("ReleasesApi selectReleasesAPIList End!!!!!!!!!!!!!");
		
		return returnMap;
	}
	
	
	/**
	 * 프로세스 버전 변경
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateToSpecificPackageVersion (Map<String, Object> map) throws Exception {
		
		logger.debug("ReleasesApi changeProcessVersion start!!!!!!");
		
		Integer id = (Integer)map.get("id");
		String url = urlPrefix + "(" + id.toString() +")/UiPath.Server.Configuration.OData.UpdateToSpecificPackageVersion";
		
		Map<String, Object> transportMap = new HashMap<String, Object>();
		transportMap.put("cmpnyCd", (String)map.get("cmpnyCd"));
		if((String)map.get("version") != null && !"".equals((String)map.get("version"))) {
			transportMap.put("packageVersion", (String)map.get("version"));
		}
		
		ResponseEntity<Map> response = restApi.post(url, transportMap);
		
		Map<String, Object> returnMap = null;
		if (response.getStatusCode() == HttpStatus.OK) {
			returnMap = response.getBody();
		} else {
			throw new RpaException("E201");
		}

		logger.debug("ReleasesApi changeProcessVersion end!!!!!!");

	}
	
	
	/**
	 * 프로세스 버전 롤백
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void rollbackToPreviousReleaseVersion (Map<String, Object> map) throws Exception {
		
		logger.debug("ReleasesApi rollbackToPreviousReleaseVersion start!!!!!!");
		
		Integer id = (Integer)map.get("id");
		String url = urlPrefix + "(" + id.toString() +")/UiPath.Server.Configuration.OData.RollbackToPreviousReleaseVersion";
		
		Map<String, Object> transportMap = new HashMap<String, Object>();
		transportMap.put("cmpnyCd", (String)map.get("cmpnyCd"));
		if((String)map.get("version") != null && !"".equals((String)map.get("version"))) {
			transportMap.put("packageVersion", (String)map.get("version"));
		}

		ResponseEntity<Map> response = restApi.post(url, transportMap);
		
		Map<String, Object> returnMap = null;
		if (response.getStatusCode() == HttpStatus.OK) {
			returnMap = response.getBody();
		} else {
			throw new RpaException("E201");
		}

		logger.debug("ReleasesApi rollbackToPreviousReleaseVersion end!!!!!!");

	}
	
	
	/**
	 * 프로세스 버전 롤백
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateToLatestPackageVersion (Map<String, Object> map) throws Exception {
		
		logger.debug("ReleasesApi updateToLatestPackageVersion start!!!!!!");
		
		Integer id = (Integer)map.get("id");
		String url = urlPrefix + "(" + id.toString() +")/UiPath.Server.Configuration.OData.UpdateToLatestPackageVersion";
		
		Map<String, Object> transportMap = new HashMap<String, Object>();
		transportMap.put("cmpnyCd", (String)map.get("cmpnyCd"));
		if((String)map.get("version") != null && !"".equals((String)map.get("version"))) {
			transportMap.put("packageVersion", (String)map.get("version"));
		}	
		
		ResponseEntity<Map> response = restApi.post(url, transportMap);
		
		Map<String, Object> returnMap = null;
		if (response.getStatusCode() == HttpStatus.OK) {
			returnMap = response.getBody();
		} else {
			throw new RpaException("E201");
		}

		logger.debug("ReleasesApi updateToLatestPackageVersion end!!!!!!");

	}
	

	/**
	 * 프로세스 가져오기
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> getReleases(Map<String, Object> map) throws Exception{
		logger.debug("ReleasesApi getReleases Start!!!!!!!!!!!!!");
		  
		String id =  map.get("Id").toString();
		String updateUrl = urlPrefix+"("+id+")";
			
		ResponseEntity<Map> response = restApi.get(updateUrl, map);
		Map<String, Object> returnMap = response.getBody();
		
		logger.debug("ReleasesApi getReleases End!!!!!!!!!!!!!");
		
		return returnMap;
	}
	
	
	
	
	/**
	 * 프로세스 등록
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> registerReleases(Map<String, Object> map) throws Exception {
		logger.debug("ReleasesApi registerReleases start!!!!!!");

		MultiValueMap<String, Object> multiMap = new LinkedMultiValueMap<>();
		multiMap.setAll(map);
		
		ResponseEntity<Map> response = restApi.post(urlPrefix, map);
		
		Map<String, Object> returnMap = null;
		if (response.getStatusCode() == HttpStatus.CREATED) {
			returnMap = response.getBody();
		} else {
			throw new RpaException("E201");
		}

		logger.debug("ReleasesApi registerReleases end!!!!!!");
		return returnMap;
	}
	
	
	/**
	 * 프로세스 수정
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> updateReleases(Map<String, Object> map) throws Exception {
		logger.debug("ReleasesApi updateReleases start!!!!!!");

		MultiValueMap<String, Object> multiMap = new LinkedMultiValueMap<>();
		multiMap.setAll(map);
		//String id = (String)map.get("id");
		String id = String.valueOf( map.get("Id"));
		String updateUrl = urlPrefix+"("+id+")";
		
		Map<String, Object> argumentMap = new HashMap<String, Object>();
		if(map.get("InputArguments") != null && !"".equals(map.get("InputArguments"))) {
			argumentMap = (Map<String, Object>)map.get("InputArguments");
			argumentMap.put("cmpnyCd", map.get("cmpnyCd"));
		}
		
		ResponseEntity<Map> response = restApi.patch(updateUrl, argumentMap);
		
		Map<String, Object> returnMap = null;
		if (response.getStatusCode() == HttpStatus.OK) {
			returnMap = response.getBody();
		} else {
			throw new RpaException("E201");
		}
		
		logger.debug("ReleasesApi updateReleases end!!!!!!");
		return returnMap;
	}

	
	
	/**
	 * 프로세스 삭제
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> deleteReleases(Map<String, Object> map) throws Exception {
		logger.debug("ReleasesApi deleteReleases start!!!!!!");

		String id = String.valueOf( map.get("id"));
		String deleteUrl = urlPrefix+"("+id+")";
		
		ResponseEntity<Map> response = restApi.delete(deleteUrl, map);
		
		Map<String, Object> returnMap = null;
		if (response.getStatusCode() == HttpStatus.NO_CONTENT) {
			returnMap = response.getBody();
		} else {
			throw new RpaException("E201");
		}
		
		logger.debug("ReleasesApi deleteReleases end!!!!!!");
		
		return returnMap;
	}

	/**
	 * 업그레이드 가능한 프로세스 조회(패키지) 
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> getUpgradeReleases(Map<String, Object> map) throws Exception{
		logger.debug("ProcessApi getUpgradeReleases Start!!!!!!!!!!!!!");
		  
		String id =  map.get("id").toString();
		String updateUrl = urlPrefix+"?$filter=ProcessKey eq '" + id + "'&$orderby=ProcessVersion desc";
			
		ResponseEntity<Map> response = restApi.get(updateUrl, map);
		Map<String, Object> returnMap = response.getBody();
		
		logger.debug("ProcessApi getUpgradeReleases End!!!!!!!!!!!!!");
		
		return returnMap;
	}

	/**
	 * 패키지 버전 업데이트
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> updatePackageLatest(Map<String, Object> map) throws Exception {
		
		logger.debug("ProcessApi updatePackageLatest start!!!!!!");
		
		String url = urlPrefix + "/UiPath.Server.Configuration.OData.UpdateToLatestPackageVersionBulk";
		
		ResponseEntity<Map> response = restApi.post(url, map);
		
		Map<String, Object> returnMap = null;
		if (response.getStatusCode() == HttpStatus.OK) {
			returnMap = response.getBody();
		} else {
			throw new RpaException("E201");
		}

		logger.debug("ProcessApi updatePackageLatest end!!!!!!");

		return returnMap;
	}

}
