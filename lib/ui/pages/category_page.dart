import 'package:flutter/material.dart';
import 'package:safe_place_app/ui/pages/categoty_list_page.dart';
import 'package:safe_place_app/ui/ui_constants.dart';
import 'package:safe_place_app/ui/widgets/botton_category.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _paddingTop = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Container(
          height: 60,
          padding: EdgeInsets.only(top: _paddingTop),
          margin: EdgeInsets.only(top: 10),
          child: Text(
            'Categorias',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Row(
              children: [
                BottonCategory(
                  label: 'Restaurante',
                  icon: Icons.restaurant,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryListPage(category: 2),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                BottonCategory(
                  label: 'Padaria',
                  icon: Icons.local_cafe,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryListPage(category: 3),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                BottonCategory(
                  label: 'Mercado',
                  icon: Icons.local_grocery_store,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryListPage(category: 1),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                BottonCategory(
                  label: 'Farmacia',
                  icon: Icons.local_pharmacy,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryListPage(category: 5),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                BottonCategory(
                  label: 'Loja de Roupas',
                  icon: Icons.local_mall,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryListPage(category: 4),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                BottonCategory(
                  label: 'Posto de Gasolina',
                  icon: Icons.local_gas_station,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryListPage(category: 6),
                    ),
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
