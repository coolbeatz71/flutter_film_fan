import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_film_fan/constants/index.dart';
import 'package:flutter_film_fan/helpers/colors.dart';
import 'package:flutter_film_fan/helpers/nameInitials.dart';
import 'package:flutter_film_fan/models/actors.dart';

class ActorsAvatar extends StatelessWidget {
  final Cast cast;
  const ActorsAvatar({
    Key key,
    this.cast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CachedNetworkImage(
          imageUrl: "$POSTER_URL${cast.profilePath}",
          imageBuilder: (context, imageProvider) => new CircleAvatar(
            radius: 28,
            backgroundImage: imageProvider,
            backgroundColor: AppColors.darkGrey,
          ),
          errorWidget: (context, url, error) => CircleAvatar(
            backgroundColor: AppColors.darkGrey,
            radius: 28,
            child: new Text(
              getInitials(cast.name),
            ),
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          cast.name,
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Quicksand",
            fontSize: 13,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          cast.character,
          style: TextStyle(
            color: Colors.white54,
            fontFamily: "Quicksand",
            fontSize: 12,
          ),
        )
      ],
    );
  }
}
