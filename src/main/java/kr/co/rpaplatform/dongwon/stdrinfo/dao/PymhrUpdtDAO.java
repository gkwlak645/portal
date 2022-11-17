package kr.co.rpaplatform.dongwon.stdrinfo.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.rpaplatform.dongwon.stdrinfo.vo.PymhrUpdtVO;

@Repository
public class PymhrUpdtDAO {

	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	/**
	 * 임율관리 조회
	 */
	public List<PymhrUpdtVO> selectPymhrList() {
		return sqlSession.selectList("selectListPymhr");
	}
	
	/**
	 * 임율관리 유무 확인
	 */
	public int selectPymhrCount(PymhrUpdtVO vo) {
		return sqlSession.selectOne("selectPymhrCount", vo);
	}
	
	/**
	 * 임율관리 업데이트
	 */
	public void updtPymhrList(PymhrUpdtVO vo) {
		sqlSession.update("updtPymhrList", vo);
	}
	
	
	/**
	 * 임율관리 추가
	 */
	public void insertPymhr(PymhrUpdtVO vo) {
		sqlSession.selectOne("insertPymhr", vo);
	}
	
	/**
	 * 임율관리 추가
	 */
	public void deletePymhr(PymhrUpdtVO vo) {
		sqlSession.delete("deletePymhr", vo);
	}
}
