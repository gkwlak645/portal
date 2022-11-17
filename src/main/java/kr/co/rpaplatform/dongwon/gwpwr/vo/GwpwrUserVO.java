package kr.co.rpaplatform.dongwon.gwpwr.vo;

import java.io.Serializable;

import lombok.Data;

/**
 * 그룹웨어 사용자 VO
 * @author LSH
 */
@Data
public class GwpwrUserVO implements Serializable  {
	
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 그룹웨어 아이디
	 */
	private String gwpwrId;
	
	/**
	 * 사용자명
	 */
	private String userNm;
	
	/**
	 * 휴대폰번호
	 */
	private String mbtlnum;
	
	/**
	 * 이메일
	 */
	private String email;
	
	/**
	 * 회사코드
	 */
	private String cmpnyCd;
	
	/**
	 * 회사명
	 */
	private String cmpnyNm;
	
	/**
	 * 부서코드
	 */
	private String deptCd;
	
	/**
	 * 부서명
	 */
	private String deptNm;
	

}
