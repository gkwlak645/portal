/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 8.         LSH
 */
package kr.co.rpaplatform.dongwon.resrce.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.co.rpaplatform.dongwon.resrce.vo.RobotVO;

/**
 * 로봇 DAO
 * @author LSH
 * 2020. 6. 8.
 */
@Repository
public class TriggerArDAO {

	private final Logger logger = LoggerFactory.getLogger(TriggerArDAO.class);
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	public int getTriggerArListCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("TriggerAr.getTriggerArListCount", map);
	}
	
	
	public List<Map<String, Object>> selectTriggerArList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("TriggerAr.selectTriggerArList", map);
	}
	
	/**
	 * 로봇 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> triggerArInstantSearchReleases(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("TriggerAr.triggerArInstantSearchReleases", map);
	}
	
	public List<Map<String, Object>> triggerArInstantSearchRobot(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("TriggerAr.triggerArInstantSearchRobot", map);
	}
	
	// Trigger AR 수정 팝업창 정보를 얻기 위함
	public List<Map<String, Object>> triggerArSelectInfoForUpdate(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("TriggerAr.triggerArSelectInfoForUpdate", map);
	}	
	
	// 프로세스 코드로 프로세스 조회
	public List<Map<String, Object>> triggerArSelectProcessForUpdate(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("TriggerAr.triggerArSelectProcessForUpdate", map);
	}
	
	
	public void insertInstantStart(Map<String, Object> map) throws Exception {
		sqlSession.insert("TriggerAr.insertInstantStart", map);
	}
	
	public void insertResveStart(Map<String, Object> map) throws Exception {
		sqlSession.insert("TriggerAr.insertResveStart", map);
	}
	
	public String getCompareTime(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("TriggerAr.getCompareTime", map);
	}
	
	
	
	
	
	
	// Not Disable → Disable TB_TEMP_RESRVE_BOT 수정
	public void convertTodisableSchdule(Map<String, Object> map) throws Exception {
		sqlSession.update("TriggerAr.convertTodisableSchdule", map);
	}
	
	// Not Disable → Disable TB_TASK_DEVLOP_PROCESS_SCHDULE 수정
	public void convertTodisableInfo(Map<String, Object> map) throws Exception {
		sqlSession.update("TriggerAr.convertTodisableInfo", map);
	}
	
	// Disable → Not Disable TB_TEMP_RESRVE_BOT 수정
	public void convertToNotdisableSchdule(Map<String, Object> map) throws Exception {
		sqlSession.update("TriggerAr.convertToNotdisableSchdule", map);
	}
	
	// Disable → Not Disable TB_TASK_DEVLOP_PROCESS_SCHDULE 수정
	public void convertToNotdisableInfo(Map<String, Object> map) throws Exception {
		sqlSession.update("TriggerAr.convertToNotdisableInfo", map);
	}
	
	
	
	
	
	
	
	
}
