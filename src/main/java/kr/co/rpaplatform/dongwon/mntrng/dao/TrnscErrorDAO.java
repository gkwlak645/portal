package kr.co.rpaplatform.dongwon.mntrng.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

/**
 * 작업 DAO
 * @author LSH
 *
 */
@Repository
public class TrnscErrorDAO {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(TrnscErrorDAO.class);
	
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	public int getTrnscErrorCount(Map<String, Object> map) {
		return sqlSession.selectOne("getTrnscErrorCount", map);
	}
	
	public List<Map<String, Object>> selectTrnscErrorList(Map<String, Object> map) {
		return sqlSession.selectList("selectTrnscErrorList", map);
	}
	
	public Map<String, Object> getTrnscErrorDetail(Map<String, Object> map) {
		return sqlSession.selectOne("getTrnscErrorDetail", map);
	}

	public void updateTrnscError(Map<String, Object> map) {
		 sqlSession.update("updateTrnscError", map);
	}
	
	public int getOverlapTrnscErrorCount(Map<String, Object> map) {
		return sqlSession.selectOne("getOverlapTrnscErrorCount", map);
	}
	
	public List<Map<String, Object>> selectOverlapTrnscErrorList(Map<String, Object> map) {
		return sqlSession.selectList("selectOverlapTrnscErrorList", map);
	}
	
	public void setOverlapTrnscErrorUnity(Map<String, Object> map) {
		 sqlSession.update("setOverlapTrnscErrorUnity", map);
	}
	
	public void setOverlapTrnscErrorNotUnity(Map<String, Object> map) {
		 sqlSession.update("setOverlapTrnscErrorNotUnity", map);
	}
	
	public int getTbTrnscError2ErrorUnityCount(Map<String, Object> map) {
		return sqlSession.selectOne("getTbTrnscError2ErrorUnityCount", map);
	}
	
	public void setTbTrnscError2ReprsntAt(Map<String, Object> map) {
		 sqlSession.update("setTbTrnscError2ReprsntAt", map);
	}
	
	/**
	 * 로봇 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectBotList(Map<String, Object> map) {
		return sqlSession.selectList("selectBotListTrnscError", map);
	}
}
