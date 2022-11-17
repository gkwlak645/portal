package kr.co.rpaplatform.dongwon.stdrinfo.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;


/**
 * Asset DAO
 * @author LSH
 */
@Repository
public class AssetDAO {
	
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	/**
	 * Asset 리스트 조회
	 */
	public List<Map<String, Object>> selectAssetList(Map<String, Object> map) {
		return sqlSession.selectList("selectAssetList", map);
	}
	
	/**
	 * Asset 건수 조회
	 */
	public int selectAssetCount(Map<String, Object> map) {
		return sqlSession.selectOne("selectAssetCount", map);
	}

	
	/**
	 * Asset 조회
	 */
	public List<Map<String, Object>> selectAsset(Map<String, Object> map) {
		return sqlSession.selectList("selectAsset", map);
	}

	
	/**
	 * Asset robot 조회
	 */
	public List<Map<String, Object>> selectAssetRobtList(Map<String, Object> map) {
		return sqlSession.selectList("selectAssetRobtList", map);
	}
	
	
	/**
	 * robot 리스트 조회
	 */
	public List<Map<String, Object>>  selectRobtList(Map<String, Object> map) {
		return sqlSession.selectList("selectRobtList", map);
	}

	
	/**
	 *  Asset 명칭 중복 체크
	 */
	public int chkOverAssetName(Map<String, Object> map) {
		return sqlSession.selectOne("chkOverAssetName", map);
	}

	
	
	/**
	 *  수정할 때 Asset 명칭 중복 체크
	 */
	public int updateChkOverAssetName(Map<String, Object> map) {
		return sqlSession.selectOne("updateChkOverAssetName", map);
	}
}
