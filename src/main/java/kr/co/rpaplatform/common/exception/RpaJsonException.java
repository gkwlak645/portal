/**
 * 
 */
package kr.co.rpaplatform.common.exception;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author LSH
 *
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class RpaJsonException extends Exception {
	
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 오류코드
	 */
	private String errorCode;
	
	/**
	 * 오류메시지
	 */
	private String errorMessage;
	
	/**
	 * 추가 메시지
	 */
	private String[] additionalMessage;
	
	/**
	 * 생성자
	 */
	public RpaJsonException() {
		
	}
	
	/**
	 * 생성자
	 */
	public RpaJsonException(String errorCode) {
		this.errorCode = errorCode;
	}
	
	/**
	 * 생성자
	 */
	public RpaJsonException(String errorCode, String errorMessage) {
		this.errorCode = errorCode;
		this.errorMessage = errorMessage;
	}
	
	/**
	 * 생성자
	 */
	public RpaJsonException(String errorCode, String[] additionalMessage) {
		this.additionalMessage = additionalMessage;
	}

}
