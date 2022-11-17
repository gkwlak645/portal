package kr.co.rpaplatform.dongwon.gwpwr.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.gwpwr.service.GwpwrDeptService;

/**
 * 그룹웨어 부서 컨트롤러
 * @author LSH
 */
@Controller
@RequestMapping("/gwpwr/dept")
public class GwpwrDeptController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(GwpwrDeptController.class);
	
	/**
	 * 그룹웨어 부서 서비스
	 */
	@Resource(name="gwpwrDeptService")
	private GwpwrDeptService gwpwrDeptService;
	
	
	/**
	 * 그룹웨어 부서 조회 팝업
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/gwpwrDeptPop")
	public ModelAndView gwpwrDeptPop() throws Exception {
		return new ModelAndView("/gwpwr/dept/gwpwrDeptPop");
	}

	/**
	 * 그룹웨어 부서 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getGwpwrDeptList")
	@ResponseBody
	public ResponseVO getGwpwrDeptList(@RequestParam(value = "schDept",required = false) String schDept
			,@RequestParam(value = "cmpnyCd",required = false) String cmpnyCd) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("schDept", schDept);
		map.put("cmpnyCd", cmpnyCd);
		//그룹웨어 부서 리스트 조회
		List<Map<String, Object>> resultList = gwpwrDeptService.getAllGwpwrDeptList(map);
		
		return new ResponseVO(resultList);
	}
}
