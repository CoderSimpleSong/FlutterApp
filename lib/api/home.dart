import '../common/http.dart';

class HomeApi {
  static getHotProductData() async {
    return await HttpGo.httpRequest('/plist');
  }
}
