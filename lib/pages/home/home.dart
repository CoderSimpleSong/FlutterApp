/*
 * @Author: 宋佳 
 * @Date: 2022-06-13 09:11:56 
 * @Last Modified by: relax
 * @Last Modified time: 2022-06-13 17:30:14
 */

import 'package:flutter/material.dart';
import 'package:hftech_flutter/common/event_bus.dart';
import 'package:hftech_flutter/common/storage.dart';
import 'package:hftech_flutter/common/toast_widget.dart';
import 'package:hftech_flutter/provider/global_notice.dart';
import 'package:hftech_flutter/widgets/alert_dialog.dart';
import 'package:hftech_flutter/widgets/alert_sure_dialog.dart';
import 'package:hftech_flutter/widgets/loading_widget.dart';
import 'package:hftech_flutter/widgets/upload_version.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

//页面缓存 AutomaticKeepAliveClientMixin 一般用来缓存tab下面的几个标签页面
class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    //模拟网络请求
    //HomeApi.getHomepageData();
    //展示等待框
    showInitStateLoading(context);
    //模拟数据请求 三秒后取消等待框
    Future.delayed(Duration(seconds: 3),(){
      hideLoadingDialog(context);
      ToastTool.showToast("打开首页");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
        centerTitle: true,
      ),
      body: SmartRefresher(
        //页面是否需要下拉刷新
        enablePullDown: true,
        //页面是否需要上拉加载
        enablePullUp: true,
        //控制器
        controller: _refreshController,
        //下拉刷新调用的方法
        onRefresh: _onRefresh,
        //上拉加载更多调用的方法
        onLoading: _onLoading,
        //视图
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: GestureDetector(
                child: Text("跳转至详情页,并传递参数",style: TextStyle(color: Colors.black87,fontSize: 16),),
                onTap: (){
                  Navigator.of(context).pushNamed("/home_detail",arguments: {"key":"fdaklfjdlsafjdsa"});
                },
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 20,),
            ),
            SliverToBoxAdapter(
              child: GestureDetector(
                child: Text("provider:点击修改共享的数据,在我的页面验证",style: TextStyle(color: Colors.black87,fontSize: 16),),
                onTap: (){
                  //修改
                  Provider.of<GlobalNotice>(context, listen: false).updateNotice();
                },
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 20,),
            ),
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
            SliverToBoxAdapter(
              child: GestureDetector(
                child: Text("点击利用eventbus切换底部tab标签",style: TextStyle(color: Colors.black87,fontSize: 16),),
                onTap: (){
                  eventBus.fire(ChangeTabIndex(1));
                },
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 20,),
            ),
            SliverToBoxAdapter(
              child: GestureDetector(
                child: Text("点击下拉刷新",style: TextStyle(color: Colors.black87,fontSize: 16),),
                onTap: (){
                  _refreshController.requestRefresh();
                },
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 20,),
            ),
            SliverToBoxAdapter(
              child: GestureDetector(
                child: Text("点击存入值:abcdef",style: TextStyle(color: Colors.black87,fontSize: 16),),
                onTap: () async{
                  bool value = await Storage.setStringValue("customKey", "abcdef");
                  if(value){
                    ToastTool.showToast("存入成功");
                  }
                },
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 20,),
            ),
            SliverToBoxAdapter(
              child: GestureDetector(
                child: Text("点击取值",style: TextStyle(color: Colors.black87,fontSize: 16),),
                onTap: () async{
                  String? value = await Storage.getStringValue("customKey");
                  ToastTool.showToast("$value");
                },
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 20,),
            ),
            SliverToBoxAdapter(
              child: GestureDetector(
                child: Text("自定义弹框一",style: TextStyle(color: Colors.black87,fontSize: 16),),
                onTap: () {
                  showAlert();
                },
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 20,),
            ),
            SliverToBoxAdapter(
              child: GestureDetector(
                child: Text("自定义弹框二",style: TextStyle(color: Colors.black87,fontSize: 16),),
                onTap: () {
                  showAlertSureDialog();
                },
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 20,),
            ),
            SliverToBoxAdapter(
              child: GestureDetector(
                child: Text("检查版本更新",style: TextStyle(color: Colors.black87,fontSize: 16),),
                onTap: () {
                  showUpdateMessage();
                },
              ),
            ),
          ],
        ),
        ),
      )
    );
  }

  void showUpdateMessage() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: SimpleAppUpgradeWidget(
                title: "发现新版本1.1,是否立即更新",
                contents: [
                  "1.修改bug若干",
                  "2.优化界面若干",
                  "3.测试换行测试换行测试换行测试换行测试换行测试换行测试换行测试换行测试换行测试换行测试换行"
                ],
                onOk: () async {
                  ToastTool.showToast("点击了ok");
                  Navigator.pop(context);
                },
                onCancel: () {
                  ToastTool.showToast("点击了取消");
                },
                force: false,
              ),
            ),
          );
        });
  }

  void showAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertCustomerDialog(
          alertTitle: "提示",
          alertContent: '确定提交吗?',
          onClickCancel: () {
            Navigator.pop(context);
            ToastTool.showToast("点击了取消");
          },
          onClickSure: () {
            Navigator.pop(context);
            ToastTool.showToast("点击了确定");
          },
        );
      }
    );
  }
  void showAlertSureDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertSureDialog(
          alertTitle: '提示',
          alertContent: '确定提交吗?',
          onClickSure: () {
            Navigator.pop(context);
            ToastTool.showToast("点击了确定");
          },
        );
      });
  }

  _onRefresh() async{
    Future.delayed(Duration(seconds: 2),(){
      _refreshController.refreshCompleted();
    });
    /* 伪代码
    //这里 用延时模拟网络请求
    await Future.delayed(Duration(milliseconds: 1000));
    //请求完毕,根据请求的情况设置下拉刷新状态
    if(请求成功){
      data =  请求成功后的数据;
    //刷新界面
    setState(() {

    });
      _refreshController.refreshCompleted();
    }else{
      _refreshController.refreshFailed();
    }
    */
  }
  _onLoading() async{
    Future.delayed(Duration(seconds: 2),(){
      _refreshController.refreshCompleted();
    });
    /* 伪代码
    page ++ ;
    //这里 用延时模拟网络请求
    await Future.delayed(Duration(milliseconds: 1000));
    //请求完毕,根据请求的情况设置下拉刷新状态
    if(请求成功 && 数据不为空){
      data =  原数据 +  请求成功后的数据;
    //刷新界面
    setState(() {

    });
      _refreshController.loadComplete();
    }else if(数据为空){
      //数据为空处理
      _refreshController.loadNoData();
    }else if(请求失败){
      //请求失败处理
      _refreshController.loadFailed();
    }
    */
  }
}