/*
 * @Author: 宋佳 
 * @Date: 2022-06-10 09:44:52 
 * @Last Modified by:   relax 
 * @Last Modified time: 2022-06-10 09:44:52 
 */

import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

//配合dio使用,自定义打印
class LogInterceptorCustomize extends Interceptor {
  LogInterceptorCustomize({
    this.request = true,
    this.requestHeader = true,
    this.requestBody = false,
    this.responseHeader = true,
    this.responseBody = true,
    this.error = true,
    this.logPrint = print,
  });
  bool request;

  bool requestHeader;

  bool requestBody;

  bool responseBody;

  bool responseHeader;

  bool error;

  void Function(Object? object) logPrint;

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    logPrint('*** Request ***');
    printKV('uri', options.uri);
    if (request) {
      printKV('method', options.method);
      printKV('responseType', options.responseType.toString());
      printKV('followRedirects', options.followRedirects);
      printKV('connectTimeout', options.connectTimeout);
      printKV('receiveTimeout', options.receiveTimeout);
      printKV('extra', options.extra);
    }
    if (requestHeader) {
      logPrint('headers:');
      options.headers.forEach((key, v) => printKV(' $key', v));
    }

    if (requestBody) {
      logPrint('Body:');
      final data = options.data;
      if (data != null) {
        print("${data.toString()}");
      }
    }
    return handler.next(options);
  }

  @override
  Future onError(DioError err,ErrorInterceptorHandler handler,) async {
    if (error) {
      logPrint('*** DioError ***:');
      logPrint('uri: ${err.requestOptions.uri}');
      logPrint('$err');
      if (err.response != null) {
        _printResponse(err.response!);
      }
      logPrint('');
    }
    return handler.next(err);
  }

  @override
  Future onResponse(Response response,ResponseInterceptorHandler? handler) async {
    
    logPrint('*** Response ***');
    _printResponse(response);
    handler?.next(response);
  }

  void _printResponse(Response response) {
    printKV('uri', response.requestOptions.uri);
    if (responseHeader) {
      printKV('statusCode', response.statusCode.toString());
      if (response.isRedirect == true) {
        printKV('redirect', response.realUri);
      }
      logPrint('headers:');
      response.headers.forEach((key, v) => printKV(' $key', v.join(',')));
    }
    if (responseBody) {
      logPrint('Response Text:');
      segmentationLog(response.toString());
//      printAll(response.toString());
    }
    logPrint('');
  }

  void printKV(String key, Object v) {
    logPrint('$key: $v');
  }

  void printAll(msg) {
    msg.toString().split('\n').forEach(logPrint);
  }

  int _limitLength = 800;
  bool isPrint = false; //是否打印了
  ///用于解决打印返回的数据 显示不全问题
  void segmentationLog(String msg) {
    var outStr = StringBuffer();
    for (var index = 0; index < msg.length; index++) {
      outStr.write(msg[index]);
      if (index % _limitLength == 0 && index != 0) {
        isPrint = true;
        print(outStr);
        outStr.clear();
        var lastIndex = index + 1;
        if (msg.length - lastIndex < _limitLength) {
          var remainderStr = msg.substring(lastIndex, msg.length);
          print(remainderStr);
          break;
        }
      }
    }
    if (!isPrint) {
      print(msg);
    }
  }
}
