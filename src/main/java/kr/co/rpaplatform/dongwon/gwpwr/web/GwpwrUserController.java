package kr.co.rpaplatform.dongwon.gwpwr.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

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
import kr.co.rpaplatform.dongwon.gwpwr.service.GwpwrUserService;

/**
 * 그룹웨어 사용자 컨트롤러
 * @author LSH
 */
@Controller
@RequestMapping("/gwpwr/user")
public class GwpwrUserController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(GwpwrUserController.class);
	
	/**
	 * 그룹웨어 사용자 서비스
	 */
	@Resource(name="gwpwrUserService")
	private GwpwrUserService gwpwrUserService;
	
	
	/**
	 * 그룹웨어 사용자 팝업 화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/gwpwrUserPop")
	public ModelAndView gwpwrUserPop() throws Exception {
		return new ModelAndView("/gwpwr/user/gwpwrUserPop");
	}
	
	/**
	 * 그룹웨어 사용자 팝업 화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/gwpwrUserPopV2")
	public ModelAndView gwpwrUserPopV2() throws Exception {
		return new ModelAndView("/gwpwr/user/gwpwrUserPopV2");
	}
	
	/**
	 * 그룹웨어 사용자 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getGwpwrUserList")
	@ResponseBody
	public ResponseVO getGwpwrUserList(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();

		//그룹웨어 사용자 리스트 카운트 조회
		int totalRecordCount = gwpwrUserService.getGwpwrUserCount(map);
		
		if (totalRecordCount > 0) {
		
			//페이징 정보 조회
			PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, totalRecordCount);
			
			//조회조건에 페이징 정보 설정
			map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, totalRecordCount));
	
			//그룹웨어 사용자 리스트 조회
			List<Map<String, Object>> resultList = gwpwrUserService.getGwpwrUserList(map);
	
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
	 * 그룹웨어 사용자 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getGwpwrUserListV2")
	@ResponseBody
	public ResponseVO getGwpwrUserListV2(@RequestBody Map<String, Object> map) throws Exception {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();

		//그룹웨어 사용자 리스트 카운트 조회
		int totalRecordCount = gwpwrUserService.getGwpwrUserCountV2(map);
		
		if (totalRecordCount > 0) {
			//페이징 정보 조회
			PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, totalRecordCount);
			
			//조회조건에 페이징 정보 설정
			map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, totalRecordCount));
	
			//그룹웨어 사용자 리스트 조회
			List<Map<String, Object>> resultList = gwpwrUserService.getGwpwrUserListV2(map);
	
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
}
