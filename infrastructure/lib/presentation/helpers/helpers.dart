// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// The `Helpers` class provides utility functions.
final class Helpers {
  const Helpers();

  /// Returns a [TextInputFormatter] that enforces a prefix at the beginning of the input text.
  /// If the user tries to remove or alter the prefix, the formatter automatically restores it.
  ///
  /// - [prefix]: The string that will always appear at the start of the input text.
  ///
  /// Example:
  /// ```dart
  /// TextFormField(
  ///   inputFormatters: [
  ///     Helpers().enforcePrefixFormatter('+1'),
  ///   ],
  /// )
  /// ```
  TextInputFormatter enforcePrefixFormatter(String prefix) {
    return TextInputFormatter.withFunction(
        (TextEditingValue oldValue, TextEditingValue newValue) {
      // Check if the new value starts with the provided prefix.
      if (newValue.text.startsWith(prefix)) {
        return newValue;
      }

      // Find the index of the prefix in the old value.
      final int cutIndex = oldValue.text.lastIndexOf(prefix);

      // If the prefix is not found, forcefully set the text to the prefix only.
      return cutIndex == -1
          ? TextEditingValue(
              text: prefix,
              selection: TextSelection.collapsed(offset: prefix.length),
            )
          : TextEditingValue(
              text: oldValue.text.characters
                  .getRange(0, cutIndex + prefix.length)
                  .toString(),
              selection:
                  TextSelection.collapsed(offset: cutIndex + prefix.length),
            );
    });
  }
}
