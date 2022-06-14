/*
 * @Author: 宋佳 
 * @Date: 2022-06-10 10:00:21 
 * @Last Modified by: relax
 * @Last Modified time: 2022-06-10 14:03:31
 */

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hftech_flutter/common/storage.dart';
import 'package:hftech_flutter/config/other_const.dart';

class UserInfo {
  String? userName;
  String? token;

  //接口返回的用户信息对象
  static dynamic _responseObj;

  static UserInfo? _instance;
  // 单例方法
  static UserInfo? getInstance() {
    if (_instance == null) {
      if (_responseObj == null) {
        //尝试本地加载
        String? localString =
            Storage.getStringValue(OtherConst.storageUserInfo);
        if (localString != null && localString.length != 0) {
          _responseObj = json.decode(localString);
          _instance = UserInfo.fromJson(_responseObj);
        }
      }
    }
    return _instance;
  }

  //拿到服务器的数据直接保存在本地
  static getUserInfoFromResponseString(dynamic responseObj) async {
    _responseObj = responseObj;
    bool result = await Storage.setStringValue(OtherConst.storageUserInfo, json.encode(responseObj));
    if (result) {
      //保存在本地成功后转模型
      _instance = UserInfo.fromJson(responseObj);
    }
  }

  //转模型
  UserInfo.fromJson(Map<String, dynamic> json) {
    userName = json['column'];
    token = json['asc'];
  }

  //转字典
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['token'] = token;
    return data;
  }
}
