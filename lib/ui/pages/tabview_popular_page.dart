import 'package:flutter/material.dart';
import 'package:safe_place_app/core/models/place.dart';
import 'package:safe_place_app/core/services/api.dart';
import 'package:safe_place_app/ui/pages/place_details.dart';
import 'package:safe_place_app/ui/widgets/loading.dart';
import 'package:safe_place_app/ui/widgets/secundary_card.dart';

class PopularTabView extends StatefulWidget {
  @override
  _PopularTabViewState createState() => _PopularTabViewState();
}

class _PopularTabViewState extends State<PopularTabView> {
  Api _api = new Api();
  bool _isBusy = false;

  List<Place> listRecentPlaces = new List<Place>();

  Future _getRecentPlaces() async {
    setBusy(true);
    listRecentPlaces = await _api.getAllPlaces();
    setBusy(false);
  }

  void setBusy(bool value) {
    setState(() {
      _isBusy = value;
    });
  }

  @override
  void initState() {
    _getRecentPlaces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !_isBusy,
      replacement: Loading(texto: 'Carregando...'),
      child: Container(
        child: ListView.builder(
          itemCount: listRecentPlaces.length,
          itemBuilder: (context, index) {
            Place _place = listRecentPlaces.elementAt(index);
            return InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlaceDetails(placeId: _place.id),
                ),
              ).then((value) => _getRecentPlaces()),
              child: SecundaryCard(place: _place),
            );
          },
        ),
      ),
    );
  }
}
