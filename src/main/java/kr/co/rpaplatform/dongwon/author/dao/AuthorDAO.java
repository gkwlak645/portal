/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 2.         LSH
 */
package kr.co.rpaplatform.dongwon.author.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.rpaplatform.dongwon.author.vo.AuthorVO;
import kr.co.rpaplatform.dongwon.author.vo.RoleMngVO;
import kr.co.rpaplatform.dongwon.menu.vo.MenuVO;

/**
 * 권한 DAO
 * @author LSH
 * 2020. 6. 2.
 */
@Repository
public class AuthorDAO {
	
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	/**
	 * URL에 따른 사용자 권한 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public AuthorVO selectUserAuthorByUrl(Map<String, Object> map) throws Exception {
		return (AuthorVO)sqlSession.selectOne("selectUserAuthorByUrl", map);
	}
	
	public List<RoleMngVO> selectRole() throws Exception {
		return sqlSession.selectList("selectRole");
	}

	public AuthorVO selectAuth(AuthorVO vo) throws Exception {
		return sqlSession.selectOne("selectAuth",vo);
	}

	public void updateAuth(AuthorVO vo) throws Exception {
		sqlSession.update("updateAuth",vo);
	}

	public void insertAuth(AuthorVO vo) throws Exception {
		sqlSession.insert("insertAuth",vo);
	}
	
	public String selectParentMenuCd(AuthorVO vo) throws Exception {
		return sqlSession.selectOne("selectParentMenuCd",vo);
	}

	public String selectAuthorCheck(AuthorVO vo) throws Exception {
		return sqlSession.selectOne("selectAuthorCheck",vo);
	}

	public void updateUpAuth(AuthorVO vo) throws Exception {
		sqlSession.update("updateUpAuth",vo);
	}

	public List<AuthorVO> selectChildAuthorMenuCd(AuthorVO vo) throws Exception {
		return sqlSession.selectList("selectChildAuthorMenuCd",vo);
	}

	public void updateDownAuth(AuthorVO vo) throws Exception {
		sqlSession.update("updateDownAuth",vo);
	}

	public void deleteAuth(MenuVO vo) throws Exception {
		sqlSession.delete("deleteAuth",vo);
	}
	
	public void deleteAuthorRoleCd(AuthorVO vo) throws Exception{
		sqlSession.delete("deleteAuthorRoleCd", vo);
		}
	
	public void updateAuthorNm(AuthorVO vo) throws Exception{
		sqlSession.update("updateAuthorNm", vo);
	}
	
}
