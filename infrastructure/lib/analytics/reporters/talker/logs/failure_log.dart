// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/intl.dart';
import 'package:deps/packages/talker_flutter.dart';
import 'package:infrastructure/_core/commons/enums/failure_type.enum.dart';
import 'package:infrastructure/_core/commons/extensions/string.ext.dart';
import 'package:infrastructure/analytics/failure/failure.dart';

/// A custom log class for handling and logging system failures using Talker.
///
/// The `FailureLog` class formats and logs failure information, including the failure type,
/// code, message, and optionally an exception if one is provided. It distinguishes between
/// different levels of severity, setting the log level to either `warning` or `critical`
/// based on the type of failure.
class FailureLog extends TalkerLog {
  FailureLog(this.failure) : super('');

  /// The `Failure` instance that contains the details of the failure to be logged.
  final Failure failure;

  /// Generates a log message for the failure, including relevant details such as
  /// the failure code, message, tag, and exception if present.
  @override
  String generateTextMessage({TimeFormat? timeFormat}) {
    return _createMessage();
  }

  /// Determines the log level based on the failure type.
  ///
  /// If the failure is an exception, the log level is set to `warning`.
  /// For other types of failures, the log level is set to `critical`.
  @override
  LogLevel get logLevel => failure.type == FailureTypeEnum.exception
      ? LogLevel.warning
      : LogLevel.critical;

  /// Sets the color of the log output based on the failure type.
  ///
  /// Exceptions are displayed in an orange-like color (`xterm(208)`), while other failures
  /// are shown in red (`xterm(196)`).
  @override
  AnsiPen get pen =>
      AnsiPen()..xterm(failure.type == FailureTypeEnum.exception ? 208 : 196);

  /// Formats the current time as `HH:mm:ss.SSS` for inclusion in the log message.
  String get _formatTime => DateFormat('HH:mm:ss.SSS').format(DateTime.now());

  /// Creates the log message with failure details, including the type of failure,
  /// tag, code, message, and exception if available.
  String _createMessage() {
    final String type =
        failure.type == FailureTypeEnum.exception ? 'EXCEPTION' : 'FAILURE';
    final StringBuffer stringBuffer = StringBuffer()
      ..writeln('\n« $type on $_formatTime »')
      ..writeln('• TAG       ─►  ${failure.tag.name.capitalize}')
      ..writeln('• CODE      ─►  ${failure.code}')
      ..writeln('• MESSAGE   ─►  ${failure.message}');

    // If an exception is present, include it in the log.
    if (failure.exception != null) {
      stringBuffer.writeln('• EXCEPTION ─►  ${failure.exception}');
    }

    return stringBuffer.toString();
  }
}
