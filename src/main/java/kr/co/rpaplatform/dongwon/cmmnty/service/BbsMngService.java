package kr.co.rpaplatform.dongwon.cmmnty.service;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.rpaplatform.dongwon.cmmnty.vo.BbsMngVO;
import kr.co.rpaplatform.dongwon.menu.dao.MenuDAO;
import kr.co.rpaplatform.dongwon.menu.service.MenuService;
import kr.co.rpaplatform.dongwon.menu.vo.MenuVO;
import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.dongwon.cmmnty.dao.BbsMngDAO;


@Service
public class BbsMngService {

	private final Logger logger = LoggerFactory.getLogger(BbsMngService.class);

	@Resource(name="bbsMngDAO")
	private BbsMngDAO bbsMngDAO;
	
	@Resource(name="menuService")
	private MenuService menuService;
	
	public Map<String,Object> getBoardList(BbsMngVO vo) throws Exception {
		logger.debug("BbsMngService getBoardList start!!");
		
		PaginationInfo pageInfo = vo.getPageInfo();
		pageInfo.setTotalRecordCount(bbsMngDAO.selectTotalMngCount(vo));
		Map<String,Object> result = new HashMap<>();
		
		result.put("items", bbsMngDAO.selectBoardManageList(vo));
		result.put("pageInfo", pageInfo);
		
		logger.debug("BbsMngService getBoardList end!!");
		return result;
	}

	public Map<String,Object> getBoardType(BbsMngVO vo) throws Exception {
		logger.debug("BbsMngService getBoardType start!!");
		
		PaginationInfo pageInfo = vo.getPageInfo();
		pageInfo.setTotalRecordCount(bbsMngDAO.selectTotalMngCount(vo));
		Map<String,Object> result = new HashMap<>();
		
		result.put("items", bbsMngDAO.selectBoardType(vo));
		result.put("pageInfo", pageInfo);
		
		logger.debug("BbsMngService getBoardType end!!");
		return result;
	}
	
	public BbsMngVO selectBoardTyproperty(BbsMngVO vo) throws Exception {
		logger.debug("BbsMngService selectBoardTyproperty start!!");
		
		BbsMngVO boardType = bbsMngDAO.selectBoardTypeProperty(vo);
		
		boardType.setBoardNo(Integer.toString(bbsMngDAO.selectCountBoardNo()));
		
		logger.debug("BbsMngService selectBoardTyproperty end!!");
		return boardType;
	}
	
	
	public List<BbsMngVO> getProperty(BbsMngVO vo) throws Exception {
		logger.debug("BbsMngService getProperty start!!");
		
		List<BbsMngVO> boardType = bbsMngDAO.getProperty(vo);
		logger.debug("BbsMngService getProperty end!!");
		return boardType;
	}

	/*public BbsMngVO getBoardDetail(BbsMngVO vo) throws Exception {
		logger.debug("BbsMngService getBoardDetail start!!");
		
		BbsMngVO boardDetail = bbsMngDAO.selectBoardManageDetail(vo);
		
		logger.debug("BbsMngService getBoardDetail end!!");
		return boardDetail;
	}*/
	/**
	 * 게시판 관리에서 등록할 시 
	 * */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void insertBoardManage(BbsMngVO vo) throws Exception {
		logger.debug("BbsMngService insertBoardManage start!!");
		
		bbsMngDAO.insertBoardManage(vo);
		int getMenuCd = menuService.selectCmmntyMenuCd()+1000000;
		
		if(getMenuCd<1100000000) {
			MenuVO voM = new MenuVO();
			voM.setMenuCd(Integer.toString(getMenuCd));
			voM.setMenuNm(vo.getBoardNm());
			voM.setMenuUrl(vo.getBoardUrl());
			voM.setUpMenuCd("1000000000");
			voM.setMenuOrdr(menuService.selectMenuMaxOrdr("1000000000"));
			voM.setMenuDc(vo.getBoardDc());
			voM.setUseAt(vo.getUseAt());
			voM.setRegisterId(vo.getTxUserId());
			voM.setUpdusrId(vo.getTxUserId());
			menuService.insertMenu(voM);
		}
		/*String getMenuCd=Integer.toString(menuService.selectCmmntyMenuCd());
		String setMenuCd=getMenuCd.substring(2, 4)+1;
		System.out.println("!!!!"+getMenuCd);
		System.out.println("@@@@"+setMenuCd);*/
		/*MenuVO voM = new MenuVO();
		menuService.insertMenu(voM);*/
		
		logger.debug("BbsMngService insertBoardManage end!!");
		
	}
	/**
	 * 게시판 관리에서 수정
	 * */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateBoardManage(BbsMngVO vo) throws Exception {
		logger.debug("BbsMngService updateBoardManage start!!");
		
		bbsMngDAO.updateBoardManage(vo);
		
		String menuCd = bbsMngDAO.selectBoardMenuCd(vo);
		MenuVO voM = new MenuVO();
		voM.setMenuCd(menuCd);
		voM.setMenuNm(vo.getBoardNm());
		voM.setMenuDc(vo.getBoardDc());
		voM.setUseAt(vo.getUseAt());
		voM.setTxUserId(vo.getTxUserId());
		menuService.updateCmmnty(voM);
		
		logger.debug("BbsMngService updateBoardManage end!!");
	}

	/**
	 * 메뉴 관리에서 업데이트 할 시
	 * */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateMenuCmmnty(BbsMngVO vo) throws Exception {
		logger.debug("BbsMngService updateBoardManage start!!");
		
		bbsMngDAO.updateBoardManage(vo);
		
		logger.debug("BbsMngService updateBoardManage end!!");
	}
	
	/**
	 * 게시판 관리에서 삭제
	 * */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void deleteBoardManage(BbsMngVO vo) throws Exception {
		logger.debug("BbsMngService deleteBoardManage start!!");
		
		
		MenuVO voM = new MenuVO();
		String menuCd = bbsMngDAO.selectBoardMenuCd(vo);
		voM.setMenuCd(menuCd);
		menuService.deleteMenuCmmnty(voM);
		bbsMngDAO.deleteBoardManage(vo);

		logger.debug("BbsMngService deleteBoardManage end!!");
	}
	
	/**
	 * 메뉴 관리에서 삭제 할 시
	 * */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void deleteBoardManageMenu(BbsMngVO vo) throws Exception {
		logger.debug("BbsMngService deleteBoardManageMenu start!!");
		
		bbsMngDAO.deleteBoardManage(vo);
		
		logger.debug("BbsMngService deleteBoardManageMenu end!!");
	}
}
