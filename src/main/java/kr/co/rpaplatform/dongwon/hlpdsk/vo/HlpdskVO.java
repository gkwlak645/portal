package kr.co.rpaplatform.dongwon.hlpdsk.vo;

import com.fasterxml.jackson.annotation.JsonInclude;

import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.dongwon.common.vo.CmmnUserVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=true)
public class HlpdskVO extends CmmnUserVO {

	
	/**
	 * serialVersionUID 
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * 요청 일련번호
	 */
	private int requstSn;
	
	/**
	 * 요청 제목
	 */
	private String requstSj;

	/**
	 * 요청 내용
	 */
	private String requstCn;
	
	/**
	 * 요청 구분
	 */
	private String requstSe;

	/**
	 * 요청 회사 코드
	 */ 
	private String requstCmpnyCd;
	
	/**
	 * 요청 사용자 id
	 */ 
	private String requstUserId;
	
	/**
	 * 요청 파일 그룹 번호
	 */ 
	private int requstFileGrpNo;
	
	/**
	 * 처리 상태 코드
	 */ 
	private String processSttusCd;
	
	/**
	 * 처리 일
	 */ 
	private String processDe;
	
	/**
	 * 처리 내용
	 */ 
	private String processCn;
	
	/**
	 * 처리 사용 아이디
	 */ 
	private String processUserId;
	
	/**
	 * 처리 파일 그룹번호
	 */	
	private String processFileGrpNo;
	
	/**
	 * 등록자 id
	 */ 
	private String registerId;
	
	/**
	 * 등록 일시
	 */ 
	private String regDt;
	
	/**
	 * 수정자 id
	 */ 
	private String updusrId;
	
	/**
	 * 수정 일시
	 */ 
	private String updtDt;
	
	/**
	 * 검색 조건 시작 날짜
	 */
	private String startDt;
	
	/**
	 * 검색 조건 마지막 날짜
	 */
	private String lastDt;
	
	/**
	 * 검색 조건 사용자 이름
	 */
	private String userNm;
	
	/*처리시간*/
	private float processTm;
	
	@JsonInclude(JsonInclude.Include.NON_NULL)
    private PaginationInfo pageInfo;
}
