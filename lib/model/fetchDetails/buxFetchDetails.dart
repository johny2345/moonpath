import 'dart:convert';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:json_annotation/json_annotation.dart';
import 'package:logger/logger.dart';

part 'buxFetchDetails.g.dart';

@RestApi(baseUrl: "https://api.bux.ph/v1/api/sandbox")
final logger = Logger();

abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/check_code?req_id=TEST1234&client_id=0000018c46&mode=API")
  @Headers(<String, dynamic>{"x-api-key": "04e2f5c9afdf4df8a6b119f1b3267b8e"})
  Future<List<FetchTransactionDetails>> getDetails();
}

@JsonSerializable()
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
}
