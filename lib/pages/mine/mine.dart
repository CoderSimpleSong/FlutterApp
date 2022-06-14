/*
 * @Author: 宋佳 
 * @Date: 2022-06-13 09:12:19 
 * @Last Modified by: relax
 * @Last Modified time: 2022-06-13 15:10:04
 */

import 'package:flutter/material.dart';
import 'package:hftech_flutter/api/mine/mine.dart';
import 'package:hftech_flutter/common/toast_widget.dart';
import 'package:hftech_flutter/provider/global_notice.dart';
import 'package:provider/provider.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    //模拟 网络请求
    //MineApi.getMinepageData();
    ToastTool.showToast("打开我的页面");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的"),
        centerTitle: true,
      ),
      body:Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              child: Consumer<GlobalNotice>(builder: ((context, notice, _) {
                 return Text("当前provider的取值为:${notice.hasNewsNotice}",style: TextStyle(color: Colors.black87,fontSize: 16));
              }))
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 20,),
          ),
        ],
      ),
      ),
    );
  }
}