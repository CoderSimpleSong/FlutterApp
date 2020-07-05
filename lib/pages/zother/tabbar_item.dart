import 'package:flutter/material.dart';

class TabbatItem extends BottomNavigationBarItem {
  String defaultImageName;
  String itemName;
  String selectedImageName;
  double iconWidth;
  TabbatItem(this.defaultImageName,this.itemName,this.iconWidth):
      super(
        icon:Image.asset(
            "images/tabbar_icon_${defaultImageName}_default.png",
            width: iconWidth,
            alignment:Alignment.topCenter
        ),
        activeIcon:Image.asset(
            "images/tabbar_icon_${defaultImageName}_selected.png",
            width: iconWidth,
            alignment:Alignment.topCenter
        ),
        title:Text(itemName)
      );
}