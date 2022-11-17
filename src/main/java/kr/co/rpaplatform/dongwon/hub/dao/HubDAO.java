package kr.co.rpaplatform.dongwon.hub.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.co.rpaplatform.dongwon.hub.vo.HubVO;

@Repository
public class HubDAO {
	private final Logger logger = LoggerFactory.getLogger(HubDAO.class);
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	
	public List<Map<String, Object>> selectHubList(Map<String, Object> map) {
		logger.debug("HubDAO 시작");
		List<Map<String, Object>> list = sqlSession.selectList("selectHubList",map);
		logger.debug(list.get(0).toString());
		return sqlSession.selectList("selectHubList",map);
	}
	
	public List<Map<String, Object>> selectHub_1List(Map<String, Object> map) {
		logger.debug("HubDAO 시작");
		List<Map<String, Object>> list = sqlSession.selectList("selectHub_1List",map);
		logger.debug(list.get(0).toString());
		return sqlSession.selectList("selectHub_1List",map);
	}
	
}
