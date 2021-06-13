import 'package:flutter/foundation.dart';
import 'package:flutter_film_fan/constants/index.dart';

class ApiManager {
  String url;

  ApiManager({@required this.url});

  String getUrl() => "$BASE_URL${this.url}?api_key=$API_KEY";
}
