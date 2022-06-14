/*
 * @Author: 宋佳 
 * @Date: 2022-06-13 10:48:40 
 * @Last Modified by: relax
 * @Last Modified time: 2022-06-14 09:44:41
 */


import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hftech_flutter/common/custom_navigator_tool.dart';
import 'package:hftech_flutter/common/storage.dart';
import 'package:hftech_flutter/config/config.dart';
import 'package:hftech_flutter/provider/global_notice.dart';
import 'package:hftech_flutter/routes/router.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() {
  //Android 沉浸式导航栏?
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  //初始化 存储器
  initStorage();
}

void initStorage() async {
  await Storage.getInstance();
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GlobalNotice(false)),
      ],
      child: RefreshConfiguration(
          headerBuilder: () {
            return ClassicHeader(
              height: 45.0,
              releaseText: '松手刷新',
              refreshingText: "加载中...",
              completeText: '刷新完成',
              failedText: '刷新失败',
              idleText: '下拉刷新',
              refreshingIcon: Container(
                width: 20.0,
                height: 20.0,
                child: SpinKitFadingCircle(
                  color: Colors.grey,
                  size: 20.0,
                ),
              ),
              releaseIcon: Icon(
                Icons.arrow_downward,
                color: Colors.grey,
              ),
              completeIcon: Icon(
                Icons.check_circle_outline,
                color: Colors.grey,
              ),
            );
          },
          // Configure the default header indicator. If you have the same header indicator for each page, you need to set this
          footerBuilder: () {
            return ClassicFooter(
              height: 80,
              canLoadingText: '松手加载更多',
              loadingText: "加载中...",
              failedText: '加载失败',
              idleText: '上拉加载更多',
              noDataText: '没有更多数据',
              loadingIcon: Container(
                width: 20.0,
                height: 20.0,
                child: SpinKitFadingCircle(
                  color: Colors.grey,
                  size: 20.0,
                ),
              ),
              idleIcon: Icon(
                Icons.arrow_upward,
                color: Colors.grey,
              ),
              canLoadingIcon: Icon(
                Icons.arrow_upward,
                color: Colors.grey,
              ),
            );
          },
          //头部触发刷新的越界距离
          headerTriggerDistance: 45.0,

          // 自定义回弹动画,三个属性值意义请查询flutter api
          springDescription:
              SpringDescription(stiffness: 170, damping: 16, mass: 1.9),

          //头部最大可以拖动的范围,如果发生冲出视图范围区域,请设置这个属性
          maxOverScrollExtent: 150,

          // 底部最大可以拖动的范围
          maxUnderScrollExtent: 150,

          //这个属性不兼容PageView和TabBarView,如果你特别需要TabBarView左右滑动,你需要把它设置为true
          enableScrollWhenRefreshCompleted: true,

          //在加载失败的状态下,用户仍然可以通过手势上拉来触发加载更多
          enableLoadingWhenFailed: true,

          // Viewport不满一屏时,禁用上拉加载更多功能
          hideFooterWhenNotFull: false,

          // 可以通过惯性滑动触发加载更多
          enableBallisticLoad: false,
          child: MaterialApp(
              navigatorKey: HFRouter.navigatorKey,
              //添加国际化支持
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: [
                const Locale('zh', 'CH'),
                const Locale('en', 'US'),
              ],
              debugShowCheckedModeBanner: false,
              title: "汇房",
              onGenerateRoute: onGenerateRoute,
              theme: ThemeData(
                //项目主色
                primaryColor: Config.primaryColor,
                //去除点击时的高亮效果
                highlightColor: Colors.transparent,
                //水波纹效果
                splashColor: Colors.transparent,
                backgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                  color: Config.primaryColor
                ),
              ))),
    );
  }
}
