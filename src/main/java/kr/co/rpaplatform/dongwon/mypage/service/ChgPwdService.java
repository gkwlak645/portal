package kr.co.rpaplatform.dongwon.mypage.service;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.co.rpaplatform.common.util.MessageDigestUtil;
import kr.co.rpaplatform.dongwon.mypage.dao.ChgPwdDAO;
import kr.co.rpaplatform.dongwon.orgnzt.service.UserSha256;
import kr.co.rpaplatform.dongwon.orgnzt.vo.UserVO;


@Service
public class ChgPwdService {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(ChgPwdService.class);
	
	@Resource(name="chgPwdDAO")
	private ChgPwdDAO chgPwdDAO;

	public void updateNewPassword(UserVO vo) throws Exception{
		String Key=vo.getPassword();
		
		String encPassword = MessageDigestUtil.getMessageDigest(Key);
		
		vo.setPassword(encPassword);
		
		chgPwdDAO.updateNewPassword(vo);
	}
}
