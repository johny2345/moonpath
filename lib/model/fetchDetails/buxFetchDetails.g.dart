// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buxFetchDetails.dart';

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
  Future<List<FetchTransactionDetails>> getTasks() async {
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
