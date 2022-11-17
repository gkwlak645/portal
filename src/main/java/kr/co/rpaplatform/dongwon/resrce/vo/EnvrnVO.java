package kr.co.rpaplatform.dongwon.resrce.vo;

import lombok.Data;

/**
 * 디바이스  VO
 * @author LKA
 * 2020. 6. 17.
 */
@Data
public class EnvrnVO {
	
	/**
	 * serialVersionUID 
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * robotIds
	 */
	int[] addedRobotIds;
	int[] removedRobotIds;
	int id;
}
