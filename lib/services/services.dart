import 'package:dio/dio.dart' hide Headers;
import 'package:logger/logger.dart';
import 'package:moonpath/api/apiProvider.dart';

class Apis {
  String? baseUrl = 'https://api.bux.ph/v1/api/sandbox';
  String? apiKey = '73484cbfcd23c7bb6e308944b4dfdfc7';
  String? clientId = '0000019057';
  Dio dio = Dio();

  Future<dynamic> buxBookRequest(reqId, amount, selectedDate, description,
      channel, email, contact, name, instructions, paymentMethod) async {
    String? url = '$baseUrl/generate_code';
    print(url);

    var formData = FormData.fromMap({
      'req_id': reqId,
      'client_id': '0000019057',
      'amount': amount,
      'description': description,
      'notification_url': '',
      'channel': channel,
      'expiry': 2,
      'email': email,
      'contact': contact,
      'name': name,
      'redirect_url':
          'https://www.facebook.com/Moonpath-travel-and-tours-103570147872534',
      'param1': instructions,
      'param2': '',
    });

    try {
      Response response = await dio.post(
        url,
        options: Options(
            receiveTimeout: 3000,
            followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            },
            headers: {"Content-Type": "application/json", 'x-api-key': apiKey}),
        data: {
          'req_id': reqId,
          'client_id': '0000019057',
          'amount': amount,
          'description': description,
          'notification_url': '',
          'channel': channel,
          'expiry': 2,
          'email': email,
          'contact': contact,
          'name': name,
          'redirect_url':
              'https://www.facebook.com/Moonpath-travel-and-tours-103570147872534',
          'param1': instructions,
          'param2': '',
          "cust_shoulder": 0
        },
      );
      ApiProvider().addBookRequest(
          reqId,
          amount,
          description,
          channel,
          email,
          contact,
          name,
          selectedDate,
          response.data['ref_code'],
          response.data['image_url'],
          response.data['payment_url'],
          'Pending',
          paymentMethod);
      print('-----------------THIS IS THE RESPONSE GENERATED----------------');
      print(response);
      print('-----------------THIS IS THE RESPONSE GENERATED----------------');
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

  Future<dynamic> getDetails(reqId) async {
    print(
        'getDetails functions being called!----$reqId-------------------------');
    String? url =
        '$baseUrl/check_code?req_id=$reqId&client_id=$clientId&mode=API';
    try {
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
      if (response.data['status'].toString() == 'Paid') {
        print('is paid------------------------');
      }
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
