package kr.co.rpaplatform.dongwon.login.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.rpaplatform.common.mail.MailHandler;
import kr.co.rpaplatform.common.util.MessageDigestUtil;
import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.crontab.service.CronSchedulService;
import kr.co.rpaplatform.dongwon.batch.service.BatchService;
import kr.co.rpaplatform.dongwon.common.service.PortalCommonService;
import kr.co.rpaplatform.dongwon.common.util.AES256Util;
import kr.co.rpaplatform.dongwon.common.vo.CmmnUserVO;
import kr.co.rpaplatform.dongwon.login.service.LoginService;
import kr.co.rpaplatform.dongwon.orgnzt.vo.UserVO;
import kr.co.rpaplatform.dongwon.common.service.SendMailDw;

/**
 * @author LSH
 * 2020. 5. 28.
 */
@Controller
@RequestMapping("/login")
public class LoginController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Resource(name="loginService")
	private LoginService loginService;
	
	@Resource(name="mailSender")
	private JavaMailSender mailSender;
	
	@Resource(name="portalCommonService")
	private PortalCommonService portalCommonService;
	
	@Resource(name="batchService")
	private BatchService batchService;
	
	@Resource(name="sendMailDw")
	private SendMailDw sendMailDw;
	
	@Resource(name="cronSchedulService")
	private CronSchedulService cronSchedulService;

	
	@RequestMapping(value = "/loginPage", method=RequestMethod.POST)
	public String loginPagePost(HttpServletRequest req, HttpSession session) throws Exception {
		UserVO vo = new UserVO();
		String sUserId = req.getParameter("SSO_CHK_LOGIN_ID");
		
		if(sUserId != null && !sUserId.equals("")){
			AES256Util asc = new AES256Util();
			String sTemp = asc.encrypt(sUserId);
			vo.setUserId(asc.decrypt(sUserId));
			CmmnUserVO cmmnUserVO = loginService.selectUser(vo);
			
			if(cmmnUserVO != null && cmmnUserVO.getTxRoleUserAt().equals("Y")) {
				session.setAttribute("sessionUserInfo", cmmnUserVO);
			}
		}
		
		if(session.getAttribute("sessionUserInfo") != null) {
			return "redirect:/main/siteMain";
		}
		else {
			return "/login/loginPage";
		}
	}
	
	
	/**
	 * ????????? ????????? ??????
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/loginPage", method=RequestMethod.GET)
	public String loginPage(HttpServletRequest req, HttpSession session) throws Exception {
		if(session.getAttribute("sessionUserInfo") != null) {
			return "redirect:/main/siteMain";
		}
		else {
			return "/login/loginPage";
		}
	}
	
	/**
	 * ?????? ????????? ??????
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/login")
	public String login() throws Exception {
		return "/main/siteMain";
	}

	/**
	 * ???????????? ?????? ????????? ??????
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/findPwd")
	public ModelAndView forgetPwd() throws Exception {
		ModelAndView mav = new ModelAndView("/login/findPwd");
		return mav;
	}
	
	/**
	 * ????????? ?????? ????????? ??????
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/findId")
	public ModelAndView findId() throws Exception {
		ModelAndView mav = new ModelAndView("/login/findId");
		return mav;
	}
	
	/**
	 * ?????????&???????????? ??????
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/loginCheck", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO loginCheck(@RequestBody UserVO vo, HttpServletRequest req) throws Exception {
		logger.debug("UserController loginCheck started !!!");
		HttpSession session = req.getSession();
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		CmmnUserVO cmmnUserVO = loginService.loginCheck(vo);
		
		//TenantId ???????????? ?????????
		//portalCommonService.getTenantId("A");
		
		if(cmmnUserVO != null && cmmnUserVO.getTxRoleUserAt().equals("Y")) {
			session.setAttribute("sessionUserInfo", cmmnUserVO);
			resultData.put("result", cmmnUserVO);
		}

		logger.debug("UserController loginCheck end !!!");
		
		return new ResponseVO(resultData);
	}
	
	/**
	 * SSO ?????????&???????????? ??????
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/loginSsoCheck", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO loginSsoCheck(@RequestBody UserVO vo, HttpServletRequest req) throws Exception {
		logger.debug("UserController loginSsoCheck started !!!");
		HttpSession session = req.getSession();
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		if(loginService.loginSsoCheck(vo)) {
			CmmnUserVO cmmnUserVO = loginService.selectUser(vo);
			if(cmmnUserVO != null && cmmnUserVO.getTxRoleUserAt().equals("Y")) {
				session.setAttribute("sessionUserInfo", cmmnUserVO);
				resultData.put("result", cmmnUserVO);
			}
		}

		logger.debug("UserController loginSsoCheck end !!!");
		
		return new ResponseVO(resultData);
	}

	/**
	 * ????????? ?????? ??????????????? 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value ="/sendFindId", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO setNewId(@RequestBody UserVO vo) throws Exception{
		logger.debug("LoginController sendFindId started !!!");
		Map<String, Object> resultData = new HashMap<String, Object>();

		UserVO sVo  = loginService.selectFindId(vo);
		
		String email = sVo.getEmailAdr();
		String userId =sVo.getUserId();
		String userName = sVo.getEmpNm();
		
		if(userId != null && email != null && userName != null) {	
			MailHandler sendMail = new MailHandler(mailSender);
			sendMail.setSubject("RPA?????? ??????????????????.");
			sendMail.setText(new StringBuffer()
		            .append("<h1>???????????? ???????????? ")
		            .append(userId)
		            .append(" ?????????.</h1>")
		            .append("<br><h1>????????? ????????? ???????????????.</h1>")
		            .toString());
			sendMail.setFrom("cic9305@naver.com", "RPA??????");
			sendMail.setTo(email, userName);
			sendMail.send();
			resultData.put("result", sVo);
		}else{
			resultData.put("result", "");
		}
		logger.debug("LoginController sendFindId end !!!");
		return new ResponseVO(resultData);
	}
	
	/**
	 * ??? ?????? ???????????? ????????? 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value ="/sendNewPwd", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO setNewPwd(@RequestBody UserVO vo) throws Exception{
		Map<String, Object> resultData = new HashMap<String, Object>();

		int checkIdEmail  = loginService.selectCountEmail(vo);

		UserVO cVo = new UserVO();
		if(checkIdEmail > 0) {
			cVo = vo;
			String email = cVo.getEmailAdr();
			String userId = cVo.getUserId();
			
			int ranKey =(int)(Math.random()*1000000)+1000000;
			if(ranKey > 1000000) {
				ranKey = ranKey - 1000000;
			}
			
			String Key = Integer.toString(ranKey);
			MailHandler sendMail = new MailHandler(mailSender);
			sendMail.setSubject("RPA?????? ?????? ?????????????????????.");
			sendMail.setText(new StringBuffer()
	                .append("<h1>????????????????????? ")
	                .append(Key)
	                .append(" ?????????.</h1>")
	                .append("<br><h1> ??????????????? ??????????????? ??? ???????????? ????????? ????????????.</h1>")
	                .toString());
			sendMail.setFrom("cic9305@naver.com", "RPA??????");
			sendMail.setTo(email, userId);
			sendMail.send();
			
			String enPassword = MessageDigestUtil.getMessageDigest(Key);
			
			cVo.setPassword(enPassword);
			
			loginService.updatePwd(cVo);
			
			resultData.put("result", "true");
		}else {
			resultData.put("result", "false");
		}
		
		return new ResponseVO(resultData);

	}
	
	@RequestMapping(value = "/logout", method=RequestMethod.GET)
	public String logout(HttpSession session) throws Exception {
		
		logger.debug("logout!");
		session.invalidate();
		return "redirect:/login/loginPage";
	}

	
	
	/**
	 * ???????????? ????????? ??????
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/testLogin")
	public String testLogin(HttpServletRequest request) throws Exception {

		CmmnUserVO cmmnUserVO = new CmmnUserVO();
		cmmnUserVO.setTxUserId("testuser1");
		cmmnUserVO.setTxEmpNo("210015");
		cmmnUserVO.setTxEmpNm("?????????");
		cmmnUserVO.setTxDeptCd("0104010000");
		cmmnUserVO.setTxDeptNm("??????1???");
		cmmnUserVO.setTxPstCd("04");
		cmmnUserVO.setTxPstNm("??????");
		
		HttpSession session = request.getSession();
		session.setAttribute("sessionUserInfo", cmmnUserVO);
		
		logger.debug("UserController loginCheck end !!!");
		
		return "redirect:/main/siteMain";
	}
	

	//------------------------------------------
	//	????????? ?????? ??????
	//------------------------------------------
	
	
	/**
	 * ???????????? SyncDept
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/syncDongwonDeptAndUser")
	public String syncDongwonDept(HttpServletRequest request) throws Exception {
		batchService.syncDongwonDept();
		batchService.syncDongwonUser();
		return "redirect:/main/siteMain";
	}
	
	@RequestMapping(value = "/testUploadType2")
	public String testUploadType2(HttpServletRequest request) throws Exception {
		return "/test/testUploadType2";
	}
	
	@RequestMapping(value = "/testSyncExecutDscntcImg")
	public String testSyncExecutDscntcImg(HttpServletRequest request) throws Exception {
		batchService.syncExecutDscntcImg();
		return "/test/testSyncExecutDscntcImg";
	}
	
	
	@RequestMapping(value = "testSendMailDw")
	public String SendMailDw(HttpServletRequest request) throws Exception {
		sendMailDw.sendMail("sm.yu@echoit.co.kr", "[RPA????????????]????????????", "????????????<br>???????????????");
		return "redirect:/main/siteMain";
	}
	
	
	@RequestMapping(value = "/testInsertStatData")
	public String testInsertStatData(HttpServletRequest request) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		cronSchedulService.insertDailyStsTotLog(map);
		return "redirect:/main/siteMain";
	}
	//------------------------------------------
	//	????????? ?????? ??????
	//------------------------------------------
	

}
