
import 'package:dio/dio.dart';
import '../widgets/toast_widget.dart';
// import './http_config.dart';

const BaseUrl = "https://crea.cs.cttyun.cn:11000/";
const TimeOut = 3000;
const String SuccessCodeKey = "status";//一般就是code/status
const int SuccessCodeValue = 200; //成功的值
const int SuccessStatusValue = 200; //成功的值
const String SuccessDataKey = "data";  //数据所在的key 一般就是data

typedef HttpErrorCallback = void Function(String errorStr);

enum HttpMethodType{
  Get,
  Post
}

class HttpGo {

static  BaseOptions op = BaseOptions(
    /// 请求基地址.
    baseUrl:BaseUrl,

    /// Http请求头.
    headers:{
      "Authorization" : "2d080e6a1812d192dcb217adca820388",
    },

    /// 连接服务器超时时间，单位是毫秒.
    connectTimeout:TimeOut, 

    //请求体-> 编码格式   json格式
    contentType:Headers.jsonContentType,

    //响应体->编码格式  json格式
    responseType:ResponseType.json,
    );

static  Dio dio = Dio(op);

static Future<dynamic> httpRequest(String url,{HttpMethodType methodType = HttpMethodType.Get ,dynamic body, Map<String,dynamic> queryParams,HttpErrorCallback errorCallBack,bool isShowToast = true}) async{
    String method = (methodType == HttpMethodType.Get) ? "get" : "post";
    Options option = Options(method: method);
    String errorMsg = '';
    int status;
    try {
      Response response;
      _addStartHttpInterceptor(dio); //添加请求之前的拦截器,目前不做拦截
      response = await dio.request(url,data: body,queryParameters: queryParams,options: option);
      status = response.statusCode;
      if (status != SuccessStatusValue) {
        errorMsg = '错误码：' + status.toString() + '，' + response.data.toString();
        _error(errorCallBack, errorMsg,isShowToast);
      }

      dynamic dataMap = response.data;
      if (dataMap != null && dataMap[SuccessCodeKey] != SuccessCodeValue) {
        errorMsg =
            '错误码：' + dataMap[SuccessCodeKey].toString() + '，' + response.data.toString();
        _error(errorCallBack, errorMsg,isShowToast);
      }
      if(dataMap != null && dataMap[SuccessCodeKey] == SuccessCodeValue){
        return dataMap;
      }

    } catch (exception) {
      if(exception is DioError){
        _error(errorCallBack, exception.response.data["msg"],isShowToast);
      }
      
    }
  }

static  _error(HttpErrorCallback errorCallBack, String error , bool isShowToast) {

    if(isShowToast){
      if (errorCallBack != null) {
        errorCallBack(error);
      }else{
        ToastTool.showToast("$error");
      }
    }else{
      if(errorCallBack != null){
        errorCallBack(error);
      }
    }
    
  }


  //拦截器  目前暂未处理
static  _addStartHttpInterceptor(Dio dio) {
    dio.interceptors.add(InterceptorsWrapper(
    onRequest:(RequestOptions options) async {
     // 在请求被发送之前做一些事情
     return options; //continue
     // 如果你想完成请求并返回一些自定义数据，可以返回一个`Response`对象或返回`dio.resolve(data)`。
     // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义数据data.
     //
     // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象，或返回`dio.reject(errMsg)`，
     // 这样请求将被中止并触发异常，上层catchError会被调用。
    },
    onResponse:(Response response) async {
     // 在返回响应数据之前做一些预处理
     return response; // continue
    },
    onError: (DioError e) async {
      // 当请求失败时做一些预处理
     return e;//continue
    }
    ));
  }
}