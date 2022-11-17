/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 4.         LSH
 */
package kr.co.rpaplatform.dongwon.common.vo;

import java.io.Serializable;



import lombok.Data;

/**
 * @author LSH
 * 2020. 6. 4.
 */
@Data
public class CdVO implements Serializable {
	
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

}
