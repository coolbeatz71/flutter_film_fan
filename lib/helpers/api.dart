import 'package:flutter/foundation.dart';
import 'package:flutter_film_fan/constants/index.dart';

class ApiManager {
  String url;
  String sessionId;

  ApiManager({@required this.url, this.sessionId});

  String getUrl() {
    return "$BASE_URL${this.url}?api_key=$API_KEY${this.sessionId != null ? '&guest_session_id=this.sessionId' : ''}";
  }
}
