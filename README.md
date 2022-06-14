
# Flutter_App
## 前言:
#### 1.本项目框架搭建环境
```
dart版本: 2.17.1 
flutter SDK版本: 3.0.1
```
#### 2.项目运行
clone项目之后,在当前文件夹下,终端执行```flutter pub get```
#### 3.运行异常解决
由于本框架flutterSDK较高,pull_to_refresh插件本身没有更新导致该异常.
```
: Warning: Operand of null-aware operation '!' has type 'WidgetsBinding' which excludes null.

- 'WidgetsBinding' is from 'package:flutter/src/widgets/binding.dart' ('../../App/flutter3.0.1/packages/flutter/lib/src/widgets/binding.dart').

WidgetsBinding.instance!.addPostFrameCallback((_) {

               ^

: Warning: Operand of null-aware operation '!' has type 'WidgetsBinding' which excludes null.

- 'WidgetsBinding' is from 'package:flutter/src/widgets/binding.dart' ('../../App/flutter3.0.1/packages/flutter/lib/src/widgets/binding.dart').

WidgetsBinding.instance!.addPostFrameCallback((_) {
               ^

```
解决方案:手动删除pull_to_refresh插件内语法使用错误的地方(将instance后的!删除)
../src/smart_refresh.dart line 513
../src/smart_refresh.dart line 765
../src/smart_refresh.dart line 788
../src/smart_refresh.dart line 796
../src/smart_refresh.dart line 803
../src/internals/indicator_wrap.dart  line260
../src/internals/indicator_wrap.dart  line290
../src/internals/indicator_wrap.dart  line393

## 一、项目组织
#### 1、文件组织形式
所有项目源代码请放在项目根目录 lib 目录下，项目所需最基本的文件包括 ``入口文件``以及``页面文件``
- 入口文件为 main.dart

- 页面文件建议放置在 lib/pages 目录下
```javascript
├── api //接口文件夹
│   └── home
│   │   └── home.dart
│   └── mine
│       └── mine.dart
├── common //公共方法文件夹
│   └── choose_rootwidget.dart
│   ├── event_bus.dart
│   ├── http.dart
│   ├── storage.dart
│   └── user_info.dart
├── config //全局配置文件夹（常量、变量、环境变量）
│   └── config.dart
├── main.dart // 入口文件
├── models //模型数据文件夹
│   └── home
│   │   └── home.dart
│   └── mine
│       └── mine.dart
├── pages //页面文件夹
│   └── home
│   │   └── home.dart
│   └── mine
│       └── mine.dart
├── provider //状态(共享)管理文件夹
│   └── global_notice.dart
├── routes //路由配置文件夹
│   └── router.dart
└── widgets //公共组件文件夹
    ├── dashed_line.dart
    ├── loading_widget.dart
    └── toast_widget.dart
```
#### 2、文件命名
普通dart文件以小写字母命名，多个单词以下划线连接，例如 util.dart、util_helper.dart


## 二、代码规范
#### 1、官方规范文档
- 官方代码规范：dart语言官方有自己的代码规范和相关的说明,在dartlang官网上,英文好的建议阅读原文

- 官方连接地址： https://www.dartlang.org/guides/language/effective-dart/style

- 正文文档中图片的说明:绿色部分为正例,右上角带good标识。红色是反例,右上角带bad标识

#### 2、常规规范
- 文件夹和文件名
> pages文件夹下面的文件命名: 小写+下划线+page.dart 或者 小写+下划线+功能名+page.dart（命名规则必须是以下划线分开，以page结束），比如：person_play_page.dart

> models、api这些文件夹里面的文件夹或者是文件的命名必须要与pages文件夹里面的页面文件一一对应

- 类型名(类名,函数类型名):大写开头驼峰

- 变量名(包含const final 常量):使用小写开头驼峰, const可以使用大写+下划线的方式,如同java中一样

## 三、路由的配置
#### 1、在home_route.dart文件夹下添加对应的路由文件，如detail.dart
#### 2、配置detail.dart
```javascript
import 'package:hftech_flutter/config/config.dart';
import 'package:hftech_flutter/pages/home/detail.dart';

Map<String,SJWidgetBuilder> homeRoute ={
  //添加 有参数的路由地址 
  "/home_detail":(context,args) => HomeDetailPage(arguments: args,),
};
// 如果不需要接受参数，直接添加即可
// Map<String, SJWidgetBuilder> homeRoute={
//  '/home_detail':(context,args) =>HomeDetailPage(),
// };
```
### 3、配置router.dart
导入路由文件，并在拦截路由里面添加
```javascript
routes.addAll(homeRoute);
```
### 4、路由参数的传递
① 首先在routes文件夹里面配置对应的arguments

