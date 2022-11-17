package kr.co.rpaplatform.dongwon.author.web;

import java.util.HashMap;
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

import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.author.service.DeptRoleService;
import kr.co.rpaplatform.dongwon.author.vo.DeptRoleVO;

/**
 * @author LJW
 * 2020. 6. 12.
 */
@Controller
@RequestMapping("/author/deptrole")
public class DeptRoleController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(DeptRoleController.class);
	
	@Resource(name="deptRoleService")
	private DeptRoleService deptRoleService;
	
	/**
	 * 부서별 역활관리 페이지
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/deptRoleManageMain", method = RequestMethod.GET)
	public ModelAndView deptRoleManage() throws Exception {
		ModelAndView mav = new ModelAndView("/author/deptrole/deptRoleManageMain");
		return mav;
	}
	
	/**
	 * 부서에 해당하는 역할 출력
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/deptRole", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO deptRole(@RequestBody DeptRoleVO vo) throws Exception {
		logger.debug("DeptRoleController deptRole started !!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		DeptRoleVO deptRole = deptRoleService.selectDeptRole(vo);
		resultData.put("deptRole", deptRole);
		
		logger.debug("DeptRoleController deptRole end !!!");
		
		return new ResponseVO(resultData);
	}
	
	/**
	 * 부서 역할 수정(추가 및 삭제 후 추가)
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/deptInsertRole", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO deptInsertRole(@RequestBody DeptRoleVO vo) throws Exception {
		logger.debug("DeptRoleController deptInsertRole started !!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		deptRoleService.insertDeptRole(vo);
		
		logger.debug("DeptRoleController deptInsertRole end !!!");
		
		return new ResponseVO(resultData);
	}
}
