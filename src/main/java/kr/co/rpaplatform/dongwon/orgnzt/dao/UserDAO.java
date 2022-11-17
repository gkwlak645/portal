package kr.co.rpaplatform.dongwon.orgnzt.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.co.rpaplatform.dongwon.stdrinfo.vo.CmmnCdVO;
import kr.co.rpaplatform.dongwon.orgnzt.vo.UserVO;

/**
 * 
 * @author jw.lee
 *
 */
@Repository
public class UserDAO {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(UserDAO.class);

	/**
	 * 
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	@Resource(name="groupwareSession")
	private SqlSession groupwareSession;
	
	public List<Map<String, Object>> selectUserList(Map<String, Object> map) throws Exception {
		logger.debug("UserDAO selectUserList started !!!");
		logger.debug("UserDAO selectUserList end !!!");
		
		return sqlSession.selectList("selectUserList", map);
	}
	
	public int selectTotalCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("selectTotalCount", map);
	}
	
	public List<CmmnCdVO> selectCategoryList() throws Exception{
		return sqlSession.selectList("selectCode");
	}
	
	
	
	public void insertUser(UserVO reguservo) throws Exception{
		sqlSession.insert("insertUser", reguservo);
	}

	/*public int selectTotalCount(UserVO vo) throws Exception {
		logger.debug("UserDAO selectTotalCount started !!!");
		
		int totalCount =  sqlSession.selectOne("selectTotalCount",vo);

		logger.debug("UserDAO selectTotalCount end !!!");
		
		return totalCount;
	}*/

	public UserVO selectDetailUserValue(UserVO vo) throws Exception{
		return sqlSession.selectOne("selectDetailUserValue",vo);
	}
	
	public void updateUser(UserVO vo) throws Exception{
		logger.debug("UserDAO updateUser started !!!");
		
		sqlSession.update("updateUser", vo);
		
		logger.debug("UserDAO updateUser end !!!");
	}
	
	public void updateUserDetail(UserVO vo) throws Exception{
		logger.debug("UserDAO updateUserDetail started !!!");
		
		sqlSession.update("updateUserDetail", vo);
		
		logger.debug("UserDAO updateUserDetail end !!!");
	}
	
	
	public void deleteUser(UserVO vo) throws Exception{
		logger.debug("UserDAO deleteUser started !!!");
		
		sqlSession.delete("deleteUser", vo);
		
		logger.debug("UserDAO deleteUser end !!!");
	}
	
	public int selectEmpTotalCount(UserVO vo) throws Exception {
		logger.debug("UserDAO selectEmpTotalCount started !!!");
		
		int totalCnt = sqlSession.selectOne("selectEmpTotalCount", vo);
		
		logger.debug("UserDAO selectEmpTotalCount end !!!");
		return totalCnt;
	}

	public List<UserVO> selectUserRoleMngList(UserVO vo) throws Exception{
		logger.debug("UserDAO selectUserRoleMngList started !!!");
		List<UserVO> userList = sqlSession.selectList("selectUserRoleMngList", vo);
		logger.debug("UserDAO selectUserRoleMngList end !!!");
		return userList;
	}
	
	public List<UserVO> selectEmp(UserVO vo) throws Exception{
		logger.debug("UserDAO selectUserRoleMngList started !!!");
		List<UserVO> userList = sqlSession.selectList("selectEmp", vo);
		logger.debug("UserDAO selectUserRoleMngList end !!!");
		return userList;
	}
	
	public int selectUserIdCheck(UserVO vo) throws Exception{
		logger.debug("UserDAO selectUserIdCheck started !!!");
		return sqlSession.selectOne("selectUserIdCheck", vo);
	}
	
	public String getMbtlnum(String userId) throws Exception{
		logger.debug("UserDAO getMbtlnum started !!!");
		return groupwareSession.selectOne("GwpwrUserMapper.getGwpwrUserMbtlnum", userId);
	}
}
