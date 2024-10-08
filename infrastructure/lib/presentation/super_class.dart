// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: file_names, prefer-match-file-name, prefer-correct-type-name, prefer-named-parameters, avoid-dynamic, prefer-correct-identifier-length, avoid-late-keyword

import 'package:deps/design/design.dart';
import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/locator/locator.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/permissions/permissions.dart';
import 'package:infrastructure/presentation/constants/paddings.dart';
import 'package:infrastructure/presentation/constants/platform.dart';
import 'package:infrastructure/presentation/constants/radiuses.dart';
import 'package:infrastructure/presentation/constants/timings.dart';
import 'package:infrastructure/presentation/contexts/bloc_context.dart';
import 'package:infrastructure/presentation/contexts/navigator_context.dart';
import 'package:infrastructure/presentation/helpers/helpers.dart';

/// Global utility class that provides access to various application-wide services,
/// constants, contexts, and helpers.
///
/// This class follows the singleton pattern to provide a unified access point
/// for common utilities such as navigation, dialogs, toasts, permissions, and more.
///
/// Example usage:
/// ```dart
/// $.navigator.push(...);
/// $.paddings.lg;
/// $.helpers.enforcePrefixFormatter(...);
/// ```
@immutable
final class $ {
  /// Factory method to return the singleton instance.
  factory $() => i;

  /// Private internal constructor for the singleton instance.
  /// Initializes various contexts, constants, and managers.
  $._internal() {
    _navigator = NavigatorContext();
    _overlay = OverlayContext();
    _dialog = DialogContext();
    _toast = ToastContext();
    _bloc = const BlocContext();
    _timings = Timings();
    _radiuses = Radiuses();
    _paddings = Paddings();
    _platform = Platform();
    _permissions = Permissions();
  }

  /// Global app context, throws an error if the navigator context is not initialized.
  static final BuildContext context = i._navigator.context ??
      (throw StateError('Navigator context is not initialized.'));

  /// Navigator context for handling navigation.
  static final NavigatorContext navigator = i._navigator;

  /// Dialog context for managing dialogs.
  static final DialogContext dialog = i._dialog;

  /// Toast context for showing toast messages.
  static final ToastContext toast = i._toast;

  /// Overlay context for handling custom overlays.
  static final OverlayContext overlay = i._overlay;

  /// Bloc context for managing state using the Bloc pattern.
  static final BlocContext bloc = i._bloc;

  /// Singleton instance of the [$] class.
  static final $ i = $._internal();

  // Internal references to various managers, constants, and contexts.

  /// Navigator context for managing navigation within the app.
  late final NavigatorContext _navigator;

  /// Dialog context for managing and displaying dialogs.
  late final DialogContext _dialog;

  /// Toast context for showing toast messages within the app.
  late final ToastContext _toast;

  /// Overlay context for managing custom overlays.
  late final OverlayContext _overlay;

  /// Bloc context for managing app state using Bloc.
  late final BlocContext _bloc;

  /// Timings constants for defining standard durations used throughout the app.
  late final Timings _timings;

  /// Radius constants for defining standard corner radii.
  late final Radiuses _radiuses;

  /// Padding constants for defining standard padding sizes.
  late final Paddings _paddings;

  /// Platform-specific utilities and constants.
  late final Platform _platform;

  /// Permissions manager for handling permission requests and statuses.
  late final Permissions _permissions;

  // Public getters for constants and managers.

  /// Accessor for predefined timing durations.
  static Timings get timings => i._timings;

  /// Accessor for predefined corner radius sizes.
  static Radiuses get radiuses => i._radiuses;

  /// Accessor for predefined padding sizes.
  static Paddings get paddings => i._paddings;

  /// Accessor for platform-specific utilities and constants.
  static Platform get platform => i._platform;

  /// Accessor for permissions manager.
  static Permissions get permissions => i._permissions;

  // Utility and helper methods.

  /// Accessor for the app's current theme configuration.
  static ThemeGen get theme => context.theme.themeGen;

  /// Accessor for app icon assets.
  // static $AssetsIconsGen get icons => Assets.icons;

  /// Accessor for app image assets.
  // static $AssetsImagesGen get images => Assets.images;

  /// Accessor for global helper methods.
  static Helpers get helpers => const Helpers();

  /// Accessor for translation cubit, used for internationalization.
  static TranslationsCubit get tr => locator<TranslationsCubit>();

  /// Generic method to retrieve a service or dependency from the service locator.
  ///
  /// Example:
  /// ```dart
  /// final MyService service = $.get<MyService>();
  /// ```
  static T get<T extends Object>() => locator<T>();

  /// Logs debug information through the global logger.
  ///
  /// [data] is the information to log, and [message] is an optional accompanying message.
  static void debug(dynamic data, [String? message]) =>
      locator<ILogger>().debug(data, message);

  /// Executes a callback after the widget build is completed.
  ///
  /// [callback] is the function to be executed post-build.
  static void afterBuildCallback(ValueChanged<Duration> callback) =>
      WidgetsBinding.instance.addPostFrameCallback(callback);
}
