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
public class LicenseApi {
		
	private final Logger logger = LoggerFactory.getLogger(RobotApi.class);
	String url = "/odata/Settings";
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
	
	public Map<String, Object> getLicense(Map<String, Object> map) throws Exception {
		logger.debug("LicenseApi getLicense start!!!!!!!!!!!!! ");
		
		
		String addLicenseUrl = url+"/UiPath.Server.Configuration.OData.GetLicense";
		
		ResponseEntity<Map> response = restApi.get(addLicenseUrl, map);
		
		Map<String, Object> returnMap = response.getBody();

/*		if (response.getStatusCode() == HttpStatus.NO_CONTENT) {
			returnMap = response.getBody();
		} else {
			throw new RpaException("E201");
		}*/
		
		
		
		
		
		logger.debug("LicenseApi @@@@@@@@@!!!!!!!!!!!!! "+returnMap);
		
		
		
		logger.debug("LicenseApi getLicense end!!!!!!!!!!!!! ");
		
		
		return returnMap;
	}


	/**
	 * 라이선스 상세 조회
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	
	public Map<String, Object> getLicenseDetail(Map<String, Object> map) throws Exception {
		logger.debug("LicenseApi getLicenseDetail start!!!!!!!!!!!!! ");

		logger.debug("LicenseApi @@@@@@@@@ map!!!!!!!!!!!!! "+map);
		String urltype = map.get("urltype").toString();	 
	    String addLicenseUrl = url2+"(robotType='"+urltype+"')";
	
	
	    ResponseEntity<Map> response = restApi.get(addLicenseUrl, map);	
	    Map<String, Object> returnMap = response.getBody();
	 
	    logger.debug("LicenseApi @@@@@@@@@!!!!!!!!!!!!! "+returnMap);
	   
		logger.debug("LicenseApi getLicenseDetail end!!!!!!!!!!!!! ");
		return returnMap;
	}
	
	
	
	/**
	 * 라이선스 상세 조회 2
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	
	public Map<String, Object> getLicenseDetail2(Map<String, Object> map) throws Exception{
		logger.debug("LicenseApi getLicenseDetail2 start!!!!!!!!!!!!! ");
		
		logger.debug("LicenseApi @@@@@@@@@ map!!!!!!!!!!!!! "+map);
     	String urltype = map.get("urltype").toString();
     	logger.debug("LicenseApi @@@@@@@@@ urltype !!!!!!!!!!!!! "+map.get("urltype"));
	    logger.debug("LicenseApi @@@@@@@@@ urltype !!!!!!!!!!!!! "+urltype);

		
		String addLicenseUrl = url3+"(robotType='"+urltype+"')";
		
		
		 ResponseEntity<Map> response = restApi.get(addLicenseUrl, map);	
		 Map<String, Object> returnMap = response.getBody();
		 
		    logger.debug("LicenseApi @@@@@@@@@!!!!!!!!!!!!! "+returnMap);
		   
			logger.debug("LicenseApi getLicenseDetail2 end!!!!!!!!!!!!! ");
			
			returnMap.put("SlotType",urltype);
		
		
		return returnMap;
	}


	/**
	 * 런타임 수정
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> updateRuntime(Map<String, Object> map) throws Exception{
		
		logger.debug("API Runtime map 넘어온값 확인" + map);
		
		String id =  map.get("MachineId").toString();	
		
		String updateUrl = url4+"("+id+")";
		
		
		//int MachineId = Integer.parseInt(map.get("MachineId").toString());
		//map.put("MachineId", MachineId);
		
		//int Id = Integer.parseInt(map.get("Id").toString());
		//map.put("Id", Id);
		
		map.remove("MachineId");
		
		ResponseEntity<Map> response = restApi.patch(updateUrl, map);
		
		logger.debug(response.getStatusCode()+"");
		
		Map<String, Object> returnMap = null;
		/*if (response.getStatusCode() == HttpStatus.OK) {
			returnMap = response.getBody();
		} else {
			throw new RpaException("E201");
		}*/
		
		return returnMap;
		
		
		
		
	}
	
	
	
	
	
	
}
