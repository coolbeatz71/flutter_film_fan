import 'dart:convert';

import 'package:flutter_film_fan/constants/index.dart';
import 'package:flutter_film_fan/models/guest_session.dart';
import 'package:flutter_film_fan/models/rating.dart';
import 'package:http/http.dart';

import 'package:flutter_film_fan/helpers/api.dart';
import 'package:flutter_film_fan/models/details.dart';
import 'package:flutter_film_fan/models/now_playing.dart';
import 'package:flutter_film_fan/models/similar.dart';
import 'package:flutter_film_fan/models/recommended.dart';
import 'package:flutter_film_fan/models/actors.dart';
import 'package:localstorage/localstorage.dart';

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
      dynamic err = json.decode(response.body);
      String message = err["status_message"];

      throw Exception(message);
    }
  }

  Future<Details> getDetails(int movieId) async {
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

  Future<Similar> getSimilar(int movieId) async {
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

  Future<Recommended> getRecommended(int movieId) async {
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

  Future<Actors> getActors(int movieId) async {
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

  Future<GuestSession> generateGuestSession() async {
    GuestSession guest;
    ApiManager api = new ApiManager(url: "authentication/guest_session/new");

    dynamic response = await client.post(api.getUrl());

    if (response.statusCode == 200) {
      dynamic body = response.body;
      dynamic jsonMap = json.decode(body);

      guest = GuestSession.fromJson(jsonMap);
      LocalStorage("guest_session").setItem(
        "guest-session",
        guest.guestSessionId,
      );
      return guest;
    } else {
      throw Exception();
    }
  }

  Future<Rating> rateMovie(int movieId, double value) async {
    String sessionId =
        LocalStorage("guest_session").getItem("guest-session") ?? SESSION_ID;

    Rating rating;
    ApiManager api = new ApiManager(
      url: "$MOVIE_BASE_URL/$movieId/rating",
      sessionId: sessionId,
    );

    dynamic response = await client.post(
      api.getUrl(),
      body: {"value": value.toString()},
    );
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      dynamic body = response.body;
      dynamic jsonMap = json.decode(body);

      rating = Rating.fromJson(jsonMap);
      return rating;
    } else {
      throw Exception();
    }
  }
}
