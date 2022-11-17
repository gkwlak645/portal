package kr.co.rpaplatform.dongwon.login.dao;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.co.rpaplatform.dongwon.common.vo.CmmnUserVO;
import kr.co.rpaplatform.dongwon.orgnzt.vo.UserVO;

@Repository
public class LoginDAO {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(LoginDAO.class);

	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	/**
	 * 로그인 아이디와 비밀번호 체크 
	 * @return
	 * @throws Exception
	 */
	public UserVO LoginCheck(UserVO vo) throws Exception{
	
		return sqlSession.selectOne("loginCheck", vo);
	}
	
	
	/**
	 * 로그인 유저 정보
	 * @return
	 * @throws Exception
	 *//*
	public UserVO selectUser(UserVO vo)throws Exception{
		return sqlSession.selectOne("selectUser", vo);
	}*/
	
	/**
	 * 로그인 유저 정보
	 * @return
	 * @throws Exception
	 */
	public CmmnUserVO selectUser(UserVO vo)throws Exception{
		return sqlSession.selectOne("selectUser", vo);
	}
	
	/**
	 * 등록된 이메일 체크
	 * @return
	 * @throws Exception
	 */
	public int selectCountEmail(UserVO vo) throws Exception{
		logger.debug("LoginDAO selectCountEmail started !!!");
		logger.debug("LoginDAO selectCountEmail end !!!");
		return sqlSession.selectOne("selectCountEmail", vo);
	}
	
	/**
	 * 비밀번호 업데이트
	 * @return
	 * @throws Exception
	 */
	public UserVO updatePwd(UserVO vo) throws Exception{
		logger.debug("LoginDAO updatePwd started !!!");
		logger.debug("LoginDAO updatePwd end !!!");
		return sqlSession.selectOne("updatePwd", vo);
	}
	
	/**
	 * 전체 메뉴 리스트 조회
	 * @return
	 * @throws Exception
	 */
	public UserVO selectEmailUser(UserVO vo) throws Exception{
		logger.debug("LoginDAO selectEmailUser started !!!");
		logger.debug("LoginDAO selectEmailUser end !!!");
		return sqlSession.selectOne("selectEmailUser", vo);
	}
	
	/**
	 * 전체 메뉴 리스트 조회
	 * @return
	 * @throws Exception
	 */
	public UserVO selectFindId(UserVO vo) throws Exception{
		return sqlSession.selectOne("selectFindId", vo);
	}

}
