/*
 * @Author: 宋佳 
 * @Date: 2022-06-13 09:25:17 
 * @Last Modified by:   relax 
 * @Last Modified time: 2022-06-13 09:25:17 
 */
import 'package:flutter/material.dart';
import 'package:hftech_flutter/config/config.dart';

class AlertCustomerDialog extends Dialog {
  final String? alertTitle;
  final String? alertContent;
  final void Function()? onClickSure;
  final void Function()? onClickCancel;

  AlertCustomerDialog(
      {this.alertTitle,
      this.alertContent,
      this.onClickSure,
      this.onClickCancel});

  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 100,
            //height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 25,
                ),
                Text(
                  alertTitle ?? "",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20,0,20,0),
                  child: Text(
                    this.alertContent ?? "",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Divider(
                  height: 1,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: FlatButton(
                            onPressed: onClickCancel,
                            child: Text(
                              "取消",
                              style: TextStyle(fontSize: 20),
                            ))),
                    Container(
                      width: 1,
                      height: 30,
                      color: Color.fromARGB(1, 248, 248, 248),
                    ),
                    Expanded(
                        child: FlatButton(
                            onPressed: onClickSure,
                            child: Text(
                              "确定",
                              style: TextStyle(
                                  fontSize: 20, color: Config.primaryColor),
                            ))),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
