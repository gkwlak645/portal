/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 5. 28.         LSH
 */
package kr.co.rpaplatform.dongwon.stdrinfo.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.stdrinfo.service.CmmnCdService;
import kr.co.rpaplatform.dongwon.stdrinfo.vo.CmmnCdVO;

/**
 * 공통코드 컨트롤러
 * @author LSH
 * 2020. 5. 28.
 */
@Controller
@RequestMapping("/stdrinfo/cmmncd")
public class CmmnCdController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(CmmnCdController.class);
	
	/**
	 * 공통코드 서비스
	 */
	@Resource(name="cmmnCdService")
	private CmmnCdService cmmnCdService;
	
	/**
	 * 공통코드 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/cmmnCdMngMain")
	public ModelAndView cmmnCdMngMain() throws Exception {
		return new ModelAndView("/stdrinfo/cmmncd/cmmnCdMngMain");
	}
	
	/**
	 * 공통코드 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/getCmmnCdListByClsCd")
	@ResponseBody
	public ResponseVO getCmmnCdListByClsCd(@RequestBody Map<String, Object> params) throws Exception {
		List<CmmnCdVO> codeList = cmmnCdService.getCmmnCdListByClsCd((String)params.get("clsCd"));
		return new ResponseVO(codeList);
	}
	
	/**
	 * 공통코드 메인 화면
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/cmmnCdModifyMain", method = RequestMethod.GET)
	public String deptModify() throws Exception{
		return "/stdrinfo/cmmncd/cmmnCdModifyMain";
	}
	
	/**
	 * 공통분류코드조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getCmmnClsCdList", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getCmmnClsCdList(@RequestBody CmmnCdVO vo) throws Exception {
		logger.debug("UserController getCmmnClsCdList started !!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		resultData.put("cmmnCdList", cmmnCdService.getCmmnClsCdList(vo));

		logger.debug("UserController getCmmnClsCdList end !!!");
		
		return new ResponseVO(resultData);

	}
	
	/**
	 * 공통코드조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getCmmnCdList", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getCmmnCdList(@RequestBody CmmnCdVO vo) throws Exception {
		logger.debug("UserController getCmmnCdList started !!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		resultData.put("cmmnCdList", cmmnCdService.getCmmnCdList(vo));
		
		logger.debug("UserController getCmmnCdList end !!!");
		
		return new ResponseVO(resultData);
	
	}
	
	/**
	 * 코드값 생성
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getCd", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getCd(@RequestBody CmmnCdVO vo) throws Exception {
		logger.debug("CmmnCdController getCd started !!!");
		
		Map<String, Object> resultData = cmmnCdService.getCd(vo);
		
		logger.debug("CmmnCdController getCd end !!!");
		
		return new ResponseVO(resultData);
	}
	
	/**
	 * 코드추가
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/inputCmmnCd", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO setCmmnCd(@RequestBody CmmnCdVO vo) throws Exception {
		logger.debug("UserController setCmmnCd started !!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		cmmnCdService.setCmmnCd(vo);
		
		logger.debug("UserController setCmmnCd end !!!");
		
		return new ResponseVO(resultData);
	}
	
	
	/**
	 * 코드제거
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteCmmnCd", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO deleteCmmnCd(@RequestBody CmmnCdVO vo) throws Exception {
		logger.debug("UserController deleteCmmnCd started !!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();

		cmmnCdService.deleteCmmnCd(vo);
		
		logger.debug("UserController deleteCmmnCd end !!!");
	
		return new ResponseVO(resultData);
	}
		
	/**
	 * 분류코드추가
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/inputCmmnClsCd", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO setCmmnClsCd(@RequestBody CmmnCdVO vo) throws Exception {
		
		logger.debug("UserController setCmmnClsCd started !!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		String valUsetAt = vo.getUseAt();
		
		if(valUsetAt.equals("N")) {
			cmmnCdService.updateCdUseAt(vo);
		}
		
		cmmnCdService.setCmmnClsCd(vo);
		
		
		logger.debug("UserController setCmmnClsCd end !!!");
		
		return new ResponseVO(resultData);
	}
		
	/**
	 * 분류코드제거
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteCmmnClsCd", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO deleteCmmnClsCd(@RequestBody CmmnCdVO vo) throws Exception {
		logger.debug("UserController deleteCmmnClsCd started !!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();

		cmmnCdService.deleteCmmnClsCd(vo);
		cmmnCdService.deleteSecCmmnCd(vo);
		
		logger.debug("UserController deleteCmmnClsCd end !!!");
	
		return new ResponseVO(resultData);
	}
}
