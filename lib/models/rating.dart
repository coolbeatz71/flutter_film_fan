import 'dart:convert';

Rating ratingFromJson(String str) => Rating.fromJson(json.decode(str));

String ratingToJson(Rating data) => json.encode(data.toJson());

class Rating {
  Rating({
    this.success,
    this.statusCode,
    this.statusMessage,
  });

  bool success;
  int statusCode;
  String statusMessage;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        success: json["success"],
        statusCode: json["status_code"],
        statusMessage: json["status_message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status_code": statusCode,
        "status_message": statusMessage,
      };
}
