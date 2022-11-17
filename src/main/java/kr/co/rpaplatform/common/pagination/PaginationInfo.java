/**
 * 
 */
package kr.co.rpaplatform.common.pagination;

/**
 * 페이징 정보
 * @author LSH
 *
 */
public class PaginationInfo {
	
	/**
	 * 현재 페이지 번호
	 */
	private int currentPageNo = 0;
	
	/**
	 * 한 페이지당 목록 수
	 */
	private int recordCountPerPage = 10;
	
	/**
	 * 페이지 리스트에 보여주는 페이지 건수
	 */
	private int pageSize = 5;
	
	/**
	 * 전체 목록 건수
	 */
	private int totalRecordCount = 0;
	
	/**
	 * 전체 페이지 개수
	 */
	private int totalPageCount = 0;
	
	/**
	 * 페이지 리스트의 첫 페이지 번호
	 */
	private int firstPageNoOnPageList = 0;
	
	/**
	 * 페이지 리스트의 마지막 페이지 번호
	 */
	private int lastPageNoOnPageList = 0;
	
	/**
	 * 페이지 첫 데이터의 인덱스
	 */
	private int firstRecordIndex = 0;
	
	/**
	 * 페이지 마지막 데이터의 인덱스
	 */
	private int lastRecordIndex = 0;
	
	/**
	 * 
	 * @return
	 */
	public int getRecordCountPerPage() {
		return this.recordCountPerPage;
	}
	
	/**
	 * 
	 * @param recordCountPerPage
	 */
	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}
	
	/**
	 * 
	 * @return
	 */
	public int getPageSize() {
		return this.pageSize;
	}
	
	/**
	 * 
	 * @param pageSize
	 */
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	
	/**
	 * 
	 * @return
	 */
	public int getCurrentPageNo() {
		return this.currentPageNo;
	}
	
	/**
	 * 
	 * @param currentPageNo
	 */
	public void setCurrentPageNo(int currentPageNo) {
		this.currentPageNo = currentPageNo;
	}
	
	/**
	 * 
	 * @param totalRecordCount
	 */
	public void setTotalRecordCount(int totalRecordCount) {
		this.totalRecordCount = totalRecordCount;
	}
	
	/**
	 * 
	 * @return
	 */
	public int getTotalRecordCount() {
		return this.totalRecordCount;
	}
	
	/**
	 * 
	 * @return
	 */
	public int getTotalPageCount() {
		this.totalPageCount = ((getTotalRecordCount() - 1) / getRecordCountPerPage()) + 1;
		return this.totalPageCount;
	}
	
	/**
	 * 
	 * @return
	 */
	public int getFirstPageNo() {
		return 1;
	}
	
	/**
	 * 
	 * @return
	 */
	public int getLastPageNo() {
		return getTotalPageCount();
	}
	
	/**
	 * 
	 * @return
	 */
	public int getFirstPageNoOnPageList() {
		this.firstPageNoOnPageList = ((getCurrentPageNo() - 1) / getPageSize()) * getPageSize() + 1;
		return this.firstPageNoOnPageList;
	}
	
	/**
	 * 
	 * @return
	 */
	public int getLastPageNoOnPageList() {
		this.lastPageNoOnPageList = getFirstPageNoOnPageList() + getPageSize() - 1;
		if (this.lastPageNoOnPageList > getTotalPageCount()) {
			this.lastPageNoOnPageList = getTotalPageCount();
		}
		return this.lastPageNoOnPageList;
	}
	
	/**
	 * 
	 * @return
	 */
	public int getFirstRecordIndex() {
		this.firstRecordIndex = (getCurrentPageNo() - 1) * getRecordCountPerPage();
		return this.firstRecordIndex;
	}
	
	/**
	 * 
	 * @return
	 */
	public int getLastRecordIndex() {
		this.lastRecordIndex = getCurrentPageNo() * getRecordCountPerPage();
		return this.lastRecordIndex;
	}

}
