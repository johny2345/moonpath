import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
// import 'package:retrofit/http.dart';
import 'package:logger/logger.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:moonpath/model/buxFetchDetails.dart';

part 'services.g.dart';

@RestApi(baseUrl: "https://api.bux.ph/v1/api/sandbox/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/check_code")
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
    "Custom-Header": "04e2f5c9afdf4df8a6b119f1b3267b8e"
  })
  Future<List<FetchTransactionDetails>> getTasks();
}

class BuxApiServices {
  static String? _apiKey = '04e2f5c9afdf4df8a6b119f1b3267b8e';
  String? req_id = 'TEST1234';
  String? client_id = "0000018c46";
  String? notification_url = '';
  int? amount = 25000;
  String? channel = 'gcash';
  int? expiry = 2;
  String? redirect_url =
      'https://www.facebook.com/Moonpath-travel-and-tours-103570147872534';
  String? param1 = 'Request received';
  String? param2 = 'test param';
  String? baseUrl = 'https://api.bux.ph/v1/api/sandbox';

  Dio? _dio;

  BuxApiServices() {
    _dio = Dio();
  }

  Future fetchBuxDetails() async {
    try {
      Response response = await _dio!.get(baseUrl.toString());
      FetchTransactionDetails transactionResponse =
          FetchTransactionDetails.fromJson(response.data);
      print(transactionResponse);
      return transactionResponse;
    } on DioError catch (e) {
      print(e);
    }
  }
}
