/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 1.         LSH
 */
package kr.co.rpaplatform.dongwon.common.aop;

import java.util.Map;

import org.aspectj.lang.JoinPoint;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;

import kr.co.rpaplatform.dongwon.common.vo.CmmnUserVO;

/**
 * @author LSH
 * 2020. 6. 1.
 */
public class UserInfoSetAspect {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(UserInfoSetAspect.class);

	/**
	 * DAO 입력 파라미터에 사용자 정보 자동 설정
	 * @param joinPoint
	 * @throws Throwable
	 */
	public void beforeAdvice(JoinPoint joinPoint) throws Throwable {

		
		Object[] objects = joinPoint.getArgs();	// 입력파라미터 리스트
		
		if (objects != null && objects.length > 0) {
			
			for (Object object : objects) {
				
				String objectName = object.getClass().getName();
				
				logger.debug("objectName : {}", objectName);
				
				if (object instanceof kr.co.rpaplatform.dongwon.common.vo.CmmnUserVO) {	//VO 인 경우
					((CmmnUserVO)object).setTxUserId(MDC.get("txUserId"));	//사용자아이디 설정
					((CmmnUserVO)object).setTxDeptCd(MDC.get("txDeptCd"));	//부서 설정
				} else if (object instanceof java.util.Map) {	// Map 인 경우
					((Map)object).put("txUserId", MDC.get("txUserId"));	//사용자아이디 설정
					((Map)object).put("txDeptCd", MDC.get("txDeptCd"));	//부서 설정
				}
			}
		}
		
	}

}
