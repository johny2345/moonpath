import 'dart:convert';

class FetchTransactionDetails {
  FetchTransactionDetails({
    this.status,
    this.id,
    this.amount,
    this.refCode,
    this.channel,
    this.imageUrl,
    this.sellerName,
    this.expiry,
    this.created,
    this.param1,
    this.param2,
    this.fee,
    this.instructions,
    this.terms,
    this.link,
    this.paymentUrl,
  });

  String? status;
  int? id;
  String? amount;
  String? refCode;
  String? channel;
  String? imageUrl;
  String? sellerName;
  String? expiry;
  String? created;
  String? param1;
  String? param2;
  int? fee;
  dynamic instructions;
  dynamic terms;
  String? link;
  String? paymentUrl;

  factory FetchTransactionDetails.fromJson(Map<String, dynamic> json) =>
      FetchTransactionDetails(
        status: json["status"],
        id: json["id"],
        amount: json["amount"],
        refCode: json["ref_code"],
        channel: json["channel"],
        imageUrl: json["image_url"],
        sellerName: json["seller_name"],
        expiry: json["expiry"],
        created: json["created"],
        param1: json["param1"],
        param2: json["param2"],
        fee: json["fee"],
        instructions: json["instructions"],
        terms: json["terms"],
        link: json["link"],
        paymentUrl: json["payment_url"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "id": id,
        "amount": amount,
        "ref_code": refCode,
        "channel": channel,
        "image_url": imageUrl,
        "seller_name": sellerName,
        "expiry": expiry,
        "created": created,
        "param1": param1,
        "param2": param2,
        "fee": fee,
        "instructions": instructions,
        "terms": terms,
        "link": link,
        "payment_url": paymentUrl,
      };
}
