import 'dart:async';
import 'package:flutter/material.dart';
import '../../common/choose_rootwidget.dart';

class LaunchAnimationWidget extends StatefulWidget {
  @override
  _LaunchAnimationWidgetState createState() => _LaunchAnimationWidgetState();
}

class _LaunchAnimationWidgetState extends State<LaunchAnimationWidget> with TickerProviderStateMixin{
  int flashDuration = 5;
  Timer timer;
  
  AnimationController controller;
  CurvedAnimation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = AnimationController(duration:  Duration(milliseconds: flashDuration*1000), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    
    animation.addStatusListener((AnimationStatus status) async{
      if (status == AnimationStatus.completed) {
        print("闪屏页结束,跳转下一个页面");
        print("${ChooseRootWidget.rootWidget}");
        // Navigator.pushNamed(context, ChooseRootWidget.rootWidget);
        // Navigator.of(context).pushNamed(ChooseRootWidget.rootWidget);
        Navigator.pushNamedAndRemoveUntil(context,ChooseRootWidget.rootWidget,(route)=>route == null);
      }
    });

    //开始动画
    controller.forward();
    //开启定时器
    _startTime();
    
  }

  //开启定时器
  void _startTime() async{
    final call = (timer){
      setState(() {
        if(flashDuration <= 0){
            timer.cancel();
          }else{
            flashDuration -=1;
          }
      });
      
    };

     timer = Timer.periodic(Duration(seconds: 1), call);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          alignment: Alignment.center,
          child: FadeTransition(
            opacity: animation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlutterLogo(
                    size: 100,
                ),
                SizedBox(height: 20,),
                Text("这是一个广告页面",style: TextStyle(color: Colors.orange,fontSize: 20,decoration: TextDecoration.none)),
              ],
            ),
          ),
        ),

        Positioned(
          top: 44,
          right: 20,
          child: Container(
            width: 75,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xffcccccc),
              borderRadius:BorderRadius.all(Radius.circular(15.0)),
            ),
            child: FlatButton(
              child: Text(
              "跳过 $flashDuration",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                backgroundColor: Color(0xffcccccc),
                decoration: TextDecoration.none,
              )
              ),
              onPressed: (){
                controller.stop();
                Navigator.pushNamedAndRemoveUntil(context,ChooseRootWidget.rootWidget,(route)=>route == null);
              },
            ),
          )
        ),
      ],
    );
  }



  @override
  dispose() {
    controller.dispose();
    timer.cancel();
    super.dispose();
  }
}