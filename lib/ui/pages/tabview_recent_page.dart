import 'package:flutter/material.dart';
import 'package:safe_place_app/core/models/place.dart';
import 'package:safe_place_app/core/services/api.dart';
import 'package:safe_place_app/ui/pages/place_details.dart';
import 'package:safe_place_app/ui/widgets/primary_card.dart';

class RecentTabView extends StatefulWidget {
  @override
  _RecentTabViewState createState() => _RecentTabViewState();
}

class _RecentTabViewState extends State<RecentTabView> {
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
      replacement: Center(child: CircularProgressIndicator()),
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
              ).then(
                (_) => _getRecentPlaces(),
              ),
              child: PrimaryCard(place: _place),
            );
          },
        ),
      ),
    );
  }
}
