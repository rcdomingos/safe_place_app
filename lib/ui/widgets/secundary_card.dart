import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:safe_place_app/core/models/place.dart';

import '../ui_constants.dart';

class SecundaryCard extends StatelessWidget {
  final Place place;

  const SecundaryCard({Key key, this.place}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        child: Container(
          color: Colors.white,
          width: 300,
          height: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                child: (FadeInImage.assetNetwork(
                    height: double.infinity,
                    placeholder: 'assets/loading.gif',
                    image: place.image,
                    fit: BoxFit.cover)),
              ),
              Container(
                width: 220,
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.name,
                      style: titleStyle.copyWith(fontSize: 18),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text(
                      place.category,
                      style: subtitleStyle.copyWith(fontSize: 14),
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
