package kr.co.rpaplatform.dongwon.author.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import kr.co.rpaplatform.dongwon.author.service.RoleMngService;
import kr.co.rpaplatform.dongwon.author.vo.RoleMngVO;
import kr.co.rpaplatform.dongwon.author.dao.UserRoleDAO;
import kr.co.rpaplatform.dongwon.author.vo.UserRoleVO;

@Service
public class UserRoleService {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(RoleMngService.class);
	
	/**
	 * 사용자별역할 DAO
	 */
	@Resource(name="userRoleDAO")
	private UserRoleDAO userRoleDAO;
	
	
	/**
	 * 사용자별역할 변경 및 등록
	 * @param role
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateUserRole(UserRoleVO vo) throws Exception {
		logger.debug("RoleService updateUserRole started !!!");
		
		int resultMng = userRoleDAO.selectCountUserRole(vo);
		if(resultMng == 1) {
			userRoleDAO.updateUserRole(vo);
		}else {
			userRoleDAO.insertUserRole(vo);
		}
		/*if(vo != null && vo.getRoleCdAray() != null && vo.getRoleCdAray().length > 0) {
			userRoleDAO.deleteUserRole(vo); 
			String roleCdAray[] = vo.getRoleCdAray();
			for(int i=0; i< roleCdAray.length ;i++) {
				vo.setRoleCd(roleCdAray[i]);
				userRoleDAO.insertUserRole(vo);
			}
		}*/
	}
	
	/**
	 * 사용자별역할 조회
	 * @param role
	 * @return
	 * @throws Exception
	 */
	/*public List<UserRoleVO> getUserRole(UserRoleVO vo) throws Exception{*/
	public UserRoleVO getUserRole(UserRoleVO vo) throws Exception{
		return userRoleDAO.getUserRole(vo);
	}
	
	/**
	 * 역할 삭제 시 사용자별 역할 삭제
	 * @param role
	 * @return
	 * @throws Exception
	 */
	public void deleteUserRole(UserRoleVO vo) throws Exception{
		userRoleDAO.deleteUserRole(vo);
	}
	
	
	/**
	 * 권한에 따른 파일 다운로드 버튼 활성화 권한 체크
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectDownloadBtnUserRoleCount() throws Exception {
		Map<String, Object> requestMap = new HashMap<String, Object>();
		return userRoleDAO.selectDownloadBtnUserRoleCount(requestMap);
	}
	
}
