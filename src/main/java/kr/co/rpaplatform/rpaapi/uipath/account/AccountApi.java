/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 5.         LSH
 */
package kr.co.rpaplatform.rpaapi.uipath.account;

import java.util.Map;

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
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.client.ClientHttpRequestFactory;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

/**
 * Account API
 * @author LSH
 * 2020. 6. 5.
 */
@Component
public class AccountApi {
	
	//RPA url
	@Value("${uipath.api.url}")
	private String uipathURL;
	
	private final Logger logger = LoggerFactory.getLogger(AccountApi.class);

	public Map<String, Object> authenticate(Map<String, Object> map) throws Exception {
		
		SSLContext sslContext = SSLContexts.custom().loadTrustMaterial(null,new TrustSelfSignedStrategy()).build();
        SSLConnectionSocketFactory connectionFactory =new SSLConnectionSocketFactory(sslContext,new NoopHostnameVerifier());
        BasicCredentialsProvider credentialsProvider =new BasicCredentialsProvider();
 
 
        credentialsProvider.setCredentials(AuthScope.ANY,new UsernamePasswordCredentials("admin","1234"));
          
        HttpClient httpClient = HttpClientBuilder.create()
                                                .setSSLSocketFactory(connectionFactory)
                                                .setDefaultCredentialsProvider(credentialsProvider)
                                                .build();
          
        ClientHttpRequestFactory requestFactory = new HttpComponentsClientHttpRequestFactory(httpClient);

		RestTemplate template = new RestTemplate(requestFactory);
		
		
		//Map<String, Object> returnMap = (Map<String, Object>)template.postForObject("https://192.168.0.40:443/api/Account/Authenticate", map, Map.class);
		//Map<String, Object> returnMap = (Map<String, Object>)template.postForObject("https://1.221.147.165:4439/api/Account/Authenticate", map, Map.class);
		Map<String, Object> returnMap = (Map<String, Object>)template.postForObject(uipathURL+"/api/Account/Authenticate", map, Map.class);
		
		logger.debug(returnMap.toString());
		
		return returnMap;
	}
}
