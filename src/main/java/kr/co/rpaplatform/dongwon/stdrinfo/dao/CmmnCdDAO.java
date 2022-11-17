/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 4.         LSH
 */
package kr.co.rpaplatform.dongwon.stdrinfo.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.rpaplatform.dongwon.stdrinfo.vo.CmmnCdVO;

/**
 * 공통코드 DAO
 * @author LSH
 * 2020. 6. 4.
 */
@Repository
public class CmmnCdDAO {
	
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	/**
	 * 사용 가능한 코드 조회
	 * @param clsCd
	 * @return
	 * @throws Exception
	 */
	public List<CmmnCdVO> selectCmmnCdListByClsCd(String clsCd) throws Exception {
		return sqlSession.selectList("selectCmmnCdListByClsCd", clsCd);
	}

	/**
	 * 분류코드별 코드 조회
	 * @param clsCd
	 * @return
	 * @throws Exception
	 */
	public List<CmmnCdVO>selectCmmnClsCdList(CmmnCdVO vo) throws Exception{
		return sqlSession.selectList("selectCmmnClsCdList",vo);
	}
	
	/**
	 * 코드 조회
	 * @return
	 * @throws Exception
	 */
	public List<CmmnCdVO>selectCmmnCdList(CmmnCdVO vo) throws Exception{
		return sqlSession.selectList("selectCmmnCdList", vo);
	}
	
	/**
	 * 코드 생성
	 * @return
	 * @throws Exception
	 */
	public String getCd(CmmnCdVO vo) throws Exception {
		return sqlSession.selectOne("getCd", vo);
	}

	/**
	 * 코드 등록
	 * @return
	 * @throws Exception
	 */
	public void insertCmmnCd(CmmnCdVO vo) throws Exception {
		 sqlSession.insert("insertCmmnCd", vo);
	}
	
	/**
	 * 코드 수정
	 * @return
	 * @throws Exception
	 */
	public void updateCmmnCd(CmmnCdVO vo) throws Exception{
		sqlSession.update("updateCmmnCd", vo);
	}
	
	/**
	 * 코드 삭제
	 * @return
	 * @throws Exception
	 */
	public void deleteCmmnCd(CmmnCdVO vo) throws Exception {
		sqlSession.delete("deleteCmmnCd", vo);
	}
	
	/**
	 * 분류코드 등록
	 * @return
	 * @throws Exception
	 */
	public void insertCmmnClsCd(CmmnCdVO vo) throws Exception {
		 sqlSession.insert("insertCmmnClsCd", vo);
	}
	
	/**
	 * 분류 코드 수정
	 * @return
	 * @throws Exception
	 */
	public void updateCmmnClsCd(CmmnCdVO vo) throws Exception{
		sqlSession.update("updateCmmnClsCd", vo);
	}
	
	/**
	 * 분류코드 삭제
	 * @return
	 * @throws Exception
	 */
	public void deleteCmmnClsCd(CmmnCdVO vo) throws Exception {
		sqlSession.delete("deleteCmmnClsCd", vo);
	}
	
	/**
	 * 분류코드 속 코드 삭제
	 * @return
	 * @throws Exception
	 */
	public void deleteSecCmmnCd(CmmnCdVO vo) throws Exception {
		sqlSession.delete("deleteSecCmmnCd", vo);
	}
	
	/**
	 * 코드 수정
	 * @return
	 * @throws Exception
	 */
	public void updateCdUseAt(CmmnCdVO vo) throws Exception {
		sqlSession.update("updateCdUseAt", vo);
	}
	
	/**
	 * 코드 업데이트 및 추가를 위한 유무 확인
	 * @return
	 * @throws Exception
	 */
	public int selectCountCmmnCd(CmmnCdVO vo) throws Exception{
		return sqlSession.selectOne("selectCountCmmnCd", vo);
	}
	
	/**
	 * 분류코드  업데이트 및 추가를 위한 유무 확인
	 * @return
	 * @throws Exception
	 */
	public int selectCountCmmnClsCd(CmmnCdVO vo) throws Exception{
		return sqlSession.selectOne("selectCountCmmnClsCd", vo);
	}
}
