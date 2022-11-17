package kr.co.rpaplatform.dongwon.cmmnty.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.co.rpaplatform.dongwon.cmmnty.vo.BbsVO;

@Repository
public class NoticeDAO {

	private final Logger logger = LoggerFactory.getLogger(BbsMngDAO.class);
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	public int selectTotalNoticeListCount(BbsVO vo) throws Exception{
		return sqlSession.selectOne("selectTotalNoticeListCount", vo);
	}
	
	public List<Map<String, Object>> selectNoticeList(BbsVO vo) throws Exception{
		return sqlSession.selectList("selectNoticeList", vo);
	}
	
}
