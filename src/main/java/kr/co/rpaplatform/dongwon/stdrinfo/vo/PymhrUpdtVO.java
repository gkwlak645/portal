package kr.co.rpaplatform.dongwon.stdrinfo.vo;

import kr.co.rpaplatform.dongwon.common.vo.CmmnUserVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=true)
public class PymhrUpdtVO extends CmmnUserVO{

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * 년도
	 */
	private String pymhrYy;
	
	/**
	 * 시급
	 */
	private int pymhrAmt;
	
	
}
