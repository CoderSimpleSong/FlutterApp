/*
 * @Author: 宋佳 
 * @Date: 2022-06-10 09:36:56 
 * @Last Modified by: relax
 * @Last Modified time: 2022-06-13 09:59:48
 */
class ChooseRootWidget {
  //这里主要处理根视图逻辑,是否首次登录? 启动页之后展示哪一页逻辑
  static String get rootWidget {
    //根据token等一系列判断,返回启动页之后的下一个页面是登录页面还是主页面
    return "/tabbar";
  }
}
