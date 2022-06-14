/*
 * @Author: 宋佳 
 * @Date: 2022-06-13 10:02:22 
 * @Last Modified by: relax
 * @Last Modified time: 2022-06-13 10:41:41
 */
import 'package:flutter/material.dart';
import 'package:hftech_flutter/common/toast_widget.dart';
import 'package:hftech_flutter/config/config.dart';
import 'package:hftech_flutter/routes/home_route.dart';
import 'package:hftech_flutter/widgets/launch_animation.dart';
import 'package:hftech_flutter/widgets/tabbar_widget.dart';

// 配置路由
Map<String, SJWidgetBuilder> routes = {
  '/': (context,arguments) => LaunchAnimationWidget(),
  '/tabbar':(context,arguments) => TabbarWidget()
};

var onGenerateRoute = (RouteSettings settings) {
  // 其他模块的路由,往routes里面加
   routes.addAll(homeRoute);
// 统一处理
  final String? name = settings.name;
  final Widget Function(BuildContext context, Object? arguments)? pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
        settings: settings,
        builder: (context) => pageContentBuilder(context,settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(
            builder: (context) => pageContentBuilder(context,null),
            settings: settings
          );
      return route;
    }
  }else{
    ToastTool.showToast("未找到对应的路由地址:${settings.name}");
  }
};