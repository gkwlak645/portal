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
import kr.co.rpaplatform.dongwon.cmmnty.vo.BbsAnswerVO;
import kr.co.rpaplatform.dongwon.cmmnty.vo.BbsVO;
import kr.co.rpaplatform.dongwon.file.service.AtchFileService;
import kr.co.rpaplatform.dongwon.file.vo.AtchFileVO;
import kr.co.rpaplatform.dongwon.cmmnty.service.BbsMngService;


@Service
public class BbsAnswerService {

	private final Logger logger = LoggerFactory.getLogger(BbsMngService.class);
	
	@Resource(name="bbsAnswerDAO")
	private BbsAnswerDAO bbsAnswerDAO;
	
	@Resource(name="atchFileService")
	private AtchFileService atchFileService;
	
	public Map<String,Object> getBoard(BbsVO vo) throws Exception {
		logger.debug("BbsAnswerService getBoard started !!!");

		PaginationInfo pageInfo = vo.getPageInfo();
		pageInfo.setTotalRecordCount(bbsAnswerDAO.selectTotalBoardCount(vo));
		Map<String,Object> result = new HashMap<>();
		
		result.put("items", bbsAnswerDAO.selectBoardList(vo));
		result.put("pageInfo", pageInfo);
		
		logger.debug("BbsAnswerService getBoard end !!!");
		return result;
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public BbsVO selectBoardDetail(BbsVO vo) throws Exception {
		logger.debug("BbsAnswerService selectBoardDetail started !!!");
		
		bbsAnswerDAO.updateNumOfHitUp(vo);
		BbsVO boardDetail = bbsAnswerDAO.selectBoardDetail(vo);
		
		logger.debug("BbsAnswerService selectBoardDetail end !!!");
		return boardDetail;
	}

	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void insertAnswer(BbsAnswerVO vo) throws Exception {
		logger.debug("BbsAnswerService insertAnswer started !!!");
		
		vo.setAnswerSn(bbsAnswerDAO.selectAnswerNextSn(vo));
		if(vo.getUpAnswerSn() == 0) {
			vo.setUpAnswerSn(vo.getAnswerSn());
		}
		bbsAnswerDAO.insertAnswer(vo);
		
		logger.debug("BbsAnswerService insertAnswer end !!!");
	}

	public Map<String,Object> getAnswers(BbsAnswerVO vo) throws Exception {
		logger.debug("BbsAnswerService getAnswers started !!!");
		
		Map<String,Object> result = new HashMap<>();
		result.put("items", bbsAnswerDAO.selectBoardAnswerList(vo));
		
		logger.debug("BbsAnswerService getAnswers end !!!");
		return result;
	}

	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void deleteAnswer(BbsAnswerVO vo) throws Exception {
		logger.debug("BbsAnswerService deleteAnswer started !!!");
		
		bbsAnswerDAO.deleteAnswer(vo);

		logger.debug("BbsAnswerService deleteAnswer end !!!");
	}

	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void deleteReply(BbsAnswerVO vo) throws Exception {
		logger.debug("BbsAnswerService deleteReply started !!!");
		
		bbsAnswerDAO.deleteReply(vo);

		logger.debug("BbsAnswerService deleteReply end !!!");		
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public List<AtchFileVO> deleteBoard(BbsVO vo) throws Exception {
		logger.debug("BbsAnswerService deleteBoard started !!!");
		
		bbsAnswerDAO.deleteBoard(vo);
		BbsAnswerVO vo2 = new BbsAnswerVO();
		vo2.setBoardNo(vo.getBoardNo());
		vo2.setBoardSn(vo.getBoardSn());
		bbsAnswerDAO.deleteBoardAnswer(vo2);
		List<AtchFileVO> deleteFile = atchFileService.deleteFile(vo.getFileGrpNo());

		logger.debug("BbsAnswerService deleteBoard end !!!");
		
		return deleteFile;
	}
	
	public BbsVO boardAnswerUpdatePop(BbsVO vo) throws Exception {
		logger.debug("BbsAnswerService boardAnswerUpdatePop started !!!");
		
		BbsVO boardValue = bbsAnswerDAO.selectUpdateBoardDetail(vo);

		logger.debug("BbsAnswerService boardAnswerUpdatePop end !!!");	
		return boardValue;
	}

	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateBoard(BbsVO vo) throws Exception {
		logger.debug("BbsAnswerService updateBoard started !!!");
		
		bbsAnswerDAO.updateBoard(vo);

		logger.debug("BbsAnswerService updateBoard end !!!");
	}

	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void insertBoard(BbsVO vo) throws Exception {
		logger.debug("BbsAnswerService insertBoard started !!!");
		
		vo.setBoardSn(bbsAnswerDAO.selectSnCnt(vo));

		bbsAnswerDAO.insertBoard(vo); 

		logger.debug("BbsAnswerService insertBoard end !!!");
	}
	
}
