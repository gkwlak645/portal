package kr.co.rpaplatform.dongwon.task.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.task.service.TaskPaymentService;
import kr.co.rpaplatform.rpaapi.uipath.common.RestApi;

/**
 * @author LSH
 */
@Controller
@RequestMapping("/task/payment")
public class TaskPaymentController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(TaskPaymentController.class);
	
	/**
	 * 과제운영 서비스
	 */
	@Resource(name="taskPaymentService")
	private TaskPaymentService taskPaymentService;
	
	/**
	 * rest Api
	 */
	@Resource(name="restApi")
	private RestApi restApi;
	
	
	/**
	 * 과재 결재요청, 과재운영취소 상신 호출
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/requestTaskPayment")
	@ResponseBody
	public ResponseVO requestTaskPayment(@RequestBody Map<String, Object> map) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("param", taskPaymentService.requestTaskPayment(map));
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 과재 운영취소 상신 실패시 RollBack - 상태코드 O6(운영취소 결재 대기중) >  O1(운영중) 롤백
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/requestTaskManageProcessCancelRollBack")
	@ResponseBody
	public ResponseVO requestTaskManageProcessCancelRollBack(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();

		//프로세스 상태 값 롤백
		taskPaymentService.requestTaskManageProcessCancelRollBack(map);

		//결과값 설정
		return new ResponseVO(returnMap);
	}
	
	
	/**
	 * 과재 결재, 운영취소 상신 실패시 RollBack - ASIS 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/requestTaskPaymentRollBack")
	@ResponseBody
	public ResponseVO requestTaskPaymentRollBack(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();

		//과재결재 결과 저장
		taskPaymentService.requestTaskPaymentRollBack(map);

		//결과값 설정
		return new ResponseVO(returnMap);
	}
	
	
	/**
	 * 과재 결재상신연동 API 호출
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/returnTaskPaymentResult")
	@ResponseBody
	public ResponseVO returnPaymentResult(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();

		//과재결재 결과 저장
		taskPaymentService.updateTaskPaymentResult(map);

		//결과값 설정
		return new ResponseVO(returnMap);
	}
	
	
	
}
