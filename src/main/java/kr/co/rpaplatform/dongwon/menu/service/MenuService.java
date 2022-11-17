/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 3.         LSH
 */
package kr.co.rpaplatform.dongwon.menu.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.rpaplatform.dongwon.author.service.AuthorService;
import kr.co.rpaplatform.dongwon.cmmnty.service.BbsMngService;
import kr.co.rpaplatform.dongwon.cmmnty.vo.BbsMngVO;
import kr.co.rpaplatform.dongwon.menu.dao.MenuDAO;
import kr.co.rpaplatform.dongwon.menu.vo.MenuVO;


/**
 * 메뉴 서비스 클래스
 * @author LSH
 * 2020. 6. 3.
 */
@Service
public class MenuService {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(MenuService.class);
	
	/**
	 * 메뉴 DAO
	 */
	@Resource(name="menuDAO")
	private MenuDAO menuDAO;
	
	@Resource(name="authorService")
	private AuthorService authorService;
	
	@Resource(name="bbsMngService")
	private BbsMngService bbsMngService;
	/**
	 * 전체 메뉴 리스트 조회
	 * @return
	 * @throws Exception
	 */
	public List<MenuVO> getAllMenuList() throws Exception {
		return menuDAO.selectAllMenuList();
	}
	
	/**
	 * 좌측 메뉴 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getLeftMenuList(Map<String, Object> map) throws Exception {
		return menuDAO.selectLeftMenuList(map);
	}

	public List<MenuVO> selectMenuList() throws Exception {
		logger.debug("MenuService selectMenuList started !!!");
		
		List<MenuVO> menuList = menuDAO.selectMenuList();
		
		logger.debug("MenuService selectMenuList end !!!");
		return menuList;
	}

	public Map<String, Object> selectMenuDetail(MenuVO vo) throws Exception {
		logger.debug("MenuService selectMenuDetail started !!!");
		
		Map<String, Object> result = new HashMap<>();
		result.put("item", menuDAO.selectMenuDetail(vo));
		result.put("ordr", menuDAO.selectMenuMaxOrdr(vo));
		
		logger.debug("MenuService selectMenuDetail end !!!");
		return result;
	}

	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateMenu(MenuVO vo) throws Exception {
		logger.debug("MenuService updateMenu started !!!");
		
		if(menuDAO.selectMenuDetail(vo) != null) {
			menuDAO.updateMenu(vo);
			
			BbsMngVO voB = new BbsMngVO(); 
			String boardNo=menuDAO.selectMenuBoardNo(vo);
	        voB.setBoardNo(boardNo);
	        voB.setBoardNm(vo.getMenuNm());
	        voB.setBoardUrl(vo.getMenuUrl());
	        voB.setBoardDc(vo.getMenuDc());
	        voB.setUseAt(vo.getUseAt());
			bbsMngService.updateBoardManage(voB);
			
			if(vo.getUseAt().equals("N")) {
				childrenUseAtUpdate(vo);
			}
		}else {
			menuDAO.insertMenu(vo);
		}
		
		logger.debug("MenuService updateMenu end !!!");
	}
	
	/**
	 * 게시판 관리에서 수정 할 시 
	 * */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateMenuCmmnty(MenuVO vo) throws Exception {
		logger.debug("MenuService updateMenuCmmnty started !!!");
		
			menuDAO.updateMenu(vo);
		
		logger.debug("MenuService updateMenuCmmnty end !!!");
	}

	/**
	 * 메뉴 관리에서 삭제 시
	 * */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void deleteMenu(MenuVO vo) throws Exception {
		logger.debug("MenuService deleteMenu started !!!");
		
		String boardNo=menuDAO.selectMenuBoardNo(vo);
		System.out.println("@@@@@@@@@@@"+boardNo);
		BbsMngVO voB = new BbsMngVO();
		voB.setBoardNo(boardNo);
		System.out.println("@@@@@@@@@@@"+voB);
		bbsMngService.deleteBoardManageMenu(voB);
		
		menuDAO.deleteMenu(vo);
		authorService.deleteAuth(vo);
		childrenDelete(vo);
		
		logger.debug("MenuService deleteMenu end !!!");
	}

