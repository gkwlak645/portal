package kr.co.rpaplatform.dongwon.mntrng.web;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
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
import kr.co.rpaplatform.dongwon.common.service.PortalCommonService;
import kr.co.rpaplatform.dongwon.common.util.PaginationUtil;
import kr.co.rpaplatform.dongwon.mntrng.service.TrnscErrorService;

/**
 * 작업 컨트롤러
 * @author LSH
 *
 */
@Controller
@RequestMapping("/mntrng/trnscerror")
public class TrnscErrorController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(TrnscErrorController.class);
	
	@Value("${executDscntcImg.basic.path}")
	private String executDscntcImgBasicPath;
	
	/**
	 * 작업 서비스
	 */
	@Resource(name="trnscErrorService")
	private TrnscErrorService trnscErrorService;
	
	@Resource(name="portalCommonService")
	private PortalCommonService portalCommonService;
	
	
	/**
	 * 작업모니터링 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/trnscErrorMain")
	public ModelAndView trnscMntrngMngMain(HttpServletRequest req) throws Exception {
		ModelAndView mav = new ModelAndView("/mntrng/trnscerror/trnscErrorMain");
		mav.addObject("paramJobId", req.getParameter("jobId"));
		return mav;
	}
	
	/**
	 * 로봇 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getRobotList")
	@ResponseBody
	public ResponseVO getRobotList(@RequestBody Map<String, Object> map) throws Exception {		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		// 해당 회사에 맞는 로봇 리스트 조회
		List<Map<String, Object>> robotList = trnscErrorService.selectBotList(map); 				
		returnMap.put("robotList", robotList);
				
		return new ResponseVO(returnMap);
	}
	
	/**
	 * 작업 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getTrnscErrorList")
	@ResponseBody
	public ResponseVO getTrnscErrorList(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();

		// 리스트 카운트 조회
		int totalRecordCount = trnscErrorService.getTrnscErrorCount(map);
		
		
		if (totalRecordCount > 0) {
			
			//페이징 정보 조회
			PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, totalRecordCount);
			
			//조회조건에 페이징 정보 설정
			map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, totalRecordCount));
			
			//디바이스 리스트 조회
			List<Map<String, Object>> resultList = trnscErrorService.selectTrnscErrorList(map); 
	
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
	 * 작업 상세 화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/trnscErrorDetailPop")
	public ModelAndView trnscErrorDetailPop() throws Exception {
		return new ModelAndView("/mntrng/trnscerror/trnscErrorDetailPop");
	}
	
	/**
	 * 작업 상세 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getTrnscErrorDetail")
	@ResponseBody
	public ResponseVO getTrnscErrorDetail(@RequestBody Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = trnscErrorService.getTrnscErrorDetail(map);
		return new ResponseVO(resultMap);
	}
	
	
	/**
	 * 작업 상세 수정
	 * @param map
	 * @return 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateTrnscError")
	@ResponseBody
	public ResponseVO updateTrnscError(HttpServletRequest req, @RequestBody Map<String, Object> map) throws Exception {
		AuthorVO oAuthorVO = portalCommonService.getScreenAuthor(req);
		//쓰기/수정 권한자 인지 확인
		if(!oAuthorVO.getWrtngAuthor().equals("Y")) {
			return new ResponseVO("E202", "비정상 접근입니다.");
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		trnscErrorService.updateTrnscError(map);
		return new ResponseVO(resultMap);
	}
	
	
	/**
	 * 중복 작업 상세 화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/overTrnscErrorDetailPop")
	public ModelAndView overTrnscErrorDetailPop() throws Exception {
		return new ModelAndView("/mntrng/trnscerror/overTrnscErrorDetailPop");
	}
	
	/**
	 * 작업 상세 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getOverTrnscErrorDetail")
	@ResponseBody
	public ResponseVO getOverTrnscErrorDetail(@RequestBody Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = trnscErrorService.getOverTrnscErrorDetail(map);
		return new ResponseVO(resultMap);
	}
	
	
	/**
	 * 작업 상세 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateOverTrnscErrorDetail")
	@ResponseBody
	public ResponseVO updateOverTrnscErrorDetail(@RequestBody Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		trnscErrorService.updateOverTrnscErrorDetail(map);
		return new ResponseVO(resultMap);
	}
	
	@RequestMapping(value = "/errorImg", method=RequestMethod.GET)
	public ModelAndView errorImg(@RequestParam("robotId") String sRrobotId, @RequestParam("processCd") String sProcessCd, @RequestParam("fileName") String sFileName) throws Exception {
			String filePath = executDscntcImgBasicPath +sProcessCd + File.separator + sRrobotId + File.separator + "Exceptions_Screenshots" + File.separator + sFileName;
			//String filePath = "C:\\uploadErrorMoveImage\\2020\\0908\\1603688371109_I00101_robot3_20200908_130301.png";
			File downloadFile = new File(filePath);
			
			if (!downloadFile.exists()) {
				throw new RpaException("E104");
			}
			
			ModelAndView mav = new ModelAndView("errorImageView");
			mav.addObject("downloadFile", downloadFile);
			mav.addObject("oriFileNm", sFileName);
			
			return mav;
	}
	
	
	/**
	 * 작업 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectOverlapTrnscErrorList")
	@ResponseBody
	public ResponseVO selectOverlapTrnscErrorList(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		// 리스트 카운트 조회
		int totalRecordCount = trnscErrorService.getOverlapTrnscErrorCount(map);
		
		
		if (totalRecordCount > 0) {
			
			//페이징 정보 조회
			PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, totalRecordCount);
			
			//조회조건에 페이징 정보 설정
			map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, totalRecordCount));
			
			//디바이스 리스트 조회
			List<Map<String, Object>> resultList = trnscErrorService.selectOverlapTrnscErrorList(map); 
	
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
	
	@RequestMapping(value = "/setOverlapTrnscError")
	@ResponseBody
	public ResponseVO setOverlapTrnscError(@RequestBody Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		return new ResponseVO(trnscErrorService.setOverlapTrnscError(map));
	}

}
