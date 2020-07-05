import 'package:flutter/material.dart';
import '../common/storage.dart';

class Login with ChangeNotifier {
  List _userInfo=[];

  List get cartList => this._userInfo;

  Login(){
    init();
  }

  init(){
    print('初始化');
  }

  removeToken(){
    Storage.clearAllKey();
  }

}
