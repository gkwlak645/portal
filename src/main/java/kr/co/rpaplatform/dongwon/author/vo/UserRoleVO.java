package kr.co.rpaplatform.dongwon.author.vo;

import kr.co.rpaplatform.dongwon.common.vo.CmmnUserVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=true)
public class UserRoleVO extends CmmnUserVO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 역할코드
	 */
	private String roleCd;
	
	/**
	 * 역할코드
	 */
	private String roleCdAray[];
	
	
	/**
	 * 사용자아이디
	 */
	private String userId;

}
