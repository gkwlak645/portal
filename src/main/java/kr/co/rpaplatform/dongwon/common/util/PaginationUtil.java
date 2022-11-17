/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 8.         LSH
 */
package kr.co.rpaplatform.dongwon.common.util;

import java.util.Map;

import kr.co.rpaplatform.common.pagination.PaginationInfo;

/**
 * 페이징 처리 유틸리티 클래스
 * @author LSH
 * 2020. 6. 8.
 */
public class PaginationUtil {
	
	/**
	 * 페이징 값 구하기
	 * @param map
	 * @param totalRecordCount
	 * @return
	 * @throws Exception
	 */
	public static PaginationInfo getPaginationInfo(Map<String, Object> map, int totalRecordCount) throws Exception {
		
		PaginationInfo paginationInfo = new PaginationInfo();
		if (map.get("currentPageNo") != null && map.get("recordCountPerPage") != null && map.get("pageSize") != null) {
			paginationInfo.setCurrentPageNo((Integer)map.get("currentPageNo"));
			paginationInfo.setRecordCountPerPage((Integer)map.get("recordCountPerPage"));
			paginationInfo.setPageSize((Integer)map.get("pageSize"));
		}
		paginationInfo.setTotalRecordCount(totalRecordCount);
		
		return paginationInfo;
	}

}
