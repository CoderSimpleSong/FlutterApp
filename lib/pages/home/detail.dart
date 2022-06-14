/*
 * @Author: 宋佳 
 * @Date: 2022-06-13 13:52:34 
 * @Last Modified by: relax
 * @Last Modified time: 2022-06-14 09:44:58
 */
import 'package:flutter/material.dart';
import 'package:hftech_flutter/common/common_function.dart';

class HomeDetailPage extends StatefulWidget {
  final Object? arguments;
  const HomeDetailPage({Key? key,this.arguments}) : super(key: key);

  @override
  State<HomeDetailPage> createState() => _HomeDetailPageState();
}

class _HomeDetailPageState extends State<HomeDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var args;
    if(widget.arguments is Map){
      args = widget.arguments as Map;
    }
   String text = "本页面主要用来测试路由跳转,以及参数的传递,接收到的参数是:${args["key"]}";
    return Scaffold(
      appBar: AppBar(
        title: Text("详情页"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Text(text.fixAutoLines()),
      ),
    );
  }
}