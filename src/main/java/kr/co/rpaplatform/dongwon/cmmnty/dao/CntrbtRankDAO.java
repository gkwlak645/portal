package kr.co.rpaplatform.dongwon.cmmnty.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

@Repository
public class CntrbtRankDAO {

	private final Logger logger = LoggerFactory.getLogger(BbsMngDAO.class);
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	public int selectCntrbtRankListCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("CntrbtRank.selectCntrbtRankListCount", map);
	}
	
	public List<Map<String, Object>> selectCntrbtRankList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("CntrbtRank.selectCntrbtRankList", map);
	}
	
	public Map<String, Object> getCntrbtRankDetailPopGetData(Map<String, Object> map) throws Exception{
		return sqlSession.selectOne("CntrbtRank.getCntrbtRankDetailPopGetData", map);
	}
	
	public List<Map<String, Object>> getCntrbtRankDetailPopGetData2(Map<String, Object> map) throws Exception{
		return sqlSession.selectList("CntrbtRank.getCntrbtRankDetailPopGetData2", map);
	}
}
