import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:safe_place_app/core/models/place.dart';

import '../ui_constants.dart';

class PrimaryCard extends StatelessWidget {
  final Place place;

  const PrimaryCard({Key key, this.place}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        child: Container(
          color: Colors.white,
          width: 300,
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                child: (FadeInImage.assetNetwork(
                    width: double.infinity,
                    placeholder: 'assets/loading.gif',
                    image: place.image,
                    fit: BoxFit.cover)),
              ),
              Container(
                height: 100,
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.name,
                      style: titleStyle.copyWith(fontSize: 20),
                    ),
                    SizedBox(height: 5),
                    Text(
                      place.category,
                      style: subtitleStyle.copyWith(fontSize: 16),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: RatingBarIndicator(
                        rating: place.averageTotalScore,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 20.0,
                        direction: Axis.horizontal,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
