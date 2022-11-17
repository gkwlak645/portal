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

import kr.co.rpaplatform.dongwon.stats.dao.GroupRpaOperDAO;
import kr.co.rpaplatform.dongwon.stats.dao.PreforPlanInputDAO;

/**
 * 그룹RPA운영실적  서비스
 * @author LSH
 */
@Service
public class GroupRpaOperService {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(GroupRpaOperService.class);

	/**
	 * 그룹RPA운영실적  DAO
	 */
	@Resource(name="groupRpaOperDAO")
	private GroupRpaOperDAO groupRpaOperDAO;

	// 그룹RPA운영실적
	public List<Map<String, Object>> getGroupRpaOperList(Map<String, Object> map) {
		return groupRpaOperDAO.getGroupRpaOperList(map);
	}
	
	// (주간 실적)그룹RPA운영실적
	public List<Map<String, Object>> getGroupRpaOperWeekList(Map<String, Object> map) {
		return groupRpaOperDAO.getGroupRpaOperWeekList(map);
	}
	
	/**
	 * 로봇리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectBotListForGroupRpaOper(Map<String, Object> map) throws Exception {
		return groupRpaOperDAO.selectBotListForGroupRpaOper(map);
	}
}