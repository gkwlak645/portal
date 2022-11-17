package kr.co.rpaplatform.rpaapi.uipath.api;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.multipart.MultipartFile;

import kr.co.rpaplatform.common.exception.RpaException;
import kr.co.rpaplatform.dongwon.resrce.dao.PackageDAO;
import kr.co.rpaplatform.rpaapi.uipath.common.RestApi;

/**
 * 패키지 API
 * @author LSH
 *
 */
@Component
public class PackageApi {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(PackageApi.class);
	
	/**
	 * URL 공통부분
	 */
	private String urlPrefix = "/odata/Processes";
	
	/**
	 * RestApi
	 */
	@Resource(name="restApi")
	private RestApi restApi;
	
	/**
	 * 패키지 DAO
	 */
	@Resource(name="packageDAO")
	private PackageDAO packageDAO;
	
	/**
	 * 프로세스 조회
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> selectProcessAPIList(Map<String, Object> map) throws Exception{
		logger.debug("PackageApi selectProcessAPIList Start!!!!!!!!!!!!!");
		  
		ResponseEntity<Map> response = restApi.get(urlPrefix, map);
		Map<String, Object> returnMap = response.getBody();
		
		logger.debug("PackageApi selectProcessAPIList End!!!!!!!!!!!!!");
		
		return returnMap;
	}
	
	/**
	 * 프로세스 조회
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> getPackageAllList(Map<String, Object> map) throws Exception{
		logger.debug("PackageApi getPackageAllList Start!!!!!!!!!!!!!");
		
		String url = urlPrefix + "?$orderby=Id%20asc";
		
		String searchKwrd = map.get("searchKwrd").toString();
		if(!searchKwrd.equals("")) {
			url += "&$filter=((contains(Id, '" + searchKwrd + "')) or (contains(Version, '" + searchKwrd + "')))";
		}	
		
		ResponseEntity<Map> response = restApi.get(url, map);
		Map<String, Object> returnMap = response.getBody();
		
		logger.debug("PackageApi getPackageAllList End!!!!!!!!!!!!!");
		
		return returnMap;
	}
	
	/**
	 * 프로세스 조회
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> getPackageList(Map<String, Object> map) throws Exception{
		logger.debug("PackageApi getPackageList Start!!!!!!!!!!!!!");
		
		String url = urlPrefix + "?$orderby=Id%20asc&$top=10&$skip=" + map.get("skip").toString();
		
		String searchKwrd = map.get("searchKwrd").toString();
		if(!searchKwrd.equals("")) {
			url += "&$filter=((contains(Id, '" + searchKwrd + "')) or (contains(Version, '" + searchKwrd + "')))";
		}	

		ResponseEntity<Map> response = restApi.get(url, map);
		Map<String, Object> returnMap = response.getBody();
				
		logger.debug("PackageApi getPackageList End!!!!!!!!!!!!!");
		
		return returnMap;
	}
	
	/**
	 * 패지키 존재 리스트(프로세스 + 버전)
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> isExistPackageProcessVersion(Map<String, Object> map) throws Exception{
		logger.debug("PackageApi selecePackageList Start!!!!!!!!!!!!!");
		
		String identifier = "";
		String version = "";
		
		// /odata/Processes?$filter=Key%20eq%20'1.0.1:'
		
		if(map.containsKey("identifier")) {
			identifier = map.get("identifier").toString();
		}

		if(map.containsKey("version")) {
			version = map.get("version").toString();
		}

		String url = urlPrefix + "?$filter=Key eq '" + identifier + ":" + version + "'";

		ResponseEntity<Map> response = restApi.get(url, map);
		Map<String, Object> returnMap = response.getBody();
				
		logger.debug("PackageApi selecePackageList End!!!!!!!!!!!!!");
		
		return returnMap;
	}
	
	/**
	 * 프로세스 버전 조회
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> selectProcessVersionAPIList(Map<String, Object> map) throws Exception{
		logger.debug("PackageApi selectProcessVersionAPIList Start!!!!!!!!!!!!!");
		
		String processId = (String)map.get("processId");
		String url = urlPrefix + "/UiPath.Server.Configuration.OData.GetProcessVersions(processId='"+processId+"')";
		  
		ResponseEntity<Map> response = restApi.get(url, map);
		Map<String, Object> returnMap = response.getBody();
		
		logger.debug("PackageApi selectProcessVersionAPIList End!!!!!!!!!!!!!");
		
		return returnMap;
	}
	
	/**
	 * 패키지 다운로드
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public ResponseEntity<byte[]> packageDownload(Map<String, Object> map) throws Exception {
		
		logger.debug("PackageApi packageDownload start!!!!!!");

		String processKey = (String)map.get("processKey");
		String version = (String)map.get("version");
//		String key = "'" + processKey + ":" + version + "'" ;
		String key = processKey + ":" + version;
		String url = urlPrefix + "/UiPath.Server.Configuration.OData.DownloadPackage(key='" + key + "')";
		
		Map<String, Object> transportMap = new HashMap<String, Object>();
		//transportMap.put("cmpnyCd", "");		
		if(map.containsKey("cmpnyCd")) {
			transportMap.put("cmpnyCd", map.get("cmpnyCd"));
		}
		else {
			transportMap.put("cmpnyCd", "");
		}
		
		ResponseEntity<byte[]> response = restApi.getFile(url, transportMap);
		
		HttpHeaders headers = new HttpHeaders();
		
		byte[] returnMap = null;
		if (response.getStatusCode() == HttpStatus.OK) {
			returnMap = response.getBody();
		} else {
			throw new RpaException("E201");
		}
		logger.debug("PackageApi packageDownload end!!!!!!");
		return response;

	}
	
	/**
	 * 패키지 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> registerPackage(MultipartFile multipartFile, Map<String, Object> map) throws Exception {
		
		logger.debug("PackageApi registerPackage start!!!!!!");
		String cmpnyCd = map.get("cmpnyCd").toString();
		
		String url = urlPrefix + "/UiPath.Server.Configuration.OData.UploadPackage";
		
//		Map<String, Object> transportMap = new HashMap<String, Object>();
//		transportMap.put("cmpnyCd", "");
		
		ResponseEntity<Map> response = restApi.postFile(cmpnyCd, url, multipartFile);
		
		Map<String, Object> returnMap = null;
		if (response.getStatusCode() == HttpStatus.OK) {
			returnMap = response.getBody();
		} else {
			throw new RpaException("E201");
		}
		logger.debug("PackageApi registerPackage end!!!!!!");
		return returnMap;
		
	}
	
	/**
	 * 패키지 삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> deletePackage (Map<String, Object> map) throws Exception {
		logger.debug("PackageApi deletePackage Start!!!!!!!!!!!!!");
	
		String processId = (String)map.get("Id");
		String cmpnyCd = (String)map.get("cmpnyCd");
		String Version = (String)map.get("Version");
		
		String url = urlPrefix + "('" + processId+":" + Version + "')";
		  
		Map<String, Object> response = restApi.packagedelete(url, map);
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		if (response.get("status").equals("success")) {
			returnMap.put("status", "success");
			
		} else {
			throw new RpaException("E201");
		}
		
		logger.debug("PackageApi deletePackage End!!!!!!!!!!!!!");
		
		return returnMap;
	}
	

}
