/**
 * 
 */
package kr.co.rpaplatform.common.view;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

/**
 * 다운로드 뷰
 * @author LSH
 *
 */
public class DownloadView extends AbstractView {

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String oriFileNm = (String)model.get("oriFileNm");
		
		File file = (File)model.get("downloadFile");
		response.setContentType(getContentType());
		response.setContentLength((int)file.length());

		String header = request.getHeader("User-Agent");
		if (header.contains("MSIE") || header.contains("Trident")) {
			oriFileNm = URLEncoder.encode(oriFileNm,"UTF-8").replaceAll("\\+", "%20");
            response.setHeader("Content-Disposition", "attachment;filename=" + oriFileNm + ";");
        } else {
        	oriFileNm = new String(oriFileNm.getBytes("UTF-8"), "ISO-8859-1");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + oriFileNm + "\"");
        }
		
		response.setHeader("Content-Transfer-Encoding", "binary");

		OutputStream out = null;
		FileInputStream fis = null;
		
		try {
			
			out = response.getOutputStream();
			fis = new FileInputStream(file);
			FileCopyUtils.copy(fis, out);

		} catch (Exception e) {
			
			throw e;
			
		} finally {
			
			if (fis != null) {
				fis.close();
			}
			
			if (out != null) {
				
				out.close();
			}
		}


	}

}
