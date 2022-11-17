package kr.co.rpaplatform.dongwon.orgnzt.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.co.rpaplatform.dongwon.orgnzt.vo.DeptVO;

/**
 * 
 * @author jw.lee
 *
 */
@Repository
public class DeptDAO {

	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(DeptDAO.class);
	
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	public List<DeptVO> selectDeptList() throws Exception {
		logger.debug("DeptDAO selectDeptList started !!!");
		
		List<DeptVO> deptList =  sqlSession.selectList("selectDeptList");
		
		logger.debug("DeptDAO selectDeptList end !!!");
		
		return deptList;
	}

	public DeptVO selectDeptDetail(DeptVO vo) throws Exception {
		logger.debug("DeptDAO selectDeptDetail started !!!");

		DeptVO deptDetail =  sqlSession.selectOne("selectDeptDetail",vo);
		
		logger.debug("DeptDAO selectDeptDetail end !!!");
		
		return deptDetail;
	}

	public int selectDeptMaxOrdr(DeptVO vo) throws Exception {
		logger.debug("DeptDAO selectDeptMaxOrdr started !!!");

		int maxOrdr =  sqlSession.selectOne("selectDeptMaxOrdr",vo);
		
		logger.debug("DeptDAO selectDeptMaxOrdr end !!!");
		
		return maxOrdr;
	}

	public void insertDept(DeptVO vo) throws Exception {
		logger.debug("DeptDAO insertDept started !!!");
		
		sqlSession.insert("insertDept",vo);
		
		logger.debug("DeptDAO insertDept end !!!");
	}

	public void deleteDept(DeptVO vo) throws Exception {
		logger.debug("DeptDAO deleteDept started !!!");
		
		sqlSession.delete("deleteDept",vo);
		
		logger.debug("DeptDAO deleteDept end !!!");
	}

	public void updateDept(DeptVO vo) throws Exception {
		logger.debug("DeptDAO updateDept started !!!");
		
		sqlSession.update("updateDept",vo);
		
		logger.debug("DeptDAO updateDept end !!!");
	}
	
	public void updateUseAtDept(DeptVO vo) throws Exception {
		logger.debug("DeptDAO updateUseAtDept started !!!");
		
		sqlSession.update("updateUseAtDept",vo);
		
		logger.debug("DeptDAO updateUseAtDept end !!!");
	}

	public void updateOrdrDept(DeptVO vo) throws Exception {
		logger.debug("DeptDAO updateOrdrDept started !!!");
		
		sqlSession.update("updateOrdrDept",vo);
		
		logger.debug("DeptDAO updateOrdrDept end !!!");
	}

	public List<DeptVO> selectChildDeptCd(DeptVO vo) throws Exception {
		logger.debug("DeptDAO selectChildDeptCd started !!!");
		
		List<DeptVO> deptList = sqlSession.selectList("selectChildDeptCd",vo);
		
		logger.debug("DeptDAO selectChildDeptCd end !!!");
		return deptList;
	}

}
