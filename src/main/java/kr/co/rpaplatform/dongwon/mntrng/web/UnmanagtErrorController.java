package kr.co.rpaplatform.dongwon.mntrng.web;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.common.util.PaginationUtil;
import kr.co.rpaplatform.dongwon.common.vo.CmmnUserVO;
import kr.co.rpaplatform.dongwon.mntrng.service.UnmanagtErrorService;

/**
 * 작업 컨트롤러
 * @author LSH
 *
 */
@Controller
@RequestMapping("/mntrng/unmanagterror")
public class UnmanagtErrorController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(UnmanagtErrorController.class);
	
	/**
	 * 작업 서비스
	 */
	@Resource(name="unmanagtErrorService")
	private UnmanagtErrorService unmanagtErrorService;
	
	
	/**
	 * 작업모니터링 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/unmanagtErrorMain")
	public ModelAndView trnscMntrngMngMain() throws Exception {
		return new ModelAndView("/mntrng/unmanagterror/unmanagtErrorMain");
	}
	
	/**
	 * 작업 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getUnmanagtErrorList")
	@ResponseBody
	public ResponseVO getUnmanagtErrorList(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		// 리스트 카운트 조회
		int totalRecordCount = unmanagtErrorService.getUnmanagtErrorCount(map);
		
		
		if (totalRecordCount > 0) {
			
			//페이징 정보 조회
			PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, totalRecordCount);
			
			//조회조건에 페이징 정보 설정
			map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, totalRecordCount));
			
			//디바이스 리스트 조회
			List<Map<String, Object>> resultList = unmanagtErrorService.selectUnmanagtErrorList(map); 
	
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
	 * 일일미조치현황 등록 화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/unmanagtErrorSave")
	public ModelAndView unmanagtErrorSave() throws Exception {
		return new ModelAndView("/mntrng/unmanagterror/unmanagtErrorSavePop");
	}
	
	
	/**
	 * 일일미조치현황 등록 저장
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveUnmanagtErrorData")
	@ResponseBody
	public ResponseVO saveUnmanagtErrorData(@RequestBody Map<String, Object> map, HttpServletRequest request) throws Exception {
		
		logger.debug("일일미조치현황 등록 저장 saveUnmanagtErrorData started !!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		
		if (request.getSession().getAttribute("sessionUserInfo") != null) {
			
			CmmnUserVO cmmnUserVO = (CmmnUserVO)request.getSession().getAttribute("sessionUserInfo");
			
			map.put("registerId", cmmnUserVO.getTxUserId());
		}else {
			map.put("registerId", "");
		}
		
		unmanagtErrorService.saveUnmanagtErrorData(map);
		
		return new ResponseVO(resultData);
	}
	
	
	/**
	 * 작업 상세 화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/unmanagtErrorDetailPop")
	public ModelAndView trnscErrorDetailPop() throws Exception {
		return new ModelAndView("/mntrng/unmanagterror/unmanagtErrorDetailPop");
	}
	
	/**
	 * 작업 상세 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getManagtErrorDetail")
	@ResponseBody
	public ResponseVO getManagtErrorDetail(@RequestBody Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = unmanagtErrorService.getManagtErrorDetail(map);
		return new ResponseVO(resultMap);
	}
	
	
	/**
	 * 작업 상세 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateUnmanagtError")
	@ResponseBody
	public ResponseVO updateUnmanagtError(@RequestBody Map<String, Object> map, HttpServletRequest request) throws Exception {
		
		logger.debug("일일미조치현황 수정 updateUnmanagtError started !!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		if (request.getSession().getAttribute("sessionUserInfo") != null) {
			
			CmmnUserVO cmmnUserVO = (CmmnUserVO)request.getSession().getAttribute("sessionUserInfo");
			
			map.put("updusrId", cmmnUserVO.getTxUserId());
		}else {
			map.put("updusrId", "");
		}
		
		unmanagtErrorService.updateUnmanagtError(map);
		
		return new ResponseVO(resultData);
	}

}
