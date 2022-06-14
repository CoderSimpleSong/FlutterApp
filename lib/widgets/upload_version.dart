/*
 * @Author: 宋佳 
 * @Date: 2022-06-13 09:37:50 
 * @Last Modified by: relax
 * @Last Modified time: 2022-06-13 09:49:19
 */

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

///
/// des:app升级提示控件
///
class SimpleAppUpgradeWidget extends StatefulWidget {
  const SimpleAppUpgradeWidget(
      {required this.title,
      this.titleStyle,
      required this.contents,
      this.contentStyle,
      this.cancelText,
      this.cancelTextStyle,
      this.okText,
      this.okTextStyle,
      this.okBackgroundColors,
      this.progressBar,
      this.progressBarColor,
      this.borderRadius = 10,
      this.force = false,
      this.iosAppId,
      this.onCancel,
      this.onOk});

  ///
  /// 升级标题
  ///
  final String title;

  ///
  /// 标题样式
  ///
  final TextStyle? titleStyle;

  ///
  /// 升级提示内容
  ///
  final List<String> contents;

  ///
  /// 提示内容样式
  ///
  final TextStyle? contentStyle;

  ///
  /// 下载进度条
  ///
  final Widget? progressBar;

  ///
  /// 进度条颜色
  ///
  final Color? progressBarColor;

  ///
  /// 确认控件
  ///
  final String? okText;

  ///
  /// 确认控件样式
  ///
  final TextStyle? okTextStyle;

  ///
  /// 确认控件背景颜色,2种颜色左到右线性渐变
  ///
  final List<Color>? okBackgroundColors;

  ///
  /// 取消控件
  ///
  final String? cancelText;

  ///
  /// 取消控件样式
  ///
  final TextStyle? cancelTextStyle;


  ///
  /// 圆角半径
  ///
  final double borderRadius;

  ///
  /// 是否强制升级,设置true没有取消按钮
  ///
  final bool force;

  ///
  /// ios app id,用于跳转app store
  ///
  final String? iosAppId;


  final VoidCallback? onCancel;
  final VoidCallback? onOk;

  @override
  State<StatefulWidget> createState() => _SimpleAppUpgradeWidget();
}

class _SimpleAppUpgradeWidget extends State<SimpleAppUpgradeWidget> {



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          _buildInfoWidget(context),
        ],
      ),
    );
  }

  ///
  /// 信息展示widget
  ///
  Widget _buildInfoWidget(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          //标题
          _buildTitle(),
          //更新信息
          _buildAppInfo(),
          //操作按钮
          _buildAction()
        ],
      ),
    );
  }

  ///
  /// 构建标题
  ///
  _buildTitle() {
    return Padding(
        padding: EdgeInsets.only(top: 20, bottom: 30),
        child: Text(widget.title,
            style: widget.titleStyle ?? TextStyle(fontSize: 22)));
  }

  ///
  /// 构建版本更新信息
  ///
  _buildAppInfo() {
    return Container(
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 30),
        height: 200,
        child: ListView(
          children: widget.contents.map((f) {
            return Text(
              f,
              style: widget.contentStyle ?? TextStyle(),
            );
          }).toList(),
        ));
  }

  ///
  /// 构建取消或者升级按钮
  ///
  _buildAction() {
    return Column(
      children: <Widget>[
        Divider(
          height: 1,
          color: Colors.grey,
        ),
        Row(
          children: <Widget>[
            widget.force
                ? Container()
                : Expanded(
                    child: _buildCancelActionButton(),
                  ),
            Expanded(
              child: _buildOkActionButton(),
            ),
          ],
        ),
      ],
    );
  }

  ///
  /// 取消按钮
  ///
  _buildCancelActionButton() {
    return Ink(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(widget.borderRadius))),
      child: InkWell(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(widget.borderRadius)),
          child: Container(
            height: 45,
            alignment: Alignment.center,
            child: Text(widget.cancelText ?? '以后再说',
                style: widget.cancelTextStyle ?? TextStyle()),
          ),
          onTap: () {
            widget.onCancel?.call();
            Navigator.of(context).pop();
          }),
    );
  }

  ///
  /// 确定按钮
  ///
  _buildOkActionButton() {
    var borderRadius =
        BorderRadius.only(bottomRight: Radius.circular(widget.borderRadius));
    if (widget.force) {
      borderRadius = BorderRadius.only(
          bottomRight: Radius.circular(widget.borderRadius),
          bottomLeft: Radius.circular(widget.borderRadius));
    }
    var _okBackgroundColors = widget.okBackgroundColors;
    if (widget.okBackgroundColors == null ||
        widget.okBackgroundColors!.length != 2) {
      _okBackgroundColors = [
        Theme.of(context).primaryColor,
        Theme.of(context).primaryColor
      ];
    }
    return Ink(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [_okBackgroundColors![0], _okBackgroundColors[1]]),
          borderRadius: borderRadius),
      child: InkWell(
        borderRadius: borderRadius,
        child: Container(
          height: 45,
          alignment: Alignment.center,
          child: Text(widget.okText ?? '立即体验',
              style: widget.okTextStyle ?? TextStyle(color: Colors.white)),
        ),
        onTap: () {
          widget.onOk?.call();
        },
      ),
    );
  }
}