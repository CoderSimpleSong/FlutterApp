/*
 * @Author: 宋佳 
 * @Date: 2022-06-10 09:45:41 
 * @Last Modified by: relax
 * @Last Modified time: 2022-06-13 17:25:01
 */



//可以根据实际项目需要 修改参数 以及其他配置项
import 'package:dio/dio.dart';
import 'package:hftech_flutter/common/common_function.dart';
import 'package:hftech_flutter/common/toast_widget.dart';
import 'package:hftech_flutter/config/other_const.dart';
import 'dio_log.dart';

const _TimeOut = 10000;
const String _SuccessCodeKey = "code"; //一般就是code/status
const int _SuccessCodeValue = 200; //成功的值
const int _SuccessStatusValue = 200; //成功的值

typedef HttpErrorCallback = void Function(String errorStr);

enum HttpMethodType { Get, Post, Put, Delete }

class HttpGo {
  static BaseOptions _op = BaseOptions(
    //baseUrl
    baseUrl: OtherConst.serviceURL,
    /// 连接服务器超时时间，单位是毫秒.
    connectTimeout: _TimeOut,
    //请求体-> 编码格式   json格式
    contentType: Headers.jsonContentType,
    //响应体->编码格式  json格式
    responseType: ResponseType.json,
    headers: {"Authorization": "bearer accessToken"},
  );

  static Dio _dio = Dio(_op);

  static Future<dynamic> httpRequest(String url,
      {HttpMethodType methodType = HttpMethodType.Get,
      dynamic body,
      Map<String, dynamic>? queryParams,
      List<Map<String, dynamic>>? path,
      int? revieveTime,
      int? connectionTime,
      HttpErrorCallback? errorCallBack,
      bool isShowToast = true}) async {
    String method = "get";
    if (methodType == HttpMethodType.Post) {
      method = "post";
    } else if (methodType == HttpMethodType.Put) {
      method = "put";
    } else if (methodType == HttpMethodType.Delete) {
      method = "delete";
    }
    Options option = Options(
        method: method,
        receiveTimeout: revieveTime == null ? 20000 : revieveTime);
    //链接时间设置，默认10s，预留外面可以设置，上传图片的时候连接时间要长点，不然会超时
    _dio.options.connectTimeout = connectionTime == null ? _TimeOut : connectionTime;

    //适配restful写法
    if (path != null && path.length != 0) {
      for (var i = 0; i < path.length; i++) {
        Map<String, dynamic> map = path[i];
        url = url + "/${map.values.first}";
      }
    }

    String errorMsg = '';
    int? status;
    try {
      Response response;
      _addStartHttpInterceptor(_dio); //添加请求之前的拦截器
      response = await _dio.request(url,data: body, queryParameters: queryParams, options: option);
      status = response.statusCode;
      if (status != _SuccessStatusValue) {
        errorMsg = response.data["message"];
        _error(errorCallBack, errorMsg, isShowToast);
      }else{
        dynamic dataMap = response.data;
        if (dataMap != null) {
          if(dataMap[_SuccessCodeKey] == _SuccessCodeValue){
            return dataMap;
          }else{
            _error(errorCallBack, dataMap["message"], isShowToast);
          }
        }else{
          _error(errorCallBack, "数据为空", isShowToast);
        }
      }
    } catch (exception) {
      if (exception is DioError) {
        if (exception.response != null && exception.response?.data != null) {
          if (exception.response?.statusCode == 401) {
            CommonTool.logoutApp(2);
          } else {
            _error(
                errorCallBack, exception.response?.data["message"], isShowToast);
          }
        }
      }
    }
  }

  ///每次登录都重新加载dio信息
  static setDioInfo(String baseUrl, String accessToken) {
    _dio.options.baseUrl = baseUrl;
    _dio.options.headers.addAll({"Authorization": "bearer $accessToken"});
  }

  static _error(HttpErrorCallback? errorCallBack, String error, bool isShowToast) {
      if(errorCallBack != null){
          errorCallBack(error);
      }else{
        if(isShowToast && error.isNotEmpty && error != 'null'){
          //过滤空提示语
          ToastTool.showToast("$error");
        }
      }
  }

  //拦截器  目前暂未处理
  static _addStartHttpInterceptor(Dio dio) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options,RequestInterceptorHandler handler){
        return handler.next(options);
      }, 
      onResponse: (Response response,ResponseInterceptorHandler handler){
        // 在返回响应数据之前做一些预处理
        return handler.next(response);
      }, onError: (DioError e , handler) async {
        // 当请求失败时做一些预处理
        return handler.next(e); //continue
      }));
    assert(() {
      // 只在debug模式下生效
      dio.interceptors.add(LogInterceptorCustomize(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          error: true)); //开启请求日志
      return true;
    }());
  }
}
