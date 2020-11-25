import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:safe_place_app/core/models/place.dart';
import 'package:safe_place_app/core/services/api.dart';
import 'package:safe_place_app/ui/pages/add_score_page.dart';
import 'package:safe_place_app/ui/pages/comments_page.dart';
import 'package:safe_place_app/ui/widgets/loading.dart';

import '../ui_constants.dart';

class PlaceDetails extends StatefulWidget {
  final int placeId;
  const PlaceDetails({Key key, this.placeId}) : super(key: key);

  @override
  _PlaceDetailsState createState() => _PlaceDetailsState();
}

class _PlaceDetailsState extends State<PlaceDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Api _api = new Api();
  Future<Place> _place;

  Future<Place> getDataPlace() async {
    final Place placeResult = await _api.getPlaceById(widget.placeId);
    return placeResult;
  }

  final snackBarSucess = SnackBar(
    backgroundColor: Colors.green,
    content: Text('Avaliação salva com sucesso!'),
    action: SnackBarAction(
      label: 'X',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  @override
  void initState() {
    super.initState();
    _place = getDataPlace();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Informações do lugar',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddScorePage(placeId: widget.placeId),
          ),
        ).then((result) {
          if (result == true) {
            setState(() {
              _place = getDataPlace();
            });
            _scaffoldKey.currentState.showSnackBar(snackBarSucess);
          }
        }),
        child: Icon(Icons.trending_up, size: 30),
      ),
      body: FutureBuilder<Place>(
        future: _place,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Loading(texto: 'Carregando...'),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text("Erro ao carregar..."),
                );
              } else {
                Place place = snapshot.data;
                return Container(
                  child: ListView(
                    children: [
                      Container(
                        height: 220,
                        child: FadeInImage.assetNetwork(
                            width: double.infinity,
                            placeholder: 'assets/loading.gif',
                            image: place.image,
                            fit: BoxFit.cover),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              place.name,
                              style: titleStyle.copyWith(fontSize: 22),
                            ),
                            Text(
                              place.category,
                              style: subtitleStyle.copyWith(fontSize: 16),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                RatingBarIndicator(
                                  rating: place.averageTotalScore,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 30.0,
                                  direction: Axis.horizontal,
                                ),
                                Spacer(),
                                IconButton(
                                  tooltip: 'Comentarios',
                                  splashColor: primaryColor,
                                  icon: Icon(Icons.comment),
                                  onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CommentsPage(
                                        placeId: widget.placeId,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                IconButton(
                                    tooltip: 'Avaliações',
                                    splashColor: primaryColor,
                                    icon: Icon(Icons.trending_up),
                                    onPressed: () {}),
                              ],
                            ),
                            SizedBox(height: 5),
                            Text(place.description),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.black,
                        margin: EdgeInsets.all(10),
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'AVALIAÇÃO DE SEGURANÇA',
                              style: titleStyle.copyWith(
                                  fontSize: 16, color: Colors.white),
                            ),
                            Text(
                              'Nota dadas pelos visitantes sobre as medidas preventivas (COVID-19) praticadas pelo estabelecimento:',
                              style: subtitleStyle.copyWith(fontSize: 12),
                            ),
                            SizedBox(height: 15),
                            Text(
                              'Limpeza e higienização',
                              style: TextStyle(color: Colors.white),
                            ),
                            RatingBarIndicator(
                              rating: place.averageCleaningScore,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 30.0,
                              direction: Axis.horizontal,
                            ),
                            SizedBox(height: 15),
                            Text(
                              'Distanciamento Social',
                              style: TextStyle(color: Colors.white),
                            ),
                            RatingBarIndicator(
                              rating: place.averageDistanceScore,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 30.0,
                              direction: Axis.horizontal,
                            ),
                            SizedBox(height: 15),
                            Text(
                              'Utilização de máscara',
                              style: TextStyle(color: Colors.white),
                            ),
                            RatingBarIndicator(
                              rating: place.averageMaskUseScore,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 30.0,
                              direction: Axis.horizontal,
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
