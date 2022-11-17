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
public class ExcResHistDAO {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(ExcResHistDAO.class);
	
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
	public List<Map<String, Object>> selectExcResList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("ExcResHistMapper.selectExcResList", map);
	}
	
	/**
	 * 작업 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectExcResCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("ExcResHistMapper.selectExcResCount", map);
	}
	
	/**
	 * 재실행 정보 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectReExcInfo(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("ExcResHistMapper.selectReExcInfo", map);
	}
	
	/**
	 * 프로세스 운영 Attended 입력
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertTaskAttendedReserve(Map<String, Object> map) throws Exception {
		sqlSession.insert("ExcResHistMapper.insertTaskAttendedReserve", map);
	}
	
	/**
	 * 프로세스 JOB SEND History 입력
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertTaskSendHistory(Map<String, Object> map) throws Exception {
		sqlSession.insert("ExcResHistMapper.insertTaskSendHistory", map);
	}
	
	/**
	 * 프로세스 JOB SEND History 입력
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertReExcInfo(Map<String, Object> map) throws Exception {
		sqlSession.insert("ExcResHistMapper.insertReExcInfo", map);
	}
	
	/**
	 * UR 원본정보 변경
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateOriginalAt(Map<String, Object> map) throws Exception {
		sqlSession.update("ExcResHistMapper.updateOriginalAt", map);
	}
	
	/**
	 * 작업 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectResHistList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("ExcResHistMapper.selectResHistList", map);
	}
	
	/**
	 * 작업 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectResHistCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("ExcResHistMapper.selectResHistCount", map);
	}
	
	/**
	 * 재실행 대상 여부 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectTrgetAt(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("ExcResHistMapper.selectTrgetAt", map);
	}
	
	/**
	 * UR 과제 실행중 여부 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectURJobExcAt(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("ExcResHistMapper.selectURJobExcAt", map);
	}
	
	/**
	 * AR 과제 실행중 여부 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectARJobExcAt(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("ExcResHistMapper.selectARJobExcAt", map);
	}
}
