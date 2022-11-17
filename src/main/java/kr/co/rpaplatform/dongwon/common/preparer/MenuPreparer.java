/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 5.         LSH
 */
package kr.co.rpaplatform.dongwon.common.preparer;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.tiles.Attribute;
import org.apache.tiles.AttributeContext;
import org.apache.tiles.preparer.ViewPreparer;
import org.apache.tiles.request.Request;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import kr.co.rpaplatform.dongwon.menu.service.MenuService;


/**
 * @author LSH
 * 2020. 6. 5.
 */
public class MenuPreparer implements ViewPreparer {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(MenuPreparer.class);
	
	/**
	 * 메뉴 서비스
	 */
	@Resource(name="menuService")
	private MenuService menuService;

	/* (non-Javadoc)
	 * @see org.apache.tiles.preparer.ViewPreparer#execute(org.apache.tiles.request.Request, org.apache.tiles.AttributeContext)
	 */
	@Override
	public void execute(Request tilesRequest, AttributeContext attributeContext) {
		
		try {

			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

			//메뉴 조회
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("userId", request.getAttribute("txUserId"));
			List<Map<String, Object>> menuList = menuService.getLeftMenuList(map);
			attributeContext.putAttribute("menuList", new Attribute(menuList), true);

		} catch (Exception e) {
			logger.error(e.toString());
			StackTraceElement[] elements = e.getStackTrace();
			for (StackTraceElement element : elements) {
				logger.error(element.toString());
			}
		}
	}

}
