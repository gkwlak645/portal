/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 16.         LSH
 */
package kr.co.rpaplatform.dongwon.mntrng.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.co.rpaplatform.dongwon.mntrng.dao.LogDAO;

/**
 * 로그 서비스
 * @author LSH
 * 2020. 6. 16.
 */
@Service
public class LogService {
	
	private final Logger logger = LoggerFactory.getLogger(LogService.class);
	
	/**
	 * 로그 DAO
	 */
	@Resource(name="logDAO")
	private LogDAO logDAO;
	
	/**
	 * 로그 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getLogList(Map<String, Object> map) throws Exception {
		return logDAO.selectLogList(map);
	}
	
	/**
	 * 로그 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int getLogCount(Map<String, Object> map) throws Exception {
		return logDAO.selectLogCount(map);
	}

}
