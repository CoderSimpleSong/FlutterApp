/*
 * @Author: 宋佳 
 * @Date: 2022-06-13 09:26:18 
 * @Last Modified by: relax
 * @Last Modified time: 2022-06-13 13:47:36
 */

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


void hideLoadingDialog(BuildContext context){
  bool canPop = Navigator.canPop(context);
  if(canPop == true){
    Navigator.of(context).pop();
  }
}

//在initState方法中调用这个方法 吊起loading  帧绘制完成回调通知
 void showInitStateLoading(BuildContext context){
   WidgetsBinding.instance.addPostFrameCallback((_){
      showMyCustomLoadingDialog(context);
    });
 }

///点击方法等 调用这个方法
///@params remindText loading 提示文字（自定义）
 void showMyCustomLoadingDialog(BuildContext context,{bool? barrierDismissible, String? remindText}) {
    showDialog(
        context: context,
        barrierDismissible: barrierDismissible == null?false:barrierDismissible,
        builder: (context) {
          return  MyCustomLoadingDialog(remindText);
        });
  }
class MyCustomLoadingDialog extends StatelessWidget {

  String? remindText;
  MyCustomLoadingDialog(String? remindText) {
    this.remindText = remindText;
  }
  @override
  Widget build(BuildContext context) {
    Duration insetAnimationDuration = const Duration(milliseconds: 100);
    Curve insetAnimationCurve = Curves.decelerate;

    RoundedRectangleBorder _defaultDialogShape = RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)));

    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      duration: insetAnimationDuration,
      curve: insetAnimationCurve,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: SizedBox(
            width: 120,
            height: 120,
            child: Material(
              elevation: 24.0,
              color: Colors.white,
              type: MaterialType.card,
              //在这里修改成我们想要显示的widget就行了，外部的属性跟其他Dialog保持一致
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    SpinKitFadingCircle(
                      color: Colors.grey,
                      size: 45.0,
                  ),
                  (remindText != null)?Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: new Text(remindText!,textAlign: TextAlign.center),
                  ):Container(),
                ],
              ),
              shape: _defaultDialogShape,
            ),
          ),
        ),
      ),
    );
  }
}