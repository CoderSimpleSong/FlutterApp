import 'package:flutter/material.dart';
import 'package:flutter_app/common/storage.dart';
import '../../common/event_bus.dart';

class Doings extends StatefulWidget {
  Doings({Key key}) : super(key: key);
  @override
  _DoingsState createState() => _DoingsState();
}

class _DoingsState extends State<Doings> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print("doinginit");

    saveValue();
  }

  void saveValue() async {
    bool isLogin = await Storage.setBoolValue("isLogin",true);
    bool isSuccess = await Storage.setDoubleValue("height",1.78);
    bool isOk = await Storage.setIntValue("age",27);
    bool storage = await Storage.setStringValue("key","value");

    print("$isLogin --- $isSuccess --- $isOk --- $storage");
  }

  @override
  void dispose() {
    super.dispose();
    eventBus.fire(new UserEvent('登录成功....'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("活动"),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: InkWell(
          onTap: (){
            Navigator.pushNamed(context, '/detail', arguments: {'id': 32332444});
          },
          child: Text('点击详情'),
        ),
      ),
    );
  }
}