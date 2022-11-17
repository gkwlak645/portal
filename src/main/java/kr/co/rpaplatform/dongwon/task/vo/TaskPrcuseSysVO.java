/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 7. 15.         LSH        최초 작성
 */
package kr.co.rpaplatform.dongwon.task.vo;

import java.io.Serializable;
import lombok.Data;

/**
 * 과제활용시스템 VO
 * @author LSH
 */
@Data
public class TaskPrcuseSysVO implements Serializable {
	
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * 과제코드
	 */
	private String taskNo;
	
	/**
	 * 활용시스템코드
	 */
	private String prcuseSysCd;

}
