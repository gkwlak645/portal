/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 4.         LSH
 */
package kr.co.rpaplatform.dongwon.stdrinfo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.rpaplatform.dongwon.stdrinfo.dao.CmmnCdDAO;
import kr.co.rpaplatform.dongwon.stdrinfo.vo.CmmnCdVO;

/**
 * 공통코드 서비스
 * @author LSH
 * 2020. 6. 4.
 */
@Service
public class CmmnCdService {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(CmmnCdService.class);
	
	/**
	 * 메뉴 DAO
	 */
	@Resource(name="cmmnCdDAO")
	private CmmnCdDAO cmmnCdDAO;
	
	/**
	 * 사용 가능한 코드 조회
	 * @param clsCd
	 * @return
	 * @throws Exception
	 */
	public List<CmmnCdVO> getCmmnCdListByClsCd(String clsCd) throws Exception {
		return cmmnCdDAO.selectCmmnCdListByClsCd(clsCd);
	}
	
	/**
	 * 분류코드별 코드 조회
	 * @param clsCd
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getCmmnClsCdList(CmmnCdVO vo) throws Exception {
		logger.debug("UserService getCmmnCdList started !!!");
		
		Map<String, Object> result = new HashMap<>();
		
		result.put("items", cmmnCdDAO.selectCmmnClsCdList(vo));
		
		logger.debug("UserService getCmmnCdList end !!!");
		
		return result;
	}
	
	/**
	 * 코드 조회
	 * @param cd
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getCmmnCdList(CmmnCdVO vo) throws Exception {
		logger.debug("UserService getCmmnCdList started !!!");
		
		Map<String, Object> result = new HashMap<>();
		
		result.put("items", cmmnCdDAO.selectCmmnCdList(vo));
		
		logger.debug("UserService getCmmnCdList end !!!");
		
		return result;
	}
	
	/**
	 * 코드 등록
	 * @param cd
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void setCmmnCd(CmmnCdVO vo) throws Exception {
		int resultCount = cmmnCdDAO.selectCountCmmnCd(vo);
		if(resultCount == 1) {
			cmmnCdDAO.updateCmmnCd(vo);
		}else {
			cmmnCdDAO.insertCmmnCd(vo);
		}
		
	}
	
	/**
	 * 코드 삭제
	 * @param cd
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void deleteCmmnCd(CmmnCdVO vo) throws Exception {
		cmmnCdDAO.deleteCmmnCd(vo);
	}
	

	/**
	 * 코드값 생성
	 * @param cd
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public Map<String, Object> getCd(CmmnCdVO vo) throws Exception {
		
		Map<String, Object> result = new HashMap<>();
		
		result.put("cd", cmmnCdDAO.getCd(vo));
		
		return  result;
	}
	
	/**
	 * 분류코드 등록
	 * @param clsCd
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void setCmmnClsCd(CmmnCdVO vo) throws Exception {
		int resultCount = cmmnCdDAO.selectCountCmmnClsCd(vo);
		if(resultCount == 1) {
			cmmnCdDAO.updateCmmnClsCd(vo);
		}else {
			cmmnCdDAO.insertCmmnClsCd(vo);
		}
	}
	
	/**
	 * 분류코드 삭제
	 * @param cd
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void deleteCmmnClsCd(CmmnCdVO vo) throws Exception {
		cmmnCdDAO.deleteCmmnClsCd(vo);
	}
	
	/**
	 * 분류코드 속 코드 삭제
	 * @param cd
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void deleteSecCmmnCd(CmmnCdVO vo) throws Exception {
		cmmnCdDAO.deleteSecCmmnCd(vo);
	}
	
	/**
	 * 코드 수정
	 * @param cd
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateCdUseAt(CmmnCdVO vo) throws Exception {
		cmmnCdDAO.updateCdUseAt(vo);
	}
	
	
}
