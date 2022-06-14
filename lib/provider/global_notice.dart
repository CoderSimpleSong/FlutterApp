/*
 * @Author: 宋佳 
 * @Date: 2022-06-13 11:10:00 
 * @Last Modified by: relax
 * @Last Modified time: 2022-06-13 16:50:50
 */

//这是一个例子  比如在首页/我的页面 都需要展示消息状态, 每当有新的消息/用户读取消息 两个页面都要展示有新消息状态  
import 'package:flutter/material.dart';

class GlobalNotice with ChangeNotifier{

  late bool _hasNewsNotice;
  GlobalNotice(this._hasNewsNotice);

  void updateNotice()async{
  //每当收到新消息或者读取消息时 就变更状态
   //这里可以请求接口,确认是否还有未读消息  要跟据实际情况
   _hasNewsNotice = !_hasNewsNotice;
    notifyListeners();
    
  }
  bool get hasNewsNotice => _hasNewsNotice;
}