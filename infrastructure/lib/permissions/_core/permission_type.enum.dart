// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

/// Enum representing different types of permissions.
enum PermissionTypeEnum {
  /// Permission for accessing media location.
  accessMediaLocation,

  /// Permission for accessing activity recognition.
  /// Permission for accessing notification policy.
  accessNotificationPolicy,

  /// Permission for scanning Bluetooth devices.
  /// Permission for accessing activity recognition.
  activityRecognition,

  /// Unknown permission, used as a placeholder.
  /// Permission for app tracking transparency.
  appTrackingTransparency,

  /// Permission for sending critical alerts.
  /// Permission for accessing audio files from external storage.
  audio,

  /// Permission for scheduling exact alarms.
  /// Permission for accessing Bluetooth adapter state.
  bluetooth,

  /// Permission for managing external storage.
  /// Permission for advertising Bluetooth devices.
  bluetoothAdvertise,

  /// Permission for connecting Bluetooth devices.
  /// Permission for connecting Bluetooth devices.
  bluetoothConnect,

  /// Permission for connecting to nearby Wi-Fi devices.
  /// Permission for scanning Bluetooth devices.
  bluetoothScan,

  /// Permission for advertising Bluetooth devices.
  /// Permission for accessing the device's calendar.
  /// Deprecated: Use [calendarWriteOnly] and [calendarFullAccess].
  calendar,

  /// Permission for accessing the device's camera.
  /// Permission for full access to the calendar.
  calendarFullAccess,

  /// Permission for writing to the calendar.
  calendarWriteOnly,

  /// Permission for full access to the calendar.
  /// Permission for accessing the device's camera.
  camera,

  /// Permission for accessing the device's contacts.
  /// Permission for accessing the device's contacts.
  contacts,

  /// Permission for accessing the device's location.
  /// Permission for sending critical alerts.
  criticalAlerts,

  /// Permission for accessing notification policy.
  /// Permission for ignoring battery optimizations.
  ignoreBatteryOptimizations,

  /// Permission for pushing notifications.
  /// Permission for accessing the device's location.
  location,

  /// Permission for accessing the device's location always.
  /// Permission for accessing the device's location always.
  locationAlways,

  /// Permission for accessing the device's location when in use.
  /// Permission for accessing the device's location when in use.
  locationWhenInUse,

  /// Permission for accessing the device's media library.
  /// Permission for managing external storage.
  manageExternalStorage,

  /// Permission for creating system alert window.
  /// Permission for accessing the device's media library.
  mediaLibrary,

  /// Permission for accessing the device's microphone.
  /// Permission for accessing the device's microphone.
  microphone,

  /// Permission for accessing the device's phone state.
  /// Permission for connecting to nearby Wi-Fi devices.
  nearbyWifiDevices,

  /// Permission for accessing video files from external storage.
  /// Permission for pushing notifications.
  notification,

  /// Permission for accessing media location.
  /// Permission for accessing the device's phone state.
  phone,

  /// Permission for accessing the device's photos.
  /// Permission for accessing the device's photos.
  photos,

  /// Permission for adding photos only.
  /// Permission for adding photos only.
  photosAddOnly,

  /// Permission for accessing the device's reminders.
  /// Permission for accessing the device's reminders.
  reminders,

  /// Permission for accessing the device's sensors.
  /// Permission for requesting package installation.
  requestInstallPackages,

  /// Permission for app tracking transparency.
  /// Permission for scheduling exact alarms.
  scheduleExactAlarm,

  /// Permission for accessing sensors always.
  /// Permission for accessing the device's sensors.
  sensors,

  /// Permission for sending and reading SMS messages.
  /// Permission for accessing sensors always.
  sensorsAlways,

  /// Permission for writing to the calendar.
  /// Permission for sending and reading SMS messages.
  sms,

  /// Permission for accessing speech recognition.
  /// Permission for accessing speech recognition.
  speech,

  /// Permission for accessing external storage.
  /// Permission for accessing external storage.
  storage,

  /// Permission for ignoring battery optimizations.
  /// Permission for creating system alert window.
  systemAlertWindow,

  /// Permission for requesting package installation.
  /// Unknown permission, used as a placeholder.
  unknown,

  /// Permission for accessing Bluetooth adapter state.
  /// Permission for accessing video files from external storage.
  videos,
}
