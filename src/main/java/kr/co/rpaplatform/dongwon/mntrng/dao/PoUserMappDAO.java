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
 * @author 
 *
 */
@Repository
public class PoUserMappDAO {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(PoUserMappDAO.class);
	
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	/**
	 * 작업 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getPoUserMappList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("PoUserMappMapper.getPoUserMappList", map);
	}
	
	/**
	 * 작업 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int getPoUserMappCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("PoUserMappMapper.getPoUserMappCount", map);
	}
	
	/**
	 * ORC 릴리즈 데이터 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getOrcReleaseList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("PoUserMappMapper.getOrcReleaseList", map);
	}
	
	/**
	 * ORC 릴리즈 데이터 조회 For 개발 서버
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getOrcReleaseListForDevServer(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("PoUserMappMapper.getOrcReleaseListForDevServer", map);
	}
	
	
	
	/**
	 * 파워유저 프로세스 매핑정보 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertMappInfo(Map<String, Object> map) throws Exception {
		sqlSession.insert("PoUserMappMapper.insertMappInfo", map);
	}
	
	/**
	 * 파워유저 프로세스 매핑정보 등록 For 개발 서버
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertMappInfoForDevServer(Map<String, Object> map) throws Exception {
		sqlSession.insert("PoUserMappMapper.insertMappInfoForDevServer", map);
	}
	
	
	
	
	/**
	 * 파워유저 프로세스 매핑정보 삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void deleteMappInfo(Map<String, Object> map) throws Exception {
		sqlSession.update("PoUserMappMapper.deleteMappInfo", map);
	}
	
	/**
	 * 매핑 데이터 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getDevMapperList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("PoUserMappMapper.getDevMapperList", map);
	}
	
	/**
	 * 매핑 데이터 조회 For 개발 서버
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getDevMapperListForDevServer(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("PoUserMappMapper.getDevMapperListForDevServer", map);
	}
	
}
