package kr.co.rpaplatform.dongwon.stdrinfo.web;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.common.vo.CmmnUserVO;
import kr.co.rpaplatform.dongwon.file.vo.AtchFileVO;
import kr.co.rpaplatform.dongwon.stdrinfo.service.TaskTmplatMngService;
import kr.co.rpaplatform.dongwon.stdrinfo.vo.TaskTmplatMngVO;


@Controller
@RequestMapping("/stdrinfo/tmplat")
public class TaskTmplatMngController {

	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(TaskTmplatMngController.class);
	
	@Resource(name="taskTmplatMngService")
	private TaskTmplatMngService taskTmplatMngService;
	
	/**
	 * 과제템플릿관리 목록 페이지 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/taskTmplatMngMain", method = RequestMethod.GET)
	public ModelAndView boardNotice(HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView("/stdrinfo/tmplat/taskTmplatMngMain");
		return mav;
	}
	
	/**
	 * 과제템플릿관리 등록 페이지
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/taskTmplatMngRegPop")
	public ModelAndView taskTmplatMngRegPop() throws Exception {
		return new ModelAndView("/stdrinfo/tmplat/taskTmplatMngRegPop");
	}
	
	/**
	 * 과제템플릿관리 상세 화면
	 * @throws Exception
	 */
	@RequestMapping(value="/taskTmplatDetailPop")
	public ModelAndView taskTmplatDetailPop() throws Exception {
		return new ModelAndView("/stdrinfo/tmplat/taskTmplatMngDetailPop");
	}

	
	/**
	 * 과제템플릿관리 목록 List
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/getTaskTmplatMng", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getTaskTmplatMng(@RequestBody TaskTmplatMngVO vo) throws Exception {		
		Map<String, Object> resultData = new HashMap<String, Object>();		
		resultData.put("taskTmplatMngList", taskTmplatMngService.getTaskTmplatMng(vo));		
		return new ResponseVO(resultData);
	}	
	
	/**
	 * 파일 FILE_GRP_NO 최대값 구하기
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/getMaxFileGrpNo", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getMaxFileGrpNo(@RequestBody TaskTmplatMngVO vo) throws Exception {		
		Map<String, Object> resultData = new HashMap<String, Object>();		
		resultData.put("maxFileGrpNo", taskTmplatMngService.getMaxFileGrpNo(vo));		
		return new ResponseVO(resultData);
	}	
	
	/**
	 * 과제템플릿관리 등록 중복체크
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/insertCheck", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO insertCheck(@RequestBody TaskTmplatMngVO vo) throws Exception {		
		Map<String, Object> resultData = new HashMap<String, Object>();		
		resultData.put("count", taskTmplatMngService.insertCheck(vo));		
		return new ResponseVO(resultData);
	}	
	
	/**
	 * 과제템플릿관리 글 등록
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/insertTaskTmplat", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO insertTaskTmplatMng(@RequestBody TaskTmplatMngVO vo) throws Exception {
		logger.debug("TaskTmplatMngController insertTaskTmplatMng start!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		vo.setRegisterId(MDC.get("txUserId"));
		taskTmplatMngService.insertTaskTmplatMng(vo);
		
		logger.debug("TaskTmplatMngController insertTaskTmplatMng end!!");
		return new ResponseVO(resultData);
	}
	
	/**
	 * 과제템플릿관리 상세 화면 내역 조회
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/getTaskTmplatDetail", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getTaskTmplatDetail(@RequestBody TaskTmplatMngVO vo) throws Exception {

		Map<String, Object> resultData = new HashMap<String, Object>();
		TaskTmplatMngVO taskTmplatMngVO = taskTmplatMngService.getTaskTmplatDetail(vo);
		
		if(taskTmplatMngVO.getRegisterId().equals(MDC.get("txUserId"))) {
			taskTmplatMngVO.setIdentityFlag("Y"); 
		}
		resultData.put("taskTmplatMng", taskTmplatMngVO);
		return new ResponseVO(resultData);
	}
	
	/**
	 * 과제템플릿관리 글 수정
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateTaskTmplat", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO updateTaskTmplat(@RequestBody TaskTmplatMngVO vo) throws Exception {
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		vo.setRegisterId(MDC.get("txUserId"));
		taskTmplatMngService.updateTaskTmplatMng(vo);
		return new ResponseVO(resultData);
	}
	
	/**
	 * 과제템플릿관리 글 삭제
	 * @return
	 * @param vo
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteTaskTmplat", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO deleteTaskTmplat(@RequestBody TaskTmplatMngVO vo) throws Exception {
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		vo.setRegisterId(MDC.get("txUserId"));
		taskTmplatMngService.deleteTaskTmplatMng(vo);
		return new ResponseVO(resultData);
	}
}

