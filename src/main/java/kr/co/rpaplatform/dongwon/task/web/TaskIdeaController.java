package kr.co.rpaplatform.dongwon.task.web;

import java.util.HashMap;
import java.util.Map;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.exception.RpaException;
import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.dongwon.author.service.AuthorService;
import kr.co.rpaplatform.dongwon.author.vo.AuthorVO;
import kr.co.rpaplatform.dongwon.common.service.PortalCommonService;
import kr.co.rpaplatform.dongwon.common.util.PaginationUtil;
import kr.co.rpaplatform.dongwon.orgnzt.service.UserService;
import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.task.service.TaskIdeaService;

/**
 * @author LSH
 */
@Controller
@RequestMapping("/task/idea")
public class TaskIdeaController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(TaskIdeaController.class);
	
	/**
	 * 과제아이디어 등록 서비스
	 */
	@Resource(name="taskIdeaService")
	private TaskIdeaService taskIdeaService;
	
	@Resource(name="userService")
	private UserService userService;
	
	@Resource(name="portalCommonService")
	private PortalCommonService portalCommonService;
	
	/**
	 * 과제아이디어등록 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/taskIdeaMain")
	public ModelAndView taskIdeaMain() throws Exception {
		return new ModelAndView("/task/idea/taskIdeaMain");
	}
	
	/**
	 * 과제아이디어등록 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectTaskIdeaList")
	@ResponseBody
	public ResponseVO selectTaskIdeaList(HttpServletRequest req, @RequestBody Map<String, Object> map) throws Exception {
		logger.debug("TaskIdeaController selectTaskIdeaList start!!");
		
		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//읽기 권한이 있는지 확인
		if(!oAuthorVO.getRedngAuthor().equals("Y")) {
			return new ResponseVO("E202", "비정상 접근입니다.");
		}
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		//과제아이디어등록 리스트 카운트 조회
		int totalRecordCount = taskIdeaService.selectTaskIdeaListCount(map);
		
		//페이징 정보 조회
		PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, totalRecordCount);
		
		//조회조건에 페이징 정보 설정
		map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, totalRecordCount));

		//과제아이디어등록 리스트 조회
		List<Map<String, Object>> resultList = taskIdeaService.selectTaskIdeaList(map);

		//결과값 설정
		returnMap.put("resultList", resultList);
		returnMap.put("paginationInfo", paginationInfo);
		
		logger.debug("TaskIdeaController selectTaskIdeaList end!!");
		return new ResponseVO(returnMap);
	}
	
	@RequestMapping(value = "/taskIdeaRegPop")
	public ModelAndView taskIdeaRegPop() throws Exception {
		return new ModelAndView("/task/idea/taskIdeaRegPop");
	}
	
	/**
	 * 과제아이디어등록 > 등록
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/insertTaskIdea", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO insertTaskIdea(HttpServletRequest req, HttpServletResponse res, @RequestBody HashMap<String, String> params) throws Exception {
		logger.debug("TaskIdeaController insertTaskIdea start!!");
		
		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//쓰기 권한이 있는지 확인
		if(!oAuthorVO.getWrtngAuthor().equals("Y")) {
			return new ResponseVO("E202", "비정상 접근입니다.");
		}
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		params.put("registerId", MDC.get("txUserId"));
		taskIdeaService.insertTaskIdea(params);
		
		logger.debug("TaskIdeaController insertTaskIdea end!!");
		return new ResponseVO(resultData);
	}
	
	@RequestMapping(value = "/taskIdeaDetailPop", method = RequestMethod.GET)
	public ModelAndView taskIdeaDetailPop(@RequestParam(value="registerId") String registerId) throws Exception {
		
		ModelAndView mav = new ModelAndView("/task/idea/taskIdeaDetailPop");
		//접속자와 게시자가 같은 사용자 인지 확인
		if(registerId.equals(MDC.get("txUserId"))) {
			mav.addObject("identityFlag", true); 
		}else {
			mav.addObject("identityFlag", false);
		}
		return mav;
	}
	
	/**
	 * 과제아이디어등록 > 상세보기
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/getTaskIdeaDetail")
	@ResponseBody
	public ResponseVO getTaskIdeaDetail(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TaskIdeaController insertTaskIdea start!!");
		
		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//읽기 권한이 있는지 확인
		if(!oAuthorVO.getRedngAuthor().equals("Y")) {
			return new ResponseVO("E202", "비정상 접근입니다.");
		}
		
		Map<String, Object> returnData = taskIdeaService.getTaskIdeaDetail(params);
		//{jobClsCd=01, rpaClsCd=01, reviewTrgetAt=N, prgrSttusNm=등록, ideaUserId=gwtest12, deptNm=사업본부, deptCd=W0001, emailAdr=gwtest12@dongwon.com, mbtlnum=, ideaSn=10, devlopResn=개발사유, expcEffect=기대효과, fileGrpNo=0, ideaSj=제목, jobDc=업무설명, cmpnyCd=A, registerId=gwtest12, cmpnyNm=동원건설산업, relateDoc=연관문서, ideaUserNm=사용자12}
		if(returnData != null && returnData.get("mbtlnum") != null) {
			//휴대폰 번호(mbtlnum) 확인 public String getMbtlnum
			returnData.put("mbtlnum", userService.getMbtlnum((String)returnData.get("ideaUserId")));
		}
		logger.debug("TaskIdeaController insertTaskIdea end!!");
		
		
		
		return new ResponseVO(returnData);
	}
	
	/**
	 * 과제아이디어등록 > 상세보기 > 검토확인
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/setTaskIdeaReviewComplete")
	@ResponseBody
	public ResponseVO setTaskIdeaReviewComplete(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TaskIdeaController setTaskIdeaReviewComplete start!!");
		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		
		if(!oAuthorVO.getResveAuthor2().equals("Y")) {//접수 권한자 인지 확인
			return new ResponseVO("E202", "비정상 접근입니다.");
		}
		
		//현재 상태확인
		Map<String, Object> returnData = taskIdeaService.getTaskIdeaDetail(params);
		String sPrgrSttus = (String)returnData.get("prgrSttus");
		if(sPrgrSttus.equals("01")) {
			//변경(접검토대상 여부: Y, 상태: 03)
			params.put("updusrId", MDC.get("txUserId"));
			taskIdeaService.setTaskIdeaReviewComplete(params);
		}
		else if(sPrgrSttus.equals("02")) {
			return new ResponseVO("E60002", "과제아이디어가 등록취소 되어 있습니다.");
		} 
		else {
			return new ResponseVO("E60003", "과제아이디어가 이미 검토완료 되어 있습니다.");
		}
		
		logger.debug("TaskIdeaController setTaskIdeaReviewComplete end!!");
		
		return new ResponseVO(new HashMap<String, Object>());
	}
	
	/**
	 * 과제아이디어등록 > 상세보기 > 저장
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/setTaskIdeaDetail")
	@ResponseBody
	public ResponseVO setTaskIdeaDetail(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TaskIdeaController setTaskIdeaDetail start!!");
		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);

		//쓰기/수정 권한자 인지 확인
		if(!oAuthorVO.getWrtngAuthor().equals("Y")) {
			return new ResponseVO("E202", "비정상 접근입니다.");
		}
		
		//현재 상태확인
		Map<String, Object> returnData = taskIdeaService.getTaskIdeaDetail(params);
		String sPrgrSttus = (String)returnData.get("prgrSttus");
		String sTxUserId = MDC.get("txUserId");
		
		//등록자와 동일인 인지 확인
		if(((String)returnData.get("registerId")).equals(sTxUserId)) {
			if(sPrgrSttus.equals("01")) {
				params.put("updusrId", sTxUserId);
				taskIdeaService.setTaskIdeaDetail(params);
			} 
			else {
				return new ResponseVO("E60004", "등록 상태인 과제아이디어만 수정 가능합니다.");
			}
		}
		else {
			return new ResponseVO("E202", "비정상 접근입니다.");
		}
		logger.debug("TaskIdeaController setTaskIdeaDetail end!!");
		
		return new ResponseVO(new HashMap<String, Object>());
	}
	
	/**
	 * 과제아이디어등록 > 상세보기 > 등록취소
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/setTaskIdeaCancel")
	@ResponseBody
	public ResponseVO setTaskIdeaCancel(HttpServletRequest req, @RequestBody Map<String, Object> params) throws Exception {
		logger.debug("TaskIdeaController setTaskIdeaCancel start!!");

		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//쓰기/수정 권한자 인지 확인
		if(!oAuthorVO.getWrtngAuthor().equals("Y")) {
			return new ResponseVO("E202", "비정상 접근입니다.");
		}
		
		//현재 상태확인
		Map<String, Object> returnData = taskIdeaService.getTaskIdeaDetail(params);
		String sPrgrSttus = (String)returnData.get("prgrSttus");
		String sTxUserId = MDC.get("txUserId");
		
		//등록자와 동일인 인지 확인
		if(((String)returnData.get("registerId")).equals(sTxUserId)) {
			if(!sPrgrSttus.equals("02")) {
				//변경(상태: "02")
				params.put("updusrId", sTxUserId);
				taskIdeaService.setTaskIdeaCancel(params);
			} 
			else {
				return new ResponseVO("E60002", "과제아이디어가 등록취소 되어 있습니다.");
			}
		}
		else {
			return new ResponseVO("E202", "비정상 접근입니다.");
		}
		logger.debug("TaskIdeaController setTaskIdeaCancel end!!");
		
		return new ResponseVO(new HashMap<String, Object>());
	}
}
