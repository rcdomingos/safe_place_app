import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget {
  final String title;

  const DefaultAppBar({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double _paddingTop = MediaQuery.of(context).padding.top;

    return PreferredSize(
      preferredSize: Size.fromHeight(80.0),
      child: Container(
        height: 60,
        padding: EdgeInsets.only(top: _paddingTop),
        margin: EdgeInsets.only(top: 10),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
