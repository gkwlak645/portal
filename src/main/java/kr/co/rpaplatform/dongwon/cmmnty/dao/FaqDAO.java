package kr.co.rpaplatform.dongwon.cmmnty.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.co.rpaplatform.dongwon.cmmnty.vo.BbsVO;
import kr.co.rpaplatform.dongwon.cmmnty.vo.FaqVO;

@Repository
public class FaqDAO {

	private final Logger logger = LoggerFactory.getLogger(BbsMngDAO.class);
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	public List<Map<String, Object>> selectFaqList(FaqVO vo) throws Exception{
		return sqlSession.selectList("selectFaqList", vo);
	}
	
	public int selectTotalFaqListCount(FaqVO vo) throws Exception{
		return sqlSession.selectOne("selectTotalFaqListCount", vo);
	}
	
	
	public int selectFaqSnCnt(FaqVO vo) throws Exception{
		return sqlSession.selectOne("selectFaqSnCnt", vo);
	}
	
	public void insertFaqBoard(FaqVO vo) throws Exception{
		sqlSession.insert("insertFaqBoard", vo);
	}
	
	public FaqVO selectBoardDetail(FaqVO vo) throws Exception{
		return sqlSession.selectOne("selectFaqDetail", vo);
	}
	
	public void updateFaqBoard(FaqVO vo) throws Exception{
		sqlSession.update("updateFaqBoard", vo);
	}
	
	public void deleteFaqBoard(FaqVO vo) throws Exception{
		sqlSession.delete("deleteFaqBoard", vo);
	}
	/*public List<Map<String, Object>> selectNoticeList(BbsVO vo) throws Exception{
		return sqlSession.selectList("selectNoticeList", vo);
	}*/
	
}
