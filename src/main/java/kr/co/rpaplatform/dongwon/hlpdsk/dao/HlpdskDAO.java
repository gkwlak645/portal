package kr.co.rpaplatform.dongwon.hlpdsk.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.co.rpaplatform.dongwon.cmmnty.vo.BbsMngVO;
import kr.co.rpaplatform.dongwon.hlpdsk.vo.HlpdskVO;

@Repository
public class HlpdskDAO {

	private final Logger logger = LoggerFactory.getLogger(HlpdskDAO.class);
	
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	public int selectTotalHlpdskListCount(HlpdskVO vo) throws Exception{
		return sqlSession.selectOne("selectTotalHlpdskListCount", vo);
	}
	
	public List<Map<String, Object>> selectNoticeList(HlpdskVO vo) throws Exception{
		return sqlSession.selectList("selectHlpdskList", vo);
	}

	public void createHlpdsk(HlpdskVO vo) throws Exception{
		 sqlSession.insert("insertHlpdsk", vo);		
	}

	public HlpdskVO detailHlpdsk(HlpdskVO vo) throws Exception{
		return sqlSession.selectOne("detailHlpdsk", vo);
	}

	public void deleteHlpdsk(HlpdskVO vo) {
		sqlSession.delete("deleteHlpdsk", vo);	
	}

	public void updateHlpdsk(HlpdskVO vo) {
		sqlSession.update("updateHlpdsk", vo);
	}
	
	// ----------------- 처리요청 끝 --------------- //
	
	public int getReceiptListCount(HlpdskVO vo) throws Exception{
		return sqlSession.selectOne("getReceiptListCount", vo);
	}

	public List<Map<String, Object>> getReceiptList(HlpdskVO vo) {
		return sqlSession.selectList("getReceiptList", vo);
	}

	public List<HlpdskVO> detailReceip(HlpdskVO vo) {
		return sqlSession.selectList("detailReceip", vo);
	}

	public void updatereceipt(HlpdskVO vo) {
		sqlSession.update("updateReceip", vo);
	}
	
	public List<Map<String, Object>> selectSendTrgetList() throws Exception{
		return sqlSession.selectList("HlpdskMapper.selectSendTrgetList");
	}
	
	
	public Map<String, Object> selectRequstSnSj(HlpdskVO vo) {
		return sqlSession.selectOne("HlpdskMapper.selectRequstSnSj", vo);
	}
}
