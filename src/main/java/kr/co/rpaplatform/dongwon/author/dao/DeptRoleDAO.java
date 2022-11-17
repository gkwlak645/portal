package kr.co.rpaplatform.dongwon.author.dao;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.co.rpaplatform.dongwon.author.vo.DeptRoleVO;


/**
 * 
 * @author jw.lee
 *
 */
@Repository
public class DeptRoleDAO {
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(DeptRoleDAO.class);
	
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	public DeptRoleVO selectDeptRole(DeptRoleVO vo) throws Exception {
		logger.debug("DeptDAO selectDeptRole started !!!");
		
		DeptRoleVO deptRole = sqlSession.selectOne("selectDeptRole",vo);
		
		logger.debug("DeptDAO selectDeptRole end !!!");
		
		return deptRole;
	}

	public void insertDeptRole(DeptRoleVO vo) throws Exception {
		logger.debug("DeptDAO insertDeptRole started !!!");
		
		sqlSession.update("insertDeptRole",vo);
		
		logger.debug("DeptDAO insertDeptRole end !!!");
	}
	
	public void deleteDeptRole(DeptRoleVO vo) throws Exception {
		logger.debug("DeptDAO deleteDeptRole started !!!");
		
		sqlSession.update("deleteDeptRole",vo);
		
		logger.debug("DeptDAO deleteDeptRole end !!!");
	}

}
