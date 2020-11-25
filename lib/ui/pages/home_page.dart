import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:safe_place_app/ui/pages/tabview_popular_page.dart';
import 'package:safe_place_app/ui/pages/tabview_recent_page.dart';
import 'package:safe_place_app/ui/ui_constants.dart';

final box = GetStorage();

class HomePage extends StatelessWidget {
  static List<Widget> _listTabBarPage = [
    Tab(text: 'Recentes'),
    Tab(text: 'Popular'),
  ];

  static List<Widget> _listTabBarPageView = [
    RecentTabView(),
    PopularTabView(),
  ];

  @override
  Widget build(BuildContext context) {
    var userFullName = box.read('name').split(" ");
    var _firtName = userFullName[0];
    double _paddingTop = MediaQuery.of(context).padding.top;

    return DefaultTabController(
      length: _listTabBarPage.length,
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(140.0),
          child: Container(
            padding: EdgeInsets.fromLTRB(15, _paddingTop, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Olá $_firtName,',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.exit_to_app, size: 38),
                      color: secundaryColor,
                      onPressed: () async {
                        await box.erase().then(
                              (value) => Navigator.popUntil(
                                  context, ModalRoute.withName('/')),
                            );
                      },
                    ),
                  ],
                ),
                Text(
                  'Aonde precisa ir hoje? \nNão esqueça de verificar se o lugar é seguro',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.topLeft,
                  child: TabBar(
                    labelColor: Colors.white,
                    unselectedLabelColor: fontSecundaryColor,
                    unselectedLabelStyle: TextStyle(fontSize: 15.0),
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.white,
                    labelStyle: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    isScrollable: true,
                    tabs: _listTabBarPage,
                  ),
                )
              ],
            ),
          ),
        ),
        body: TabBarView(children: _listTabBarPageView),
      ),
    );
  }
}
