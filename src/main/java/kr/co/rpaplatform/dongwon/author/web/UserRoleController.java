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
import kr.co.rpaplatform.dongwon.author.web.RoleMngController;
import kr.co.rpaplatform.dongwon.author.service.UserRoleService;
import kr.co.rpaplatform.dongwon.author.vo.UserRoleVO;

/**
 * 사용자별역할관리 컨트롤러
 * @author CIC
 * 2020. 6. 12.
 */
@Controller		
@RequestMapping("/author/userrole")
public class UserRoleController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(RoleMngController.class);
	
	/**
	 * 역할관리 서비스
	 */
	@Resource(name="userRoleService")
	private UserRoleService userRoleService;
	
	/**
	 * 사용자별 역할 관리 화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/userRoleListMain")
	public ModelAndView userRoleListMain() throws Exception {
		ModelAndView mav = new ModelAndView("/author/userrole/userRoleListMain");
		return mav;
	}
	
	/**
	 * 사용자별역할관리 수정 및 추가
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/updateUserRole", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO updateUserRole(@RequestBody UserRoleVO vo) throws Exception {
		logger.debug("UserRoleController updateUserRole started !!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		userRoleService.updateUserRole(vo);

		logger.debug("UserRoleController updateUserRole end !!!");
		
		return new ResponseVO(resultData);
	}
	
	/**
	 * 사용자별역할관리 역할 확인
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/getUserRole", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getUserRole(@RequestBody UserRoleVO vo) throws Exception {
		logger.debug("UserRoleController getUserRole started !!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		//resultData.put("userRoleList", userRoleService.getUserRole(vo));
		resultData.put("userRole", userRoleService.getUserRole(vo));

		logger.debug("UserRoleController getUserRole end !!!");
		
		return new ResponseVO(resultData);
	}

}
