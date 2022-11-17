/*==========================================================

 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 9.         LSH
 */
package kr.co.rpaplatform.rpaapi.uipath.common;

import java.net.URI;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.net.ssl.SSLContext;

import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.HttpClient;
import org.apache.http.conn.ssl.NoopHostnameVerifier;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.TrustSelfSignedStrategy;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.ssl.SSLContexts;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.ClientHttpRequestFactory;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.co.rpaplatform.common.exception.RpaException;
import kr.co.rpaplatform.rpaapi.uipath.token.TokenMng;

/**
 * @author LSH
 * 2020. 6. 9.
 */
@Component
public class RestApi {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(RestApi.class);
	
	/**
	 * api 토큰 관리
	 */
	@Resource(name="tokenMng")
	private TokenMng tokenMng;
	
	//RPA url
	@Value("${uipath.api.url}")
	private String uipathURL;
	
	/**
	 * api token 획득
	 * @return
	 * @throws Exception
	 */
	private Map<String, Object> getApiTkn(String cmpnyCd) throws Exception {
		
		Map<String, Object> searchMap = new HashMap<String, Object>();
		
		if(cmpnyCd == null || "".equals(cmpnyCd)) {
			searchMap.put("cmpnyCd", "");
		}else {
			searchMap.put("cmpnyCd", cmpnyCd);
		}
		
		Map<String, Object> tknMap = tokenMng.getApiTkn(searchMap);
		
		return tknMap;
	}
	
	/**
	 * SSL RestTemplate 획득
	 * @return
	 * @throws Exception
	 */
	private RestTemplate getSslRestTemplate() throws Exception {
		

		
		SSLContext sslContext = SSLContexts.custom().loadTrustMaterial(null,new TrustSelfSignedStrategy()).build();
        SSLConnectionSocketFactory connectionFactory = new SSLConnectionSocketFactory(sslContext,new NoopHostnameVerifier());
        BasicCredentialsProvider credentialsProvider = new BasicCredentialsProvider();
 
 
        credentialsProvider.setCredentials(AuthScope.ANY,new UsernamePasswordCredentials("admin","1234"));
          
        HttpClient httpClient = HttpClientBuilder.create()
                                                .setSSLSocketFactory(connectionFactory)
                                                .setDefaultCredentialsProvider(credentialsProvider)
                                                .build();
          
        ClientHttpRequestFactory requestFactory = new HttpComponentsClientHttpRequestFactory(httpClient);

		RestTemplate template = new RestTemplate(requestFactory);
		
		return template;
	}
	

	
	/**
	 * GET 방식 요청
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public ResponseEntity<Map> get(String url, Map<String, Object> map) throws Exception {
		
		logger.debug("RestApi get start!!!!!!");
		
		String cmpnyCd = "";
		if(map.containsKey("cmpnyCd")) {
			cmpnyCd = (String)map.get("cmpnyCd");
			map.remove("cmpnyCd");
		}
		
		Map<String, Object> tknMap = getApiTkn(cmpnyCd);
		//String serverUrl = uipathURL;
		String serverUrl = uipathURL;
		String tknValue = "Bearer "+(String)tknMap.get("tknValue");
		
		RestTemplate template = getSslRestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", tknValue);
		
		HttpEntity request = new HttpEntity(map, headers);

		logger.debug(serverUrl+url);
		logger.debug(request.toString());
		ResponseEntity<Map> response = template.exchange(serverUrl+url, HttpMethod.GET, request, Map.class, map);

		logger.debug("RestApi get end!!!!!!");
		return response;
	}
	
	/**
	 * GET 방식 요청
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public ResponseEntity<byte[]> getFile(String url, Map<String, Object> map) throws Exception {
		
		logger.debug("RestApi get start!!!!!!");
		
		String cmpnyCd = "";
		if(map.containsKey("cmpnyCd")) {
			cmpnyCd = (String)map.get("cmpnyCd");
			map.remove("cmpnyCd");
		}
		
		Map<String, Object> tknMap = getApiTkn(cmpnyCd);
		String serverUrl = uipathURL;
		String tknValue = "Bearer "+(String)tknMap.get("tknValue");
		
		RestTemplate template = getSslRestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", tknValue);
		
		HttpEntity request = new HttpEntity(headers);

		logger.debug(serverUrl+url);
		logger.debug(request.toString());
		
		ResponseEntity<byte[]> response = template.exchange(serverUrl+url, HttpMethod.GET, request, byte[].class);
		
		logger.debug("RestApi get end!!!!!!");
		return response;
	}
	
	/**
	 * POST 방식 요청
	 * @param url
	 * @param multiMap
	 * @return
	 * @throws Exception
	 */
	public ResponseEntity<Map> post(String url, Map<String, Object> map) throws Exception {
		logger.debug("RestApi post start!!!!!!");
		
		String cmpnyCd = "";
		if(map.containsKey("cmpnyCd")) {
			cmpnyCd = (String)map.get("cmpnyCd");
			map.remove("cmpnyCd");
		}
		
		Map<String, Object> tknMap = getApiTkn(cmpnyCd);
		String serverUrl = uipathURL;
		String tknValue = "Bearer "+(String)tknMap.get("tknValue");
		
		URI httpUri = new URI(serverUrl+url);
		
		RestTemplate template = getSslRestTemplate();

		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", tknValue);
		
		//=====
		//-------------------Map To JSON--------------------------
		
		JSONObject jsonObject = new JSONObject();
        for( Map.Entry<String, Object> entry : map.entrySet() ) {
            String key = entry.getKey();
            Object value = entry.getValue();
            jsonObject.put(key, value);
		}
		logger.debug("JsonObject : " + jsonObject.toString());
		logger.debug("Map : " + map.toString());
		//-------------------//Map To JSON------------------------
		//=====
		
		HttpEntity<Map<String, Object>> request = new HttpEntity<>(jsonObject,headers);
		logger.debug(httpUri+"");
		logger.debug(request.toString());
		ResponseEntity<Map> response = template.exchange(httpUri, HttpMethod.POST, request, Map.class);
		
		logger.debug(response.getStatusCode().toString());
		logger.debug("RestApi post end!!!!!!");
		return response;
		
	}
	
