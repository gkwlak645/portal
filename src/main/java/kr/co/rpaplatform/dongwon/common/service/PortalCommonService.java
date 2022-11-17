package kr.co.rpaplatform.dongwon.common.service;


import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import kr.co.rpaplatform.dongwon.author.service.AuthorService;
import kr.co.rpaplatform.dongwon.author.service.UserRoleService;
import kr.co.rpaplatform.dongwon.author.vo.AuthorVO;
import kr.co.rpaplatform.dongwon.common.dao.PortalCommonDao;

@Service
public class PortalCommonService {
	private final Logger logger = LoggerFactory.getLogger(PortalCommonService.class);
	
	@Resource(name="portalCommonDao")
	private PortalCommonDao portalCommonDao;
	
	public String getTenantId(String cmpnyCd) throws Exception {
		return portalCommonDao.getTenantId(cmpnyCd);
	}
	
	
	/*
	 * 화면 권한 가져오기
	 */
	public AuthorVO getScreenAuthor(HttpServletRequest req) throws Exception {
		String urlPath = null;
		
		String requestURI = req.getRequestURI();
		logger.debug("requestURI : {}", requestURI);
		
		if (requestURI.lastIndexOf("/") > 0) {
			urlPath = requestURI.substring(0, requestURI.lastIndexOf("/") + 1);
			logger.debug("menuUrl : {}", urlPath);
		}
		WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(req.getServletContext());
		return ((AuthorService)context.getBean("authorService")).getUserAuthorByUrl(urlPath);
	}
	
	
	/**
	 * 권한에 따른 파일 다운로드 버튼 활성화 권한 체크
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectDownloadBtnUserRoleCount(HttpServletRequest req) throws Exception {
		WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(req.getServletContext());
		return ((UserRoleService)context.getBean("userRoleService")).selectDownloadBtnUserRoleCount();
	}
	 
	

}
