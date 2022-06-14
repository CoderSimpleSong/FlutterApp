/*
 * @Author: 宋佳 
 * @Date: 2022-06-13 08:58:59 
 * @Last Modified by: relax
 * @Last Modified time: 2022-06-13 09:21:00
 */

import 'package:hftech_flutter/common/http.dart';
import 'package:hftech_flutter/models/home/home.dart';

class HomeApi{
  static Future<HomePageModel?> getHomepageData() async{
    return HomePageModel.fromJson(await HttpGo.httpRequest(
      "请求地址",
      queryParams: {"args": 2},
    ));
  }
}