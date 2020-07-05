
import './user_info.dart';

class ChooseRootWidget {
  //这里主要处理根视图逻辑,是否登录?是否展示引导页,是否展示广告页等
  static String rootWidget = UserInfo.isLogin ? "tabbar" : "login";
}