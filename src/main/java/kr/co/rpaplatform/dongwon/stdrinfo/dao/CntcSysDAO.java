package kr.co.rpaplatform.dongwon.stdrinfo.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;


import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.co.rpaplatform.dongwon.stdrinfo.vo.CntcSysVO;

/**
 * CntcSysDAO 
 * @author jyj
 * 20.09.09
 */

@Repository
public class CntcSysDAO {
	
	
	private final Logger logger = LoggerFactory.getLogger(CntcSysDAO.class);

	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	/**
	 * 코드 중복체크
	 * @param 
	 * @return
	 * @throws Exception
	 */
	public int chkCntcSysCd(Map<String, Object> map) throws Exception {
		return this.sqlSession.selectOne("CntcSysMapper.chkCntcSysCd", map);
	}

	
	/**
	 * 연계시스템 삽입
	 * @param 
	 * @return
	 * @throws Exception
	 */
	public void insertCntc(Map<String, Object> map) throws Exception {
		
		logger.debug("CntcSysDAO insertCntc start!!!!!!");		
		this.sqlSession.insert("insertCntc", map);		
		logger.debug("CntcSysDAO insertCntc end!!!!!!");
	}

	/**
	 * 연계시스템 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getCntcSysList(Map<String, Object> map) throws Exception {
		
		return sqlSession.selectList("getCntcSysList", map);
	}

	/**
	 * 연계시스템 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectCntcCount(Map<String, Object> map) throws Exception {
		
		return sqlSession.selectOne("selectCntcCount",map);
	}

	/**
	 * 연계시스템 상세화면 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public CntcSysVO cntcDetailSelectPage(CntcSysVO vo) throws Exception{
		
        logger.debug("CntcSysDAO cntcDetailSelectPage start!!!!!!");		
		logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Dao에 vo 넘어온 값 : " + vo);
		logger.debug("CntcSysDAO cntcDetailSelectPage end!!!!!!");
		return sqlSession.selectOne("selectCntcDetail", vo); 
	}

	/**
	 * 연계시스템 수정
	 * @param 
	 * @return
	 * @throws Exception
	 */
	public void updateCntc(Map<String, Object> map) throws Exception{
		
        logger.debug("CntcSysDAO updateCntc start!!!!!!");		
		this.sqlSession.update("updateCntc", map);		
		logger.debug("CntcSysDAO updateCntc end!!!!!!");
		
	}

	/**
	 * 연계시스템 삭제
	 * @param 
	 * @return
	 * @throws Exception
	 */
	public void cntcDelete(Map<String, Object> map) throws Exception {
		logger.debug("CntcSysDAO cntcDelete start!!!!!!");		
	    this.sqlSession.delete("cntcDelete", map);		
		logger.debug("CntcSysDAO cntcDelete end!!!!!!");
		
	}
	/**
	 * 연계시스템 자동채번
	 * @param 
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> autoNumSelect(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("autoNumSelect", map);
	}
	
	
	
	
}
