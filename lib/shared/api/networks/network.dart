import 'dart:async';
import 'dart:convert';
import 'dart:developer';


import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:mechinetest/shared/consrants/base_url.dart';

class NetworkProvider {
  final Dio _dio;
  static final Map<String, Response> _cache = {};

  NetworkProvider()
      : _dio = Dio(BaseOptions(
            baseUrl: baseUrl, headers: {"Content-Type": "application/json"})) {
    _dio.interceptors.add(RetryInterceptor(
      dio: _dio,
      logPrint: print,
      retries: 3,
      retryEvaluator: (error, attempt) {
        if (error.response?.statusCode == 403 ||
            error.response?.statusCode == 401 ||
            (error.response?.statusCode == 400)) {
          return false; // Don't retry on unauthorized errors
        }
        return true; // Retry on other errors
      },
    ));
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        log('------------------------------------------------------------------------------------------------');
        String fullUrl = baseUrl + options.path;
        log('Full URL: $fullUrl');
        if (options.contentType == 'multipart/form-data') {
          log('Request = ${options.data}', name: options.path);
        } else {
          log('Request = ${jsonEncode(options.data)}', name: options.path);
        }
        log('------------------------------------------------------------------------------------------------');

        if (options.headers.containsKey('auth')) {
          options.headers.remove('auth');
        } else {

         

          // log("token $token");
        }

        return handler.next(options);
      },
      onResponse: (response, handler) {
        log('************************************************************************************************');
        log('Response = ${response.data.toString()}',
            name: response.requestOptions.path);
        log('************************************************************************************************');

        return handler.next(response);
      },
      onError: (error, handler) async {
        log('Error-Response [${error.response?.statusCode}] = ${error.response.toString()}',
            name: error.requestOptions.path);

        if (error.response?.statusCode == 403 &&
            !error.requestOptions.extra.containsKey('retry')) {
          try {
         
          } catch (refreshError) {
            return handler.reject(DioException(
              requestOptions: error.requestOptions,
              error: 'Failed to refresh token',
            ));
          }
        } else {
          return handler.next(DioException(
            requestOptions: error.requestOptions,
            response: error.response,
          ));
        }
      },
    ));
  }

  Future<Response<T>> _makeRequest<T>(
    String method,
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
    bool force = false,
  }) async {
    final cacheKey =
        _generateCacheKey(method, path, data ?? queryParameters ?? {});

    if (_cache.containsKey(cacheKey) && force && method == 'GET') {
      return _cache[cacheKey]! as Response<T>;
    }

    try {
      Response<T> response;
      switch (method) {
        case 'GET':
          response = await _dio.get<T>(
            path,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onReceiveProgress: onReceiveProgress,
          );
          break;
        case 'POST':
          response = await _dio.post<T>(
            path,
            data: removeNullValues(data ?? {}),
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
          );
          break;
        case 'PUT':
          response = await _dio.put<T>(
            path,
            data: data,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
          );
          break;
        case 'DELETE':
          response = await _dio.delete<T>(
            path,
            data: data,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
          );
          break;
        case 'PATCH':
          response = await _dio.patch<T>(
            path,
            data: removeNullValues(data ?? {}),
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
          );
          break;
        default:
          throw UnsupportedError('Unsupported HTTP method');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        _cache[cacheKey] = response;
      }

      return response;
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
    bool force = false,
  }) async {
    return _makeRequest<T>(
      'GET',
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      force: force,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    Map<String, dynamic>? data,
    FormData? formData,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
    bool force = false,
  }) async {
    return _makeRequest<T>(
      'POST',
      path,
      data: data ?? formData,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      force: force,
    );
  }

  Future<Response<T>> put<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
    bool force = false,
  }) async {
    return _makeRequest<T>(
      'PUT',
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      force: force,
    );
  }

  Future<Response<T>> delete<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    bool force = false,
  }) async {
    return _makeRequest<T>(
      'DELETE',
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      force: force,
    );
  }

  Future<Response<T>> patch<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    bool force = false,
  }) async {
    return _makeRequest<T>(
      'PATCH',
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      force: force,
    );
  }

  Future<Response<T>> formData<T>(
    String path, {
    FormData? formData,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
    bool force = false,
  }) async {
    return _dio.post<T>(
      path,
      data: formData,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response<T>> retryRequest<T>(RequestOptions requestOptions) async {
    final Completer<Response<T>> responseCompleter = Completer<Response<T>>();

    responseCompleter.complete(
      request<T>(
        requestOptions,
      ),
    );

    return responseCompleter.future;
  }

  Future<Response<T>> request<T>(RequestOptions requestOptions) async {
    return _dio.request<T>(
      requestOptions.path,
      cancelToken: requestOptions.cancelToken,
      data: requestOptions.data,
      onReceiveProgress: requestOptions.onReceiveProgress,
      onSendProgress: requestOptions.onSendProgress,
      queryParameters: requestOptions.queryParameters,
      options: Options(
        method: requestOptions.method,
        sendTimeout: requestOptions.sendTimeout,
        receiveTimeout: requestOptions.receiveTimeout,
        extra: requestOptions.extra,
        headers: requestOptions.headers,
        responseType: requestOptions.responseType,
        contentType: requestOptions.contentType,
        validateStatus: requestOptions.validateStatus,
        receiveDataWhenStatusError: requestOptions.receiveDataWhenStatusError,
        followRedirects: requestOptions.followRedirects,
        maxRedirects: requestOptions.maxRedirects,
        persistentConnection: requestOptions.persistentConnection,
        requestEncoder: requestOptions.requestEncoder,
        responseDecoder: requestOptions.responseDecoder,
        listFormat: requestOptions.listFormat,
      ),
    );
  }

  String _generateCacheKey(
      String method, String url, Map<String, dynamic> data) {
    final methodString = method.toString();
    final dataString = jsonEncode(data);
    return '$methodString|$url|$dataString';
  }


}
  Map<String, dynamic> removeNullValues(Map<String, dynamic> input) {
    return Map.fromEntries(input.entries.where((e) => e.value != null));
  }