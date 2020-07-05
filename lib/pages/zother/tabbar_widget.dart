import 'package:flutter/material.dart';
import '../home/home.dart';
import '../mine/mine.dart';
import '../study/study.dart';
import '../doings/doing.dart';
import 'tabbar_item.dart';

class TabbarWidget extends StatefulWidget {
  @override
  _TabbarWidgetState createState() => _TabbarWidgetState();
}

class _TabbarWidgetState extends State<TabbarWidget> {

  int currentIndex = 0;
  PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(
      initialPage: currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          Home(),
          Doings(),
          Study(),
          Mine()
        ],
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
         currentIndex: this.currentIndex,
         selectedFontSize: 12.0,
        // selectedIconTheme: IconThemeData(color: Colors.red),
        onTap:(value){
          setState(() {
            this.currentIndex = value;
            controller.jumpToPage(value);
          });
        },
        items:[
          TabbatItem("focus", "首页", 24),
          TabbatItem("news", "活动", 24),
          TabbatItem("treasure", "学习", 24),
          TabbatItem("user", "我的", 24),
        ]
      ),
    );
  }
}