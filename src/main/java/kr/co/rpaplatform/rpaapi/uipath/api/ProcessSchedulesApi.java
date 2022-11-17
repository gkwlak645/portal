package kr.co.rpaplatform.rpaapi.uipath.api;

import java.util.HashMap;
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
import kr.co.rpaplatform.rpaapi.uipath.token.TokenMng;

@Component
public class ProcessSchedulesApi {
	
	private final Logger logger = LoggerFactory.getLogger(TokenMng.class);
	String urlPrefix = "/odata/ProcessSchedules";
	
	@Resource(name="restApi")
	private RestApi restApi;
	
	/**
	 * 프로세스 버전 롤백
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectFutureProcessSchedulesList(Map<String, Object> map) throws Exception {
		
		logger.debug("ProcessSchedulesApi selectFutureProcessSchedulesList start!!!!!!");
		
		String url = urlPrefix + "?$filter=Enabled%20eq%20true&$select=EnvironmentName%2CEnvironmentId%2CReleaseId%2CReleaseName%2CStartProcessCron%2CStartProcessNextOccurrence";
		Map<String, Object> transportMap = new HashMap<String, Object>();
		transportMap.put("cmpnyCd", (String)map.get("cmpnycd"));

		ResponseEntity<Map> response = restApi.get(url, transportMap);
		
		Map<String, Object> returnMap = null;
		if (response.getStatusCode() == HttpStatus.OK) {
			returnMap = response.getBody();
		} else {
			throw new RpaException("E201");
		}

		logger.debug("ProcessSchedulesApi selectFutureProcessSchedulesList end!!!!!!");
		
		return returnMap;
	}
}
