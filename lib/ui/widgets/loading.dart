import 'package:flutter/material.dart';

import '../ui_constants.dart';

class Loading extends StatelessWidget {
  final String texto;
  Loading({this.texto});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            backgroundColor: primaryColor,
            strokeWidth: 5.0,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            this.texto,
            style: TextStyle(color: primaryColor),
          ),
        ],
      ),
    );
  }
}
