package kr.co.rpaplatform.dongwon.resrce.dao;


import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.co.rpaplatform.dongwon.resrce.vo.LicenseVO;

/**
 * 라이선스 DAO
 * @author JYJ
 * 2020. 8. 26.
 */

@Repository
public class LicenseDAO {

	
	private final Logger logger = LoggerFactory.getLogger(LicenseDAO.class);
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	
	
	
	public LicenseVO getLicenseInfo(LicenseVO vo) throws Exception {
		logger.debug("LicenseDAO getLicenseInfo start!!!!!!");
		logger.debug("getLicenseInfo@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Dao에 vo 넘어온 값 : " + vo);
		logger.debug("LicenseDAO getLicenseInfo end!!!!!!");		
		return sqlSession.selectOne("getLicenseInfo", vo);
	} 
	
	
	
	
}
