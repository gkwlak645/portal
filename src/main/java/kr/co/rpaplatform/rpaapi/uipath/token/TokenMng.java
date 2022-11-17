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

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import kr.co.rpaplatform.rpaapi.uipath.account.AccountApi;
import kr.co.rpaplatform.rpaapi.uipath.token.dao.ApiTokenDAO;

/**
 * api 토큰을 관리
 * @author LSH
 * 2020. 6. 9.
 */
@Component
public class TokenMng {
	
	private final Logger logger = LoggerFactory.getLogger(TokenMng.class);
	
	/**
	 * API 토큰 DAO
	 */
	@Resource(name="apiTokenDAO")
	private ApiTokenDAO apiTokenDAO;
	
	
	/**
	 * Account API
	 */
	@Resource(name="accountApi")
	private AccountApi accountApi;
	
	/**
	 * 토큰 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getApiTkn(Map<String, Object> map) throws Exception {
		return apiTokenDAO.selectTknValue(map);
	}

}
