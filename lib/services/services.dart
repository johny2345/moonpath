import 'package:dio/dio.dart' hide Headers;
import 'package:logger/logger.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:moonpath/model/fetchDetails/buxFetchDetails.dart';

class Apis {
  String? baseUrl = 'https://api.bux.ph/v1/api/sandbox';
  String? apiKey = '04e2f5c9afdf4df8a6b119f1b3267b8e';

  Future<void> buxBookRequest() async {
    var formData = FormData.fromMap({
      'req_id': '',
      'client_id': '',
      'amount': '',
      'description': '',
      'notification_url': '',
      'channel': '',
      'expiry': '',
      'email': '',
      'contact': '',
      'name': '',
      'redirect_url': '',
      'param1': '',
      'param2': '',
    });
  }

  Future<dynamic> getDetails() async {
    String? req_id = 'TEST1234';
    String? client_id = '0000018c46';
    String? url =
        '$baseUrl/check_code?req_id=$req_id&client_id=$client_id&mode=API';
    try {
      Dio dio = Dio();
      print('-----------GET RESPONSE 2---------------');
      final response = await dio.get(url,
          options: Options(
              receiveTimeout: 3000,
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              },
              headers: {
                "Content-Type": "application/json",
                'x-api-key': apiKey
              }));
      print(response);
      print(response.data['status']);
      return response;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        print('timeout err');
        throw Exception('Connection timeout exception');
      }
      print('-----------------CATCHING ERROR--------------');
      print(e.response!.statusCode);
      print('the error: ' + e.response!.data['status']);
      print('-----------------CATCHING ERROR--------------');
    }
  }
}