	public ResponseEntity<Map> post2(String url, Map<String, Object> map) throws Exception{
 		logger.debug("RestApi post2 start!!!!!!");
		try {
				String cmpnyCd = "";
				if(map.containsKey("cmpnyCd")) {
					cmpnyCd = (String)map.get("cmpnyCd");
					map.remove("cmpnyCd");
				}
				
				Map<String, Object> tknMap;
				
					tknMap = getApiTkn(cmpnyCd);
				
				String serverUrl = uipathURL;
				String tknValue = "Bearer "+(String)tknMap.get("tknValue");
				
				URI httpUri = new URI(serverUrl+url);
				
				RestTemplate template = getSslRestTemplate();

				HttpHeaders headers = new HttpHeaders();
				headers.set("Authorization", tknValue);
				
				//=====
				//-------------------Map To JSON--------------------------
				
				JSONObject jsonObject = new JSONObject();
		        for( Map.Entry<String, Object> entry : map.entrySet() ) {
		            String key = entry.getKey();
		            Object value = entry.getValue();
		            jsonObject.put(key, value);
				}
				logger.debug("JsonObject : " + jsonObject.toString());
				logger.debug("Map : " + map.toString());
				//-------------------//Map To JSON------------------------
				//=====
				
				logger.debug(httpUri+"");
				
				
				headers.setContentType(MediaType.APPLICATION_JSON);
				
				HttpEntity<Map<String, Object>> request = new HttpEntity<>(jsonObject,headers);
				
				logger.debug(httpUri+"");
				logger.debug(request.toString());
				ResponseEntity<Map> response = template.exchange(httpUri, HttpMethod.POST, request, Map.class);
				
				logger.debug(response.getStatusCode().toString());
				logger.debug("RestApi post end!!!!!!");
				return response;
		} catch (HttpStatusCodeException  e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			e.getResponseBodyAsByteArray();
			ObjectMapper mapper = new ObjectMapper();
			String sResponseText = e.getResponseBodyAsString();
			if(sResponseText != null || sResponseText.length() > 0) {
				Map<String, String> aResponse = (Map<String, String>)mapper.readValue(sResponseText, Map.class);
				logger.debug("HttpStatusCodeException message: " + aResponse.get("message").toString());
				throw new RpaException("ECST", aResponse.get("message").toString());//Orchestrator return message
			}
			else {
				throw new Exception(e.getMessage(), e.getCause());
			}
		}
	}
	
