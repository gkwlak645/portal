package kr.co.rpaplatform.dongwon.stdrinfo.vo;

import java.util.Date;

import kr.co.rpaplatform.dongwon.common.vo.CmmnUserVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=true)
public class CmmnCdVO extends CmmnUserVO{

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 코드
	 */
	private String cd;
	
	/**
	 * 코드명
	 */
	private String cdNm;
	
	
	/**
	 * 분류코드
	 */
	private String clsCd;
	
	/**
	 * 분류코드이름
	 */
	private String clsCdNm;
	
	/**
	 * 분류코드설명
	 */
	private String clsCdDc;
	
	/**
	 * 사용여부
	 */
	private String useAt;
	
	/**
	 * 등록자아이디
	 */
	private String registerId;
	
	/**
	 * 수정자아이디
	 */
	private String updusrId;
	
	/**
	 * 수정일자
	 */
	private Date updtDt;
	
	/**
	 * 코드설명
	 */
	private String cdDc;
	
	
	/**
	 * 코드설명
	 */
	private CmmnCdVO where;
}
