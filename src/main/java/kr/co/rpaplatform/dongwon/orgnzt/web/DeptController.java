package kr.co.rpaplatform.dongwon.orgnzt.web;

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

import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.author.vo.DeptRoleVO;
import kr.co.rpaplatform.dongwon.orgnzt.service.DeptService;
import kr.co.rpaplatform.dongwon.orgnzt.vo.DeptVO;


/**
 * @author LJW
 * 2020. 6. 4.
 */
@Controller
@RequestMapping("/orgnzt/dept")
public class DeptController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(DeptController.class);
	
	@Resource(name="deptService")
	private DeptService deptService;
	
	/**
	 * 부서관리 페이지
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/deptManageMain", method = RequestMethod.GET)
	public ModelAndView deptManage() throws Exception {
		ModelAndView mav = new ModelAndView("/orgnzt/dept/deptManageMain");
		return mav;
	}
	
	/**
	 * 부서정보 리스트
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/deptManageList", method = RequestMethod.GET)
	@ResponseBody
	public ResponseVO deptManageList() throws Exception {
		logger.debug("DeptController deptManageList started !!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		List<DeptVO> deptList = deptService.getDeptList();
		
		resultData.put("deptList", deptList);
		
		logger.debug("DeptController deptManageList end !!!");
		
		return new ResponseVO(resultData);
	}
	
	/**
	 * 상세 부서정보
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/deptDetail", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO deptDetail(@RequestBody DeptVO vo) throws Exception {
		logger.debug("DeptController deptDetail started !!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		resultData.put("deptDetail", deptService.getDeptDetail(vo));
		
		logger.debug("DeptController deptDetail end !!!");
		
		return new ResponseVO(resultData);
	}
	
	/**
	 * 부서 삭제
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/deptDelete", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO deptDelete(@RequestBody DeptRoleVO vo) throws Exception {
		logger.debug("DeptController deptDelete started !!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		deptService.deleteDept(vo);
		
		logger.debug("DeptController deptDelete end !!!");
		
		return new ResponseVO(resultData);
	}
	
	/**
	 * 부서 수정
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/deptUpdate", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO deptUpdate(@RequestBody DeptVO vo) throws Exception {
		logger.debug("DeptController deptUpdate started !!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		deptService.updateDept(vo);
		
		logger.debug("DeptController deptUpdate end !!!");
		
		return new ResponseVO(resultData);
	}
	
	/**
	 * 정렬 순서 수정
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/deptUpdateOrdr", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO deptUpdateOrdr(@RequestBody DeptVO vo) throws Exception {
		logger.debug("DeptController deptUpdateOrdr started !!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		deptService.updateOrdrDept(vo);
		
		logger.debug("DeptController deptUpdateOrdr end !!!");
		
		return new ResponseVO(resultData);
	}
	
}
