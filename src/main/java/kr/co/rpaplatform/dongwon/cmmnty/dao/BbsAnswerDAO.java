package kr.co.rpaplatform.dongwon.cmmnty.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.co.rpaplatform.dongwon.cmmnty.vo.BbsAnswerVO;
import kr.co.rpaplatform.dongwon.cmmnty.vo.BbsVO;
import kr.co.rpaplatform.dongwon.cmmnty.dao.BbsMngDAO;

@Repository
public class BbsAnswerDAO {

	private final Logger logger = LoggerFactory.getLogger(BbsMngDAO.class);
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	public int selectTotalBoardCount(BbsVO vo) throws Exception {
		int totalCnt = sqlSession.selectOne("selectTotalBoardCount",vo);
		return totalCnt;
	}

	public List<Map<String, Object>> selectBoardList(BbsVO vo) throws Exception {
		return sqlSession.selectList("selectBoardList",vo);
	}

	public void updateNumOfHitUp(BbsVO vo) throws Exception {
		sqlSession.update("updateNumOfHitUp",vo);
	}

	public BbsVO selectBoardDetail(BbsVO vo) throws Exception {
		return sqlSession.selectOne("selectBoardDetail",vo);
	}

	public void insertAnswer(BbsAnswerVO vo) throws Exception {
		sqlSession.insert("insertAnswer",vo);
	}

	public int selectAnswerNextSn(BbsAnswerVO vo) throws Exception {
		return sqlSession.selectOne("selectAnswerNextSn",vo);
	}

	public List<BbsAnswerVO> selectBoardAnswerList(BbsAnswerVO vo) throws Exception {
		return sqlSession.selectList("selectBoardAnswerList",vo);
	}

	public void deleteAnswer(BbsAnswerVO vo) throws Exception {
		sqlSession.delete("deleteAnswer",vo);
	}
	
	public void deleteReply(BbsAnswerVO vo) throws Exception {
		sqlSession.delete("deleteReply",vo);
	}

	public void deleteBoard(BbsVO vo) throws Exception {
		sqlSession.delete("deleteBoard",vo);
	}
	
	public void deleteBoardAnswer(BbsAnswerVO vo) throws Exception {
		sqlSession.delete("deleteBoardAnswer",vo);
	}
	
	public BbsVO selectUpdateBoardDetail(BbsVO vo) throws Exception {
		return sqlSession.selectOne("selectUpdateBoardDetail",vo);
	}

	public void updateBoard(BbsVO vo) throws Exception {
		sqlSession.update("updateBoard",vo);
	}
	
	public int selectSnCnt(BbsVO vo) throws Exception {
		return sqlSession.selectOne("selectSnCnt",vo);
	}

	public void insertBoard(BbsVO vo) throws Exception {
		sqlSession.insert("insertBoard", vo);
	}

}
