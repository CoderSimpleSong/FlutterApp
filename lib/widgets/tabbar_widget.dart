/*
 * @Author: 宋佳 
 * @Date: 2022-06-13 09:37:40 
 * @Last Modified by: relax
 * @Last Modified time: 2022-06-13 15:21:37
 */
import 'package:flutter/material.dart';
import 'package:hftech_flutter/common/event_bus.dart';
import 'package:hftech_flutter/config/config.dart';
import 'package:hftech_flutter/pages/home/home.dart';
import 'package:hftech_flutter/pages/mine/mine.dart';
import 'tabbar_item.dart';

class TabbarWidget extends StatefulWidget {

  @override
  _TabbarWidgetState createState() => _TabbarWidgetState();
}

class _TabbarWidgetState extends State<TabbarWidget>
    with WidgetsBindingObserver {
  int currentIndex = 0;
  PageController? controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(
      initialPage: currentIndex,
    );

    eventBus.on<ChangeTabIndex>().listen((event) {
      setState(() {
        this.currentIndex = event.index;
        controller?.jumpToPage(event.index);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          HomePage(),
          MinePage()
        ],
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
         currentIndex: this.currentIndex,
         selectedFontSize: 12.0,
         selectedItemColor: Config.primaryColor,
        // selectedIconTheme: IconThemeData(color: Colors.red),
        onTap:(value){
          setState(() {
            this.currentIndex = value;
            controller?.jumpToPage(value);
          });
        },
        items:[
          TabbatItem("home", "首页", 24),
          TabbatItem("my", "我的", 24),
        ]
      ),
    );
  }
}