	/**
	 * POST 방식 요청
	 * @param url
	 * @param object
	 * @return
	 * @throws Exception
	 */
	public ResponseEntity<Map> postObject(String url, Object object, Map<String, Object> map) throws Exception {
		
		logger.debug("RestApi postObject start!!!!!!");
		
		String cmpnyCd = "";
		if(map.containsKey("cmpnyCd")) {
			cmpnyCd = (String)map.get("cmpnyCd");
			map.remove("cmpnyCd");
		}
		
		Map<String, Object> tknMap = getApiTkn(cmpnyCd);
		String serverUrl = uipathURL;
		String tknValue = "Bearer "+(String)tknMap.get("tknValue");
		
		URI httpUri = new URI(serverUrl+url);
		
		RestTemplate template = getSslRestTemplate();

		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", tknValue);
		
		HttpEntity<Object> request = new HttpEntity<>(object, headers);
		logger.debug(httpUri+"");
		logger.debug(request.toString());
		ResponseEntity<Map> response = template.exchange(httpUri, HttpMethod.POST, request, Map.class);
		
		logger.debug(response.getStatusCode().toString());
		logger.debug("RestApi postObject end!!!!!!");
		return response;
		
	}
	
	/**
	 * POST 방식 요청
	 * @param url
	 * @param MultipartFile
	 * @return
	 * @throws Exception
	 */
	public ResponseEntity<Map> postFile(String cmpnyCd, String url, MultipartFile multipartFile) throws Exception {
		
		logger.debug("RestApi postFile start!!!!!!");

		Map<String, Object> tknMap = getApiTkn(cmpnyCd);
		String serverUrl = uipathURL;
		String tknValue = "Bearer "+(String)tknMap.get("tknValue");
		
		URI httpUri = new URI(serverUrl+url);
		
		RestTemplate template = getSslRestTemplate();

		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", tknValue);
		
		MultiValueMap<String, Object> multiValueMap = new LinkedMultiValueMap<>();
		ByteArrayResource resource = new ByteArrayResource(multipartFile.getBytes()){
		      @Override
		      public String getFilename() throws IllegalStateException {
		          return multipartFile.getOriginalFilename();
		      }
		};
		multiValueMap.add("file", resource);
		
		HttpEntity<Object> request = new HttpEntity<>(multiValueMap, headers);
		logger.debug(httpUri+"");
		logger.debug(request.toString());
		ResponseEntity<Map> response = template.postForEntity(httpUri, request, Map.class);
		
		logger.debug(response.getStatusCode().toString());
		logger.debug("RestApi postFile end!!!!!!");
		return response;
		
	}
	
