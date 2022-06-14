
import 'package:flutter/material.dart';

class DashedLine extends StatelessWidget {
  final Axis axis;
  final double dashedWidth;
  final double dashedHeight;
  final Color color;
  final int count;

  DashedLine({
    this.axis = Axis.horizontal,
    this.dashedHeight = 1,
    this.dashedWidth = 1,
    this.color = const Color(0xA5aaaaaa),
    this.count = 10
  });

/*
//获取父控件的大小
LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints){
        constraints.width
        return 
      }
    )
*/

  @override
  Widget build(BuildContext context) {
    return Flex(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      direction: this.axis,
      children:List.generate(this.count, (int index){
        return Container(
          width: this.dashedWidth,
          height: this.dashedHeight,
          color: this.color,
        );
      })
    );
  }
}