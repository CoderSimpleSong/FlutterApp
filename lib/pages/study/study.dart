import 'package:flutter/material.dart';

class Study extends StatefulWidget {
  @override
  _StudyState createState() => _StudyState();
}

class _StudyState extends State<Study> with AutomaticKeepAliveClientMixin{
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("studyinit");
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("学习"),
        //隐藏返回按钮
        automaticallyImplyLeading:false
      ),
      body: _getStudyWidget(),
    );
  }

  Widget _getStudyWidget(){
    return Container(

    );
  }
}