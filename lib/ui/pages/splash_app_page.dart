import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:safe_place_app/ui/pages/welcome_page.dart';
import 'package:safe_place_app/ui/ui_constants.dart';
import 'package:safe_place_app/ui/widgets/bottom_navigator.dart';
import 'package:splashscreen/splashscreen.dart';

final box = GetStorage();

class SplashAppPage extends StatelessWidget {
  Future<Widget> loadFromFuture() async {
    if (box.read('id') != null) {
      await Future.delayed(Duration(seconds: 1));
      return Future.value(new BottomNavigator());
    } else {
      await Future.delayed(Duration(seconds: 2));
      return Future.value(new WelcomePage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 10,
      navigateAfterFuture: loadFromFuture(),
      title: new Text(
        'Bem Vindo ao SafePlace',
        style: new TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20.0, color: secundaryColor),
      ),
      image: Image.asset('assets/logoSafePlace_200.png'),
      backgroundColor: primaryColor,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 150.0,
      loaderColor: secundaryColor,
      loadingText: Text('carregando...'),
    );
  }
}