```javascript
Map<String,SJWidgetBuilder> homeRoute ={
  //添加 有参数的路由地址 
  "/home_detail":(context,args) => HomeDetailPage(arguments: args,),
};
```

② 参数的传递，传递Map对象
```javascript
Navigator.of(context).pushNamed("/home_detail",arguments: {"key":"fdaklfjdlsafjdsa"});
```

③ 参数的接受,接受Map对象
```javascript
import 'package:flutter/material.dart';

class HomeDetailPage extends StatefulWidget {
  final Object? arguments;
  const HomeDetailPage({Key? key,this.arguments}) : super(key: key);

  @override
  State<HomeDetailPage> createState() => _HomeDetailPageState();
}

class _HomeDetailPageState extends State<HomeDetailPage> {
  @override
  Widget build(BuildContext context) {
    var args;
    if(widget.arguments is Map){
      args = widget.arguments as Map;
    }
   
    return Scaffold(
      appBar: AppBar(
        title: Text("详情页"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Text("本页面主要用来测试路由跳转,以及参数的传递,接收到的参数是:${args["key"]}"),
        ),
      ),
    );
  }
}
```

## 四、Provider的配置和使用
#### 1、在provider文件夹下面新增对应的provider的类文件，如global_notice.dart
```javascript
//这是一个例子  比如在首页/我的页面 都需要展示消息状态, 每当有新的消息/用户读取消息 两个页面都要展示有新消息状态  
import 'package:flutter/material.dart';

class GlobalNotice with ChangeNotifier{

  late bool _hasNewsNotice;
  GlobalNotice(this._hasNewsNotice);

  void updateNotice()async{
  //每当收到新消息或者读取消息时 就变更状态
   //这里可以请求接口,确认是否还有未读消息  要跟据实际情况
   _hasNewsNotice = !_hasNewsNotice;
    notifyListeners();
    
  }
  bool get hasNewsNotice => _hasNewsNotice;
}
```
#### 2、在main.dart里面配置，首先引入provider的文件，然后在MultiProvider类里面的providers的list添加通知类，按如下代码格式添加即可：
```javascript
ChangeNotifierProvider(create: (_) => GlobalNotice(false)),
```

#### 3、使用方法
```javascript
//修改状态
Provider.of<GlobalNotice>(context, listen: false).updateNotice();
//在widget拿到状态并展示
child: Container(child: Consumer<GlobalNotice>(builder: ((context, notice, _) {
     return Text("当前provider的取值为:${notice.hasNewsNotice}",style: TextStyle(color: Colors.black87,fontSize: 16));
    }))
),
```

## 五、页面缓存的配置
#### 1、页面类mixin或继承下AutomaticKeepAliveClientMixin类
#### 2、配置keepAlive

#### 实例：
```javascript
class _MineState extends State<Mine> with AutomaticKeepAliveClientMixin {
  ...
  @override
    bool get wantKeepAlive => true;
  ...
}
```

## 六、事件总线（EventBus）
#### 1、主要是对common文件夹下面的event_bus.dart的编写,具体应用在框架中有例子
```javascript
//全局事件总线  类似于广播 iOS的通知
EventBus eventBus = new EventBus();

class ChangeTabIndex {
  late int index;
  ChangeTabIndex(index) {
    this.index = index;
  }
}
```

#### 2、引入eventbus文件，添加发送事件

实例：
```javascript
  ...
   eventBus.fire(ChangeTabIndex(1));
  ...
```

#### 3、引入eventbus文件，添加订阅事件

实例：
```javascript
@override
  void initState() {
    super.initState();

    eventBus.on<ChangeTabIndex>().listen((event) {
      setState(() {
        this.currentIndex = event.index;
        controller?.jumpToPage(event.index);
      });
    });
  }
```
## 七、模型层(Model类)的建立
#### 1、规则说明
转换成model类的好处：转换后可以减少上线后APP崩溃和出现异常，所以如果后端接口返回的数据层级比较复杂，原则上每个接口返回的数据都需要经过model层的转换，首先需要制作model类模型，然后用model的形式编辑UI界面。

**新建model类的规则：**

**①可以每个接口都使用model类模型**

