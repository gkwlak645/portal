package kr.co.rpaplatform.dongwon.mypage.dao;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.co.rpaplatform.dongwon.orgnzt.vo.UserVO;


@Repository
public class ChgPwdDAO {

	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(ChgPwdDAO.class);

	/**
	 * 
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	public void updateNewPassword(UserVO vo) throws Exception{
		sqlSession.update("updateNewPassword", vo);
	}
}
