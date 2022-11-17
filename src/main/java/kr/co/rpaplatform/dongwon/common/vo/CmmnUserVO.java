/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 1.         LSH
 */
package kr.co.rpaplatform.dongwon.common.vo;

import java.io.Serializable;

import lombok.Data;

/**
 * 공통 사용자 정보 VO
 * @author LSH
 * 2020. 6. 1.
 */
@Data
public class CmmnUserVO implements Serializable {
	
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * 사용자아이디
	 */
	private String txUserId;
	
	/**
	 * 사원번호
	 */
	private String txEmpNo;
	
	/**
	 * 사원명
	 */
	private String txEmpNm;
	
	/**
	 * 직급코드
	 */
	private String txPstCd;
	
	/**
	 * 직급명
	 */
	private String txPstNm;
	
	/**
	 * 부서코드
	 */
	private String txDeptCd;
	
	/**
	 * 부서명
	 */
	private String txDeptNm;
	
	/**
	 * 회사코드
	 */
	private String txCmpnyCd;
	
	/**
	 * 회사명
	 */
	private String txCmpnyNm;
	
	/**
	 * Role 사용 여부
	 */
	private String txRoleUserAt;
	
	/**
	 * 테넌트 아이디
	 */
	private String txTenantId;
	
	/**
	 * 사용자 분류
	 */
	private String txUserCls;
}
