package kr.co.rpaplatform.dongwon.orgnzt.vo;


import com.fasterxml.jackson.annotation.JsonInclude;

import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.dongwon.common.vo.CmmnUserVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 
 * @author jw.lee
 *
 */

@Data
@EqualsAndHashCode(callSuper=true)
public class UserVO extends CmmnUserVO {
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * 회사코드
	 */
	private String cmpnyCd;
	
	/**
	 * 회사명
	 */
	private String cmpnyNm;
	
	/**
	 * 사용자아이디
	 */
	private String userId;
	
	/**
	 * 사원번호
	 */
	private String empNo;
	
	/**
	 * 사원명
	 */
	private String empNm;
	
	/**
	 * 직급코드
	 */
	private String pstCd;
	
	/**
	 * 직급명
	 */
	private String pstNm;
	
	/**
	 * 부서코드
	 */
	private String deptCd;
	
	/**
	 * 부서명
	 */
	private String deptNm;
	
	/**
	 * 이메일주소
	 */
	private String emailAdr;
	
	/**
	 * 전화번호
	 */
	private String telno;
	
	/**
	 * 이동전화번호
	 */
	private String mbtlnum;
	
	/**
	 * 사용여부
	 */
	private String useAt;
	
	/**
	 * 사용자 분류
	 */
	private String userCls;
	
	/**
	 * 비밀번호
	 */
	private String password;
	
	/*
	 * 수정 가능 여부([TB_CMMN_CD] AND A_1.CLS_CD = '0024'에 등록된 회사 코드만 수정 가능)
	 * */
	
	private String editAt;
	

	@JsonInclude(JsonInclude.Include.NON_NULL)
    private PaginationInfo pageInfo;

}
