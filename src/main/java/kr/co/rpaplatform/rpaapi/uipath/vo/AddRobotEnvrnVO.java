package kr.co.rpaplatform.rpaapi.uipath.vo;

import java.io.Serializable;
import java.util.List;

import lombok.Data;

/**
 * 로봇 환경 등록 VO
 * @author LSH
 * 
 */
@Data
public class AddRobotEnvrnVO implements Serializable {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * 
	 */
	private List<Integer> addedRobotIds;
	
	/**
	 * 
	 */
	private List<Integer> removedRobotIds;

}
