
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


void hideLoadingDialog(BuildContext context){
  Navigator.of(context).pop();
}

//在initState方法中调用这个方法 吊起loading  帧绘制完成回调通知
 void showInitStateLoading(BuildContext context){
   WidgetsBinding.instance.addPostFrameCallback((_){
      showMyCustomLoadingDialog(context);
    });
 }

//点击方法等 调用这个方法
 void showMyCustomLoadingDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return  MyCustomLoadingDialog();
        });
  }

class MyCustomLoadingDialog extends StatelessWidget {
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
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: new Text("加载中"),
                  ),
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