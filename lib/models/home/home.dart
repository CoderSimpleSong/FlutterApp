/*
 * @Author: 宋佳 
 * @Date: 2022-06-13 09:17:44 
 * @Last Modified by: relax
 * @Last Modified time: 2022-06-13 09:55:27
 */
class HomePageModel {
  Args? args;
  Headers? headers;
  String? url;

  HomePageModel({this.args, this.headers, this.url});

  HomePageModel.fromJson(Map<String, dynamic> json) {
    args = json['args'] != null ? new Args.fromJson(json['args']) : null;
    headers =
        json['headers'] != null ? new Headers.fromJson(json['headers']) : null;
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.args != null) {
      data['args'] = this.args!.toJson();
    }
    if (this.headers != null) {
      data['headers'] = this.headers!.toJson();
    }
    data['url'] = this.url;
    return data;
  }
}

class Args {
  String? aaa;

  Args({this.aaa});

  Args.fromJson(Map<String, dynamic> json) {
    aaa = json['aaa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aaa'] = this.aaa;
    return data;
  }
}

class Headers {
  String? xForwardedProto;
  String? xForwardedPort;
  String? host;
  String? xAmznTraceId;
  String? userAgent;
  String? acceptEncoding;
  String? authorization;

  Headers(
      {this.xForwardedProto,
      this.xForwardedPort,
      this.host,
      this.xAmznTraceId,
      this.userAgent,
      this.acceptEncoding,
      this.authorization});

  Headers.fromJson(Map<String, dynamic> json) {
    xForwardedProto = json['x-forwarded-proto'];
    xForwardedPort = json['x-forwarded-port'];
    host = json['host'];
    xAmznTraceId = json['x-amzn-trace-id'];
    userAgent = json['user-agent'];
    acceptEncoding = json['accept-encoding'];
    authorization = json['authorization'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['x-forwarded-proto'] = this.xForwardedProto;
    data['x-forwarded-port'] = this.xForwardedPort;
    data['host'] = this.host;
    data['x-amzn-trace-id'] = this.xAmznTraceId;
    data['user-agent'] = this.userAgent;
    data['accept-encoding'] = this.acceptEncoding;
    data['authorization'] = this.authorization;
    return data;
  }
}