	/**
	 * 삭제API DELETE
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public ResponseEntity<Map> delete(String url, Map<String, Object> map) throws Exception {
		logger.debug("RestApi delete start!!!!!!");
		
		String cmpnyCd = "";
		if(map.containsKey("cmpnyCd")) {
			cmpnyCd = (String)map.get("cmpnyCd");
			map.remove("cmpnyCd");
		}
		
		Map<String, Object> tknMap = getApiTkn(cmpnyCd);
		String serverUrl = uipathURL;
		String tknValue = "Bearer "+(String)tknMap.get("tknValue");
		URI httpUri = new URI(serverUrl+url);
		
		RestTemplate template = getSslRestTemplate();

		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", tknValue);
		
		HttpEntity<Map<String, Object>> request = new HttpEntity<>(headers);
		logger.debug(httpUri+"    "+request);
		ResponseEntity<Map> response = template.exchange(httpUri, HttpMethod.DELETE, request, Map.class);
		
		logger.debug(response.getStatusCode().toString());
		logger.debug("RestApi delete end!!!!!!");

		return response;		
	}
	
	
	/**
	 * 패키지 삭제API DELETE
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> packagedelete(String url, Map<String, Object> map) throws Exception {
		logger.debug("RestApi delete start!!!!!!");
		
		String cmpnyCd = "";
		if(map.containsKey("cmpnyCd")) {
			cmpnyCd = (String)map.get("cmpnyCd");
			map.remove("cmpnyCd");
		}
		
		Map<String, Object> tknMap = getApiTkn(cmpnyCd);
		String serverUrl = uipathURL;
		String tknValue = "Bearer "+(String)tknMap.get("tknValue");
		URI httpUri = new URI(serverUrl+url);
		
		RestTemplate template = getSslRestTemplate();

		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", tknValue);
		
		HttpEntity<Map<String, Object>> request = new HttpEntity<>(headers);
		logger.debug(httpUri+"    "+request);
		ResponseEntity<Map> response = template.exchange(httpUri, HttpMethod.DELETE, request, Map.class);
		
		logger.debug(response.getStatusCode().toString());
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		if(response.getStatusCode().toString().equals("204")) {
			returnMap.put("status", "success");
		}
		else {
			throw new RpaException("E201");
		}
		
		logger.debug("RestApi delete end!!!!!!");
		
		return returnMap;		
		
	}
	
	
	/**
	 * 수정API PATCH
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public ResponseEntity<Map> patch(String url, Map<String, Object> map) throws Exception {
		logger.debug("RestApi patch start!!!!!!");
		
		String cmpnyCd = "";
		if(map.containsKey("cmpnyCd")) {
			cmpnyCd = (String)map.get("cmpnyCd");
			map.remove("cmpnyCd");
		}
		
		Map<String, Object> tknMap = getApiTkn(cmpnyCd);
		String serverUrl = uipathURL;
		String tknValue = "Bearer "+(String)tknMap.get("tknValue");
		
		//REST API를 요청할 주소
		URI httpUri = new URI(serverUrl+url);
		RestTemplate template = getSslRestTemplate();
		
		// header에 권한 담기
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", tknValue);
		
		//-------------------Map To JSON--------------------------
		
		JSONObject jsonObject = new JSONObject();
        for( Map.Entry<String, Object> entry : map.entrySet() ) {
            String key = entry.getKey();
            Object value = entry.getValue();
            jsonObject.put(key, value);
		 }
		logger.debug("JsonObject : " + jsonObject.toString());
		logger.debug("Map : " + map.toString());
		//-------------------//Map To JSON------------------------
		

		// 요청할 header와 body담기
//		HttpEntity<Map<String, Object>> request = new HttpEntity<>(map,headers);
		HttpEntity<Map<String, Object>> request = new HttpEntity<>(jsonObject, headers);

		logger.debug(httpUri+"");
		logger.debug(request.toString());

		ResponseEntity<Map> response = template.exchange(httpUri, HttpMethod.PATCH, request, Map.class);
		
		logger.debug("RestApi patch end!!!!!!");
		return response;		
	}
	
	
	
	
	/**
	 * 수정API PUT
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public ResponseEntity<Map> put(String url, Map<String, Object> map) throws Exception {
		logger.debug("RestApi put start!!!!!!");
		
		String cmpnyCd = "";
		if(map.containsKey("cmpnyCd")) {
			cmpnyCd = (String)map.get("cmpnyCd");
			map.remove("cmpnyCd");
		}
		
		Map<String, Object> tknMap = getApiTkn(cmpnyCd);
		String serverUrl = uipathURL;
		String tknValue = "Bearer "+(String)tknMap.get("tknValue");
		//REST API를 요청할 주소
		URI httpUri = new URI(serverUrl+url);
		RestTemplate template = getSslRestTemplate();
				
		
		// header에 권한 담기
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", tknValue);
		
		//-------------------Map To JSON--------------------------		
		JSONObject jsonObject = new JSONObject();
        for( Map.Entry<String, Object> entry : map.entrySet() ) {
            String key = entry.getKey();
            Object value = entry.getValue();
            jsonObject.put(key, value);
		 }
		logger.debug("JsonObject : " + jsonObject.toString());
		logger.debug("Map : " + map.toString());
		//-------------------//Map To JSON------------------------
		
		

		// 요청할 header와 body담기
//		HttpEntity<Map<String, Object>> request = new HttpEntity<>(map,headers);
		HttpEntity<Map<String, Object>> request = new HttpEntity<>(jsonObject,headers);

		logger.debug("template :" + template);
		logger.debug("httpUri :" + httpUri +"");
		logger.debug("request :" + request.toString());

		
		
		ResponseEntity<Map> response = template.exchange(httpUri, HttpMethod.PUT, request, Map.class);
		
		logger.debug("RestApi put end!!!!!!");
		return response;
	}
	
	
	/**
	 * 수정API PUT
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public ResponseEntity<Map> put2(String url, Map<String, Object> map) throws Exception {
		logger.debug("RestApi put2 start!!!!!!");
		try {
			String cmpnyCd = "";
			if(map.containsKey("cmpnyCd")) {
				cmpnyCd = (String)map.get("cmpnyCd");
				map.remove("cmpnyCd");
			}
			
			Map<String, Object> tknMap = getApiTkn(cmpnyCd);
			String serverUrl = uipathURL;
			String tknValue = "Bearer "+(String)tknMap.get("tknValue");
			//REST API를 요청할 주소
			URI httpUri = new URI(serverUrl+url);
			RestTemplate template = getSslRestTemplate();
					
			
			// header에 권한 담기
			HttpHeaders headers = new HttpHeaders();
			headers.set("Authorization", tknValue);
			
			//-------------------Map To JSON--------------------------		
			JSONObject jsonObject = new JSONObject();
	        for( Map.Entry<String, Object> entry : map.entrySet() ) {
	            String key = entry.getKey();
	            Object value = entry.getValue();
	            jsonObject.put(key, value);
			 }
			logger.debug("JsonObject : " + jsonObject.toString());
			logger.debug("Map : " + map.toString());
			//-------------------//Map To JSON------------------------
			
			
	
			// 요청할 header와 body담기
	//		HttpEntity<Map<String, Object>> request = new HttpEntity<>(map,headers);
			HttpEntity<Map<String, Object>> request = new HttpEntity<>(jsonObject,headers);
	
			logger.debug("template :" + template);
			logger.debug("httpUri :" + httpUri +"");
			logger.debug("request :" + request.toString());
	
			
			
			ResponseEntity<Map> response = template.exchange(httpUri, HttpMethod.PUT, request, Map.class);
			
			logger.debug("RestApi put end!!!!!!");
			return response;
		} catch (HttpStatusCodeException  e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			e.getResponseBodyAsByteArray();
			ObjectMapper mapper = new ObjectMapper();
			String sResponseText = e.getResponseBodyAsString();
			if(sResponseText != null || sResponseText.length() > 0) {
				Map<String, String> aResponse = (Map<String, String>)mapper.readValue(sResponseText, Map.class);
				logger.debug("HttpStatusCodeException message: " + aResponse.get("message").toString());
				throw new RpaException("ECST", aResponse.get("message").toString());//Orchestrator return message
			}
			else {
				throw new Exception(e.getMessage(), e.getCause());
			}
			
			
		}
	}
	
	
	
}
