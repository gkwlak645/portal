/**
 * 
 */
package kr.co.rpaplatform.rpaapi.uipath.vo;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

/**
 * @author LSH
 *
 */
@Data
public class ProcessSettingsVO implements Serializable {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	@JsonProperty("ErrorRecordingEnabled")
	private Boolean errorRecordingEnabled;
	
	@JsonProperty("Duration")
	private Integer duration;
	
	@JsonProperty("Frequency")
	private Integer frequency;
	
	@JsonProperty("Quality")
	private Integer quality;
	
	@JsonProperty("AutoStartProcess")
	private Boolean autoStartProcess;

}
