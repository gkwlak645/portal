/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 2.         LSH
 */
package kr.co.rpaplatform.dongwon.author.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.rpaplatform.dongwon.author.dao.AuthorDAO;
import kr.co.rpaplatform.dongwon.author.vo.AuthorVO;
import kr.co.rpaplatform.dongwon.author.vo.RoleMngVO;
import kr.co.rpaplatform.dongwon.menu.vo.MenuVO;

/**
 * 권한 서비스 클래스
 * @author LSH
 * 2020. 6. 2.
 */
@Service
public class AuthorService {
	
	private final Logger logger = LoggerFactory.getLogger(AuthorService.class);
	
	@Resource(name="authorDAO")
	private AuthorDAO authorDAO;
	
	/**
	 * URL에 따른 사용자 권한 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public AuthorVO getUserAuthorByUrl(String urlPath) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("urlPath", urlPath);
		return authorDAO.selectUserAuthorByUrl(map);
	}

	public List<RoleMngVO> selectRole() throws Exception {
		logger.debug("AuthorService selectRole started !!!");
		
		List<RoleMngVO> selectbox = authorDAO.selectRole();
		
		logger.debug("AuthorService selectRole end !!!");
		return selectbox;
	}

	public AuthorVO selectAuth(AuthorVO vo) throws Exception {
		logger.debug("AuthorService selectAuth started !!!");
		
		AuthorVO selectAuth = authorDAO.selectAuth(vo);
		logger.debug("AuthorService selectAuth end !!!");
		return selectAuth;
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateAuth(AuthorVO vo) throws Exception {
		logger.debug("AuthorService updateAuth started !!!");
		
		if(authorDAO.selectAuth(vo) != null) {
			authorDAO.updateAuth(vo);
		}else {
			authorDAO.insertAuth(vo);
		}
		authorDAO.updateAuthorNm(vo);
		childrenUpdate(vo);
		parentUpdate(vo);
		
		logger.debug("AuthorService updateAuth end !!!");
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void deleteAuth(MenuVO vo) throws Exception {
		logger.debug("AuthorService deleteAuth started !!!");
		
		authorDAO.deleteAuth(vo);
		
		logger.debug("AuthorService deleteAuth end !!!");
	}
	
	/**
	 * 상위부서의 권한이 사라졌을 때 하위부서도 빠지게 하는 재귀함수
	 * @param vo
	 * @throws Exception
	 */
	public void childrenUpdate(AuthorVO vo) throws Exception {
		List<AuthorVO> childList = authorDAO.selectChildAuthorMenuCd(vo);
		
		if(childList != null) {
			for(AuthorVO i : childList) {
				vo.setMenuCd(i.getMenuCd());
				if(authorDAO.selectAuthorCheck(vo) != null) {
					authorDAO.updateDownAuth(vo);
				}
				childrenUpdate(vo);
			}
		}
	}
	
	/**
	 * 현재노드의 권한이 추가됬을 때 상위부서에도 추가하는 재귀함수
	 * @param vo
	 * @throws Exception
	 */
	public void parentUpdate(AuthorVO vo) throws Exception {
		String parentCode = authorDAO.selectParentMenuCd(vo);
		if(parentCode != null) {
			vo.setMenuCd(parentCode);
			
			if(authorDAO.selectAuthorCheck(vo) == null) {
				authorDAO.insertAuth(vo);
			}else {
				authorDAO.updateUpAuth(vo);
			}
			parentUpdate(vo);
		}
	}
	
	public void deleteAuthorRoleCd(AuthorVO vo) throws Exception{
		authorDAO.deleteAuthorRoleCd(vo);
	}
}
