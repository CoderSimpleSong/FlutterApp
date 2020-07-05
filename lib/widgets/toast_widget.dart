import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class ToastTool{

  static showToast(String msg){
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,  //时间
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 14.0
    );
  }

}