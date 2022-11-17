/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 4. 13.         LSH
 */
package kr.co.rpaplatform.dongwon.common.aop;

import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.MessageSource;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import kr.co.rpaplatform.common.exception.RpaException;
import kr.co.rpaplatform.common.exception.RpaJsonException;

/**
 * @author LSH
 *
 */
public class ExceptionViewAspect {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(ExceptionViewAspect.class);
	
	/**
	 * MessageSource
	 */
	@Resource(name="messageSource")
	private MessageSource messageSource;
	
	/**
	 * Controller 에서 Exception 이 전달되었을때 처리
	 * @param joinPoint
	 * @return
	 * @throws Throwable
	 */
	public Object aroundAdvice(ProceedingJoinPoint joinPoint) throws Throwable {
		
		logger.debug(joinPoint.getSignature().getDeclaringType().getSimpleName() + "." + joinPoint.getSignature().getName() + " started !!!");
		
		Object result = null;
		
		try {
			
			result = joinPoint.proceed();
			
		} catch (Exception e) {
			
			//Exception 로그 출력
			printExceptionLog(e);
			
			//Exception 변환
			convertException(e, joinPoint);

			throw e;
			
		}
		
		logger.debug(joinPoint.getSignature().getDeclaringType().getSimpleName() + "." + joinPoint.getSignature().getName() + " end !!!");
		
		return result;
		
	}
	
	/**
	 * Exception 로그 출력
	 * @param e
	 * @throws Exception
	 */
	private void printExceptionLog(Exception e) throws Exception {
		
		logger.error(e.toString());
		StackTraceElement[] elements = e.getStackTrace();
		for (StackTraceElement element : elements) {
			logger.error(element.toString());
		}
		
	}
	
	/**
	 * Exception 변환
	 * @param e
	 * @param joinPoint
	 * @throws Exception
	 */
	private void convertException(Exception e, ProceedingJoinPoint joinPoint) throws Exception {
		
		
		logger.debug("return type : {}", ((MethodSignature)(joinPoint.getSignature())).getReturnType().getCanonicalName());
		
		String returnType = ((MethodSignature)(joinPoint.getSignature())).getReturnType().getCanonicalName();
		
		
		//Locale 구하기
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder .getRequestAttributes()).getRequest();
		Locale locale = request.getLocale();
		logger.debug("Locale : {}", locale.toString());
		
		if ("kr.co.rpaplatform.common.vo.ResponseVO".equals(returnType)) {	//리턴타입이 ResponseVO 인 경우 JSON으로 간주 처리
			
			RpaJsonException jsonException = null;
			
			if (e instanceof kr.co.rpaplatform.common.exception.RpaException) {	//사용자 Exception 인 경우
				jsonException = new RpaJsonException();
				String errorCode = ((RpaException)e).getErrorCode();
				jsonException.setErrorCode(errorCode);
				String errorMessage = "";
				//커스템 메시지 사용(ORC 에러 메시지 처리용)
				if(errorCode.equals("ECST")) {
					errorMessage = ((RpaException)e).getErrorMessage();
				}
				else if (((RpaException)e).getAdditionalMessage() != null) {
					errorMessage = messageSource.getMessage(errorCode, ((RpaException)e).getAdditionalMessage(), Locale.KOREAN);
				} else {
					errorMessage = messageSource.getMessage(errorCode, null, locale);
				}
				jsonException.setErrorMessage(errorMessage);
				
			} else {	//사용자 Exception 이 아닌 경우
				
				String errorCode = "E101";
				jsonException = new RpaJsonException(errorCode);
				jsonException.setErrorMessage(messageSource.getMessage(errorCode, null, locale));
			}
			
			throw jsonException;
			
		} else {
			
			RpaException exception = null;
			
			if (e instanceof kr.co.rpaplatform.common.exception.RpaException) {	//사용자 Exception 인 경우
				exception = new RpaException();
				String errorCode = ((RpaException)e).getErrorCode();
				exception.setErrorCode(errorCode);
				String errorMessage = "";
				if (((RpaException)e).getAdditionalMessage() != null) {
					errorMessage = messageSource.getMessage(errorCode, ((RpaException)e).getAdditionalMessage(), Locale.KOREAN);
				} else {
					errorMessage = messageSource.getMessage(errorCode, null, locale);
				}
				exception.setErrorMessage(errorMessage);
				
			} else {	//사용자 Exception 이 아닌 경우
				
				String errorCode = "E101";
				exception = new RpaException(errorCode);
				exception.setErrorMessage(messageSource.getMessage(errorCode, null, locale));
			}
			
			throw exception;
			
		}
	}

}
