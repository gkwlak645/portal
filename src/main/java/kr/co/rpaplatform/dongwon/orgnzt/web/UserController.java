/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 1.         LSH
 */
package kr.co.rpaplatform.dongwon.orgnzt.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

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
import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.common.util.MessageDigestUtil;
import kr.co.rpaplatform.common.vo.ResponseVO;
import kr.co.rpaplatform.dongwon.common.util.PaginationUtil;
import kr.co.rpaplatform.dongwon.orgnzt.service.UserService;
import kr.co.rpaplatform.dongwon.orgnzt.vo.UserVO;
import kr.co.rpaplatform.dongwon.stdrinfo.vo.CmmnCdVO;


/**
 * @author LSH
 * 2020. 6. 1.
 */
@Controller
@RequestMapping("/orgnzt/user")
public class UserController {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Resource(name="userService")
	private UserService userService;
	
	@Resource(name="mailSender")
	private JavaMailSender mailSender;
	
	/**
	 * 사용자관리화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/userManageListMain", method = RequestMethod.GET)
	public ModelAndView userManageList() throws Exception {
		ModelAndView mav = new ModelAndView("/orgnzt/user/userManageListMain");
		return mav;
	}
	
	/**
	 * 유저 테이블 가져오기
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/userManageList", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO userManageList(@RequestBody Map<String, Object> map) throws Exception {
		
		logger.debug("UserController userManageList started !!!");

		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		// 리스트 카운트 조회
		int totalRecordCount = userService.selectTotalCount(map);	
		
		if(totalRecordCount > 0) {
			//페이징 정보 조회
			PaginationInfo paginationInfo = PaginationUtil.getPaginationInfo(map, totalRecordCount);		
			
			//조회조건에 페이징 정보 설정
			map.put("paginationInfo", PaginationUtil.getPaginationInfo(map, totalRecordCount));

			//디바이스 리스트 조회
			List<Map<String, Object>> resultList = userService.getUserList(map); 	
			
			//결과값 설정
			returnMap.put("resultList", resultList);
			returnMap.put("paginationInfo", paginationInfo);
		}
		else {
			//결과값 설정
			returnMap.put("resultList", null);
			returnMap.put("paginationInfo", PaginationUtil.getPaginationInfo(map, 0));
		}
		
		logger.debug("UserController userManageList end !!!");
		
		return new ResponseVO(returnMap);
	}

	/**
	 * 유저등록페이지 화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/userRegisterPagePop", method = RequestMethod.GET)
	public ModelAndView userRegister1() throws Exception {
		ModelAndView mav = new ModelAndView("/orgnzt/user/userRegisterPagePop");
		return mav;
	}
		
	
	
	/**
	 * 유저페이지 직급 카테고리
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/userCategory", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO getUserRegisterCategory() throws Exception {
		
		logger.debug("UserController getUserRegisterCategory started !!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		List<CmmnCdVO> list = userService.getCategoryList();
		
		resultData.put("list", list);
		
		logger.debug("UserController getUserRegisterCategory end !!!");

		return new ResponseVO(resultData);
	}
		
	/**
	 * 유저 등록 및 이메일 발송
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/registerUser", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO setUser(@RequestBody UserVO vo) throws Exception{
		logger.debug("UserController setUser started !!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		String email = vo.getEmailAdr();
		String userName = vo.getTxEmpNm();
		

		int ranKey =(int)(Math.random()*1000000)+1000000;
		
		if(ranKey > 1000000) {
			ranKey = ranKey - 1000000;
		}
		
		String Key = Integer.toString(ranKey);
		
		MailHandler sendMail = new MailHandler(mailSender);
		sendMail.setSubject("RPA포탈 임시 비밀번호입니다.");
		sendMail.setText(new StringBuffer()
                .append("<h1>임시비밀번호는 ")
                .append(Key)
                .append(" 입니다.</h1>")
                .append("<br><h1> 로그인하여 비밀번호를 꼭 수정하여 주시기 바랍니다.</h1>")
                .toString());
		sendMail.setFrom("cic9305@naver.com", "RPA포탈");
		sendMail.setTo(email, userName);
		sendMail.send();
		
		String encPassword = MessageDigestUtil.getMessageDigest(Key);
		
		vo.setPassword(encPassword);
		
		userService.setUser(vo);
		
		logger.debug("UserController setUser end !!!");

		return new ResponseVO(resultData);
	}
		
		
	/**
	 * 유저디테일페이지  화면
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/userDetailPagePop", method = RequestMethod.GET)
	public ModelAndView userDetailPage() throws Exception {
		ModelAndView mav = new ModelAndView("/orgnzt/user/userDetailPagePop");
		return mav;
	}
		
		
	/**
	 * 유저디테일페이지  유저 정보 불러오기
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/userDetailPagePop", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO userDetailSelectPage(@RequestBody UserVO vo) throws Exception {
		logger.debug("UserController userSelectDetailPage started !!!");

		Map<String, Object> resultData = new HashMap<String, Object>();

		resultData.put("userDetailSelect", userService.getUserDetailValue(vo));
		
		logger.debug("UserController userSelectDetailPage end !!!");

		return new ResponseVO(resultData);
	}
	
	/**
	 * 유저디테일페이지  유저 수정
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/userUpdate", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO userUpdate(@RequestBody UserVO vo) throws Exception {
		logger.debug("UserController userDelete started !!!");

		Map<String, Object> resultData = new HashMap<String, Object>();
		
		userService.updateUser(vo);

		logger.debug("UserController userDelete end !!!");

		return new ResponseVO(resultData);
	}
		
	/**
	 * 유저디테일페이지  유저 삭제
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/userDelete", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO userDelete(@RequestBody UserVO vo) throws Exception {
		logger.debug("UserController userDelete started !!!");

		Map<String, Object> resultData = new HashMap<String, Object>();
		
		userService.deleteUser(vo);

		logger.debug("UserController userDelete end !!!");

		return new ResponseVO(resultData);
	}
		
	/**
	 * 유저권한 검색
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/userRoleMngList", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO userRoleMngList(@RequestBody UserVO vo) throws Exception {
		
		logger.debug("UserController userRoleMngList started !!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();

		resultData.put("userRoleMng", userService.selectUserRoleMngList(vo));

		logger.debug("UserController userRoleMngList end !!!");
		
		return new ResponseVO(resultData);

	}
		
	/**
	 * 사원검색
	 * @return
	 * @throws Exception
	 */  
	@RequestMapping(value = "/userSearchEmpNum", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO selectEmp(@RequestBody UserVO vo) throws Exception {
		logger.debug("UserController selectEmp started !!!");
				
		Map<String, Object> resultData = new HashMap<String, Object>();

		resultData.put("userList", userService.selectEmp(vo));

		logger.debug("UserController selectEmp end !!!");
		
		return new ResponseVO(resultData);

	}
	
	/**
	 * 아이디 중복 체크
	 * @return
	 * @throws Exception
	 */  
	@RequestMapping(value = "/selectUserIdCheck", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO selectUserIdCheck(@RequestBody UserVO vo) throws Exception{
		logger.debug("UserController selectUserIdCheck started !!!");
		
		Map<String, Object> resultData = new HashMap<String, Object>();
		
		resultData.put("idCheck", userService.selectUserIdCheck(vo));
		
		logger.debug("UserController selectUserIdCheck end !!!");
		
		return new ResponseVO(resultData);
	}
}
