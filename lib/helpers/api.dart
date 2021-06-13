import 'package:flutter/foundation.dart';

const API_KEY = "49293f4edb9812c1b86990775a8";
const BASE_URL = "https://api.themoviedb.org/3/";

class ApiManager {
  String url;

  ApiManager({@required this.url});

  String getUrl() => "$BASE_URL${this.url}?api_key=$API_KEY";
}
