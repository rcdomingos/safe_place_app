import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String type;
  final String label;
  final Function onPressed;

  const DefaultButton({Key key, this.type, this.label, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color _btnColor;
    Color _labeColor;
    switch (type) {
      case "primary":
        _btnColor = Color(0XFFffce07);
        _labeColor = Colors.black;

        break;
      case "secundary":
        _btnColor = Colors.transparent;
        _labeColor = Colors.black;

        break;
      default:
        _btnColor = Colors.grey;
        _labeColor = Colors.black;
    }

    return SizedBox(
      height: 55.0,
      width: double.infinity,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey[300]),
        ),
        color: _btnColor,
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(color: _labeColor),
        ),
      ),
    );
  }
}
