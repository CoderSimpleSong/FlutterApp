/*
 * @Author: 宋佳 
 * @Date: 2022-06-10 09:44:39 
 * @Last Modified by: relax
 * @Last Modified time: 2022-06-13 10:53:02
 */

import 'package:flutter/material.dart';

//实现无context路由跳转，需要在创建MaterialApp的时候，将navigatorKey 赋值给navigatorKey
class HFRouter {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
}
