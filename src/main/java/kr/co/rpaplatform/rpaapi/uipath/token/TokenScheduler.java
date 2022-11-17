/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 9.         LSH
 */
package kr.co.rpaplatform.rpaapi.uipath.token;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.text.StringEscapeUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import kr.co.rpaplatform.dongwon.batch.service.BatchService;
import kr.co.rpaplatform.rpaapi.uipath.account.AccountApi;
import kr.co.rpaplatform.rpaapi.uipath.token.dao.ApiTokenDAO;

/**
 * api 토큰 저장 스케쥴러
 * @author LSH
 * 2020. 6. 9.
 */
@EnableAsync
@Component
public class TokenScheduler {
	
	private final Logger logger = LoggerFactory.getLogger(TokenScheduler.class);
	
	/**
	 * API 토큰 DAO
	 */
	@Resource(name="apiTokenDAO")
	private ApiTokenDAO apiTokenDAO;
	
	@Resource(name="batchService")
	private BatchService batchService;
	
	
	/**
	 * Account API
	 */
	@Resource(name="accountApi")
	private AccountApi accountApi;
	
	
	private boolean bRunAyncArcLogs = false;
	
	/**
	 * api 토큰 처리 프로세스
	 * 최초 이후 20분마다 실행
	 */
	@Scheduled(fixedRate=(1*60*1000))
	@Async("threadPoolTaskExecutor")
	public void processApiToken() {
		
		try {
			
			logger.info("TokenScheduler start !!!");
			
			List<Map<String, Object>> tknList = apiTokenDAO.selectApiTknList();
			
			if (tknList != null && tknList.size() > 0) {
				
				for (Map<String, Object> map : tknList) {
					
					//api를 통한 토큰 획득
					Map<String, Object> requestMap = new HashMap<String, Object>();
					requestMap.put("tenancyName", map.get("tenantNm"));
					requestMap.put("usernameOrEmailAddress", map.get("userNm"));
					requestMap.put("password", StringEscapeUtils.escapeHtml4((String)map.get("password")));
					logger.debug("###########################");
					logger.debug(requestMap.toString());
					logger.debug("###########################");

					Map<String, Object> returnMap = accountApi.authenticate(requestMap);
					
					logger.debug("###########################");
					logger.debug(returnMap.get("result").toString());
					logger.debug("###########################");
					
					//토큰 저장
					Map<String, Object> updateMap = new HashMap<String, Object>();
					updateMap.put("serverNo", map.get("serverNo"));
					updateMap.put("userNm", map.get("userNm"));
					updateMap.put("tenantId", map.get("tenantId"));
					updateMap.put("tknValue", returnMap.get("result"));
					apiTokenDAO.updateApiTkn(updateMap);
				}
			}
			
			logger.info("TokenScheduler end !!!");
		
		} catch (Exception e) {
			
			logger.error(e.toString());
			StackTraceElement[] elements = e.getStackTrace();
			for (StackTraceElement element : elements) {
				logger.error(element.toString());
			}
		}
		
	}
	
	
//	//1분마다
//	@Scheduled(cron="0 */1 * * * ?")
//	public void executDscntcImg() {
//		batchService.syncExecutDscntcImg();
//	}
	
	//5분마다
	@Scheduled(cron="0 0/5 * * * ?")
	@Async("threadPoolTaskExecutor")
	public void syncArcLogs() {
		logger.debug("###########################");
		logger.debug("TokenScheduler.syncArcLogs()");
		logger.debug("###########################");
		if(bRunAyncArcLogs) {
			return;
		}
		
		try {
			bRunAyncArcLogs = true;
			batchService.syncArcLogs();
			bRunAyncArcLogs = false;
			logger.debug("-TokenScheduler.syncArcLogs(): Success");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			bRunAyncArcLogs = false;
			logger.debug("-TokenScheduler.syncArcLogs(): Fail");
			e.printStackTrace();
			
		}
	}
	
	//메일 1시 실행
	//사용자, 부서 동기화
	@Scheduled(cron="0 0 1 * * ?")
	@Async("threadPoolTaskExecutor")
	public void syncUserDept() {
		logger.debug("###########################");
		logger.debug("TokenScheduler.syncUserDept()");
		logger.debug("###########################");
		try {
			batchService.syncDongwonDept();
			batchService.syncDongwonUser();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
