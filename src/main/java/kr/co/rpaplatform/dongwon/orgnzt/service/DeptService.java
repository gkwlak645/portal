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

import kr.co.rpaplatform.dongwon.author.service.DeptRoleService;
import kr.co.rpaplatform.dongwon.author.vo.DeptRoleVO;
import kr.co.rpaplatform.dongwon.orgnzt.dao.DeptDAO;
import kr.co.rpaplatform.dongwon.orgnzt.vo.DeptVO;



/**
 * 
 * @author jw.lee
 *
 */
@Service
public class DeptService {

	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(DeptService.class);
	
	@Resource(name="deptDAO")
	private DeptDAO deptDAO;
	
	@Resource(name="deptRoleService")
	private DeptRoleService deptRoleService;
	
	public List<DeptVO> getDeptList() throws Exception {
		logger.debug("DeptService getDeptList started !!!");
		
		List<DeptVO> deptList = deptDAO.selectDeptList();
		
		logger.debug("DeptService getDeptList end !!!");
		
		return deptList;
	}

	public Map<String, Object> getDeptDetail(DeptVO vo) throws Exception {
		logger.debug("DeptService getDeptDetail started !!!");
		
		Map<String, Object> result = new HashMap<>();
		result.put("item", deptDAO.selectDeptDetail(vo));
		result.put("ordr", deptDAO.selectDeptMaxOrdr(vo));
		
		logger.debug("DeptService getDeptDetail end !!!");
		
		return result;
	}

	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void deleteDept(DeptRoleVO vo) throws Exception {
		logger.debug("DeptService deleteDept started !!!");
		
		deptDAO.deleteDept(vo);
		childrenDelete(vo);
		
		logger.debug("DeptService deleteDept end !!!");
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateDept(DeptVO vo) throws Exception {
		logger.debug("DeptService updateDept started !!!");
		
		if(deptDAO.selectDeptDetail(vo) != null) {
			deptDAO.updateDept(vo);
		}else {
			deptDAO.insertDept(vo);
		}
		
		if(vo.getUseAt().equals("N")) {
			childrenUpdate(vo);
		}
		
		logger.debug("DeptService updateDept end !!!");
	}

	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateOrdrDept(DeptVO vo) throws Exception {
		logger.debug("DeptService updateOrdrDept started !!!");
		
		deptDAO.updateOrdrDept(vo);
		
		logger.debug("DeptService updateOrdrDept end !!!");
	}

	/**
	 * 현재부서의 사용여부를 N으로 바꿨을 때 자식부서 전부 바뀌는 재귀함수
	 * @param vo
	 * @throws Exception
	 */
	public void childrenUpdate(DeptVO vo) throws Exception {
		List<DeptVO> childList = deptDAO.selectChildDeptCd(vo);
		
		if(childList != null) {
			for(DeptVO i : childList) {
				vo.setDeptCd(i.getDeptCd());
				deptDAO.updateUseAtDept(vo);
				childrenUpdate(vo);
			}
		}
	}
	
	/**
	 * 현재부서의 하위부서와 하위부서의 권한을 삭제하는 재귀함수
	 * @param vo
	 * @throws Exception
	 */
	public void childrenDelete(DeptRoleVO vo) throws Exception {
		List<DeptVO> childList = deptDAO.selectChildDeptCd(vo);
		deptRoleService.deleteDeptRole(vo);
		
		if(childList != null) {
			for(DeptVO i : childList) {
				vo.setDeptCd(i.getDeptCd());
				deptDAO.deleteDept(vo);
				deptRoleService.deleteDeptRole(vo);
				childrenDelete(vo);
			}
		}
	}
}
