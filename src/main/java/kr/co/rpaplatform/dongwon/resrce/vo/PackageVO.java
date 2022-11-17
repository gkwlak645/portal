/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 7. 14.         LSH        최초 작성
 */
package kr.co.rpaplatform.dongwon.resrce.vo;


import kr.co.rpaplatform.dongwon.common.vo.CmmnUserVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 과제 VO
 * @author LSH
 */
@Data
@EqualsAndHashCode(callSuper=true)
public class PackageVO extends CmmnUserVO {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	private String identifier ;
	
	private String description ;
	
	private String lastupdated ;
	
	private String version;

	private String authors;
	
	private String created;
	
	private String processKey;
	
	private String id;
	
	private String versionNumber;
	
	private String creationTime;
	
	private String statement;
	
	
	
}
