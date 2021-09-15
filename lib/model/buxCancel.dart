import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.reqId,
    this.clientId,
    this.reason,
  });

  String? reqId;
  String? clientId;
  String? reason;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        reqId: json["req_id"],
        clientId: json["client_id"],
        reason: json["reason"],
      );

  Map<String, dynamic> toJson() => {
        "req_id": reqId,
        "client_id": clientId,
        "reason": reason,
      };
}
