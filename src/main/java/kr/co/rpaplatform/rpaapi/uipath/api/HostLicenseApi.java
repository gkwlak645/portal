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
public class HostLicenseApi {
		
	private final Logger logger = LoggerFactory.getLogger(RobotApi.class);
	String url = "/odata/HostLicenses";
	String url2 = "/odata/LicensesNamedUser/UiPath.Server.Configuration.OData.GetLicensesNamedUser";
	String url3 = "/odata/LicensesRuntime/UiPath.Server.Configuration.OData.GetLicensesRuntime";
	String url4 = "/odata/Machines"; 
	
	/**
	 * RestApi
	 */
	@Resource(name="restApi")
	private RestApi restApi;

	
	
	/**
	 * 라이선스 조회
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	
	public Map<String, Object> getHostLicense(Map<String, Object> map) throws Exception {
		logger.debug("HostLicenseApi getHostLicense start!!!!!!!!!!!!! ");
		
		String tenantId = map.get("tenantId").toString();
		
		String addUrl = url+"/UiPath.Server.Configuration.OData.GetTenantLicense(tenantId=" + Integer.parseInt(tenantId) + ")";
				
		ResponseEntity<Map> response = restApi.get(addUrl, map);
		
		Map<String, Object> returnMap = response.getBody();

/*		if (response.getStatusCode() == HttpStatus.NO_CONTENT) {
			returnMap = response.getBody();
		} else {
			throw new RpaException("E201");
		}*/
		
		logger.debug("HostLicenseApi @@@@@@@@@!!!!!!!!!!!!! "+returnMap);
		logger.debug("HostLicenseApi getHostLicense end!!!!!!!!!!!!! ");
		
		return returnMap;
	}

	/**
	 * 라이선스 조회
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	
	public Map<String, Object> getHostLicenseCnt(Map<String, Object> map) throws Exception {
		logger.debug("HostLicenseApi getHostLicenseCnt start!!!!!!!!!!!!! ");
		
//		String tenantId = map.get("tenantId").toString();
		
		ResponseEntity<Map> response = restApi.get(url, map);
		
		Map<String, Object> returnMap = response.getBody();
		
		/*		if (response.getStatusCode() == HttpStatus.NO_CONTENT) {
			returnMap = response.getBody();
		} else {
			throw new RpaException("E201");
		}*/
		
		logger.debug("HostLicenseApi @@@@@@@@@!!!!!!!!!!!!! "+returnMap);
		logger.debug("HostLicenseApi getHostLicenseCnt end!!!!!!!!!!!!! ");
		
		return returnMap;
	}
	
	
}
