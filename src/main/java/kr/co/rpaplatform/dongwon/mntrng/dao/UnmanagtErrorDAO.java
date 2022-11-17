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
public class UnmanagtErrorDAO {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(UnmanagtErrorDAO.class);
	
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	public int getUnmanagtErrorCount(Map<String, Object> map) {
		return sqlSession.selectOne("getUnmanagtErrorCount", map);
	}
	
	public List<Map<String, Object>> selectUnmanagtErrorList(Map<String, Object> map) {
		return sqlSession.selectList("selectUnmanagtErrorList", map);
	}
	
	public void saveUnmanagtErrorData(Map<String, Object> map) {
		 sqlSession.insert("saveUnmanagtErrorData", map);
	}	
	
	public Map<String, Object> getManagtErrorDetail(Map<String, Object> map) {
		return sqlSession.selectOne("getManagtErrorDetail", map);
	}

	public void updateUnmanagtError(Map<String, Object> map) {
		 sqlSession.update("updateUnmanagtError", map);
	}
	


}