**②如果返回数据比较复杂或者返回的数据的层级超过三层，必须要使用model类模型**

#### 2、生成model类
在使用工具之前需要首先对model类的概念和代码进行理解。

生成工具网址：https://javiercbk.github.io/json_to_dart/

#### 3、model类的使用
在实际使用场景中，建议把model的使用放在api文件夹里面
```javascript
class HomeApi{
  static Future<HomePageModel?> getHomepageData() async{
    return HomePageModel.fromJson(await HttpGo.httpRequest(
      "请求地址",
      queryParams: {"args": 2},
    ));
  }
}
```
## 八、下拉刷新(pull_to_refresh)的使用
#### 1.使用规则
项目中已做好下拉刷新,上拉加载全局配置(具体可在main.dart中查看修改),具体到某个页面只需要选择是否进入页面自动刷新,是否启用下拉刷新,是否启用上拉加载等以及相关业务逻辑
#### 2.下拉刷新,上拉加载具体到页面的使用
-  引入``` import ‘package:pull_to_refresh/pull_to_refresh.dart’; ```
-  在声明下拉刷新组件控制器``` RefreshController _refreshController = RefreshController(initialRefresh: true); //true代表进入页面自动刷新```
-  在build方法中声明页面声明需要下拉刷新组件,并配置回调方法
```javascript
@override
  Widget build(BuildContext context) {
    return SmartRefresher(
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
      child: ListView.builder(
        itemBuilder: (ccontext, index) => Card(child: Center(child: Text(data[index]))),
          itemExtent: 100.0,
          itemCount: data.length,
        ),
      );
  }
```
- 在回调方法中实现与服务端交互,根据交互结果改变下拉刷新组件的状态

```javascript
  //下拉刷新调用的方法
  void _onRefresh() async {
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
  }
 //上拉加载更多调用的方法
  void _onLoading() async {
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
  }
```


## 九、网络请求(Dio)框架的使用
#### 1.使用说明
- 项目中使用的网络请求,是在Dio基础上做的二次封装,每次新项目启动要重新配置http.dart文件,一般项目负责人都会配置好,我们只管用就可以;
- 项目中二次封装的工具类只支持get,post请求方式,put,delete等方式目前不支持
- 目前该框架暂不支持获取下载文件进度功能(可能随着做项目会完善该功能)

#### 2.参数说明

```javascript
  //必传参数  接口名,如果要请求一个非项目统一配置的服务器地址接口,直接填写全地址 
  //例:"https://play.cttyun.cn:8080/mobile-user/user-data"
  "home/banner",

  //非必传参数,默认为get请求,支持get,post请求
  methodType: HttpMethodType.Get,

  //非必传参数,拼接在url后面的参数
  queryParams: params,

  //非必传参数,请求体中参数
    body: body,

    //非必传参数,错误处理; 如果不处理,默认弹toast提示,如果不想弹toast可以做如下操作
    errorCallBack: (str){
      print(str);
    },
  //非必传参数, 是否展示toast,使用场景只有一种: 就是不想展示toast,也不想设置errorCallBack参数,
  //只需要设置该属性为false
  isShowToast: true,

```

#### 3.使用🌰

```javascript
@override
  void initState() {
    // TODO: implement initState
    super.initState();

    //加载数据
	  requestExample();
  }

  void  requestExample() async{
    //m为服务端返回数据,包括code,msg,data等
    Map<String,dynamic> body = {
      "name":"sj",
      "age":18
    };

    Map<String,dynamic> params = {
      "userName":"3301",
      "pwd":7777777
    };

    Map<String,dynamic> m = await HttpGo.httpRequest(
      //必传参数  接口名,如果要请求一个非项目统一配置的服务器地址接口,直接填写全地址 
      //例:"https://play.cttyun.cn:8080/mobile-user/user-data"
      "home/banner",

      //非必传参数,默认为get请求,支持get,post请求
      methodType: HttpMethodType.Get,

      //非必传参数,拼接在url后面的参数
      queryParams: params,

      //非必传参数,请求体中
       body: body,

       //非必传参数,错误处理; 如果不处理,默认弹toast提示,如果不像弹toast可以做如下操作
       errorCallBack: (str){
         print(str);
       },
      //非必传参数, 是否展示toast,使用场景只有一种: 就是不想展示toast,也不想设置errorCallBack参数,只需要设置该属性为false
      isShowToast: true,
    );
   //根据服务端返回的map处理业务逻辑 
   .
   ..
```
#### 4.上传等相关操作

