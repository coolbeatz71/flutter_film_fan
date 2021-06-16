import 'dart:convert';

GuestSession guestSessionFromJson(String str) =>
    GuestSession.fromJson(json.decode(str));

String guestSessionToJson(GuestSession data) => json.encode(data.toJson());

class GuestSession {
  GuestSession({
    this.success,
    this.guestSessionId,
    this.expiresAt,
  });

  bool success;
  String guestSessionId;
  String expiresAt;

  factory GuestSession.fromJson(Map<String, dynamic> json) => GuestSession(
        success: json["success"],
        guestSessionId: json["guest_session_id"],
        expiresAt: json["expires_at"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "guest_session_id": guestSessionId,
        "expires_at": expiresAt,
      };
}
