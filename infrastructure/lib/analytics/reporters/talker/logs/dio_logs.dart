// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'dart:convert';

import 'package:deps/packages/dio.dart';
import 'package:deps/packages/intl.dart';
import 'package:deps/packages/talker_dio_logger.dart';
import 'package:deps/packages/talker_flutter.dart';

/// Converts common HTTP status codes to a descriptive emoji string.
///
/// This helper function maps HTTP status codes to human-readable descriptions
/// to make logs more informative. If a status code isn't mapped, it returns the code itself.
String statusCodeToEmoji(int statusCode) {
  const Map<int, String> statusCodeEmojis = <int, String>{
    200: '(OK)',
    201: '(Created)',
    400: '(Bad Request)',
    401: '(Unauthorized)',
    403: '(Forbidden)',
    404: '(Not Found)',
    408: '(Timeout)',
    429: '(Too Many Requests)',
    500: '(Internal Server Error)',
    503: '(Service Unavailable)',
  };

  final String? emojiDescription = statusCodeEmojis[statusCode];
  if (emojiDescription != null) {
    return '$statusCode - $emojiDescription';
  } else {
    return '$statusCode';
  }
}

/// Custom log for logging `Dio` HTTP requests using Talker.
///
/// This class captures and formats the details of an HTTP request made via `Dio`.
/// It logs the request method, URL, headers, and body if available, making it easier
/// to track outgoing network requests.
class DioRequestLog extends TalkerLog {
  DioRequestLog(
    this.uri, {
    required this.requestOptions,
    required this.settings,
  }) : super('');

  final RequestOptions requestOptions;
  final TalkerDioLoggerSettings settings;
  final String uri;

  @override
  String generateTextMessage({TimeFormat? timeFormat}) {
    return _createMessage();
  }

  @override
  AnsiPen get pen => settings.requestPen ?? (AnsiPen()..xterm(219));

  /// Formats the current time as `HH:mm:ss.SSS` for log entry.
  String get _formatTime => DateFormat('HH:mm:ss.SSS').format(DateTime.now());

  /// Creates a formatted log message for the HTTP request, including method, URL, headers, and body data.
  String _createMessage() {
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final dynamic data = requestOptions.data;
    final Map<String, dynamic> headers = requestOptions.headers;

    final StringBuffer stringBuffer = StringBuffer()
      ..writeln('\n« DIO on $_formatTime »')
      ..writeln('• TYPE\t  ─►  ${requestOptions.method} Request')
      ..writeln('• URL\t   ─►  $uri');

    // Log request headers if enabled.
    if (settings.printRequestHeaders && headers.isNotEmpty) {
      final Map<String, String> stringHeaders = headers.map(
        (String key, dynamic value) =>
            MapEntry<String, String>(key, value.toString()),
      );

      final String prettyHeaders = encoder.convert(stringHeaders);
      final Map<String, dynamic> parsedJson = jsonDecode(prettyHeaders);
      final String formattedEntries = parsedJson.entries
          .map(
            (MapEntry<String, dynamic> entry) =>
                '"${entry.key}": "${entry.value}"',
          )
          .join(',\n');
      stringBuffer.writeln('• HEADERS   ─►  $formattedEntries');
    }

    // Log request data if enabled.
    if (settings.printRequestData && data != null) {
      final String prettyData = encoder.convert(data);
      final Map<String, dynamic> parsedJson = jsonDecode(prettyData);
      final String formattedEntries = parsedJson.entries
          .map(
            (MapEntry<String, dynamic> entry) =>
                '"${entry.key}": "${entry.value}"',
          )
          .join(',\n');
      stringBuffer.writeln('• DATA\t  ─►  $formattedEntries');
    }

    return stringBuffer.toString();
  }
}

/// Custom log for logging `Dio` HTTP responses using Talker.
///
/// This class captures and formats the details of an HTTP response received via `Dio`.
/// It logs the response status, headers, and body data, making it easier to track incoming network responses.
class DioResponseLog extends TalkerLog {
  DioResponseLog(this.uri, {required this.response, required this.settings})
      : super('');

  final Response<dynamic> response;
  final TalkerDioLoggerSettings settings;
  final String uri;

  @override
  String generateTextMessage({TimeFormat? timeFormat}) {
    return _createMessage();
  }

  @override
  AnsiPen get pen => settings.responsePen ?? (AnsiPen()..xterm(46));

  /// Formats the current time as `HH:mm:ss.SSS` for log entry.
  String get _formatTime => DateFormat('HH:mm:ss.SSS').format(DateTime.now());

