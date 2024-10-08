// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:flutter/material.dart';

/// Extension on `TextStyle` to easily modify text style properties.
extension TextStyleExt on TextStyle {
  /// Sets the font weight to the most thick (w900).
  TextStyle get mostThick => copyWith(fontWeight: FontWeight.w900);

  /// Sets the font weight to extra bold (w800).
  TextStyle get extraBold => copyWith(fontWeight: FontWeight.w800);

  /// Sets the font weight to bold (w700).
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);

  /// Sets the font weight to semi-bold (w600).
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);

  /// Sets the font weight to medium (w500).
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  /// Sets the font weight to regular (w400).
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);

  /// Sets the font weight to light (w300).
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);

  /// Sets the font weight to extra light (w200).
  TextStyle get extraLight => copyWith(fontWeight: FontWeight.w200);

  /// Sets the font weight to thin (w100).
  TextStyle get thin => copyWith(fontWeight: FontWeight.w100);

  /// Sets the font style to italic.
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);

  /// Underlines the text.
  TextStyle get underline => copyWith(decoration: TextDecoration.underline);

  /// Changes the font size to the given [size].
  TextStyle changeSize(double size) => copyWith(fontSize: size);

  /// Changes the font family to the given [family].
  TextStyle changeFamily(String family) => copyWith(fontFamily: family);

  /// Changes the letter spacing to the given [space].
  TextStyle changeLetterSpacing(double space) => copyWith(letterSpacing: space);

  /// Changes the word spacing to the given [space].
  TextStyle changeWordSpacing(double space) => copyWith(wordSpacing: space);

  /// Changes the text color to the given [color].
  TextStyle changeColor(Color color) => copyWith(color: color);

  /// Changes the text baseline to the given [textBaseline].
  TextStyle changeBaseline(TextBaseline textBaseline) =>
      copyWith(textBaseline: textBaseline);

  /// Changes the color of the text based on a [condition].
  ///
  /// If the [condition] is true, the color is set to [ifTrue]; otherwise, it's set to [ifFalse].
  TextStyle changeColorWithCondition({
    required bool condition,
    Color? ifTrue,
    Color? ifFalse,
  }) =>
      copyWith(color: condition ? ifTrue ?? color : ifFalse ?? color);
}
