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
public class SavingTimeIssueMntrngDAO {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(SavingTimeIssueMntrngDAO.class);
	
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	/**
	 * 절감시간 이슈관리 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSavingTimeIssueList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("SavingTimeIssueMntrngMapper.selectSavingTimeIssueList", map);
	}
	
	/**
	 * 절감시간 이슈관리  카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectSavingTimeIssueListCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("SavingTimeIssueMntrngMapper.selectSavingTimeIssueListCount", map);
	}

	/**
	 * 절감시간 이슈관리  사유 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void insertSavingTimeIssueResn(Map<String, Object> map) throws Exception {
		sqlSession.insert("SavingTimeIssueMntrngMapper.insertSavingTimeIssueResn", map);
	}
	
	/**
	 * 절감시간 이슈관리  사유 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateSavingTimeIssueResn(Map<String, Object> map) throws Exception {
		sqlSession.update("SavingTimeIssueMntrngMapper.updateSavingTimeIssueResn", map);
	}
	
	/**
	 * 절감시간 이슈관리 정상여부 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public void updateSavingTimeIssueNormalAt(Map<String, Object> map) throws Exception {
		sqlSession.update("SavingTimeIssueMntrngMapper.updateSavingTimeIssueNormalAt", map);
	}
	
}
