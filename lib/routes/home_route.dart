/*
 * @Author: 宋佳 
 * @Date: 2022-06-13 10:04:07 
 * @Last Modified by: relax
 * @Last Modified time: 2022-06-13 17:06:33
 */
import 'package:hftech_flutter/config/config.dart';
import 'package:hftech_flutter/pages/home/detail.dart';

Map<String,SJWidgetBuilder> homeRoute ={
  //添加 有参数的路由地址 
  "/home_detail":(context,args) => HomeDetailPage(arguments: args,),
};