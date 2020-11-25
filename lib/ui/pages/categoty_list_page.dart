import 'package:flutter/material.dart';
import 'package:safe_place_app/core/models/place.dart';
import 'package:safe_place_app/core/services/api.dart';
import 'package:safe_place_app/ui/pages/place_details.dart';
import 'package:safe_place_app/ui/ui_constants.dart';
import 'package:safe_place_app/ui/widgets/primary_card.dart';
import 'package:safe_place_app/ui/widgets/secundary_card.dart';

class CategoryListPage extends StatefulWidget {
  final int category;

  const CategoryListPage({Key key, this.category}) : super(key: key);
  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  List<Place> _recentPlacesList = List<Place>();
  Api _api = new Api();
  bool _ocupado = false;

  Future _getCategotyPlaces() async {
    this._ocupado = true;
    _recentPlacesList = await _api.getPlacesCategoty(this.widget.category);
    setState(() {
      this._ocupado = false;
    });
  }

  @override
  void initState() {
    _getCategotyPlaces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text(
          'Resultado',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
      ),
      body: Visibility(
        visible: !_ocupado,
        replacement: Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.builder(
          itemCount: _recentPlacesList.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            Place _place = _recentPlacesList.elementAt(index);
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlaceDetails(placeId: _place.id),
                  ),
                );
              },
              child: SecundaryCard(place: _place),
            );
          },
        ),
      ),
    );
  }
}
