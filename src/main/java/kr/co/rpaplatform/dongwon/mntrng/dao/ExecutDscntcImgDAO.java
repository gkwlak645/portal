package kr.co.rpaplatform.dongwon.mntrng.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import kr.co.rpaplatform.dongwon.mntrng.vo.ExecutDscntcImgVO;

/**
 * 작업 DAO
 * @author LSH
 *
 */
@Repository
public class ExecutDscntcImgDAO {
	
	/**
	 * logger
	 */
	private final Logger logger = LoggerFactory.getLogger(ExecutDscntcImgDAO.class);
	
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	/**
	 * 로봇 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getSelectRobotList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("getSelectRobotList", map);
	}
	
	/**
	 * 실행중단 이미지 리스트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectExecutDscntcImgList(ExecutDscntcImgVO vo) throws Exception {
		return sqlSession.selectList("selectExecutDscntcImgList", vo);
	}
	
	/**
	 * 실행중단 이미지 리스트 카운트 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int selectExecutDscntcImgCount(ExecutDscntcImgVO vo) throws Exception {
		return sqlSession.selectOne("selectExecutDscntcImgCount", vo);
	}
	
	/**
	 * 작업 상세 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public ExecutDscntcImgVO getExecutDscntcImgDetail(ExecutDscntcImgVO vo) throws Exception {
		return sqlSession.selectOne("getExecutDscntcImgDetail", vo);
	}

}
