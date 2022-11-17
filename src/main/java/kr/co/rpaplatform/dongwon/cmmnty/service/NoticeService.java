package kr.co.rpaplatform.dongwon.cmmnty.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.dongwon.cmmnty.dao.BbsAnswerDAO;
import kr.co.rpaplatform.dongwon.cmmnty.dao.NoticeDAO;
import kr.co.rpaplatform.dongwon.cmmnty.vo.BbsAnswerVO;
import kr.co.rpaplatform.dongwon.cmmnty.vo.BbsVO;
import kr.co.rpaplatform.dongwon.file.service.AtchFileService;
import kr.co.rpaplatform.dongwon.file.vo.AtchFileVO;

@Service
public class NoticeService {

	private final Logger logger = LoggerFactory.getLogger(BbsMngService.class);
	
	@Resource(name="noticeDAO")
	private NoticeDAO noticeDAO;
	
	@Resource(name="bbsAnswerDAO")
	private BbsAnswerDAO bbsAnswerDAO;
	
	@Resource(name="atchFileService")
	private AtchFileService atchFileService;
	
	/**
	 * 공지사항 게시글 List
	 * */
	public Map<String,Object> getNotice(BbsVO vo) throws Exception {
		logger.debug("NoticeService getNotice started !!!");

		PaginationInfo pageInfo = vo.getPageInfo();
		pageInfo.setTotalRecordCount(noticeDAO.selectTotalNoticeListCount(vo));
		Map<String,Object> result = new HashMap<>();
		
		result.put("items", noticeDAO.selectNoticeList(vo));
		System.out.println("NoticeSevice getNotice:"+noticeDAO.selectNoticeList(vo));
		result.put("pageInfo", pageInfo);
		
		logger.debug("NoticeService getNotice end !!!");
		return result;
	}
	/**
	 * 공지사항 게시글 등록
	 * */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void setNoticeBoard(BbsVO vo) throws Exception{
		logger.debug("NoticeService setNoticeBoard started !!!");
		
		vo.setBoardSn(bbsAnswerDAO.selectSnCnt(vo));

		bbsAnswerDAO.insertBoard(vo); 
		
		logger.debug("NoticeService setNoticeBoard end !!!");
	}
	
	/**
	 * 공지사항 게시글 상세정보 & 조회수
	 * */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public BbsVO getNoticeDetailNumOfHit(BbsVO vo) throws Exception{
		logger.debug("NoticeService getNoticeDetail started !!!");
		bbsAnswerDAO.updateNumOfHitUp(vo);
		logger.debug("NoticeService getNoticeDetail end !!!");
		return bbsAnswerDAO.selectBoardDetail(vo);
	}
	/**
	 *  공지사항 게시글 상세정보
	 * */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public BbsVO getNoticeDetail(BbsVO vo) throws Exception{
		logger.debug("NoticeService getNoticeDetail started !!!");
		logger.debug("NoticeService getNoticeDetail end !!!");
		return bbsAnswerDAO.selectBoardDetail(vo);
	}
	/**
	 * 공지사항 게시글 수정
	 * */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updtNoticeDetail(BbsVO vo) throws Exception{
		logger.debug("NoticeService updtNoticeDetail started !!!");
		logger.debug("NoticeService updtNoticeDetail end !!!");
		bbsAnswerDAO.updateBoard(vo);
	}
	
	/**
	 * 공지사항 게시글 삭제
	 * */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public List<AtchFileVO> deleteNoticeDetail(BbsVO vo) throws Exception{
		
		logger.debug("NoticeService deleteNoticeDetail started !!!");
		
		bbsAnswerDAO.deleteBoard(vo);
				
		List<AtchFileVO> deleteFile = atchFileService.deleteFile(vo.getFileGrpNo());
		
		logger.debug("NoticeService deleteNoticeDetail end !!!");
		
		return deleteFile;
	}
}
