import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get_storage/get_storage.dart';
import 'package:safe_place_app/core/models/reviews_score.dart';
import 'package:safe_place_app/core/services/api.dart';
import 'package:safe_place_app/ui/widgets/Button.dart';
import 'package:safe_place_app/ui/widgets/loading.dart';

import '../ui_constants.dart';

class AddScorePage extends StatefulWidget {
  final int placeId;

  const AddScorePage({Key key, this.placeId}) : super(key: key);

  @override
  _AddScorePageState createState() => _AddScorePageState();
}

class _AddScorePageState extends State<AddScorePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  double _cleanScore = 3;
  double _distanceScore = 3;
  double _useMaskScore = 3;

  final box = GetStorage();
  Api _api = new Api();
  bool _isBusy = false;

  Future _saveScore() async {
    setBusy(true);

    ReviewsScore _newReviewScore = await _createReviewsScore();
    bool resultSendScore = await _api.addPlaceScore(
        placeId: widget.placeId, score: _newReviewScore);

    setBusy(false);
    return resultSendScore;
  }

  ReviewsScore _createReviewsScore() {
    var userId = box.read('id');
    ReviewsScore reviewsScore = new ReviewsScore(
      userId: userId,
      distanceScore: _distanceScore.toInt(),
      cleanScore: _cleanScore.toInt(),
      maskScore: _useMaskScore.toInt(),
    );
    return reviewsScore;
  }

  void setBusy(bool value) {
    setState(() {
      _isBusy = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Avalie o lugar',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
      ),
      body: Visibility(
        visible: !_isBusy,
        replacement: Loading(texto: 'Avaliando...'),
        child: Container(
          padding: EdgeInsets.fromLTRB(15, 20, 15, 30),
          height: double.infinity,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Ajude os outros usuários informando as suas notas para as medidas de segurança tomada pelo lugar',
                  style: TextStyle(color: fontPrimaryColor),
                ),
                Spacer(),
                Text(
                  'Limpeza e higienização',
                  style: TextStyle(color: fontPrimaryColor),
                ),
                RatingBar(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    _cleanScore = rating;
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Distanciamento Social',
                  style: TextStyle(color: fontPrimaryColor),
                ),
                RatingBar(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    _distanceScore = rating;
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Utilização de máscara',
                  style: TextStyle(color: fontPrimaryColor),
                ),
                RatingBar(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    _useMaskScore = rating;
                  },
                ),
                Spacer(),
                DefaultButton(
                  label: 'Enviar Avaliação',
                  type: 'primary',
                  onPressed: () {
                    _saveScore().then((result) {
                      if (result) {
                        Navigator.of(context).pop(true);
                      } else {
                        _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('Erro ao salvar a avaliação'),
                            action: SnackBarAction(
                              label: 'X',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          ),
                        );
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
