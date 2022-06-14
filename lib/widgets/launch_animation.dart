/*
 * @Author: 宋佳 
 * @Date: 2022-06-13 09:53:08 
 * @Last Modified by: relax
 * @Last Modified time: 2022-06-13 13:43:16
 */

import 'dart:async';
import 'package:flutter/material.dart';
import '../../common/choose_rootwidget.dart';

class LaunchAnimationWidget extends StatefulWidget {
  @override
  _LaunchAnimationWidgetState createState() => _LaunchAnimationWidgetState();
}

class _LaunchAnimationWidgetState extends State<LaunchAnimationWidget> with TickerProviderStateMixin{
  int flashDuration = 2;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    //开启定时器
    _startTime();
    
  }

  //开启定时器
  void _startTime() async {
    final call = (timer) {
      setState(() {
        if (flashDuration <= 0) {
          timer.cancel();
          if (ChooseRootWidget.rootWidget == "/login") {
            Navigator.pushNamedAndRemoveUntil(context,
                  ChooseRootWidget.rootWidget, (route) => false);
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, ChooseRootWidget.rootWidget, (route) => false);
          }
        } else {
          flashDuration -= 1;
        }
      });
    };
    timer = Timer.periodic(Duration(seconds: 1), call);
  }

  @override
  Widget build(BuildContext context) {
    // Config.appcontext = context;
    return Scaffold(
      backgroundColor: Color(0xFFFC8E2B),
      body: Container(
        color: Color(0xFFFC8E2B),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "images/tabbar_icon_treasure_default.png",
              ),
              Text("这是一个广告页,默认时间为2秒",style: TextStyle(color: Colors.white),)
            ],
          ),
        ),
      ),
    );
  }



  @override
  dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }
}