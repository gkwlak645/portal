package kr.co.rpaplatform.dongwon.stats.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

/**
 * 그룹RPA운영실적   DAO
 *
 */
@Repository
public class GroupRpaOperDAO {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(GroupRpaOperDAO.class);
	
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	// 그룹RPA운영실적
	public List<Map<String, Object>> getGroupRpaOperList(Map<String, Object> map) {
		return sqlSession.selectList("getGroupRpaOperList", map);
	}
	
	// (주간 실적)그룹RPA운영실적
	public List<Map<String, Object>> getGroupRpaOperWeekList(Map<String, Object> map) {
		return sqlSession.selectList("getGroupRpaOperWeekList", map);
	}

	/**
	 * 로봇 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectBotListForGroupRpaOper(Map<String, Object> map) {
		return sqlSession.selectList("selectBotListForGroupRpaOper", map);
	}
}
