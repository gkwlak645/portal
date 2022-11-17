/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 7. 14.         LSH        최초 작성
 */
package kr.co.rpaplatform.dongwon.stats.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

/**
 * 통계 DAO
 * @author LSH
 */
@Repository
public class ExecutStatsDAO {
	
	private final Logger logger = LoggerFactory.getLogger(ExecutStatsDAO.class);
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	

	
	/**
	 * 프로세스별실행현황  월별 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectProcessRunStsList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("ExecutStatsMapper.selectProcessRunStsList", map);
	}
	
	/**
	 * 프로세스별실행현황  월 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectMonthPerDayCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("ExecutStatsMapper.selectMonthPerDayCount", map);
	}
	
	/**
	 * 프로세스별실행현황  일별 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectProcessMonthList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("ExecutStatsMapper.selectProcessMonthList", map);
	}
	
	/**
	 * 로봇별실행현황  월별 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectRobotRunYearStsList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("ExecutStatsMapper.selectRobotRunYearStsList", map);
	}
	
	/**
	 * 로봇별실행현황  일별 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectRobotRunMonthStsList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("ExecutStatsMapper.selectRobotRunMonthStsList", map);
	}
	
	/**
	 * 인원 및 봇수 현황 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectNpRobotStatusList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("ExecutStatsMapper.selectNpRobotStatusList", map);
	}
	
	/**
	 * ROLE_CD 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectRoleCdCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("ExecutStatsMapper.selectRoleCdCount", map);
	}
	
	/**
	 * 계획대비실적 리스트 조회 (당월)
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectPlanAgainstPerforStatusList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("ExecutStatsMapper.selectPlanAgainstPerforStatusList", map);
	}
	
	/**
	 * 계획대비실적 리스트 조회 (누적)
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectPlanAgainstPerforStatusTwoList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("ExecutStatsMapper.selectPlanAgainstPerforStatusTwoList", map);
	}
	
	/**
	 * 프로세스 운영 현황 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectPreocessOperStatusList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("ExecutStatsMapper.selectPreocessOperStatusList", map);
	}
	
	/**
	 * 프로세스 운영 현황 합계 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectPreocessOperStatusTotList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("ExecutStatsMapper.selectPreocessOperStatusTotList", map);
	}
	
	/**
	 * 프로세스 운영 현황 차트 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectPreocessOperStatusChart(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("ExecutStatsMapper.selectPreocessOperStatusChart", map);
	}
	
	/**
	 * 프로세스별실행현황  일별 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectProcessMonthListV2(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("ExecutStatsMapper.selectProcessMonthListV2", map);
	}
	
	/**
	 * 프로세스별실행현황  월별 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectProcessRunStsListV2(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("ExecutStatsMapper.selectProcessRunStsListV2", map);
	}
	
	/**
	 * 로봇별실행현황  월별 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectRobotRunYearStsListV2(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("ExecutStatsMapper.selectRobotRunYearStsListV2", map);
	}
	
	/**
	 * 로봇별실행현황  일별 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectRobotRunMonthStsListV2(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("ExecutStatsMapper.selectRobotRunMonthStsListV2", map);
	}
	
	/**
	 * 과제별실행현황  월별 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectTaskRunYearStsListV2(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("ExecutStatsMapper.selectTaskRunYearStsListV2", map);
	}
	
	/**
	 * 과제별실행현황  일별 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectTaskRunMonthStsListV2(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("ExecutStatsMapper.selectTaskRunMonthStsListV2", map);
	}
}
