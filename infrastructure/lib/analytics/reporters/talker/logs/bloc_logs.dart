// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: avoid_dynamic_calls

import 'package:deps/packages/flutter_bloc.dart';
import 'package:deps/packages/intl.dart';
import 'package:deps/packages/talker_bloc_logger.dart';
import 'package:deps/packages/talker_flutter.dart';

/// Custom log for logging Bloc events using Talker.
///
/// This class is responsible for formatting and logging events received by a Bloc,
/// showing details like the Bloc's type, event received, and the time of the event.
class BlocEventLog extends TalkerLog {
  BlocEventLog({
    required this.bloc,
    required this.event,
    required this.settings,
  }) : super('');

  final Bloc<dynamic, dynamic> bloc;
  final dynamic event;
  final TalkerBlocLoggerSettings settings;

  @override
  String generateTextMessage({TimeFormat? timeFormat}) {
    return _createMessage;
  }

  @override
  AnsiPen get pen => AnsiPen()..xterm(51);

  /// Generates a formatted message for logging the Bloc event.
  String get _createMessage {
    final StringBuffer stringBuffer = StringBuffer()
      ..writeln('\n« BLOC on $_formatTime »')
      ..writeln('• NAME\t  ─►  ${bloc.runtimeType}')
      ..writeln(
          '• STATUS\t─►  Received event: ${settings.printEventFullData ? event : event.runtimeType}');
    return stringBuffer.toString();
  }

  /// Formats the current time as `HH:mm:ss.SSS` for log entry.
  String get _formatTime => DateFormat('HH:mm:ss.SSS').format(DateTime.now());
}

/// Custom log for logging Bloc state transitions using Talker.
///
/// This class logs the details of a Bloc's state transition, including the
/// current and next state, and the event that triggered the transition.
class BlocStateLog extends TalkerLog {
  BlocStateLog({
    required this.bloc,
    required this.settings,
    required this.transition,
  }) : super('');

  final Bloc<dynamic, dynamic> bloc;
  final TalkerBlocLoggerSettings settings;
  final Transition<dynamic, dynamic> transition;

  @override
  String generateTextMessage({TimeFormat? timeFormat}) {
    return _createMessage;
  }

  @override
  AnsiPen get pen => AnsiPen()..xterm(49);

  /// Generates a formatted message for logging the state transition.
  String get _createMessage {
    final StringBuffer stringBuffer = StringBuffer()
      ..writeln('\n« BLOC on $_formatTime »')
      ..writeln('• NAME\t  ─►  ${bloc.runtimeType}')
      ..writeln(
          '• STATUS\t─►  Transitioning with event ${transition.event.runtimeType}');

    final dynamic currentState = _serializeObject(transition.currentState);
    final dynamic nextState = _serializeObject(transition.nextState);

    if (settings.printStateFullData &&
        (currentState is Map || currentState is List) &&
        (nextState is Map || nextState is List)) {
      if (settings.printStateFullData) {
        stringBuffer
          ..writeln(
            '• FROM\t  ─►  ${currentState.entries.map(
                  (MapEntry<String, dynamic> entry) =>
                      '- "${entry.key}": "${entry.value}"',
                ).join(',\n')}',
          )
          ..writeln(
            '• TO\t\t─►  ${nextState.entries.map(
                  (MapEntry<String, dynamic> entry) =>
                      '- "${entry.key}": "${entry.value}"',
                ).join(',\n')}',
          );
      }
    } else {
      stringBuffer
        ..writeln(
          '• FROM\t  ─►  ${transition.currentState.runtimeType}',
        )
        ..writeln(
          '• TO\t\t─►  ${transition.nextState.runtimeType}',
        );
    }

    return stringBuffer.toString();
  }

  /// Attempts to serialize the state object, or falls back to its string representation.
  dynamic _serializeObject(dynamic object) {
    if (object == null) {
      return null;
    }
    try {
      return object.toJson();
    } catch (e) {
      return object.toString();
    }
  }

  /// Formats the current time as `HH:mm:ss.SSS` for log entry.
  String get _formatTime => DateFormat('HH:mm:ss.SSS').format(DateTime.now());
}

/// Custom log for logging Bloc state changes using Talker.
///
/// This class logs state changes within a Bloc, including the current and next state.
class BlocChangeLog extends TalkerLog {
  BlocChangeLog({
    required this.bloc,
    required this.change,
    required this.settings,
  }) : super('');

