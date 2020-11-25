import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:safe_place_app/ui/pages/splash_app_page.dart';
import 'package:safe_place_app/ui/pages/welcome_page.dart';
import 'package:safe_place_app/ui/widgets/bottom_navigator.dart';

import 'core/app_route.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SafePlace',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        accentColor: Colors.black,
        primaryColor: Color(0XFFffce07),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: AppRoute.SPLASH_PAGE,
      routes: {
        AppRoute.SPLASH_PAGE: (_) => SplashAppPage(),
        AppRoute.HOME_PAGE: (_) => BottomNavigator(),
        AppRoute.START_PAGE: (_) => WelcomePage(),
      },
    );
  }
}
