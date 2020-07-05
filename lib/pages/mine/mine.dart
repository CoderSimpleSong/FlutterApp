

import 'package:flutter/material.dart';
import 'package:flutter_app/common/storage.dart';
import 'package:flutter_app/widgets/loading_widget.dart';
import '../../common/event_bus.dart';
import 'package:provider/provider.dart';
import '../../provider/login.dart';

class Mine extends StatefulWidget {
  Mine({Key key}) : super(key: key);
  @override
  _MineState createState() => _MineState();
}

class _MineState extends State<Mine> with AutomaticKeepAliveClientMixin{
  var loginProvider;

  @override
  bool get wantKeepAlive => true;
  
  @override
  void initState() {
    super.initState();

    getValue();
    eventBus.on<UserEvent>().listen((event){
      this._getUserinfo();
    });

    // Navigator.of(context).pop();
  }

  void getValue() async {
    showInitStateLoading(context);
    

    bool islogin = await Storage.getBoolValue("isLogin");
    double height = await Storage.getDoubleValue("height");
    int age = await Storage.getIntValue("age");
    String value = await Storage.getStringValue("key");

    print("$islogin --- $height --- $age --- $value");

    //清除指定键值对
    bool isComplete = await Storage.removeKey("key");
   //清除本地所有键值对
    bool isClear = await Storage.clearAllKey();
    Future.delayed(Duration(seconds: 3),(){
      print("延时3s");
      // Navigator.of(context).pop();
      // Navigator.pop(context);
      hideLoadingDialog(context);
    });
  }


  _getUserinfo(){
    print('获取用户信息');
    this.loginProvider.removeToken();
  }

  @override
  Widget build(BuildContext context) {
    this.loginProvider = Provider.of<Login>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("我的"),
        automaticallyImplyLeading: false,
      ),
      body: _getMineWidget(),
    );
  }

  Widget _getMineWidget(){
    return Container(
      color: Colors.lightBlue,
      child: RaisedButton(
        onPressed: (){
          getData();
        },
      ),
    );
  }

  void getData() async {
    showMyCustomLoadingDialog(context);
    Future.delayed(Duration(seconds: 3),(){
      hideLoadingDialog(context);
    });
  }
}