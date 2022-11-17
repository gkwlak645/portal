/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 3.         LSH
 */
package kr.co.rpaplatform.dongwon.menu.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.rpaplatform.dongwon.menu.vo.MenuVO;


/**
 * 메뉴 DAO
 * @author LSH
 * 2020. 6. 3.
 */
@Repository
public class MenuDAO {
	
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	/**
	 * 전체 메뉴 리스트 조회
	 * @return
	 * @throws Exception
	 */
	public List<MenuVO> selectAllMenuList() throws Exception {
		return sqlSession.selectList("selectAllMenuList");
	}
	
	/**
	 * 좌측 메뉴 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectLeftMenuList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("selectLeftMenuList", map);
	}

	public List<MenuVO> selectMenuList() throws Exception {
		return sqlSession.selectList("selectMenuList");
	}

	public MenuVO selectMenuDetail(MenuVO vo) throws Exception {
		return sqlSession.selectOne("selectMenuDetail",vo);
	}

	public int selectMenuMaxOrdr(MenuVO vo) throws Exception {
		return sqlSession.selectOne("selectMenuMaxOrdr",vo);
	}

	public void updateMenu(MenuVO vo) throws Exception {
		sqlSession.update("updateMenu",vo);
	}

	public void insertMenu(MenuVO vo) throws Exception {
		sqlSession.insert("insertMenu",vo);
	}

	public void deleteMenu(MenuVO vo) throws Exception {
		sqlSession.delete("deleteMenu",vo);
	}

	public void updateUseAtMenu(MenuVO vo) throws Exception {
		sqlSession.update("updateUseAtMenu",vo);
	}

	public void updateOrdrMenu(MenuVO vo) throws Exception {
		sqlSession.update("updateOrdrMenu",vo);
	}

	public List<MenuVO> selectChildMenuCd(MenuVO vo) throws Exception {
		return sqlSession.selectList("selectChildMenuCd",vo);
	}

	/**
	 * 현재 메뉴 URL 경로 조회
	 * @param urlPath
	 * @return
	 * @throws Exception
	 */
	public String selectCurrentMenuPath(String urlPath) throws Exception {
		return sqlSession.selectOne("selectCurrentMenuPath", urlPath);
	}
	
	/**
	 * 메뉴경로상의 메뉴코드 리스트 조회
	 * @param urlPath
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectPathMenuCdList(String urlPath) throws Exception {
		return sqlSession.selectList("selectPathMenuCdList", urlPath);
	}

	/**
	 * 메뉴(커뮤니티) 업데이트
	 * @param urlPath
	 * @return
	 * @throws Exception
	 */
	public void updateCmmnty(MenuVO vo) throws Exception {
		sqlSession.update("updateCmmnty",vo);
	}

	/**
	 * 메뉴코드 가져오기
	 * @param urlPath
	 * @return
	 * @throws Exception
	 */
	public String selectMenuCd(String boardCd) throws Exception {
		return sqlSession.selectOne("selectMenuCd",boardCd);
	}

	/**
	 * 메뉴 자식노드 가져오기
	 * @param urlPath
	 * @return
	 * @throws Exception
	 */
	public List<String> selectMenuChildren(String upmenuCd) throws Exception {
		return sqlSession.selectList("selectMenuChildren",upmenuCd);
	}
	
	public int selectCmmntyMenuCd() throws Exception{
		return sqlSession.selectOne("selectCmmntyMenuCd");
	}
	
	public String selectMenuBoardNo(MenuVO vo) throws Exception{
		return sqlSession.selectOne("selectMenuBoardNo", vo);
	}
}
