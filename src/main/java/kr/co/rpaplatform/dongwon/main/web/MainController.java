/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 4.         LSH
 */
package kr.co.rpaplatform.dongwon.main.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.MDC;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.main.service.MainService;
import kr.co.rpaplatform.dongwon.menu.service.MenuService;


/**
 * @author LSH
 * 2020. 6. 4.
 */
@Controller
@RequestMapping("/main")
public class MainController {
	
	/**
	 * 메뉴 서비스
	 */
	@Resource(name="menuService")
	private MenuService menuService;
	
	/**
	 * 메인 서비스
	 */
	@Resource(name="mainService")
	private MainService mainService;
	
	
	/**
	 * 메인화면 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/siteMain")
	public ModelAndView siteMain() throws Exception {
		
		String mainUrl = "";
		String userRoleCd = mainService.getMainUserRoleCd(new HashMap<String, Object>());
		
		if("0005".equals(userRoleCd)) { //로그인한 사용자가 임원일때
			mainUrl = "/main/siteOwnerV2Main";
		}else {
			mainUrl = "/main/siteMain";
		}
		
		return new ModelAndView(mainUrl);
	}
	
	/**
	 * 임원용 대쉬보드관리 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/siteOwnerMain")
	public ModelAndView siteOwnerMain() throws Exception {
		ModelAndView mav = new ModelAndView("/main/siteOwnerV2Main");
		return mav;
	}
	
	
	@RequestMapping(value = "/siteTestMain")
	public ModelAndView siteTestMain() throws Exception {
		ModelAndView mav = new ModelAndView("/main/siteTestMain");
		return mav;
	}
	
	@RequestMapping(value = "/{mainCardPop}", method=RequestMethod.GET)
	public ModelAndView mainCardPop(@PathVariable("mainCardPop") String sMainCardPop) throws Exception {
		ModelAndView mav = new ModelAndView("/main/" + sMainCardPop);
		return mav;
	}
	
	
	/**
	 * 메인(1_1) - RPA현황
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/rpaStatus/getRPAStatusCnt", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getRPAStatusCnt(@RequestBody Map<String,Object> map) throws Exception {		
		Map<String, Object> resultData = mainService.getRPAStatusCnt(map);
		return new ResponseVO(resultData);
	}
	
	
	/**
	 * 메인(1_2) - 부분별 프로세스 현황
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/clsProcessStatus/getClsProcessStatusCnt", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getClsProcessStatusCnt(@RequestBody Map<String,Object> map) throws Exception {		
		Map<String, Object> resultData = mainService.getClsProcessStatusCnt(map);
		return new ResponseVO(resultData);
	}
	
	
	/**
	 * 메인(2_1) - 나의 프로세스 
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/task/getTaskProcessCnt", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getTaskProcessCnt(@RequestBody Map<String,Object> map) throws Exception {		
		Map<String, Object> resultData = mainService.getTaskProcessCnt(map);
		return new ResponseVO(resultData);
	}
	
	
	/**
	 * 메인(2_2) - 헬프데스크 처리요청 리스트
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/requst/getHlpdsk", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getHlpdsk(@RequestBody Map<String,Object> map) throws Exception {		
		Map<String, Object> resultData = new HashMap<String, Object>();		
		
		map.put("txCmpnyCd", MDC.get("txCmpnyCd"));

		resultData.put("hlpdskList", mainService.getHlpdsk(map));		
		return new ResponseVO(resultData);
	}
	
	
	/**
	 * 메인(2_3) - Automation index
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/automationIndex/getAutomationIndexCnt", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getAutomationIndexCnt(@RequestBody Map<String,Object> map) throws Exception {		
		Map<String, Object> resultData = mainService.getAutomationIndexCnt(map);
		return new ResponseVO(resultData);
	}
	
	
	/**
	 * 메인(2_4) - 시스템작업공지 리스트
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/sysOpertNotice/getSysOpertNoticeList", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getSysOpertNoticeList(@RequestBody Map<String,Object> map) throws Exception {		
		Map<String, Object> resultData = new HashMap<String, Object>();		
		resultData.put("sysOpertNoticeList", mainService.getSysOpertNoticeList(map));		
		return new ResponseVO(resultData);
	}
	
	
	
	/**
	 * 메인(2_5) - 실행결과 개수
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/jobmntrng/getJobsCnt", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getJobsCnt(@RequestBody Map<String,Object> map) throws Exception {		
		Map<String, Object> resultData = mainService.getJobsCnt(map);
		return new ResponseVO(resultData);
	}
	
	/**
	 * 메인(2_6) - 명예의 전당(절감시간)
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/cntrbtRank/getRankRedcnTmList", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getRankRedcnTmList(@RequestBody Map<String,Object> map) throws Exception {	
		Map<String, Object> resultData = mainService.getRankRedcnTmList(map);
		return new ResponseVO(resultData);
	}
	
	/**
	 * 메인(2_7) - 명예의 전당(개선지수)
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/cntrbtRank/getRankCntrbtList", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getRankCntrbtList(@RequestBody Map<String,Object> map) throws Exception {		
		Map<String, Object> resultData = mainService.getRankCntrbtList(map);
		return new ResponseVO(resultData);
	}
	
	
	/**
	 * 메인(2_8) - RPA 담당자
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/user/getRpaChargerList", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getRpaChargerList(@RequestBody Map<String,Object> map) throws Exception {		
		Map<String, Object> resultData = mainService.getRpaChargerList(map);
		return new ResponseVO(resultData);
	}
	
	
	/**
	 * 메인(2_9) - 절감시간 Top3
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/topRedcnTm/getTopRedcnTmList", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getTopRedcnTmList(@RequestBody Map<String,Object> map) throws Exception {		
		Map<String, Object> resultData = mainService.getTopRedcnTmList(map);
		return new ResponseVO(resultData);
	}
	
	
	/**
	 * 메인(3_1) - 오늘의 프로세스 실행현황
	 * @return
	 * @param map
	 * @throws Exception
	 */
	@RequestMapping(value = "/task/getTodayProcessList", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getTodayProcessList(HttpServletRequest request,@RequestBody Map<String,Object> map) throws Exception {		
		Map<String, Object> resultData = mainService.getTodayProcessList(request,map);
		return new ResponseVO(resultData);
	}
	
	
	/**
	 * 메인(3_2) - 신규등록 프로세스
	 * @return
	 * @param map
	 * @throws Exception
	 */
	@RequestMapping(value = "/task/getNewProcessList", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getNewProcessList(HttpServletRequest request,@RequestBody Map<String,Object> map) throws Exception {		
		Map<String, Object> resultData = mainService.getNewProcessList(request,map);
		return new ResponseVO(resultData);
	}
	
	
	/**
	 * 임원메인
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/main/getOwnerMainList", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getOwnerMainList(@RequestBody Map<String,Object> map) throws Exception {		
		Map<String, Object> resultData = mainService.getOwnerMainList(map);
		return new ResponseVO(resultData);
	}
	/**/
	
	@RequestMapping(value = "/main/searchType2Card1_1_sch1", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO searchType2Card1_1_sch1(@RequestBody Map<String,Object> map) throws Exception {		
		Map<String, Object> resultData = mainService.searchType2Card1_1_sch1(map);
		return new ResponseVO(resultData);
	}
	
	@RequestMapping(value = "/main/searchType2Card1_1_sch2", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO searchType2Card1_1_sch2(@RequestBody Map<String,Object> map) throws Exception {		
		Map<String, Object> resultData = mainService.searchType2Card1_1_sch2(map);
		return new ResponseVO(resultData);
	}
	
	/**/
	/**
	 * 임원메인 - 가동률 조회
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/main/getOwnerMainOperRateList", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getOwnerMainOperRateList(@RequestBody Map<String,Object> map) throws Exception {		
		Map<String, Object> resultData = mainService.getOwnerMainOperRateList(map);
		return new ResponseVO(resultData);
	}

	/**/
	/**
	 * 임원메인 - 성공률 조회
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/main/getOwnerMainSuccRateList", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getOwnerMainSuccRateList(@RequestBody Map<String,Object> map) throws Exception {		
		Map<String, Object> resultData = mainService.getOwnerMainSuccRateList(map);
		return new ResponseVO(resultData);
	}
	
}
