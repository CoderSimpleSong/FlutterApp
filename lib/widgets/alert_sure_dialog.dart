/*
 * @Author: 宋佳 
 * @Date: 2022-06-13 09:26:03 
 * @Last Modified by:   relax 
 * @Last Modified time: 2022-06-13 09:26:03 
 */

import 'package:flutter/material.dart';
import 'package:hftech_flutter/config/config.dart';

class AlertSureDialog extends Dialog {
  final String? alertTitle;
  final String? alertContent;
  final void Function()? onClickSure;

  AlertSureDialog({
    this.alertTitle,
    this.alertContent,
    this.onClickSure,
  });

  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
            width: MediaQuery.of(context).size.width - 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                color: Colors.white),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
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
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  this.alertContent ?? "",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 1,
              ),
              FlatButton(
                  onPressed: onClickSure,
                  child: Text(
                    "确定",
                    style: TextStyle(fontSize: 20, color: Config.primaryColor),
                  )),
            ])),
      ),
    );
  }
}
