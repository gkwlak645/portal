package kr.co.rpaplatform.dongwon.resrce.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;


/**
 * Asset DAO
 * @author LSH
 */
@Repository
public class QueDAO {
	
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	/**
	 * queue 리스트 조회
	 */
	public List<Map<String, Object>> selectQueList(Map<String, Object> map) {
		return sqlSession.selectList("selectQueList", map);
	}
	
	/**
	 * queue 건수 조회
	 */
	public int selectQueCount(Map<String, Object> map) {
		return sqlSession.selectOne("selectQueCount", map);
	}

	
	/**
	 * queue 조회
	 */
	public Map<String, Object> selectQue(Map<String, Object> map) {
		return sqlSession.selectOne("selectQue", map);
	}

	
	/**
	 * queue의 회사코드 조회
	 */
	public String selectQueCmpny(Map<String, Object> map) {
		return sqlSession.selectOne("selectQueCmpny", map);
	}
	
	
	/**
	 * queue의 회사코드 조회
	 */
	public List<Map<String, Object>> selectRlseList(Map<String, Object> map) {
		return sqlSession.selectList("selectRlseList", map);
	}

	

}
