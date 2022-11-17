/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 1.         LSH
 */
package kr.co.rpaplatform.dongwon.common.interceptor;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.co.rpaplatform.dongwon.author.service.AuthorService;
import kr.co.rpaplatform.dongwon.author.vo.AuthorVO;
import kr.co.rpaplatform.dongwon.common.vo.CmmnUserVO;
import kr.co.rpaplatform.dongwon.menu.service.MenuService;

/**
 * @author LSH
 * 2020. 6. 1.
 */
public class UserAuthInterceptor extends HandlerInterceptorAdapter {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(UserAuthInterceptor.class);
	
	/**
	 * 권한 및 메뉴 경로 무시할 URL 목록
	 */
	private final static String[] authExcludeUrls = {"/main/", "/login/", "/file/", "/gwpwr/user/", "/gwpwr/dept/","/task/payment/", "/resrce/"};
	
	/**
	 * 세션 무시할 URL 목록
	 */
	private final static String[] sessionExcludeUrls = {"/login/","/task/payment/"};
	
	@Value("${url.hostname}")
	private String url_hostname;
	
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		/*
		 * URL 확인
		 */
		String urlPath = null;
		
		String requestURI = request.getRequestURI();

		if (requestURI.startsWith("/resources/")) {
			return super.preHandle(request, response, handler);
		}
		
		logger.debug("requestURI : {}", requestURI);
		
		if (requestURI.lastIndexOf("/") > 0) {
			urlPath = requestURI.substring(0, requestURI.lastIndexOf("/") + 1);
			logger.debug("requestURL : {}", urlPath);
		}
		
		/*
		 * URL 이 세션 체크를 무시할 URL 이 아닌 경우 세션체크
		 */
		if (urlPath != null) {
			String URL = request.getRequestURL().toString();

			if(!isSessionExcludeUrl(urlPath) && URL.startsWith("http://") && URL.indexOf(url_hostname) >= 0) {
		    	String redirectURL = "https://" + url_hostname + requestURI;
		    	response.sendRedirect(redirectURL);
		    	//request.getRequestDispatcher(redirectURL).forward(request, response);
			    return false;
		    }
			
			if (!isSessionExcludeUrl(urlPath)) {
				logger.debug("url not !!!");
				if (request.getSession().getAttribute("sessionUserInfo") == null) {
					logger.debug("session not found");
					response.sendRedirect("/login/loginPage");
					return false;
				}
			}
		}
		
		/*
		 * 세션정보를 thread local 에 추가
		 */
		if (request.getSession().getAttribute("sessionUserInfo") != null) {
			
			CmmnUserVO cmmnUserVO = (CmmnUserVO)request.getSession().getAttribute("sessionUserInfo");
			
			// MDC 데이터 세팅
			MDC.put("txCmpnyCd", cmmnUserVO.getTxCmpnyCd());
			MDC.put("txUserId", cmmnUserVO.getTxUserId());
			MDC.put("txUserNm", cmmnUserVO.getTxEmpNm());
			MDC.put("txDeptCd", cmmnUserVO.getTxDeptCd());
			MDC.put("txDeptNm", cmmnUserVO.getTxDeptNm());
			
			//Attribute에 추가
			request.setAttribute("txCmpnyCd", MDC.get("txCmpnyCd"));
			request.setAttribute("txUserId", MDC.get("txUserId"));
			request.setAttribute("txUserNm", MDC.get("txUserNm"));
			request.setAttribute("txDeptCd", MDC.get("txDeptCd"));
			request.setAttribute("txDeptNm", MDC.get("txDeptNm"));
		}

        return super.preHandle(request, response, handler);
    }
	
	@Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

		if (modelAndView != null) {
			/*
			 * URL을 확인하여 메뉴URL 값 추출
			 */
			String urlPath = null;
			
			String requestURI = request.getRequestURI();
			logger.debug("requestURI : {}", requestURI);
			
			if (requestURI.lastIndexOf("/") > 0) {
				urlPath = requestURI.substring(0, requestURI.lastIndexOf("/") + 1);
				logger.debug("menuUrl : {}", urlPath);
			}
			
			/*
			 * URL에 따른 사용자 권한 조회 및 설정
			 */
			if (urlPath != null) {
				
				if (!isAuthExcludeUrl(urlPath)) {
	
					WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(request.getServletContext());
					AuthorVO screenAuthor = ((AuthorService)context.getBean("authorService")).getUserAuthorByUrl(urlPath);
					modelAndView.addObject("txScreenAuthor", screenAuthor);

					String menuPath = ((MenuService)context.getBean("menuService")).getCurrentMenuPath(urlPath);
					modelAndView.addObject("menuPath", menuPath);
					String[] menuPaths = menuPath.split(" / ");
					if (menuPaths != null && menuPaths.length > 0) {
						modelAndView.addObject("menuNm", menuPaths[menuPaths.length -1]);
					}
					
					List<Map<String, Object>> menuCdList = ((MenuService)context.getBean("menuService")).getPathMenuCdList(urlPath);
					if (menuCdList != null && menuCdList.size() > 0) {
						modelAndView.addObject("menuCdList", menuCdList);
					}
					
				} else {
					
					modelAndView.addObject("menuPath", "Dashboard");
					modelAndView.addObject("menuNm", "Dashboard");
				}
			
			}
		}
		
		// MDC 클리어
		MDC.clear();
		
        super.postHandle(request, response, handler, modelAndView);
    }
	
	/**
	 * 권한 및 메뉴 경로 무시할 URL 인지 확인
	 * @param urlPath
	 * @return
	 * @throws Exception
	 */
	private boolean isAuthExcludeUrl(String urlPath) throws Exception {
		
		for (String excludeUrl : authExcludeUrls) {
			if (urlPath.equals(excludeUrl)) {
				return true;
			}
		}
		
		return false;
	}
	
	/**
	 * 세션 체크 무시할 URL 인지 확인
	 * @param urlPath
	 * @return
	 * @throws Exception
	 */
	private boolean isSessionExcludeUrl(String urlPath) throws Exception {
		
		for (String excludeUrl : sessionExcludeUrls) {
			if (urlPath.equals(excludeUrl)) {
				return true;
			}
		}
		
		return false;
	}

}
