import 'package:flutter/material.dart';
import '../pages/zother/launch_animation.dart';
import '../pages/zother/tabbar_widget.dart';
import './detail.dart';


// 配置路由
Map<String, WidgetBuilder> routes = {
  '/': (context) => LaunchAnimationWidget(),
  'tabbar':(context) => TabbarWidget()
};

var onGenerateRoute = (RouteSettings settings) {
  routes.addAll(detail);
// 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};