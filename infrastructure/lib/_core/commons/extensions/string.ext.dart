// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:flutter/widgets.dart';

/// Extension on `String` to provide various text manipulation and utility methods.
extension StringExt on String {
  /// Capitalizes the first letter of each word in the string.
  String get capitalize => isEmpty
      ? this
      : split(' ').map((String letter) => letter.capitalizeFirst).join(' ');

  /// Capitalizes only the first letter of the string.
  String get capitalizeFirst {
    if (isEmpty) {
      return this;
    }
    final String firstCharacter = characters.firstOrNull?.toUpperCase() ?? '';
    final Characters remainingCharacters = characters.skip(1).toLowerCase();
    return firstCharacter + remainingCharacters.string;
  }

  /// Converts the first letter of the string to lowercase.
  String get lowercaseFirst {
    if (isEmpty) {
      return this;
    }
    final String firstCharacter = characters.firstOrNull?.toLowerCase() ?? '';
    final Characters remainingCharacters = characters.skip(1);
    return firstCharacter + remainingCharacters.string;
  }

  /// Calculates the width of the string when rendered with a specific [TextStyle].
  double width(TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: this, style: style),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout();
    return textPainter.size.width * 1.16;
  }

  /// Removes all whitespaces from the string.
  String get removeAllWhitespace => replaceAll(' ', '');

  /// Checks if the string matches a given regular expression [pattern].
  bool hasMatch(String pattern) {
    return RegExp(pattern).hasMatch(this);
  }

  /// Checks if the string contains only numeric characters.
  bool get isNumericOnly => hasMatch(r'^\d+$');

  /// Checks if the string contains only alphabetic characters.
  bool get isAlphabetOnly => hasMatch(r'^[a-zA-Z]+$');

  /// Checks if the string contains at least one capital letter.
  bool get hasCapitalletter => hasMatch('[A-Z]');

  /// Checks if the string represents a boolean value (`true` or `false`).
  bool get isBool => this == 'true' || this == 'false';

  /// Creates a `Text` widget with the string and applies the given [TextStyle] and other parameters.
  Text text({
    TextStyle? style,
    Key? key,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    TextScaler? textScaler,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    Color? selectionColor,
  }) {
    return Text(
      this,
      key: key,
      style: style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaler: textScaler,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }
}
