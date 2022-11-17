package kr.co.rpaplatform.dongwon.mntrng.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

/**
 * Bot별 동작현황 DAO
 * @author 박해선
 *
 */
@Repository
public class BotMntrngDAO {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(BotMntrngDAO.class);
	
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	public int selectCountLoginCmpny(Map<String, Object> map) {
		return sqlSession.selectOne("BotMntrngMapper.selectCountLoginCmpny", map);
	}
	
	public List<Map<String, Object>> selectBotMntrngList(Map<String, Object> map) {
		return sqlSession.selectList("BotMntrngMapper.selectBotMntrngList", map);
	}
	
	public List<Map<String, Object>> selectBotList(Map<String, Object> map) {
		return sqlSession.selectList("BotMntrngMapper.selectBotList", map);
	}
	
	public List<Map<String, Object>> selectTriggerArScheduleList(Map<String, Object> map) {
		return sqlSession.selectList("BotMntrngMapper.selectTriggerArScheduleList", map);
	}
	
	public List<Map<String, Object>> selectTriggerUrScheduleList(Map<String, Object> map) {
		return sqlSession.selectList("BotMntrngMapper.selectTriggerUrScheduleList", map);
	}
}
