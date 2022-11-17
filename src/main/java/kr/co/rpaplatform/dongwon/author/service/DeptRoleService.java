package kr.co.rpaplatform.dongwon.author.service;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.rpaplatform.dongwon.author.dao.DeptRoleDAO;
import kr.co.rpaplatform.dongwon.author.vo.DeptRoleVO;


/**
 * 
 * @author jw.lee
 *
 */
@Service
public class DeptRoleService {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(DeptRoleService.class);
	
	@Resource(name="deptRoleDAO")
	private DeptRoleDAO deptRoleDAO;
	
	public DeptRoleVO selectDeptRole(DeptRoleVO vo) throws Exception {
		logger.debug("DeptRoleService selectDeptRole started !!!");
		
		DeptRoleVO deptRole = deptRoleDAO.selectDeptRole(vo);
		
		logger.debug("DeptRoleService selectDeptRole end !!!");
		
		return deptRole;
	}

	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void insertDeptRole(DeptRoleVO vo) throws Exception {
		logger.debug("DeptRoleService insertDeptRole started !!!");
		
		deptRoleDAO.deleteDeptRole(vo);
		deptRoleDAO.insertDeptRole(vo);
		
		logger.debug("DeptRoleService insertDeptRole end !!!");
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void deleteDeptRole(DeptRoleVO vo) throws Exception {
		logger.debug("DeptRoleService deleteDeptRole started !!!");
		
		deptRoleDAO.deleteDeptRole(vo);
		
		logger.debug("DeptRoleService deleteDeptRole end !!!");
	}
}
