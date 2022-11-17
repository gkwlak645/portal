/**
 * 
 */
package kr.co.rpaplatform.common.util;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 일자관련 유틸 클래스
 * @author LSH
 *
 */
public class DateUtil {
	
	/**
	 * 현재 일자 구하기
	 * @return
	 * @throws Exception
	 */
	public static String getCurrentDe() throws Exception {
		Date today = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		return format.format(today);
	}
	
	/**
	 * 현재 일시 구하기
	 * @return
	 * @throws Exception
	 */
	public static String getCurrentDt() throws Exception {
		Date date = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHH24MISS");
		return format.format(date);
	}
	
	/**
	 * 입력된 포맷의 현재 일자 구하기
	 * @param formatString
	 * @return
	 * @throws Exception
	 */
	public static String getFormatCurrentDe(String formatString) throws Exception {
		Date date = new Date();
		SimpleDateFormat format = new SimpleDateFormat(formatString);
		return format.format(date);
	}
	
	
	/**
	 * 입력된 포맷의 현재 일시 구하기
	 * @param formatString
	 * @return
	 * @throws Exception
	 */
	public static String getFormatCurrentDt(String formatString) throws Exception {
		Date date = new Date();
		SimpleDateFormat format = new SimpleDateFormat(formatString);
		return format.format(date);
	}
	
	/**
	 * 입력된 일자를 입력된 포맷의 문자열로 리턴
	 * @param date
	 * @param formatString
	 * @return
	 * @throws Exception
	 */
	public static String getFormattedDate(Date date, String formatString) throws Exception {
		SimpleDateFormat format = new SimpleDateFormat(formatString);
		return format.format(date);
	}

}
