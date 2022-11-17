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
public class PoUserHistMngDAO {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(PoUserHistMngDAO.class);
	
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
	public List<Map<String, Object>> getPoUserHistMngList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("PoUserHistMngMapper.getPoUserHistMngList", map);
	}
	
	/**
	 * 작업 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int getPoUserHistMngCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("PoUserHistMngMapper.getPoUserHistMngCount", map);
	}
	
	/**
	 * 이력 관리 디테일 데이터 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getDetailMappData(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("PoUserHistMngMapper.getDetailMappData", map);
	}
	
	/**
	 * 이력 관리 정보 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertRetryInfo(Map<String, Object> map) throws Exception {
		sqlSession.insert("PoUserHistMngMapper.insertRetryInfo", map);
	}
	
	/**
	 * 이력관리, 원본 데이터 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateTargetInfo(Map<String, Object> map) throws Exception {
		sqlSession.update("PoUserHistMngMapper.updateTargetInfo", map);
	}
	
	/**
	 * 이력관리, 재시도 데이터 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateOriginalInfo(Map<String, Object> map) throws Exception {
		sqlSession.update("PoUserHistMngMapper.updateOriginalInfo", map);
	}
	
	/**
	 * 삭제 여부 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void deleteRetryInfo(Map<String, Object> map) throws Exception {
		sqlSession.delete("PoUserHistMngMapper.deleteRetryInfo", map);
	}
	
	/**
	 * 이력관리 삭제 시 재실행데이터 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateJobInfo(Map<String, Object> map) throws Exception {
		sqlSession.update("PoUserHistMngMapper.updateJobInfo", map);
	}
	
	/**
	 * 이력관리 삭제 시 Target데이터 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateTargetJobInfo(Map<String, Object> map) throws Exception {
		sqlSession.update("PoUserHistMngMapper.updateTargetJobInfo", map);
	}
	
	/**
	 * 매핑된 상세데이터 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getPoUserHistDetailList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("PoUserHistMngMapper.getPoUserHistDetailList", map);
	}
}
