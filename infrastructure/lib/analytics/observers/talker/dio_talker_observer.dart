// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/dio.dart';
import 'package:deps/packages/talker_dio_logger.dart';
import 'package:deps/packages/talker_flutter.dart';
import 'package:infrastructure/analytics/reporters/talker/logs/dio_logs.dart';

/// Custom `Interceptor` for Dio to log HTTP requests, responses, and errors using Talker.
final class DioTalkerObserver extends Interceptor {
  DioTalkerObserver({required this.settings, required this.talker});

  /// Talker instance for logging.
  final Talker talker;

  /// Settings for customizing Talker Dio logging.
  TalkerDioLoggerSettings settings;

  /// Allows for the configuration of Dio logger settings.
  void configure({
    AnsiPen? errorPen,
    bool? printRequestData,
    bool? printRequestHeaders,
    bool? printResponseData,
    bool? printResponseHeaders,
    bool? printResponseMessage,
    AnsiPen? requestPen,
    AnsiPen? responsePen,
  }) {
    settings = settings.copyWith(
      printResponseData: printResponseData,
      printResponseHeaders: printResponseHeaders,
      printResponseMessage: printResponseMessage,
      printRequestData: printRequestData,
      printRequestHeaders: printRequestHeaders,
      requestPen: requestPen,
      responsePen: responsePen,
      errorPen: errorPen,
    );
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    final bool accepted = settings.requestFilter?.call(options) ?? true;
    if (!accepted) {
      return;
    }

    final String message = '${options.uri}';
    final DioRequestLog httpLog = DioRequestLog(
      message,
      requestOptions: options,
      settings: settings,
    );
    talker.logTyped(httpLog);
  }

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    final bool accepted = settings.responseFilter?.call(response) ?? true;
    if (!accepted) {
      return;
    }

    final String message = '${response.requestOptions.uri}';
    final DioResponseLog httpLog = DioResponseLog(
      message,
      response: response,
      settings: settings,
    );
    talker.logTyped(httpLog);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);

    final String message = '${err.requestOptions.uri}';
    final DioErrorLog httpErrorLog = DioErrorLog(
      message,
      dioException: err,
      settings: settings,
    );
    talker.logTyped(httpErrorLog);
  }
}
