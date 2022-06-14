/*
 * @Author: 宋佳 
 * @Date: 2022-06-13 09:37:33 
 * @Last Modified by: relax
 * @Last Modified time: 2022-06-13 09:45:36
 */

import 'package:flutter/material.dart';
class TabbatItem extends BottomNavigationBarItem {
  late String defaultImageName;
  late String itemName;
  late String selectedImageName;
  late double iconWidth;
  TabbatItem(this.defaultImageName, this.itemName, this.iconWidth)
      : super(
          icon: Image.asset(
              "images/tabbar_icon_${defaultImageName}_default.png",
              width: iconWidth,
              alignment: Alignment.topCenter),
          activeIcon: Image.asset(
              "images/tabbar_icon_${defaultImageName}_selected.png",
              width: iconWidth,
              alignment: Alignment.topCenter),
          label: itemName
        );
}
