/*
 * @Author: 宋佳 
 * @Date: 2022-06-13 09:21:08 
 * @Last Modified by: relax
 * @Last Modified time: 2022-06-13 09:21:43
 */

import 'package:hftech_flutter/common/http.dart';
import 'package:hftech_flutter/models/mine/mine.dart';

class MineApi{
  static Future<MinePageModel?> getMinepageData() async{
    return MinePageModel.fromJson(await HttpGo.httpRequest(
      "请求地址",
      queryParams: {"args": 2},
    ));
  }
}