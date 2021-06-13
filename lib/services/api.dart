import 'dart:convert';

import 'package:http/http.dart';

import 'package:flutter_film_fan/helpers/api.dart';
import 'package:flutter_film_fan/models/details.dart';
import 'package:flutter_film_fan/models/now_playing.dart';
import 'package:flutter_film_fan/models/similar.dart';
import 'package:flutter_film_fan/models/recommended.dart';

Client client = Client();

class ApiService {
  Future<NowPlaying> getNowPlaying(String url) async {
    NowPlaying nowPlaying;
    ApiManager api = new ApiManager(url: url);

    try {
      dynamic response = await client.get(api.getUrl());

      if (response.statusCode == 200) {
        dynamic body = response.body;
        dynamic jsonMap = json.decode(body);

        nowPlaying = NowPlaying.fromJson(jsonMap);
      }
    } catch (Exception) {
      return nowPlaying;
    }

    return nowPlaying;
  }

  Future<Details> getDetails(String url) async {
    Details details;
    ApiManager api = new ApiManager(url: url);

    try {
      dynamic response = await client.get(api.getUrl());

      if (response.statusCode == 200) {
        dynamic body = response.body;
        dynamic jsonMap = json.decode(body);

        details = Details.fromJson(jsonMap);
      }
    } catch (Exception) {
      return details;
    }

    return details;
  }

  Future<Similar> getSimilar(String url) async {
    Similar similar;
    ApiManager api = new ApiManager(url: url);

    try {
      dynamic response = await client.get(api.getUrl());

      if (response.statusCode == 200) {
        dynamic body = response.body;
        dynamic jsonMap = json.decode(body);

        similar = Similar.fromJson(jsonMap);
      }
    } catch (Exception) {
      return similar;
    }

    return similar;
  }

  Future<Recommended> getRecommended(String url) async {
    Recommended recommended;
    ApiManager api = new ApiManager(url: url);

    try {
      dynamic response = await client.get(api.getUrl());

      if (response.statusCode == 200) {
        dynamic body = response.body;
        dynamic jsonMap = json.decode(body);

        recommended = Recommended.fromJson(jsonMap);
      }
    } catch (Exception) {
      return recommended;
    }

    return recommended;
  }
}
