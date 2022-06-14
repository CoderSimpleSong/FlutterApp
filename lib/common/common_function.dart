/*
 * @Author: 宋佳 
 * @Date: 2022-06-10 09:44:29 
 * @Last Modified by: relax
 * @Last Modified time: 2022-06-14 09:42:09
 */

import 'package:flutter/material.dart';
import 'package:hftech_flutter/common/custom_navigator_tool.dart' as rout;
import 'package:hftech_flutter/common/storage.dart';
import 'package:hftech_flutter/common/toast_widget.dart';
import 'package:hftech_flutter/config/other_const.dart';

class CommonTool {
  //手机号有几个基本需求
  /*
  1.长度为11
  2.开头必须为1；
  3.第二位不能为012
  */
  static bool isChinaPhoneLegal(String str) {
    print(str);
    return new RegExp("^1[3-9]{1}[0-9]{9}\$").hasMatch(str);
  }

  //退出登录type = 1/token过期type = 2  
  static logoutApp(int type) async {
    //清空用户信息
    bool result = await Storage.setStringValue(OtherConst.storageUserInfo, "");
    if(result){
      Navigator.pushNamedAndRemoveUntil(rout.HFRouter.navigatorKey.currentState!.overlay!.context,"/login",(route) => false);
      if(type == 2){
        ToastTool.showToast("您的登录已过期,请重新登录!");
      }
    }
  }
}
//解决中英文提前换行问题  str.fixAutoLines();
extension FixAutoLines on String {
  String fixAutoLines(){
    return Characters(this).join('\u{200B}');
  }
}