  final BlocBase<dynamic> bloc;
  final Change<dynamic> change;
  final TalkerBlocLoggerSettings settings;

  @override
  String generateTextMessage({TimeFormat? timeFormat}) {
    return _createMessage;
  }

  @override
  AnsiPen get pen => AnsiPen()..xterm(49);

  /// Generates a formatted message for logging the state change.
  String get _createMessage {
    final StringBuffer stringBuffer = StringBuffer()
      ..writeln('\n« BLOC on $_formatTime »')
      ..writeln('• NAME\t  ─►  ${bloc.runtimeType}')
      ..writeln('• STATUS\t─►  Changed');

    final dynamic currentState = _serializeObject(change.currentState);
    final dynamic nextState = _serializeObject(change.nextState);

    if (settings.printStateFullData &&
        (currentState is Map || currentState is List) &&
        (nextState is Map || nextState is List)) {
      if (settings.printStateFullData) {
        stringBuffer
          ..writeln(
            '• FROM\t  ─►  ${currentState.entries.map(
                  (MapEntry<String, dynamic> entry) =>
                      '- "${entry.key}": "${entry.value}"',
                ).join(',\n')}',
          )
          ..writeln(
            '• TO\t\t─►  ${nextState.entries.map(
                  (MapEntry<String, dynamic> entry) =>
                      '- "${entry.key}": "${entry.value}"',
                ).join(',\n')}',
          );
      }
    } else {
      stringBuffer
        ..writeln(
          '• FROM\t  ─►  ${change.currentState.runtimeType}',
        )
        ..writeln(
          '• TO\t\t─►  ${change.nextState.runtimeType}',
        );
    }

    return stringBuffer.toString();
  }

  /// Attempts to serialize the state object, or falls back to its string representation.
  dynamic _serializeObject(dynamic object) {
    if (object == null) {
      return null;
    }
    try {
      return object.toJson();
    } catch (e) {
      return object.toString();
    }
  }

  /// Formats the current time as `HH:mm:ss.SSS` for log entry.
  String get _formatTime => DateFormat('HH:mm:ss.SSS').format(DateTime.now());
}

/// Custom log for logging Bloc creation using Talker.
///
/// This class logs when a Bloc is created, showing the Bloc's runtime type and the timestamp.
class BlocCreateLog extends TalkerLog {
  BlocCreateLog({required this.bloc}) : super('');

  final BlocBase<dynamic> bloc;

  @override
  String generateTextMessage({TimeFormat? timeFormat}) {
    return _createMessage;
  }

  @override
  AnsiPen get pen => AnsiPen()..xterm(8);

  /// Generates a formatted message for logging the creation of a Bloc.
  String get _createMessage {
    final StringBuffer stringBuffer = StringBuffer()
      ..writeln('\n« BLOC on $_formatTime »')
      ..writeln('• NAME\t  ─►  ${bloc.runtimeType}')
      ..writeln('• STATUS\t─►  Created');

    return stringBuffer.toString();
  }

  /// Formats the current time as `HH:mm:ss.SSS` for log entry.
  String get _formatTime => DateFormat('HH:mm:ss.SSS').format(DateTime.now());
}

/// Custom log for logging Bloc closure using Talker.
///
/// This class logs when a Bloc is closed, showing the Bloc's runtime type and the timestamp.
class BlocCloseLog extends TalkerLog {
  BlocCloseLog({required this.bloc}) : super('');

  final BlocBase<dynamic> bloc;

  @override
  String generateTextMessage({TimeFormat? timeFormat}) {
    return _createMessage;
  }

  @override
  AnsiPen get pen => AnsiPen()..xterm(13);

  /// Generates a formatted message for logging the closure of a Bloc.
  String get _createMessage {
    final StringBuffer stringBuffer = StringBuffer()
      ..writeln('\n« BLOC on $_formatTime »')
      ..writeln('• NAME\t  ─►  ${bloc.runtimeType}')
      ..writeln('• STATUS\t─►  Closed');

    return stringBuffer.toString();
  }

  /// Formats the current time as `HH:mm:ss.SSS` for log entry.
  String get _formatTime => DateFormat('HH:mm:ss.SSS').format(DateTime.now());
}
