package kr.co.rpaplatform.dongwon.hlpdsk.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.rpaplatform.common.pagination.PaginationInfo;
import kr.co.rpaplatform.dongwon.cmmnty.vo.BbsMngVO;
import kr.co.rpaplatform.dongwon.file.service.AtchFileService;
import kr.co.rpaplatform.dongwon.file.vo.AtchFileVO;
import kr.co.rpaplatform.dongwon.hlpdsk.dao.HlpdskDAO;
import kr.co.rpaplatform.dongwon.hlpdsk.vo.HlpdskVO;

@Service
public class HlpdskService {

	private final Logger logger = LoggerFactory.getLogger(HlpdskService.class);
	
	@Resource(name="hlpdskDAO")
	private HlpdskDAO hlpdskDAO;
	
	@Resource(name="atchFileService")
	private AtchFileService atchFileService;	

	public Map<String,Object> getHlpdsk(HlpdskVO vo) throws Exception {
		PaginationInfo pageInfo = vo.getPageInfo();
		pageInfo.setTotalRecordCount(hlpdskDAO.selectTotalHlpdskListCount(vo));
		Map<String,Object> result = new HashMap<>();
		result.put("items", hlpdskDAO.selectNoticeList(vo));
		result.put("pageInfo", pageInfo);		
		return result;
	}	

	public void createHlpdsk(HlpdskVO vo) throws Exception{
		hlpdskDAO.createHlpdsk(vo);
	}	

	public HlpdskVO detailHlpdsk(HlpdskVO vo) throws Exception{
		return hlpdskDAO.detailHlpdsk(vo);
	}

	public List<AtchFileVO> deleteHlpdsk(HlpdskVO vo) throws Exception {
		hlpdskDAO.deleteHlpdsk(vo);
		List<AtchFileVO> deleteFile = atchFileService.deleteFile(vo.getRequstFileGrpNo());
		return deleteFile;
	}

	public void updateHlpdsk(HlpdskVO vo) {
		hlpdskDAO.updateHlpdsk(vo);		
	}
	
	// ----------------- 처리요청 끝 --------------- //

	public Map<String,Object> getReceiptList(HlpdskVO vo) throws Exception {
		PaginationInfo pageInfo = vo.getPageInfo();
		pageInfo.setTotalRecordCount(hlpdskDAO.getReceiptListCount(vo));
		Map<String,Object> result = new HashMap<>();		
		result.put("items", hlpdskDAO.getReceiptList(vo));
		result.put("pageInfo", pageInfo);
		return result;
	}

	public Object detailReceip(HlpdskVO vo) {
		List<HlpdskVO> boardType = hlpdskDAO.detailReceip(vo);
		return boardType;
	}

	public void updatereceipt(HlpdskVO vo) {
		hlpdskDAO.updatereceipt(vo);
	}
	
	public List<Map<String, Object>> selectSendTrgetList() throws Exception{
		return hlpdskDAO.selectSendTrgetList();
	}	
	
	public Map<String, Object> selectRequstSnSj(HlpdskVO vo) throws Exception{
		return hlpdskDAO.selectRequstSnSj(vo);
	}
}
