// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

/// Analytics interface for tracking user behavior and interactions.
///
/// - `setUserId`: Sets the user ID for analytics tracking.
/// - `setPage`: Logs page navigation or views with a specific page name and widget.
/// - `send`: Sends a custom analytics event or message.
abstract interface class IAnalytics {
  void setUserId(String? id);

  void setPage({required String name, required String widgetName});

  void send(String message);
}
