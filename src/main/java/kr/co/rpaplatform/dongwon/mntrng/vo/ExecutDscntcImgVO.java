package kr.co.rpaplatform.dongwon.mntrng.vo;

import com.fasterxml.jackson.annotation.JsonInclude;

import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.dongwon.common.vo.CmmnUserVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=true)
public class ExecutDscntcImgVO extends CmmnUserVO {

	
	/**
	 * serialVersionUID 
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * SN
	 */
	private String executDscntcImageSn;
	
	/**
	 * 회사 코드
	 */
	private String cmpnyCd;
	
	/**
	 * 회사 명
	 */
	private String cmpnyNm;
	
	/**
	 * 실행중단일
	 */
	private String executDscntcDt;
	
	/**
	 * 프로세스 코드
	 */
	private String processCd;
	
	/**
	 * 프로세스 명
	 */
	private String processNm;
	
	/**
	 * 로봇 ID
	 */
	private String robotId;
	
	/**
	 * 로봇 명
	 */
	private String robotNm;

	/**
	 * 파일 경로
	 */ 
	private String fileCours;
	
	/**
	 * 파일 이름
	 */
	private String fileNm;
	
	/**
	 * 검색 조건 시작 날짜
	 */
	private String startDt;
	
	/**
	 * 검색 조건 마지막 날짜
	 */
	private String lastDt;
	
	@JsonInclude(JsonInclude.Include.NON_NULL)
    private PaginationInfo pageInfo;
}