	/**
	 * 커뮤니티 게시판 관리에서 삭제
	 * */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void deleteMenuCmmnty(MenuVO vo) throws Exception {
		logger.debug("MenuService deleteMenuCmmnty started !!!");
		
		menuDAO.deleteMenu(vo);
		authorService.deleteAuth(vo);

		logger.debug("MenuService deleteMenuCmmnty end !!!");
	}
	
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateOrdrMenu(MenuVO vo) throws Exception {
		logger.debug("MenuService updateOrdrMenu started !!!");
		
		menuDAO.updateOrdrMenu(vo);
		
		logger.debug("MenuService updateOrdrMenu end !!!");
	}

	/**
	 * 현재 메뉴의 사용여부를 N으로 변경했을 떄 하위 메뉴도 전부 변경하는 재귀함수
	 * @param vo
	 * @throws Exception
	 */
	public void childrenUseAtUpdate(MenuVO vo) throws Exception {
		List<MenuVO> childList = menuDAO.selectChildMenuCd(vo);
		
		if(childList != null) {
			for(MenuVO i : childList) {
				vo.setMenuCd(i.getMenuCd());
				menuDAO.updateUseAtMenu(vo);
				childrenUseAtUpdate(vo);
			}
		}
	}
	
	/**
	 * 현재 메뉴를 삭제하였을 떄 하위 메뉴를 전부 삭제하는 재귀함수
	 * @param vo
	 * @throws Exception
	 */
	public void childrenDelete(MenuVO vo) throws Exception {
		List<MenuVO> childList = menuDAO.selectChildMenuCd(vo);
		
		if(childList != null) {
			for(MenuVO i : childList) {
				vo.setMenuCd(i.getMenuCd());
				menuDAO.deleteMenu(vo);
				authorService.deleteAuth(vo);
				childrenDelete(vo);
			}
		}
	}
	
	/**
	 * 현재 메뉴 URL 경로 조회
	 * @param urlPath
	 * @return
	 * @throws Exception
	 */
	public String getCurrentMenuPath(String urlPath) throws Exception {
		return menuDAO.selectCurrentMenuPath(urlPath);
	}
	
	/**
	 * 메뉴경로상의 메뉴코드 리스트 조회
	 * @param urlPath
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getPathMenuCdList(String urlPath) throws Exception {
		return menuDAO.selectPathMenuCdList(urlPath);
	}
	
	/**
	 * 메뉴 추가 
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void insertMenu(MenuVO vo) throws Exception {
		menuDAO.insertMenu(vo);
	}
	
	/**
	 * 다음 정렬값 찾기 
	 * @param upMenuCd
	 * @return
	 * @throws Exception
	 */
	public int selectMenuMaxOrdr(String upMenuCd) throws Exception {
		MenuVO vo = new MenuVO();
		vo.setMenuCd(upMenuCd);
		return menuDAO.selectMenuMaxOrdr(vo);
	}
	
	/**
	 * 메뉴 수정(커뮤니티) 
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateCmmnty(MenuVO vo) throws Exception {
		menuDAO.updateCmmnty(vo);
	}

	/**
	 * 메뉴 코드가져오기 
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public String selectMenuCd(String boardCd) throws Exception {
		return menuDAO.selectMenuCd(boardCd);
	}

	/**
	 * 메뉴 자식노드가져오기 
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List<String> selectMenuChildren(String upmenuCd) throws Exception {
		return menuDAO.selectMenuChildren(upmenuCd);
	}

	/**
	 * 커뮤니티 메뉴 코드가져오기 
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public int selectCmmntyMenuCd() throws Exception{
		return menuDAO.selectCmmntyMenuCd();
	}
}
