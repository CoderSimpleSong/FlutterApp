/*
 * @Author: 宋佳 
 * @Date: 2022-06-10 09:45:33 
 * @Last Modified by: relax
 * @Last Modified time: 2022-06-13 14:35:32
 */

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

//使用时直接 ToastTool.showToast("欢迎使用app")
class ToastTool {
  static showToast(String msg) {
    if(msg.isEmpty) return;
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        //时间
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 14.0);
  }
}
