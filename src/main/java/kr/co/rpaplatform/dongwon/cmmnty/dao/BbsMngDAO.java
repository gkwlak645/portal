package kr.co.rpaplatform.dongwon.cmmnty.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.co.rpaplatform.dongwon.cmmnty.vo.BbsMngVO;
import kr.co.rpaplatform.dongwon.cmmnty.vo.BbsVO;

@Repository
public class BbsMngDAO {
	private final Logger logger = LoggerFactory.getLogger(BbsMngDAO.class);
	
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	public List<BbsMngVO> selectBoardManageList(BbsMngVO vo) throws Exception {
		return sqlSession.selectList("selectBoardManageList",vo);
	}

	public List<BbsMngVO> selectBoardType(BbsMngVO vo) throws Exception {
		return sqlSession.selectList("selectBoardType", vo);
	}

	/*public BbsMngVO selectBoardManageDetail(BbsMngVO vo) throws Exception {
		return sqlSession.selectOne("selectBoardManageDetail",vo);
	}*/

	public void insertBoardManage(BbsMngVO vo) throws Exception {
		sqlSession.insert("insertBoardManage",vo);
	}

	/*public String selectBoardUrl(BbsMngVO vo) throws Exception {
		return sqlSession.selectOne("selectBoardUrl", vo);
	}*/

	public void updateBoardManage(BbsMngVO vo) throws Exception {
		sqlSession.update("updateBoardManage", vo);
	}

	public void deleteBoardManage(BbsMngVO vo) throws Exception {
		sqlSession.delete("deleteBoardManage", vo);		
	}

	public int selectTotalMngCount(BbsMngVO vo) throws Exception{
		int totalCnt = sqlSession.selectOne("selectTotalMngCount",vo);
		return totalCnt;
	}

	public BbsMngVO selectBoardTypeProperty(BbsMngVO vo)throws Exception {		
		return sqlSession.selectOne("selectBoardTypeProperty", vo);
	}

	public List<BbsMngVO> getProperty(BbsMngVO vo)throws Exception {		
		return sqlSession.selectList("getProperty", vo);
	}
	
	public int selectCountBoardNo()throws Exception{
		return sqlSession.selectOne("selectCountBoardNo");
	}	
	
	public String selectBoardMenuCd(BbsMngVO vo) throws Exception{
		return sqlSession.selectOne("selectBoardMenuCd", vo);
	}
}
