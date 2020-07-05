import 'package:flutter/material.dart';
import '../pages/detail/detail.dart';

Map<String, WidgetBuilder> detail={
 '/detail':(context, {arguments}) => DetailPage(arguments: arguments)
};
