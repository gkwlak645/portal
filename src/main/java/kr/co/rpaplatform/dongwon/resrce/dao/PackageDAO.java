/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 7. 14.         LSH        최초 작성
 */
package kr.co.rpaplatform.dongwon.resrce.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.co.rpaplatform.dongwon.resrce.vo.PackageVO;
import kr.co.rpaplatform.dongwon.task.vo.TaskPrcuseSysVO;
import kr.co.rpaplatform.dongwon.task.vo.TaskReviewVO;
import kr.co.rpaplatform.dongwon.task.vo.TaskVO;

/**
 * 과제 DAO
 * @author LSH
 */
@Repository
public class PackageDAO {
	
	private final Logger logger = LoggerFactory.getLogger(PackageDAO.class);
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	/**
	 * cmpnyCd 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCmpnyCdAll() throws Exception {
		return sqlSession.selectList("selectCmpnyCdAll");
	}
	
	/**
	 * cmpnyCd 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCmpnyCd(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("selectCmpnyCd", map);
	}
	
	/**
	 * 패키지, 라이브러리 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectPackageLibraryList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("selectPackageLibraryList", map);
	}
	
	/**
	 * 패키지, 라이브러리 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectPackageLibraryRequstCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("selectPackageLibraryRequstCount", map);
	}
	
	/**
	 * 패키지, 라이브러리 버전정보 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<PackageVO> packageLibraryVersionInfoList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("packageLibraryVersionInfoList", map);
	}

	/**
	 * 패키지, 라이브러리 이력조회 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
//	public List<PackageVO> packageLibraryHistInqireList(Map<String, Object> map) throws Exception {
//		return sqlSession.selectList("packageLibraryHistInqireList", map);
//	}
	
	/**
	 * 패키지 중복 등록 여부 확인
	 * @return 
	 * @return
	 * @throws Exception
	 */
	public int chkProcess(Map<String, Object> map) {
		return sqlSession.selectOne("chkProcess", map);
	}
	
}
