/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 8.         LSH
 */
package kr.co.rpaplatform.common.util;

import java.util.HashMap;

/**
 * 파스칼 표기법 키를 카멜표기법 키로 변경
 * @author LSH
 * 2020. 6. 8.
 */
public class PascalToCamelMap extends HashMap {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	@Override
	public Object put(Object key, Object value) {
		return super.put(Character.toLowerCase(((String)key).charAt(0)) + ((String)key).substring(1), value);
	}

}
