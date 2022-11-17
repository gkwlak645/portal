package kr.co.rpaplatform.dongwon.author.service;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.rpaplatform.dongwon.author.dao.RoleMngDAO;
import kr.co.rpaplatform.dongwon.author.vo.AuthorVO;
import kr.co.rpaplatform.dongwon.author.vo.RoleMngVO;
import kr.co.rpaplatform.dongwon.author.service.UserRoleService;
import kr.co.rpaplatform.dongwon.author.vo.UserRoleVO;


@Service
public class RoleMngService {
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(RoleMngService.class);
	
	/**
	 * 역할 DAO
	 */
	@Resource(name="roleMngDAO")
	private RoleMngDAO roleMngDAO;
	
	@Resource(name="userRoleService")
	private UserRoleService userRoleService;
	
	@Resource(name="authorService")
	private AuthorService authorService;
	
	/**
	 * 역할관리 조회
	 * @param role
	 * @return
	 * @throws Exception
	 */
	public List<RoleMngVO> getRoleMngList(RoleMngVO vo) throws Exception {
		logger.debug("RoleMngService getRoleMngList started !!!");
		logger.debug("RoleMngService getRoleMngList end !!!");
		return roleMngDAO.selectRoleMngList(vo);
		
	}
	
	/**
	 * 역할 추가 & 역할 수정
	 * @param role
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateRoleMng(RoleMngVO vo) throws Exception {
		logger.debug("RoleMngService updateRoleMng started !!!");
		int resultCount = roleMngDAO.selectCountRoleMngList(vo);
		System.out.println("resultCount :" + resultCount);
		if(resultCount == 1) {
			roleMngDAO.updateRoleMng(vo);
		}else {
			roleMngDAO.insertRoleMng(vo);
		}
		logger.debug("RoleMngService updateRoleMng end !!!");
		
	}
	
	/**
	 * 역할관리에서 역할 삭제 시 사용자별 역할 과 권한에 해당 역할 삭제
	 * @param role
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void deleteRoleMng(RoleMngVO vo) throws Exception {
		logger.debug("RoleMngService deleteRoleMng started !!!");
		
		UserRoleVO uvo = new UserRoleVO();
		uvo.setRoleCd(vo.getRoleCd());
		
		AuthorVO avo = new AuthorVO();
		avo.setRoleCd(vo.getRoleCd());
		
		userRoleService.deleteUserRole(uvo);
	
		authorService.deleteAuthorRoleCd(avo);
		
		roleMngDAO.deleteRoleMng(vo);
		
		logger.debug("RoleMngService deleteRoleMng end !!!");	
	}
	
}
