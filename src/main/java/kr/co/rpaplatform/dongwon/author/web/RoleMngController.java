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
import kr.co.rpaplatform.dongwon.author.service.RoleMngService;
import kr.co.rpaplatform.dongwon.author.vo.RoleMngVO;



/**
 * 역할관리 컨트롤러
 * @author CIC
 * 2020. 6. 10.
 */
@Controller		
@RequestMapping("/author/rolemng")
public class RoleMngController {
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(RoleMngController.class);
	
	/**
	 * 역할관리 서비스
	 */
	@Resource(name="roleMngService")
	private RoleMngService roleMngService;
	
	/**
	 * 역할관리 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/roleMngListMain")
	public ModelAndView roleMngListMain() throws Exception {
		ModelAndView mav = new ModelAndView("/author/rolemng/roleMngListMain");
		return mav;
	}
	
	/**
	 * 역할관리 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */ 
	@RequestMapping(value="/roleMngList", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getRoleMngList(@RequestBody RoleMngVO vo) throws Exception {
		logger.debug("RoleMngController getRoleMngList started !!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		resultData.put("roleMngList", roleMngService.getRoleMngList(vo));
		
		logger.debug("RoleMngController getRoleMngList end !!!");
		
		return new ResponseVO(resultData);
	}
	
	/**
	 * 역할관리 역할 수정 및 추가
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/updateRoleMng", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO updateRoleMng(@RequestBody RoleMngVO vo) throws Exception {
		logger.debug("RoleMngController updateRoleMng started !!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		roleMngService.updateRoleMng(vo);
		
		logger.debug("RoleMngController updateRoleMng end !!!");
		
		return new ResponseVO(resultData);
	}
	
	/**
	 * 역할관리 역할제거
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteRoleMng", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO deleteRoleMng(@RequestBody RoleMngVO vo) throws Exception {
		logger.debug("RoleMngController deleteRoleMng started !!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		roleMngService.deleteRoleMng(vo);
		
		logger.debug("RoleMngController deleteRoleMng end !!!");
		
		return new ResponseVO(resultData);
	}
}
