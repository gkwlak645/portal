package kr.co.rpaplatform.dongwon.author.vo;


import kr.co.rpaplatform.dongwon.orgnzt.vo.DeptVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 
 * @author jw.lee
 *
 */
@Data
@EqualsAndHashCode(callSuper=true)
public class DeptRoleVO extends DeptVO {
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 권한 코드
	 */
	private String roleCd;
	
	/**
	 * 권한 이름
	 */
	private String roleNm;
}
