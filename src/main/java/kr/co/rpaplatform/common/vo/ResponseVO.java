package kr.co.rpaplatform.common.vo;

import java.io.Serializable;

import lombok.Data;

/**
 * 응답(JSON형태) VO
 * @author LSH
 *
 */
@Data
public class ResponseVO implements Serializable {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 7850357626854345802L;
	
	/**
	 * 응답코드
	 */
	private String responseCode = "I101";
	
	/**
	 * 응답메시지
	 */
	private String responseMessage = "정상적으로 처리되었습니다.";
	
	/**
	 * 트랜잭션 아이디
	 */
	private String transactionId;
	
	/**
	 * 응답객체
	 */
	private Object result;
	
	/**
	 * 생성자
	 */
	public ResponseVO() {}
	
	/**
	 * 생성자
	 * @param result
	 */
	public ResponseVO(Object result) {
		this.result = result;
	}
	
	/**
	 * 생성자
	 * @param responseCode
	 * @param responseMessage
	 */
	public ResponseVO(String responseCode, String responseMessage) {
		this.responseCode = responseCode;
		this.responseMessage = responseMessage;
	}
	
	/**
	 * 생성자
	 * @param responseCode
	 * @param responseMessage
	 * @param result
	 */
	public ResponseVO(String responseCode, String responseMessage, Object result) {
		this.responseCode = responseCode;
		this.responseMessage = responseMessage;
		this.result = result;
	}

}
