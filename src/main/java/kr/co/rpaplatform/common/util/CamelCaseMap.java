/**
 * 
 */
package kr.co.rpaplatform.common.util;

import java.util.HashMap;

import org.springframework.jdbc.support.JdbcUtils;

/**
 * 맵의 키값을 카멜표기법으로 전환하는 맵
 * @author LSH
 *
 */
@SuppressWarnings("rawtypes")
public class CamelCaseMap extends HashMap {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	@SuppressWarnings("unchecked")
	@Override
	public Object put(Object key, Object value) {
		return super.put(JdbcUtils.convertUnderscoreNameToPropertyName((String)key), value);
	}

}
