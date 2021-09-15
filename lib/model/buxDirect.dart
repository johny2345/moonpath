import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.reqId,
    this.clientId,
    this.amount,
    this.description,
    this.notificationUrl,
    this.channel,
    this.expiry,
    this.email,
    this.contact,
    this.name,
    this.redirectUrl,
    this.param1,
    this.param2,
    this.custShoulder,
  });

  String? reqId;
  String? clientId;
  String? amount;
  String? description;
  String? notificationUrl;
  String? channel;
  int? expiry;
  String? email;
  String? contact;
  String? name;
  String? redirectUrl;
  String? param1;
  String? param2;
  int? custShoulder;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        reqId: json["req_id"],
        clientId: json["client_id"],
        amount: json["amount"],
        description: json["description"],
        notificationUrl: json["notification_url"],
        channel: json["channel"],
        expiry: json["expiry"],
        email: json["email"],
        contact: json["contact"],
        name: json["name"],
        redirectUrl: json["redirect_url"],
        param1: json["param1"],
        param2: json["param2"],
        custShoulder: json["cust_shoulder"],
      );

  Map<String, dynamic> toJson() => {
        "req_id": reqId,
        "client_id": clientId,
        "amount": amount,
        "description": description,
        "notification_url": notificationUrl,
        "channel": channel,
        "expiry": expiry,
        "email": email,
        "contact": contact,
        "name": name,
        "redirect_url": redirectUrl,
        "param1": param1,
        "param2": param2,
        "cust_shoulder": custShoulder,
      };
}
