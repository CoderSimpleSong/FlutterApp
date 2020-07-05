import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/dashed_line.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin{

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("homeinit");
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
        //隐藏返回按钮
        automaticallyImplyLeading:false
      ),
      body: _getHomeWidget(),
    );
  }

  Widget _getHomeWidget(){
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.lightBlue,
      child: DashedLine(
        axis: Axis.horizontal,
        dashedWidth: 6,
        dashedHeight: 3,
        count: 40,
        color: Colors.orange,
      ),
    );
  }
}