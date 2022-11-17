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
import kr.co.rpaplatform.dongwon.cmmnty.dao.FaqDAO;
import kr.co.rpaplatform.dongwon.cmmnty.dao.NoticeDAO;
import kr.co.rpaplatform.dongwon.cmmnty.vo.BbsAnswerVO;
import kr.co.rpaplatform.dongwon.cmmnty.vo.BbsVO;
import kr.co.rpaplatform.dongwon.cmmnty.vo.FaqVO;
import kr.co.rpaplatform.dongwon.file.service.AtchFileService;
import kr.co.rpaplatform.dongwon.file.vo.AtchFileVO;
import kr.co.rpaplatform.dongwon.cmmnty.service.BbsMngService;


@Service
public class FaqService {

	private final Logger logger = LoggerFactory.getLogger(BbsMngService.class);
	
	@Resource(name="faqDAO")
	private FaqDAO faqDAO;
	
	@Resource(name="atchFileService")
	private AtchFileService atchFileService;
	
	/**
	 * 공지사항 게시글 List
	 * */
	public Map<String,Object> getFaq(FaqVO vo) throws Exception {
		logger.debug("FaqService getFaq started !!!");

		PaginationInfo pageInfo = vo.getPageInfo();
		pageInfo.setTotalRecordCount(faqDAO.selectTotalFaqListCount(vo));
		Map<String,Object> result = new HashMap<>();
		
		result.put("items", faqDAO.selectFaqList(vo));
		result.put("pageInfo", pageInfo);
		
		logger.debug("FaqService getFaq end !!!");
		return result;
	}
	/**
	 * 공지사항 게시글 등록
	 * */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void setFaqBoard(FaqVO vo) throws Exception{
		logger.debug("FaqService setFaqBoard started !!!");
		
		vo.setBoardSn(faqDAO.selectFaqSnCnt(vo));

		faqDAO.insertFaqBoard(vo); 
		
		logger.debug("FaqService setFaqBoard end !!!");
	}
	
	/**
	 * 공지사항 게시글 상세정보 & 조회수
	 * */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public FaqVO getFaqDetail(FaqVO vo) throws Exception{
		logger.debug("FaqService getFaqDetail started !!!");
		logger.debug("FaqService getFaqDetail end !!!");
		return faqDAO.selectBoardDetail(vo);
	}
	
	/**
	 * 공지사항 게시글 수정
	 * */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updtFaqDetail(FaqVO vo) throws Exception{
		logger.debug("FaqService updtFaqDetail started !!!");
		logger.debug("FaqService updtFaqDetail end !!!");
		faqDAO.updateFaqBoard(vo);
	}
	
	/**
	 * 공지사항 게시글 삭제
	 * */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public List<AtchFileVO> deleteFaqDetail(FaqVO vo) throws Exception{
		
		logger.debug("FaqService deleteFaqDetail started !!!");
		
		faqDAO.deleteFaqBoard(vo);
		
		List<AtchFileVO> deleteFile = atchFileService.deleteFile(vo.getFileGrpNo());
		
		logger.debug("FaqService deleteFaqDetail end !!!");
		
		return deleteFile;
	}

}
