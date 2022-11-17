package kr.co.rpaplatform.dongwon.mntrng.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.quartz.CronExpression;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.common.util.PaginationUtil;
import kr.co.rpaplatform.dongwon.mntrng.service.DevBotMntrngService;
import kr.co.rpaplatform.dongwon.mntrng.service.SavingTimeIssueMntrngService;

/**
 * 작업 컨트롤러
 * @author LSH
 *
 */
@Controller
@RequestMapping("/mntrng/savingTimeIssue")
public class SavingTimeIssueMntrngController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(SavingTimeIssueMntrngController.class);
	
	/**
	 * 작업 서비스
	 */
	@Resource(name="savingTimeIssueMntrngService")
	private SavingTimeIssueMntrngService savingTimeIssueMntrngService;
	
	/**
	 * 작업모니터링 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/savingTimeIssueMntrngMain")
	public ModelAndView savingTimeIssueMntrngMain(HttpServletRequest request) throws Exception {	
		ModelAndView mav = new ModelAndView("/mntrng/savingTimeIssue/savingTimeIssueMntrngMain");	
		return mav;
	}

	
	/**
	 * 절감시간 이슈관리 리스트 조회(jsp 출력)
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectSavingTimeIssueList")
	@ResponseBody
	public ResponseVO selectSavingTimeIssueList(@RequestBody Map<String, Object> map) throws Exception {		
		// 반환 Map
		Map<String, Object> returnMap = new HashMap<String, Object>();		
				
		// 리스트 카운트 조회
		int totalRecordCount = savingTimeIssueMntrngService.selectSavingTimeIssueListCount(map); 
		
		if (totalRecordCount > 0) {
			
			//페이징 정보 조회
			PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, totalRecordCount);
			
			//조회조건에 페이징 정보 설정
			map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, totalRecordCount));

			//디바이스 리스트 조회
			List<Map<String, Object>> resultList = savingTimeIssueMntrngService.selectSavingTimeIssueList(map); 
	
			//결과 설정
			returnMap.put("resultList", resultList);
			returnMap.put("paginationInfo", paginationInfo);		
		} 
		else 
		{	
			//결과 설정
			returnMap.put("resultList", null);
			returnMap.put("paginationInfo", PaginationUtil.getPaginationInfo(map, 0));			
		}
		
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 절감시간 이슈관리 사유 등록 팝업창
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/savingTimeIssueInsertDetailPop")
	public ModelAndView savingTimeIssueInsertDetailPop() throws Exception {
		return new ModelAndView("/mntrng/savingTimeIssue/savingTimeIssueInsertDetailPop");
	}
	
	/**
	 * 절감시간 이슈관리 사유 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/insertSavingTimeIssueResn")
	@ResponseBody
	public ResponseVO insertSavingTimeIssueResn(@RequestBody Map<String, Object> map) throws Exception {		
		// 반환 Map
		Map<String, Object> returnMap = new HashMap<String, Object>();		
		
		savingTimeIssueMntrngService.insertSavingTimeIssueResn(map);
		savingTimeIssueMntrngService.updateSavingTimeIssueNormalAt(map);

		return new ResponseVO(returnMap);
	}
	
	/**
	 * 절감시간 이슈관리 사유 수정 팝업창
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/savingTimeIssueUpdateDetailPop")
	public ModelAndView savingTimeIssueUpdateDetailPop() throws Exception {
		return new ModelAndView("/mntrng/savingTimeIssue/savingTimeIssueUpdateDetailPop");
	}
	
	/**
	 * 절감시간 이슈관리 사유 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/upadteSavingTimeIssueResn")
	@ResponseBody
	public ResponseVO updateSavingTimeIssueResn(@RequestBody Map<String, Object> map) throws Exception {		
		// 반환 Map
		Map<String, Object> returnMap = new HashMap<String, Object>();		
		savingTimeIssueMntrngService.updateSavingTimeIssueResn(map);
		savingTimeIssueMntrngService.updateSavingTimeIssueNormalAt(map);
		
		return new ResponseVO(returnMap);
	}
}