  /// Creates a formatted log message for the HTTP response, including status, headers, and body data.
  String _createMessage() {
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final String? responseMessage = response.statusMessage;
    final dynamic data = response.data;
    final Map<String, List<String>> headers = response.headers.map;

    final StringBuffer stringBuffer = StringBuffer()
      ..writeln('\n« DIO on $_formatTime »')
      ..writeln('• TYPE\t  ─►  ${response.requestOptions.method} Response')
      ..writeln('• URL\t   ─►  $uri');

    // Log status code with description.
    if (response.statusCode != null) {
      final String statusWithEmoji = statusCodeToEmoji(response.statusCode!);
      stringBuffer.writeln('• STATUS\t─►  $statusWithEmoji');
    }

    // Log response message if available.
    if (settings.printResponseMessage && responseMessage != null) {
      stringBuffer.writeln('• MESSAGE   ─►  $responseMessage');
    }

    // Log response headers if enabled.
    if (settings.printRequestHeaders && headers.isNotEmpty) {
      final Map<String, String> stringHeaders = headers.map(
        (String key, dynamic value) =>
            MapEntry<String, String>(key, value.toString()),
      );

      final String prettyHeaders = encoder.convert(stringHeaders);
      final Map<String, dynamic> parsedJson = jsonDecode(prettyHeaders);
      final String formattedEntries = parsedJson.entries
          .map(
            (MapEntry<String, dynamic> entry) =>
                '"${entry.key}": "${entry.value}"',
          )
          .join(',\n');
      stringBuffer.writeln('• HEADERS   ─►  $formattedEntries');
    }

    // Log response data if enabled.
    if (settings.printResponseData && data != null) {
      final String prettyData = encoder.convert(data);
      if (data is Map) {
        final Map<String, dynamic> parsedJson = jsonDecode(prettyData);
        final String formattedEntries = parsedJson.entries
            .map(
              (MapEntry<String, dynamic> entry) =>
                  '"${entry.key}": "${entry.value}"',
            )
            .join(',\n');
        stringBuffer.writeln('• DATA\t  ─►  $formattedEntries');
      } else if (data is List) {
        final List<dynamic> parsedJson = jsonDecode(prettyData);
        final String formattedEntries =
            parsedJson.map((dynamic entry) => '- $entry').join('\n');
        stringBuffer.writeln('• DATA\t  ─►  $formattedEntries');
      }
    }

    return stringBuffer.toString();
  }
}

/// Custom log for logging `Dio` HTTP errors using Talker.
///
/// This class captures and formats the details of an HTTP error encountered via `Dio`.
/// It logs the error status, headers, and any data, making it easier to debug failed network requests.
class DioErrorLog extends TalkerLog {
  DioErrorLog(
    this.uri, {
    required this.dioException,
    required this.settings,
  }) : super('');

  final DioException dioException;
  final TalkerDioLoggerSettings settings;
  final String uri;

  @override
  String generateTextMessage({TimeFormat? timeFormat}) {
    return _createMessage();
  }

  @override
  AnsiPen get pen => settings.errorPen ?? (AnsiPen()..red());

  /// Formats the current time as `HH:mm:ss.SSS` for log entry.
  String get _formatTime => DateFormat('HH:mm:ss.SSS').format(DateTime.now());

  /// Creates a formatted log message for the HTTP error, including status, headers, and data.
  String _createMessage() {
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final String? responseMessage = dioException.message;
    final int? statusCode = dioException.response?.statusCode;
    final dynamic data = dioException.response?.data;
    final Map<String, dynamic> headers = dioException.requestOptions.headers;

    final StringBuffer stringBuffer = StringBuffer()
      ..writeln('\n« DIO on $_formatTime »')
      ..writeln('• TYPE\t  ─►  ${dioException.requestOptions.method} Error')
      ..writeln('• URL\t   ─►  $uri');

    // Log status code with description.
    if (statusCode != null) {
      final String statusWithEmoji = statusCodeToEmoji(statusCode);
      stringBuffer.writeln('• STATUS\t─►  $statusWithEmoji');
    }

    // Log response message if available.
    if (responseMessage != null) {
      stringBuffer.writeln('• MESSAGE   ─►  $responseMessage');
    }

    // Log request headers if enabled.
    if (settings.printRequestHeaders && headers.isNotEmpty) {
      final Map<String, String> stringHeaders = headers.map(
        (String key, dynamic value) =>
            MapEntry<String, String>(key, value.toString()),
      );

      final String prettyHeaders = encoder.convert(stringHeaders);
      final Map<String, dynamic> parsedJson = jsonDecode(prettyHeaders);
      final String formattedEntries = parsedJson.entries
          .map(
            (MapEntry<String, dynamic> entry) =>
                '"${entry.key}": "${entry.value}"',
          )
          .join(',\n');
      stringBuffer.writeln('• HEADERS   ─►  $formattedEntries');
    }

    // Log response data if available.
    if (data != null) {
      final String prettyData = encoder.convert(data);
      final Map<String, dynamic> parsedJson = jsonDecode(prettyData);
      final String formattedEntries = parsedJson.entries
          .map(
            (MapEntry<String, dynamic> entry) =>
                '"${entry.key}": "${entry.value}"',
          )
          .join(',\n');
      stringBuffer.writeln('• DATA\t  ─►  $formattedEntries');
    }

    return stringBuffer.toString();
  }
}
