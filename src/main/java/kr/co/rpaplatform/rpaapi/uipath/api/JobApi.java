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
import kr.co.rpaplatform.rpaapi.uipath.token.TokenMng;

@Component
public class JobApi {

	private final Logger logger = LoggerFactory.getLogger(JobApi.class);
	
	String url = "/odata/Jobs";
	
	@Resource(name="restApi")
	private RestApi restApi;
	
	
	/**
	 * JOB 중지
	 * @param map
	 * @return 
	 * @throws Exception
	 */
	public Map<String, Object> stopJob(Map<String, Object> map) throws Exception {
		logger.debug("JobApi stopJob start!!!!!!");
		
		String id = String.valueOf(map.get("id"));
		String stopJobUrl = url+"("+id+")/UiPath.Server.Configuration.OData.StopJob";
		
		map.remove("id");
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		ResponseEntity<Map> response = restApi.post(stopJobUrl, map);
		
		if (response.getStatusCode() == HttpStatus.OK) {
			returnMap = response.getBody();
		} else {
			throw new RpaException("E201");
		}

		logger.debug("JobApi stopJob end!!!!!!");
		return returnMap;
	}


	
	
}
