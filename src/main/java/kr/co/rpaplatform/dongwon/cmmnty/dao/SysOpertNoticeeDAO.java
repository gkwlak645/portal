package kr.co.rpaplatform.dongwon.cmmnty.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.co.rpaplatform.dongwon.cmmnty.vo.BbsVO;

@Repository
public class SysOpertNoticeeDAO {

	private final Logger logger = LoggerFactory.getLogger(BbsMngDAO.class);
	/**
	 * sqlSession
	 */
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	
	public int selectSysOpertNoticeListCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("SysOpertNotice.selectSysOpertNoticeListCount", map);
	}
	
	public List<Map<String, Object>> selectSysOpertNoticeList(Map<String, Object> map) throws Exception{
		return sqlSession.selectList("SysOpertNotice.selectSysOpertNoticeList", map);
	}
	
	public int getSysOpertNoticeNextSn() throws Exception{
		return sqlSession.selectOne("SysOpertNotice.getSysOpertNoticeNextSn");
	}
	
	public void insertSysOpertNotice(Map<String, Object> map) throws Exception{
		sqlSession.insert("SysOpertNotice.insertSysOpertNotice", map);
	}
	
	public void insertSysOpertNoticeCntcSys(Map<String, Object> map) throws Exception{
		sqlSession.insert("SysOpertNotice.insertSysOpertNoticeCntcSys", map);
	}
	
	public Map<String, Object> getSysOpertNoticeDetailPopGetData(Map<String, Object> map) throws Exception{
		return sqlSession.selectOne("SysOpertNotice.getSysOpertNoticeDetailPopGetData", map);
	}
	
	public void updateSysOpertNotice(Map<String, Object> map) throws Exception{
		sqlSession.update("SysOpertNotice.updateSysOpertNotice", map);
	}
	
	public void deleteSysOpertNotice(Map<String, Object> map) throws Exception{
		sqlSession.update("SysOpertNotice.deleteSysOpertNotice", map);
	}
	
	public List<Map<String, Object>> selectSysOpertNoticeCntcSys(Map<String, Object> map) throws Exception{
		return sqlSession.selectList("SysOpertNotice.selectSysOpertNoticeCntcSys", map);
	}
	
	public void deleteSysOpertNoticeCntcSys(Map<String, Object> map) throws Exception{
		sqlSession.delete("SysOpertNotice.deleteSysOpertNoticeCntcSys", map);
	}
	
	public List<Map<String, Object>> selectSendTrgetList(Map<String, Object> map) throws Exception{
		return sqlSession.selectList("SysOpertNotice.selectSendTrgetList", map);
	}
	
	
}
