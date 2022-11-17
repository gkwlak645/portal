package kr.co.rpaplatform.dongwon.resrce.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.common.util.PaginationUtil;
import kr.co.rpaplatform.dongwon.resrce.service.EnvrnService;

/**
 * 환경 컨트롤러
 * @author KA.LEE
 * 2020. 6. 15.
 */
@Controller
@RequestMapping("/resrce/envrn")
public class EnvrnController {
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(EnvrnController.class);
	
	/**
	 * 환경 서비스
	 */
	@Resource(name="envrnService")
	private EnvrnService envrnService;
	
	/**
	 * 환경관리 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/envrnMngMain")
	public ModelAndView envrnMngMain() throws Exception {
		return new ModelAndView("/resrce/envrn/envrnMngMain");
	}

	/**
	 * 환경 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/getEnvrnList")
	@ResponseBody
	public ResponseVO getEnvrnList(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();

		//디바이스 리스트 카운트 조회
		int totalRecordCount = envrnService.getEnvrnCount(map);
	
		//페이징 정보 조회
		PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, totalRecordCount);
		
		//조회조건에 페이징 정보 설정
		map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, totalRecordCount));

		//디바이스 리스트 조회
		List<Map<String, Object>> resultList = envrnService.getEnvrnList(map);
		
		//결과값 설정
		returnMap.put("resultList", resultList);
		returnMap.put("paginationInfo", paginationInfo);
		
		return new ResponseVO(returnMap);
	}
	
	
	/**
	 * 환경 리스트 API 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/getEnvrnAPIList")
	@ResponseBody
	public ResponseVO getEnvrnAPIList(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();

		//디바이스 리스트 조회
		List<Map<String, Object>> resultList = envrnService.getEnvrnAPIList(map);
		
		return new ResponseVO(resultList);
	}
	
	/**
	 * 환경관리 등록 화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/envrnRegisterPagePop")
	public ModelAndView envrnRegPop() throws Exception {
		return new ModelAndView("/resrce/envrn/envrnRegisterPagePop");
	}
	
	/**
	 * 환경 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/registerEnvrn")
	@ResponseBody
	public ResponseVO registerEnvrn(@RequestBody Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = envrnService.registerEnvrn(map);
		return new ResponseVO(resultMap);
	}
	
	/**
	 * 환경 등록 - 로봇 목록 Get
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/envrnRobotRegisterPagePop")
	public ModelAndView getRobotList() throws Exception {
		return new ModelAndView("/resrce/envrn/envrnRobotRegisterPagePop");
	}

	/**
	 * 환경 등록 - 로봇 목록 Post
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/getRobotList")
	@ResponseBody
	public ResponseVO getRobotList(@RequestBody Map<String, Object> map) throws Exception {

		List<Map<String, Object>> resultList = envrnService.getRobotList(map);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("resultList", resultList);

		return new ResponseVO(resultMap);
	}
	
	/**
	 * 환경 등록 - 로봇 등록
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/addRobotToEnvrn")
	@ResponseBody
	public ResponseVO addRobotToEnvrn(@RequestBody Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = envrnService.addRobotToEnvrn(map);
		return new ResponseVO(resultMap);
	}
	
	/**
	 * 환경관리 상세 화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/envrnDetailPop")
	public ModelAndView envrnDetailPop() throws Exception {
		return new ModelAndView("/resrce/envrn/envrnDetailPop");
	}
	
	/**
	 * 환경관리 상세 조회
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/getEnvrnDetail")
	@ResponseBody
	public ResponseVO getEnvrnDetail(@RequestBody Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = envrnService.envrnDetailSelectPage(map);
		return new ResponseVO(resultMap);
	}
	
	/**
	 * 환경관리 삭제
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteEnvrn")
	@ResponseBody
	public ResponseVO deleteEnvrn(@RequestBody Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = envrnService.deleteEnvrn(map);
		return new ResponseVO(resultMap);
	}
	
	/**
	 * 환경관리 수정
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/updateEnvrn")
	@ResponseBody
	public ResponseVO updateEnvrn(@RequestBody Map<String, Object> map) throws Exception {
		Map<String, Object> resultMap = envrnService.updateEnvrn(map);
		return new ResponseVO(resultMap);
	}
	
	/**
	 * 환경관리 수정 - 환경x로봇 리스트 가져오기
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/getEnvrnRobotList")
	@ResponseBody
	public ResponseVO getEnvrnRobotList(@RequestBody Map<String, Object> map) throws Exception {
		List<Map<String, Object>> resultList = envrnService.getEnvrnRobotList(map);
		return new ResponseVO(resultList);
	}
}
