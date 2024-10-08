// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

/// The [AppSettings] class holds various configuration options for the app's
/// runtime behavior, particularly useful for debugging and diagnostics.
///
/// These settings are used to control aspects of the app's visual representation
/// and performance monitoring during development.
final class AppSettings {
  /// Creates an instance of [AppSettings] with optional configurations.
  ///
  /// * [title]: The title of the application.
  /// * [debugShowMaterialGrid]: Whether to display a baseline grid overlay for debugging material design.
  /// * [showPerformanceOverlay]: Whether to display a performance overlay in the app.
  /// * [checkerboardRasterCacheImages]: Whether to checkerboard images that are cached in the raster cache.
  /// * [checkerboardOffscreenLayers]: Whether to checkerboard layers rendered offscreen.
  /// * [showSemanticsDebugger]: Whether to display the semantics debugger overlay.
  /// * [debugShowCheckedModeBanner]: Whether to display the "debug" banner in debug mode.
  const AppSettings({
    this.title = '',
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
  });

  /// The title of the application, usually displayed in the system UI or app bar.
  final String title;

  /// Whether to display a grid overlay to help debug the layout of material design components.
  ///
  /// This is useful for ensuring that your app follows material design guidelines
  /// and the components are aligned correctly.
  final bool debugShowMaterialGrid;

  /// Whether to show a performance overlay on the screen.
  ///
  /// The performance overlay displays graphical information about the app's rendering performance,
  /// which helps in identifying performance bottlenecks during development.
  final bool showPerformanceOverlay;

  /// Whether to checkerboard images that are cached in the raster cache.
  ///
  /// Checkerboarding is a visual debugging tool that shows areas where offscreen images are being cached.
  /// When this is enabled, images stored in the raster cache will be overlaid with a checkerboard pattern.
  final bool checkerboardRasterCacheImages;

  /// Whether to checkerboard layers rendered offscreen.
  ///
  /// Similar to [checkerboardRasterCacheImages], this setting overlays a checkerboard pattern
  /// on layers that are rendered offscreen, providing a visual indication for debugging purposes.
  final bool checkerboardOffscreenLayers;

  /// Whether to display the semantics debugger overlay.
  ///
  /// The semantics debugger visually shows the semantics information associated with widgets in the app,
  /// which helps in testing and ensuring proper accessibility support for screen readers and other assistive technologies.
  final bool showSemanticsDebugger;

  /// Whether to display the "debug" banner in debug mode.
  ///
  /// The debug banner appears in the top-right corner of the app when running in debug mode,
  /// and this flag controls whether the banner is shown.
  final bool debugShowCheckedModeBanner;
}
