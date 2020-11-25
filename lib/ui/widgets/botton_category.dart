import 'package:flutter/material.dart';
import 'package:safe_place_app/ui/ui_constants.dart';

class BottonCategory extends StatelessWidget {
  final String label;
  final Function onTap;
  final IconData icon;

  const BottonCategory({Key key, this.label, this.onTap, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width * 0.41,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: fontSecundaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              right: 5,
              top: 10,
              child: Icon(
                icon,
                color: Colors.grey.withOpacity(0.5),
                size: 80,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
