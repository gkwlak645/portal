package kr.co.rpaplatform.dongwon.mntrng.web;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.exception.RpaException;
import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.common.util.PaginationUtil;
import kr.co.rpaplatform.dongwon.file.vo.AtchFileVO;
import kr.co.rpaplatform.dongwon.mntrng.service.ExecutDscntcImgService;
import kr.co.rpaplatform.dongwon.mntrng.vo.ExecutDscntcImgVO;

/**
 * 작업 컨트롤러
 * @author 
 *
 */
@Controller
@RequestMapping("/mntrng/executdscntc")
public class ExecutDscntcImgController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(ExecutDscntcImgController.class);
	
	@Value("${executDscntcImg.move.path}")
	private String executDscntcImgMovePath;
	
	/**
	 * 작업 서비스
	 */
	@Resource(name="executDscntcImgService")
	private ExecutDscntcImgService executDscntcImgService;
	
	
	/**
	 * 실행중단이미지 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/executDscntcImgMain")
	public ModelAndView executDscntcImgMain() throws Exception {
		return new ModelAndView("/mntrng/executdscntc/executDscntcImgMain");
	}

	/**
	 * 실행중단이미지 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getSelectRobotList", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getSelectRobotList(@RequestBody Map<String, Object> map) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		List<Map<String, Object>> resultList = executDscntcImgService.getSelectRobotList(map);
		returnMap.put("resultList", resultList);

		return new ResponseVO(returnMap);
	}
	
	/**
	 * 실행중단이미지 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getExecutDscntcImgList", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getExecutDscntcImgList(@RequestBody ExecutDscntcImgVO vo) throws Exception {
		Map<String, Object> resultData = new HashMap<String, Object>();		
		resultData.put("executDscntcImgList", executDscntcImgService.getExecutDscntcImgList(vo));		
		return new ResponseVO(resultData);
	}
	
	/**
	 * 작업 상세 화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/executDscntcDetailPop")
	public ModelAndView executDscntcDetailPop() throws Exception {
		return new ModelAndView("/mntrng/executdscntc/executDscntcImgDetailPop");
	}
	
	/**
	 * 작업 상세 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getExecutDscntcImgDetail")
	@ResponseBody
	public ResponseVO getExecutDscntcImgDetail(@RequestBody ExecutDscntcImgVO vo) throws Exception {

		Map<String, Object> resultData = new HashMap<String, Object>();		
		resultData.put("executDscntcImg", executDscntcImgService.getExecutDscntcImgDetail(vo));		
		
		return new ResponseVO(resultData);
	}
	
	@RequestMapping(value = "/errorImg", method=RequestMethod.GET)
	public ModelAndView errorImg(@RequestParam("filePath") String sFilePath, @RequestParam("fileName") String sFileName) throws Exception {
			String filePath = executDscntcImgMovePath + sFilePath;
			//String filePath = "C:\\uploadErrorMoveImage\\2020\\0908\\1603688371109_I00101_robot3_20200908_130301.png";
			File downloadFile = new File(filePath);
			
			if (!downloadFile.exists()) {
				throw new RpaException("E104");
			}
			
			ModelAndView mav = new ModelAndView("downloadView");
			mav.addObject("downloadFile", downloadFile);
			mav.addObject("oriFileNm", sFileName);
			
			return mav;
	}

}
