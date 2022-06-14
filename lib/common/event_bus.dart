/*
 * @Author: 宋佳 
 * @Date: 2022-06-10 09:45:12 
 * @Last Modified by: relax
 * @Last Modified time: 2022-06-13 15:21:13
 */

import 'package:event_bus/event_bus.dart';

//全局事件总线  类似于广播 iOS的通知
EventBus eventBus = new EventBus();

class ChangeTabIndex {
  late int index;
  ChangeTabIndex(index) {
    this.index = index;
  }
}

/*例如 我们要实现这样一个功能 :点击首页上面的某一个按钮 实现底部标签的切换;
1.在此dart文件中定义下方的类

class ChangeTabIndex {
  late int index;
  ChangeTabIndex(index) {
    this.index = index;
  }
}
2.在tab控制器注册监听并实现底部标签的切换功能
  eventBus.on<ChangeTabIndex>().listen((event) {
    setState(() {
      this.currentIndex = event.index;
      controller.jumpToPage(this.currentIndex);
    });
  });
3.在首页的按钮绑定方法,发出切换底部标签的通知
  eventBus.fire(ChangeTabIndex(targetIndex));
 */

