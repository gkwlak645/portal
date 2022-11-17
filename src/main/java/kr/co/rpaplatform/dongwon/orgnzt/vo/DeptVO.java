package kr.co.rpaplatform.dongwon.orgnzt.vo;


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
public class DeptVO extends CmmnUserVO {
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 부서코드
	 */
	private String deptCd;
	
	/**
	 * 부서명
	 */
	private String deptNm;
	
	/**
	 * 상위부서코드
	 */
	private String upDeptCd;
	
	/**
	 * 부서정렬
	 */
	private int deptOrdr;
	
	/**
	 * 사용여부
	 */
	private String useAt;
	
}
