/*
 * @Author: 宋佳 
 * @Date: 2022-06-10 13:02:02 
 * @Last Modified by: relax
 * @Last Modified time: 2022-06-13 10:38:49
 */

import 'package:flutter/material.dart';

//路由拦截使用
typedef SJWidgetBuilder = Widget Function(BuildContext context,Object? args);

class Config {
  //项目主色
  static Color primaryColor = Color(0xFFE87F4B);
  //背景色
  static Color backgroundColor = Color(0xFFF2F2F2);
  //辅助线条
  static Color aiderLineColor = Color(0xFFE9E9E9);
  //辅助字体颜色01
  static Color aiderTextColor1 = Color(0xFF9A9A9A);
  //辅助字体颜色02
  static Color aiderTextColor2 = Color(0xFF666666);
  //辅助字体颜色03
  static Color aiderTextColor3 = Color(0xFF999999);
  //标题色
  static Color titleColor = Color(0xFF333333);
  //删除
  static Color deleteColor = Color(0xFFE87F4B);
  //其他
  static Color otherColor = Color(0xFFD66B36);
  //成功
  static Color successColor = Color(0xFFFFC0A1);
  //白色
  static const Color bg_white = Color(0xFFFFFFFF);

  //分页没页请求数据
  static int pageSize = 20;
}
