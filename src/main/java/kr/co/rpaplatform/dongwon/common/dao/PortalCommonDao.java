package kr.co.rpaplatform.dongwon.common.dao;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

@Repository
public class PortalCommonDao {
	private final Logger logger = LoggerFactory.getLogger(PortalCommonDao.class);
	
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	public String getTenantId(String cmpnyCd) throws Exception{
		return sqlSession.selectOne("PortalCommonMapper.getTenantId", cmpnyCd);
		//return sqlSession.selectOne("loginCheck", cmpnyCd);
	}
}
