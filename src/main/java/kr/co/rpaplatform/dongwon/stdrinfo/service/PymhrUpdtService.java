package kr.co.rpaplatform.dongwon.stdrinfo.service;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.rpaplatform.dongwon.stdrinfo.dao.PymhrUpdtDAO;
import kr.co.rpaplatform.dongwon.stdrinfo.vo.PymhrUpdtVO;

@Service
public class PymhrUpdtService {
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(PymhrUpdtService.class);
	
	@Resource(name="pymhrUpdtDAO")
	private PymhrUpdtDAO pymhrUpdtDAO;
	
	/**
	 * 임율관리 조회
	 * 
	 */
	public List<PymhrUpdtVO> getPymhrList() throws Exception {
		logger.debug("PymhrUpdtService getPymhrList started !!!");
		
		logger.debug("PymhrUpdtService getPymhrList end !!!");
		
		return pymhrUpdtDAO.selectPymhrList();
	}
	
	/**
	 * 임율관리 수정
	 * 
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updtPymhrList(PymhrUpdtVO vo) throws Exception{
		logger.debug("PymhrUpdtService updtPymhrList started !!!");
		
		int num = pymhrUpdtDAO.selectPymhrCount(vo);
		
		if(num > 0) {
			pymhrUpdtDAO.updtPymhrList(vo);
		}else {
			pymhrUpdtDAO.insertPymhr(vo);
		}
		
		logger.debug("PymhrUpdtService updtPymhrList end !!!");
	}
	
	/**
	 * 임율관리 삭제
	 * 
	 */
	public void deletePymhr(PymhrUpdtVO vo) throws Exception {
		logger.debug("PymhrUpdtService deletePymhr started !!!");
		
		pymhrUpdtDAO.deletePymhr(vo);
		
		logger.debug("PymhrUpdtService deletePymhr end !!!");
	}
	
}