```javascript
//单文件上传,既包含key-Value,又包含文件 
FormData formData = FormData.from({
  "name": "wendux",
  "age": 25,
  "file": await MultipartFile.fromFile("./text.txt",filename: "upload.txt")
});
Map result = await HttpGo.httpRequest(
  "home/picUpload",

  //请求方式一定要选择post
  methodType: HttpMethodType.Post,

  //请求体
  body:formData
);
//多文件上传,数据处理
FormData.fromMap({
  "files": [
    MultipartFile.fromFileSync("./example/upload.txt",
        filename: "upload.txt"),
    MultipartFile.fromFileSync("./example/upload.txt",
        filename: "upload.txt"),
  ]
});
```

具体可以参考[Dio官方文档](https://github.com/flutterchina/dio/blob/master/README-ZH.md "Dio官方文档")
## 十、吐司(flutterToast)的使用
#### 1.使用说明
本项目统一吐司样式,是对第三方插件fluttertoast的二次封装
#### 2.使用方式
- 引入```import '../widgets/toast_widget.dart';```
- 使用```ToastTool.showToast("提示文字"); ```
## 十一、键值对本地存储(Storage)
#### 1.使用说明
本项目键值对存储是对第三方插件shared_preferences的简单封装
#### 2.使用步骤
- 引入```../common/storage.dart```
- 存值 

```javascript
    //存储bool值
    bool isLogin = await Storage.setBoolValue("isLogin",true);
	//存储double值
    bool isSuccess = await Storage.setDoubleValue("height",1.78);
	//存储int值
    bool isOk = await Storage.setIntValue("age",27);
	//存储字符串
    bool storage = await Storage.setStringValue("key","value");

    print("$isLogin --- $isSuccess --- $isOk --- $storage");
```

- 取值

```javascript
  bool? islogin = await Storage.getBoolValue("isLogin");
  double? height = await Storage.getDoubleValue("height");
  int? age = await Storage.getIntValue("age");
  String? value = await Storage.getStringValue("key");

  print("$islogin --- $height --- $age --- $value");
```

- 其他

```javascript
  //清除指定键值对
  bool isComplete = await Storage.removeKey("key");
  //清除本地所有键值对
  bool isClear = await Storage.clearAllKey();
```

## 十二、虚线工具的使用(DashedLine)
#### 1.使用说明
本工具类本质就是一个个container实现的虚线效果
#### 2.使用🌰

```javascript
  Container(
    width: double.infinity,
    height: double.infinity,
    color: Colors.lightBlue,
    child: DashedLine(
      //虚线的方向,横向还是竖向
      axis: Axis.horizontal,
      //每一个小的点的宽度
      dashedWidth: 6,
      //每一个小的点的高度
      dashedHeight: 3,
      //虚线点的个数
      count: 40,
      //虚线点的颜色
      color: Colors.orange,
    ),
  );
```

## 十三、加载框的使用(Loading)
## 1.使用说明
项目中loading是使用showDialog + flutter_spinkit(第三方loading插件)实现的
## 2.使用方法
- 引入 ```import '../widgets/loading_widget.dart';```
- 直接调用全局方法调起loading,注意这里分两种情况

```javascript
//场景一: 在进入页面(initState方法中)立即异步请求 则需要在异步请求的方法中调用showInitStateLoading(context)
  void initState() {
    super.initState();
    getValue();
  }
   void getValue() async {
   //调起loading
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
	//模拟网络请求延时操作
	Future.delayed(Duration(seconds: 3),(){
      print("延时3s");
	//取消loading
      hideLoadingDialog(context);
     });
  }
  
  //场景二:点击按钮,进行网络请求,同时展示loading
  Widget build(BuildContext context) {
    this.loginProvider = Provider.of<Login>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("我的"),
        automaticallyImplyLeading: false,
      ),
      body:Container(
        color: Colors.lightBlue,
        child: RaisedButton(
          onPressed: (){
            getData();
         },
       ),
    ),
    );
  }
  void getData() async {
    //展示loading
    showMyCustomLoadingDialog(context);
    //模拟网络请求
    Future.delayed(Duration(seconds: 3),(){
      //隐藏loading
      hideLoadingDialog(context);
    });
  }
```

## 十四、项目首页(launch_animation)
- 该页面是应用首页路由"/"对应的页面,现在预留的是一个广告页面,要根据具体项目的需求修该页面






















