/*
 * @Author: 宋佳 
 * @Date: 2022-06-10 09:45:03 
 * @Last Modified by:   relax 
 * @Last Modified time: 2022-06-10 09:45:03 
 */

import 'dart:convert';
import 'dart:convert' as convert;

/// Description: Base64工具类
class Encode {
/*
  * Base64加密
  */
  static String encodeBase64(String data) {
    var content = utf8.encode(data);
    var digest = base64Encode(content);
    return digest;
  }

  /*
  * Base64解密
  */
  static String decodeBase64(String data) {
    List<int> bytes = convert.base64Decode(data);
    // 网上找的很多都是String.fromCharCodes，这个中文会乱码
    String result = convert.utf8.decode(bytes);
    return result;
  }
}
