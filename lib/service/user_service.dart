import 'dart:convert';
import '../common/storage.dart';

class UserServices{
  static getUserInfo() async {
    List userinfo;
    try {
      List userInfoData = json.decode(await Storage.getStringValue('userInfo'));
      userinfo=userInfoData;
    }catch(e) {
      userinfo = [];
    }
    return userinfo;
  }

  static loginOut() {
    Storage.removeKey("userInfo");
  }
}