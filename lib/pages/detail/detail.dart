import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final Map arguments;
  DetailPage({Key key, this.arguments}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    var id = widget.arguments['id'];
    return Scaffold(
      appBar: AppBar(title: Text('详情')),
      body: Container(
        child: Text('详情id:$id'),
      ),
    );
  }
}