package kr.co.rpaplatform.dongwon.mntrng.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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
import kr.co.rpaplatform.dongwon.mntrng.service.JobService;

/**
 * 작업 컨트롤러
 * @author LSH
 *
 */
@Controller
@RequestMapping("/mntrng/jobmntrng")
public class JobController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(JobController.class);
	
	/**
	 * 작업 서비스
	 */
	@Resource(name="jobService")
	private JobService jobService;
	
	
	/**
	 * 작업모니터링 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/jobMntrngMain")
	public ModelAndView jobMntrngMngMain(HttpServletRequest request) throws Exception {
		
		ModelAndView mav = new ModelAndView("/mntrng/jobmntrng/jobMntrngMain");
		
		//메인- 헬프데스크 선택시 requestSn 넘김
		if(request.getParameter("mainInitAt") != null && request.getParameter("mainInitAt") != "") {
			mav.addObject("mainInitAt", request.getParameter("mainInitAt"));
		}
		
		return mav;
	}
	
	/**
	 * 작업 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getJobList")
	@ResponseBody
	public ResponseVO getJobList(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();

		//디바이스 리스트 카운트 조회
		int totalRecordCount = jobService.getJobCount(map);
		
		if (totalRecordCount > 0) {
		
			//페이징 정보 조회
			PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, totalRecordCount);
			
			//조회조건에 페이징 정보 설정
			map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, totalRecordCount));
	
			//디바이스 리스트 조회
			List<Map<String, Object>> resultList = jobService.getJobList(map);
	
			//결과값 설정
			returnMap.put("resultList", resultList);
			returnMap.put("paginationInfo", paginationInfo);
			
		} else {
			
			//결과값 설정
			returnMap.put("resultList", null);
			returnMap.put("paginationInfo", PaginationUtil.getPaginationInfo(map, 0));
			
		}
		
		return new ResponseVO(returnMap);
	}
	
	
	/**
	 * JOB 중지
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/stopJob")
	@ResponseBody
	public ResponseVO stopJob(@RequestBody Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = jobService.stopJob(map);
		return new ResponseVO(resultMap);
	}
	
	/**
	 * 작업 상세 화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/jobDetailPop")
	public ModelAndView processDetailPagePop() throws Exception {
		return new ModelAndView("/mntrng/jobmntrng/jobDetailPop");
	}
	
	/**
	 * 작업 상세 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getJobDetail")
	@ResponseBody
	public ResponseVO getJobDetail(@RequestBody Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = jobService.getJobDetail(map);
		return new ResponseVO(resultMap);
	}

}
