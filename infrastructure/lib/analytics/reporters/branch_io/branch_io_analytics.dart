// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/injectable.dart';
import 'package:infrastructure/analytics/reporters/i_analytics.dart';

/// A concrete implementation of the [IAnalytics] interface that uses Branch.io analytics.
///
/// The [BranchIoAnalytics] class provides methods for sending analytics data,
/// tracking page views, and setting user IDs. This class is annotated with
/// `@LazySingleton` to ensure that a single instance is used throughout the app.
@LazySingleton(as: IAnalytics)
class BranchIoAnalytics implements IAnalytics {
  /// A constant constructor for the [BranchIoAnalytics] class.
  ///
  /// This ensures that the class is stateless and can be instantiated as a singleton.
  const BranchIoAnalytics();

  /// Sends an analytics message using Branch.io.
  ///
  /// This method is intended to send a message or event to the analytics system. In a
  /// real implementation, this would involve interacting with Branch.io's API to log the event.
  ///
  /// * [message]: A string representing the event or message to be sent to analytics.
  @override
  Future<void> send(String message) async {
    // Add Branch.io event sending logic here.
  }

  /// Tracks a page view event using Branch.io.
  ///
  /// This method tracks when a user views a page in the app, providing information
  /// about the page name and widget that triggered the event. Typically used for
  /// navigation and screen tracking.
  ///
  /// * [name]: The name of the page viewed by the user.
  /// * [widgetName]: The name of the widget associated with the page.
  @override
  Future<void> setPage(
      {required String name, required String widgetName}) async {
    // Add Branch.io page view tracking logic here.
  }

  /// Sets the user ID in Branch.io for tracking purposes.
  ///
  /// This method assigns a unique identifier to a user in Branch.io, which allows
  /// the analytics system to track events and actions tied to a specific user.
  ///
  /// * [id]: The unique user ID. If null, it could mean the user is logged out or anonymous.
  @override
  Future<void> setUserId(String? id) async {
    // Add Branch.io user ID setting logic here.
  }
}
