package kr.co.rpaplatform.dongwon.cmmnty.web;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.exception.RpaException;
import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.author.vo.AuthorVO;
import kr.co.rpaplatform.dongwon.cmmnty.service.CntrbtRankService;
import kr.co.rpaplatform.dongwon.cmmnty.service.NoticeService;
import kr.co.rpaplatform.dongwon.cmmnty.service.SysOpertNoticeService;
import kr.co.rpaplatform.dongwon.common.service.PortalCommonService;
import kr.co.rpaplatform.dongwon.common.service.SendMailDw;
import kr.co.rpaplatform.dongwon.common.util.PaginationUtil;

@Controller
@RequestMapping("/cmmnty/cntrbtRank")
public class CntrbtRankController {
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(CntrbtRankController.class);
	
	@Resource(name="portalCommonService")
	private PortalCommonService portalCommonService;
	
	@Resource(name="cntrbtRankService")
	private CntrbtRankService cntrbtRankService;
	
	/**
	 * 명예의전당 > 메인
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/cntrbtRankMain", method = RequestMethod.GET)
	public ModelAndView cntrbtRankMain(HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView("/cmmnty/cntrbtRank/cntrbtRankMain");
		return mav;
	}
	
	
	/**
	 * 명예의전당 > 메인: 조회
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectCntrbtRankList", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO selectCntrbtRankList(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("CntrbtRankController.selectCntrbtRanList end!!");
		Map<String, Object> returnMap = new HashMap<String, Object>();
		//리스트 카운트 조회
		int totalRecordCount = cntrbtRankService.selectCntrbtRankListCount(params);
		
		//페이징 정보 조회
		PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(params, totalRecordCount);
		
		//조회조건에 페이징 정보 설정
		params.put("paginationInfo", PaginationUtil.getPaginationInfo(params, totalRecordCount));

		System.out.println(paginationInfo.toString());
		
		//과제개발 > 메인: 리스트  조회
		List<Map<String, Object>> resultList = cntrbtRankService.selectCntrbtRankList(params);

		//결과값 설정
		returnMap.put("resultList", resultList);
		returnMap.put("paginationInfo", paginationInfo);
		logger.debug("CntrbtRankController.selectSysOpertNoticeList end!!");
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 시스템 작업공지 > 상세: getData
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/getCntrbtRankDetailPopGetData", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getCntrbtRankDetailPopGetData(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("CntrbtRankController.getCntrbtRankDetailPopGetData start!!");

		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//읽기 권한자 인지 확인
		if(!oAuthorVO.getRedngAuthor().equals("Y")) {
			throw new RpaException("E202");//비정상 접근입니다.
		}
		
		Map<String, Object> returnData = cntrbtRankService.getCntrbtRankDetailPopGetData(params);
		
		logger.debug("CntrbtRankController.getCntrbtRankDetailPopGetData end!!");
		return new ResponseVO(returnData);
	}
	
	/**
	 * 시스템 작업공지 > 상세: LAYOUT
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/cntrbtRankDetailPop", method = RequestMethod.GET)
	public ModelAndView cntrbtRankDetailPop(@RequestParam(value="registerId") String registerId) throws Exception {
		
		ModelAndView mav = new ModelAndView("/cmmnty/cntrbtRank/cntrbtRankDetailPop");
		return mav;
	}
}
