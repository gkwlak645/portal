/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 7. 14.         LSH        최초 작성
 */
package kr.co.rpaplatform.dongwon.stats.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.co.rpaplatform.dongwon.stats.dao.ExpectRealProcessDAO;
import kr.co.rpaplatform.dongwon.stats.dao.GroupRpaOperDAO;
import kr.co.rpaplatform.dongwon.stats.dao.PreforPlanInputDAO;

/**
 * 예상실제비교  서비스
 * @author LSH
 */
@Service
public class ExpectRealProcessService {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(ExpectRealProcessService.class);

	/**
	 * 예상실제비교  DAO
	 */
	@Resource(name="expectRealProcessDAO")
	private ExpectRealProcessDAO expectRealProcessDAO;

	public int getExpectRealProcessListCount(Map<String, Object> map) {
		return expectRealProcessDAO.getExpectRealProcessListCount(map);
	}
	
	// 예상실제비교
	public List<Map<String, Object>> getExpectRealProcessList(Map<String, Object> map) {
		return expectRealProcessDAO.getExpectRealProcessList(map);
	}

	/**
	 * 로봇리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectBotListForExpectRealRobot(Map<String, Object> map) throws Exception {
		return expectRealProcessDAO.selectBotListForExpectRealRobot(map);
	}
}