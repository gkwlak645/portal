package kr.co.rpaplatform.rpaapi.uipath.vo;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

/**
 * 
 * @author LSH
 */
@Data
public class ReleaseVO implements Serializable {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	@JsonProperty("Id")
	private Integer id;
	
	@JsonProperty("ProcessKey")
	private String processKey;
	
	@JsonProperty("ProcessVersion")
	private String processVersion;
	
	@JsonProperty("Name")
	private String name;
	
	@JsonProperty("ProcessSettings")
	private ProcessSettingsVO processSettings;

}
