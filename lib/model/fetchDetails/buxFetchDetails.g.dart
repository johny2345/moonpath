// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buxFetchDetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FetchTransactionDetails _$FetchTransactionDetailsFromJson(
        Map<String, dynamic> json) =>
    FetchTransactionDetails(
      status: json['status'] as String?,
      id: json['id'] as int?,
      amount: json['amount'] as String?,
      refCode: json['refCode'] as String?,
      channel: json['channel'] as String?,
      imageUrl: json['imageUrl'] as String?,
      sellerName: json['sellerName'] as String?,
      expiry: json['expiry'] as String?,
      created: json['created'] as String?,
      param1: json['param1'] as String?,
      param2: json['param2'] as String?,
      fee: json['fee'] as int?,
      instructions: json['instructions'],
      terms: json['terms'],
      link: json['link'] as String?,
      paymentUrl: json['paymentUrl'] as String?,
    );

Map<String, dynamic> _$FetchTransactionDetailsToJson(
        FetchTransactionDetails instance) =>
    <String, dynamic>{
      'status': instance.status,
      'id': instance.id,
      'amount': instance.amount,
      'refCode': instance.refCode,
      'channel': instance.channel,
      'imageUrl': instance.imageUrl,
      'sellerName': instance.sellerName,
      'expiry': instance.expiry,
      'created': instance.created,
      'param1': instance.param1,
      'param2': instance.param2,
      'fee': instance.fee,
      'instructions': instance.instructions,
      'terms': instance.terms,
      'link': instance.link,
      'paymentUrl': instance.paymentUrl,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://api.bux.ph/v1/api/sandbox/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<FetchTransactionDetails>> getDetails() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<FetchTransactionDetails>>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'x-api-key': '04e2f5c9afdf4df8a6b119f1b3267b8e'
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, '/check_code',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) =>
            FetchTransactionDetails.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
