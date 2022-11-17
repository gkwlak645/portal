package kr.co.rpaplatform.dongwon.orgnzt.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.dongwon.orgnzt.dao.UserDAO;
import kr.co.rpaplatform.dongwon.orgnzt.vo.UserVO;
import kr.co.rpaplatform.dongwon.stdrinfo.vo.CmmnCdVO;

/**
 * 
 * @author jw.lee
 *
 */
@Service
public class UserService {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(UserService.class);
	
	@Resource(name="userDAO")
	private UserDAO userDAO;
	
	public List<Map<String, Object>> getUserList(Map<String, Object> map) throws Exception {
		logger.debug("UserService getUserList started !!!");
		logger.debug("UserService getUserList end !!!");
		return userDAO.selectUserList(map);
	}
	
	public int selectTotalCount(Map<String, Object> map) throws Exception {
		return userDAO.selectTotalCount(map);
	}

	public List<CmmnCdVO> getCategoryList() throws Exception{
		return userDAO.selectCategoryList();
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void setUser(UserVO vo) throws Exception{
		userDAO.insertUser(vo);
	}
		
	public Map<String, Object> getUserDetailValue(UserVO vo) throws Exception{
		logger.debug("UserService getUserDetailValue started !!!");
		Map<String, Object> result = new HashMap<>();
		result.put("items",userDAO.selectDetailUserValue(vo));
		logger.debug("UserService getUserDetailValue end !!!");
		return result;
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateUser(UserVO vo) throws Exception{
		logger.debug("UserService updateUser started !!!");
		
		userDAO.updateUser(vo);
		userDAO.updateUserDetail(vo);
		if(vo != null && vo.getUserCls() != null) {
			userDAO.updateUserDetail(vo);
		}
		
		logger.debug("UserService updateUser end !!!");
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void deleteUser(UserVO vo) throws Exception{
		logger.debug("UserService deleteUser started !!!");
		userDAO.deleteUser(vo);
		logger.debug("UserService deleteUser end !!!");
	}
	
	public List<UserVO> selectUserRoleMngList(UserVO vo) throws Exception{
		logger.debug("UserService selectUserRoleMngList started !!!");
		return userDAO.selectUserRoleMngList(vo);
	}
	
	public Map<String, Object> selectEmp(UserVO vo) throws Exception {
		logger.debug("UserService selectEmp started !!!");
		
		PaginationInfo pageInfo = vo.getPageInfo();

		pageInfo.setTotalRecordCount(userDAO.selectEmpTotalCount(vo));
		
		Map<String, Object> result = new HashMap<>();
		
		result.put("items", userDAO.selectEmp(vo));
		
		result.put("pageInfo", pageInfo);
		
		return result;
	}
	
	public int selectUserIdCheck(UserVO vo) throws Exception{
		logger.debug("UserService selectUserIdCheck started !!!");
		return userDAO.selectUserIdCheck(vo);
	}
	
	/*
	 * 사용자 핸드폰 전화번호
	 */
	
	public String getMbtlnum(String userId)  throws Exception{
		return userDAO.getMbtlnum(userId);
	}

}
