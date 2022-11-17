package kr.co.rpaplatform.dongwon.mypage.web;

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
import kr.co.rpaplatform.dongwon.login.service.LoginService;
import kr.co.rpaplatform.dongwon.mypage.service.ChgPwdService;
import kr.co.rpaplatform.dongwon.orgnzt.vo.UserVO;

@Controller
@RequestMapping("/mypage/chgpwd")
public class ChgPwdController {
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(ChgPwdController.class);
	
	@Resource(name="loginService")
	private LoginService loginservice;
	
	@Resource(name="chgPwdService")
	private ChgPwdService chgPwdService;
	
	/**
	 * 비밀번호 변경 메인화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/chgPwdModifyMain", method = RequestMethod.GET)
	public ModelAndView userPwdModifyMain() throws Exception {
		ModelAndView mav = new ModelAndView("/mypage/chgpwd/chgPwdModifyMain");
		return mav;
	}
	
	
	/**
	 * 비밀번호 변경 팝업화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/chgPwdModifyPop", method = RequestMethod.GET)
	public ModelAndView chgPwdModifyPop() throws Exception {
		ModelAndView mav = new ModelAndView("/mypage/chgpwd/chgPwdModifyPop");
		return mav;
	}
	
	/**
	 * 비밀번호 변경
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/updateNewPassword", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO updateNewPassword(@RequestBody UserVO vo) throws Exception{
		logger.debug("ChgPwdController updateNewPassword started !!!");

		Map<String, Object> resultData = new HashMap<String, Object>();
		
		chgPwdService.updateNewPassword(vo);
		
		logger.debug("ChgPwdController updateNewPassword end !!!");
		
		return new ResponseVO(resultData);
	}

}
