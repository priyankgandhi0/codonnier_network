import 'dart:convert';

import 'package:codonnier_network/network.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api_type.dart';

class RestClient {
  static final RestClient instance = RestClient._internal();

  late Dio _dio;
  late int connectionTO;
  late int receiveTO;
  late String baseUrl;
  late String token;
  late CancelToken cancelToken;
  late VoidCallback? onSessionExpired;

  RestClient._internal();

  factory RestClient({
    required String baseUrl,
    required String token,
    VoidCallback? onSessionExpired,
    required int connectionTO,
    required int receiveTO,
  }) {
    instance.baseUrl = baseUrl;
    instance.token = token;
    instance.connectionTO = connectionTO;
    instance.connectionTO = receiveTO;
    instance.cancelToken = CancelToken();
    instance.onSessionExpired = onSessionExpired;

    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(milliseconds: connectionTO),
      receiveTimeout: Duration(milliseconds: receiveTO),
    );

    instance._dio = Dio(options);

    return instance;
  }

  Future<Response<dynamic>> get(
    APIType apiType, {
    String? path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    bool printDioLogger = true,
  }) async {
    _addDioInterceptorList(printDioLogger);

    final standardOptions = await _getApiOptions(apiType);

    if (headers != null) {
      standardOptions.headers?.addAll(headers);
    }

    return _dio
        .get(
      path ?? instance.baseUrl,
      queryParameters: query,
      options: standardOptions,
      cancelToken: cancelToken,
    )
        .then((response) {
      Map<String, dynamic> map =
          (response.data is String) ? jsonDecode(response.data) : response.data;
      if (map['force_logout'] != null && map['force_logout'] == 1) {
        response.requestOptions.cancelToken!.cancel();
        if (onSessionExpired != null) {
          onSessionExpired!();
        }
        throw DioException(
            requestOptions: response.requestOptions,
            type: DioExceptionType.cancel,
            message:
                'The request was manually cancelled because Auth Token is expired.');
      }
      return response;
    }).catchError(_handleException);
  }

  Future<Response<dynamic>> post(
    APIType apiType,
    Map<String, dynamic> data, {
    String? path,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
    bool printDioLogger = true,
  }) async {
    _addDioInterceptorList(printDioLogger);

    final standardOptions = await _getApiOptions(apiType);

    if (headers != null) {
      standardOptions.headers?.addAll(headers);
    }

    return _dio
        .post(
      path ?? instance.baseUrl,
      data: data,
      queryParameters: query,
      options: standardOptions,
      cancelToken: cancelToken,
    )
        .then((response) {
      Map<String, dynamic> map =
          (response.data is String) ? jsonDecode(response.data) : response.data;
      if (map['force_logout'] != null && map['force_logout'] == 1) {
        response.requestOptions.cancelToken!.cancel();
        if (onSessionExpired != null) {
          onSessionExpired!();
        }
        throw DioException(
            requestOptions: response.requestOptions,
            type: DioExceptionType.cancel,
            message:
                'The request was manually cancelled because Auth Token is expired.');
      }
      return response;
    }).catchError(_handleException);
  }

  Future<Response<dynamic>> put(
    APIType apiType,
    Map<String, dynamic> data, {
    String? path,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
    bool printDioLogger = true,
  }) async {
    _addDioInterceptorList(printDioLogger);

    final standardHeaders = await _getApiOptions(apiType);
    if (headers != null) {
      standardHeaders.headers?.addAll(headers);
    }

    return _dio
        .put(
      path ?? instance.baseUrl,
      data: data,
      options: standardHeaders,
      cancelToken: cancelToken,
    )
        .then((response) {
      Map<String, dynamic> map =
          (response.data is String) ? jsonDecode(response.data) : response.data;
      if (map['force_logout'] != null && map['force_logout'] == 1) {
        response.requestOptions.cancelToken!.cancel();
        if (onSessionExpired != null) {
          onSessionExpired!();
        }
        throw DioException(
            requestOptions: response.requestOptions,
            type: DioExceptionType.cancel,
            message:
                'The request was manually cancelled because Auth Token is expired.');
      }
      return response;
    }).catchError(_handleException);
  }

  Future<Response<dynamic>> delete(
    APIType apiType, {
    String? path,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
    bool printDioLogger = true,
  }) async {
    _addDioInterceptorList(printDioLogger);

    final standardHeaders = await _getApiOptions(apiType);
    if (headers != null) {
      standardHeaders.headers?.addAll(headers);
    }

    return _dio
        .delete(
      path ?? instance.baseUrl,
      data: data,
      queryParameters: query,
      options: standardHeaders,
      cancelToken: cancelToken,
    )
        .then((response) {
      Map<String, dynamic> map =
          (response.data is String) ? jsonDecode(response.data) : response.data;
      if (map['force_logout'] != null && map['force_logout'] == 1) {
        response.requestOptions.cancelToken!.cancel();
        if (onSessionExpired != null) {
          onSessionExpired!();
        }
        throw DioException(
            requestOptions: response.requestOptions,
            type: DioExceptionType.cancel,
            message:
                'The request was manually cancelled because Auth Token is expired.');
      }
      return response;
    }).catchError(_handleException);
  }

  Future<Response<dynamic>> patch(
    APIType apiType,
    Map<String, dynamic> data, {
    String? path,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
    bool printDioLogger = true,
  }) async {
    _addDioInterceptorList(printDioLogger);

    final standardHeaders = await _getApiOptions(apiType);
    if (headers != null) {
      standardHeaders.headers?.addAll(headers);
    }

    return _dio
        .patch(
      path ?? instance.baseUrl,
      data: data,
      options: standardHeaders,
      cancelToken: cancelToken,
    )
        .then((response) {
      Map<String, dynamic> map =
          (response.data is String) ? jsonDecode(response.data) : response.data;
      if (map['force_logout'] != null && map['force_logout'] == 1) {
        response.requestOptions.cancelToken!.cancel();
        if (onSessionExpired != null) {
          onSessionExpired!();
        }
        throw DioException(
            requestOptions: response.requestOptions,
            type: DioExceptionType.cancel,
            message:
                'The request was manually cancelled because Auth Token is expired.');
      }
      return response;
    }).catchError(_handleException);
  }

  /// Supports media upload
  Future<Response<dynamic>> postFormData(
    APIType apiType,
    Map<String, dynamic> data, {
    String? path,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
    bool printDioLogger = true,
  }) async {
    _addDioInterceptorList(printDioLogger);

    final standardHeaders = await _getApiOptions(apiType);
    if (headers != null) {
      standardHeaders.headers?.addAll(headers);
    }
    standardHeaders.headers?.addAll({
      'Content-Type': 'multipart/form-data',
    });

    return _dio
        .post(
      path ?? instance.baseUrl,
      data: FormData.fromMap(data),
      options: standardHeaders,
      queryParameters: query,
      cancelToken: cancelToken,
    )
        .then((response) {
      Map<String, dynamic> map =
          (response.data is String) ? jsonDecode(response.data) : response.data;
      if (map['force_logout'] != null && map['force_logout'] == 1) {
        response.requestOptions.cancelToken!.cancel();
        if (onSessionExpired != null) {
          onSessionExpired!();
        }
        throw DioException(
            requestOptions: response.requestOptions,
            type: DioExceptionType.cancel,
            message:
                'The request was manually cancelled because Auth Token is expired.');
      }
      return response;
    }).catchError(_handleException);
  }

  void _addDioInterceptorList(bool printDioLogger) {
    List<Interceptor> interceptorList = [];
    _dio.interceptors.clear();

    if (kDebugMode && printDioLogger) {
      interceptorList.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
      ));
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
    if ((error as DioException).type == DioExceptionType.connectionError) {
      throw InternetNotAvailable(error);
    }
    if (error.type == DioExceptionType.cancel) {
      throw SessionExpired(error);
    }
    dynamic errorData = error.response?.data;

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
