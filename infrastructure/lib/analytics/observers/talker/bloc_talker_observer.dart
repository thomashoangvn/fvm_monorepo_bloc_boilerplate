// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/flutter_bloc.dart';
import 'package:deps/packages/talker_bloc_logger.dart'
    hide BlocChangeLog, BlocCloseLog, BlocCreateLog, BlocEventLog, BlocStateLog;
import 'package:deps/packages/talker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:infrastructure/analytics/reporters/talker/logs/bloc_logs.dart';

/// Custom `BlocObserver` that logs Bloc events, transitions, and errors using Talker.
@immutable
final class BlocTalkerObserver extends BlocObserver {
  const BlocTalkerObserver({required this.settings, required this.talker});

  /// Talker instance for logging Bloc events.
  final Talker talker;

  /// Settings for customizing Bloc logging.
  final TalkerBlocLoggerSettings settings;

  @override
  @mustCallSuper
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    if (!settings.enabled || !settings.printEvents) {
      return;
    }
    final bool isAccepted = settings.eventFilter?.call(bloc, event) ?? true;
    if (!isAccepted) {
      return;
    }
    talker.logTyped(BlocEventLog(bloc: bloc, event: event, settings: settings));
  }

  @override
  @mustCallSuper
  void onTransition(
      Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    super.onTransition(bloc, transition);
    if (!settings.enabled || !settings.printTransitions) {
      return;
    }
    final bool isAccepted =
        settings.transitionFilter?.call(bloc, transition) ?? true;
    if (!isAccepted) {
      return;
    }
    talker.logTyped(
        BlocStateLog(bloc: bloc, settings: settings, transition: transition));
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (!settings.enabled || !settings.printChanges) {
      return;
    }
    talker.logTyped(
      BlocChangeLog(bloc: bloc, change: change, settings: settings),
    );
  }

  @override
  @mustCallSuper
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    talker.error(bloc.runtimeType, error, stackTrace);
  }

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    if (!settings.enabled || !settings.printCreations) {
      return;
    }
    talker.logTyped(BlocCreateLog(bloc: bloc));
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    if (!settings.enabled || !settings.printClosings) {
      return;
    }
    talker.logTyped(BlocCloseLog(bloc: bloc));
  }
}
