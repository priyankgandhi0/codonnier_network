import 'package:codonnier_network/utils/failure.dart';
import 'package:codonnier_network/utils/pretty_dio_logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api_type.dart';

class RestClient {
  static final RestClient _instance = RestClient._internal();

  late Dio _dio;
  late int connectionTO;
  late int receiveTO;
  late String baseUrl;
  late String token;

  RestClient._internal();

  factory RestClient({
    required String baseUrl,
    required String token,
    int connectionTO = 30000,
    int receiveTO = 30000,
  }) {
    _instance.baseUrl = baseUrl;
    _instance.token = token;
    _instance.connectionTO = connectionTO;
    _instance.receiveTO = receiveTO;

    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(milliseconds: connectionTO),
      receiveTimeout: Duration(milliseconds: receiveTO),
    );

    _instance._dio = Dio(options);

    return _instance;
  }

  Future<Response<dynamic>> get(
    APIType apiType,
    String path, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  }) async {
    _addDioInterceptorList();

    final standardOptions = await _getApiOptions(apiType);

    return _dio
        .get(
          path,
          queryParameters: query,
          options: standardOptions,
        )
        .then((value) => value)
        .catchError(_handleException);
  }

  Future<Response<dynamic>> post(
    APIType apiType,
    String path,
    Map<String, dynamic> data, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  }) async {
    _addDioInterceptorList();

    final standardOptions = await _getApiOptions(apiType);

    if (headers != null) {
      standardOptions.headers?.addAll(headers);
    }

    return _dio
        .post(path, queryParameters: query, options: standardOptions)
        .then((value) => value)
        .catchError(_handleException);
  }

  void _addDioInterceptorList() {
    List<Interceptor> interceptorList = [];
    _dio.interceptors.clear();

    if (kDebugMode) {
      interceptorList.add(PrettyDioLogger());
    }
    _dio.interceptors.addAll(interceptorList);
  }

  Future<Options> _getApiOptions(APIType apiType) async {
    switch (apiType) {
      case APIType.public:
        return PublicApiOptions().options;
      case APIType.protected:
        return ProtectedApiOptions(token).options;
      default:
        return PublicApiOptions().options;
    }
  }

  dynamic _handleException(error) {
    dynamic errorData = error.response!.data;

    switch (error.response?.statusCode) {
      case 400:
        throw BadRequest(errorData);
      case 401:
        throw Unauthorised(errorData);
      case 403:
        throw Forbidden(errorData);
      case 404:
        throw NotFound(errorData);
      case 405:
        throw MethodNotAllowed(errorData);
      case 406:
        throw NotAcceptable(errorData);
      case 408:
        throw RequestTimeout(errorData);
      case 409:
        throw Conflict(errorData);
      case 410:
        throw Gone(errorData);
      case 411:
        throw LengthRequired(errorData);
      case 412:
        throw PreconditionFailed(errorData);
      case 413:
        throw PayloadTooLarge(errorData);
      case 414:
        throw URITooLong(errorData);
      case 415:
        throw UnsupportedMediaType(errorData);
      case 416:
        throw RangeNotSatisfiable(errorData);
      case 417:
        throw ExpectationFailed(errorData);
      case 422:
        throw UnprocessableEntity(errorData);
      case 429:
        throw TooManyRequests(errorData);
      case 500:
        throw InternalServerError(errorData);
      case 501:
        throw NotImplemented(errorData);
      case 502:
        throw BadGateway(errorData);
      case 503:
        throw ServiceUnavailable(errorData);
      case 504:
        throw GatewayTimeout(errorData);
      default:
        throw Unexpected(errorData);
    }
  }
}
