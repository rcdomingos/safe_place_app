import 'package:flutter/material.dart';
import 'package:safe_place_app/ui/pages/category_page.dart';
import 'package:safe_place_app/ui/pages/home_page.dart';
import 'package:safe_place_app/ui/pages/information_page.dart';
import 'package:safe_place_app/ui/pages/profile_page.dart';
import 'package:safe_place_app/ui/ui_constants.dart';

class BottomNavigator extends StatefulWidget {
  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _currentIndex = 0;

  void _alterCurrentPage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  static List<Widget> listPagesView = [
    HomePage(),
    CategoryPage(),
    InformationPage(),
    // ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listPagesView.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: primaryColor,
        selectedItemColor: Colors.white,
        elevation: 0,
        onTap: _alterCurrentPage,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Categorias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Informações',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person),
          //   label: 'Perfil',
          //   backgroundColor: primaryColor,
          // )
        ],
      ),
    );
  }
}
