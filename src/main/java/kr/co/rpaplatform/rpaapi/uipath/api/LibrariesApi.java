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
import org.springframework.web.multipart.MultipartFile;

import kr.co.rpaplatform.common.exception.RpaException;
import kr.co.rpaplatform.rpaapi.uipath.common.RestApi;

/**
 * 라이브러리 API
 * @author LSH
 *
 */
@Component
public class LibrariesApi {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(LibrariesApi.class);
	
	/**
	 * URL 공통부분
	 */
	private String urlPrefix = "/odata/Libraries";
	
	/**
	 * RestApi
	 */
	@Resource(name="restApi")
	private RestApi restApi;
	
	/**
	 * 라이브러리 조회
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> getLibraryList(Map<String, Object> map) throws Exception{
		logger.debug("LibrariesApi getLibraryList Start!!!!!!!!!!!!!");
		
		String url = urlPrefix + "?$orderby=Id%20asc&$top=10&$skip=" + map.get("skip").toString();
		
		String searchKwrd = map.get("searchKwrd").toString();
		if(!searchKwrd.equals("")) {
			url += "&$filter=contains(Id, '" + searchKwrd + "')";
		}	
		
		ResponseEntity<Map> response = restApi.get(url, map);
		Map<String, Object> returnMap = response.getBody();
		
		logger.debug("LibrariesApi getLibraryList End!!!!!!!!!!!!!");
		
		return returnMap;
	}
	
	/**
	 * 라이브러리 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> registerLibrary(MultipartFile multipartFile, Map<String, Object> map) throws Exception {
		
		logger.debug("LibrariesApi registerLibrary start!!!!!!");
		
		String url = urlPrefix + "/UiPath.Server.Configuration.OData.UploadPackage";
		String cmpnyCd = map.get("cmpnyCd").toString();
		
		ResponseEntity<Map> response = restApi.postFile(cmpnyCd, url, multipartFile);
		
		Map<String, Object> returnMap = null;
		if (response.getStatusCode() == HttpStatus.OK) {
			returnMap = response.getBody();
		} else {
			throw new RpaException("E201");
		}
		
		logger.debug("LibrariesApi registerLibrary end!!!!!!");
		return returnMap;
	}
	
	/**
	 * 라이브러리 버전 조회
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> selectLibraryVersionAPIList(Map<String, Object> map) throws Exception{
		logger.debug("LibrariesApi selectLibraryVersionAPIList Start!!!!!!!!!!!!!");
		
		String packageId = (String)map.get("packageId");
		String url = urlPrefix + "/UiPath.Server.Configuration.OData.GetVersions(packageId='"+packageId+"')";
		  
		ResponseEntity<Map> response = restApi.get(url, map);
		Map<String, Object> returnMap = response.getBody();
		
		logger.debug("LibrariesApi selectLibraryVersionAPIList End!!!!!!!!!!!!!");
		
		return returnMap;
	}

}
