/*==========================================================
 *  Copyright (C) 2020 Echo Information Technology
 *  All rights reserved
 *==========================================================
 *
 *   수정일자                  수정자                  수정 내용
 *----------------------------------------------------------
 *  2020. 6. 1.         LSH
 */
package kr.co.rpaplatform.common.util;

import java.math.BigInteger;
import java.security.MessageDigest;

/**
 * hash 암호화 유틸
 * @author LSH
 * 2020. 6. 1.
 */
public class MessageDigestUtil {
	
	/**
	 * 평문을 입력받아 암호화된 메시지 리턴
	 * @param plainText
	 * @return
	 * @throws Exception
	 */
	public static String getMessageDigest(String plainText) throws Exception {
		MessageDigest digest = MessageDigest.getInstance("SHA-256");
		digest.reset();
	    digest.update(plainText.getBytes("utf8"));
	    return String.format("%064x", new BigInteger(1, digest.digest()));
	}

	/**
	 * 입력받은 평문과 암호화 메시지가 같은지 비교
	 * @param plainText
	 * @param encText
	 * @return
	 * @throws Exception
	 */
	public static boolean isSameMessage(String plainText, String encMessage) throws Exception {

		MessageDigest digest = MessageDigest.getInstance("SHA-256");
		digest.reset();
	    digest.update(plainText.getBytes("utf8"));
	    String digestMessage = String.format("%064x", new BigInteger(1, digest.digest()));
	    
	    if (digestMessage.equals(encMessage)) {
	    	return true;
	    } else {
	    	return false;
	    }
	}

}
