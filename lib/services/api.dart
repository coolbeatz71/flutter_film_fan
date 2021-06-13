import 'dart:convert';

import 'package:flutter_film_fan/constants/index.dart';
import 'package:http/http.dart';

import 'package:flutter_film_fan/helpers/api.dart';
import 'package:flutter_film_fan/models/details.dart';
import 'package:flutter_film_fan/models/now_playing.dart';
import 'package:flutter_film_fan/models/similar.dart';
import 'package:flutter_film_fan/models/recommended.dart';
import 'package:flutter_film_fan/models/actors.dart';

class ApiService {
  Client client = Client();

  Future<NowPlaying> getNowPlaying() async {
    NowPlaying nowPlaying;
    ApiManager api = new ApiManager(url: NOW_PLAYING_URL);

    dynamic response = await client.get(api.getUrl());

    if (response.statusCode == 200) {
      dynamic body = response.body;
      dynamic jsonMap = json.decode(body);

      nowPlaying = NowPlaying.fromJson(jsonMap);
      return nowPlaying;
    } else {
      throw Exception();
    }
  }

  Future<Details> getDetails(String movieId) async {
    Details details;
    ApiManager api = new ApiManager(
      url: "$MOVIE_BASE_URL/$movieId",
    );

    dynamic response = await client.get(api.getUrl());

    if (response.statusCode == 200) {
      dynamic body = response.body;
      dynamic jsonMap = json.decode(body);

      details = Details.fromJson(jsonMap);
      return details;
    } else {
      throw Exception();
    }
  }

  Future<Similar> getSimilar(String movieId) async {
    Similar similar;
    ApiManager api = new ApiManager(
      url: "$MOVIE_BASE_URL/$movieId/similar",
    );

    dynamic response = await client.get(api.getUrl());

    if (response.statusCode == 200) {
      dynamic body = response.body;
      dynamic jsonMap = json.decode(body);

      similar = Similar.fromJson(jsonMap);
      return similar;
    } else {
      throw Exception();
    }
  }

  Future<Recommended> getRecommended(String movieId) async {
    Recommended recommended;
    ApiManager api = new ApiManager(
      url: "$MOVIE_BASE_URL/$movieId/recommendations",
    );

    dynamic response = await client.get(api.getUrl());

    if (response.statusCode == 200) {
      dynamic body = response.body;
      dynamic jsonMap = json.decode(body);

      recommended = Recommended.fromJson(jsonMap);
      return recommended;
    } else {
      throw Exception();
    }
  }

  Future<Actors> getActors(String movieId) async {
    Actors actors;
    ApiManager api = new ApiManager(url: "$MOVIE_BASE_URL/$movieId/credits");

    dynamic response = await client.get(api.getUrl());

    if (response.statusCode == 200) {
      dynamic body = response.body;
      dynamic jsonMap = json.decode(body);

      actors = Actors.fromJson(jsonMap);
      return actors;
    } else {
      throw Exception();
    }
  }
}
