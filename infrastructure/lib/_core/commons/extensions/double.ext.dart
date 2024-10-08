// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:flutter/material.dart';

/// Extension on `double` to simplify the creation of `EdgeInsets` from a single value.
extension DoubleExt on double {
  /// Creates an `EdgeInsets` with only the specified sides enabled.
  ///
  /// You can specify which sides to apply the padding to by setting the
  /// boolean flags `b` (bottom), `l` (left), `r` (right), and `t` (top).
  EdgeInsets only({
    bool b = false,
    bool l = false,
    bool r = false,
    bool t = false,
  }) =>
      EdgeInsets.fromLTRB(
        l ? this : 0, // Left padding
        t ? this : 0, // Top padding
        r ? this : 0, // Right padding
        b ? this : 0, // Bottom padding
      );

  /// Creates an `EdgeInsets` with only left padding.
  EdgeInsets get left => EdgeInsets.only(left: this);

  /// Creates an `EdgeInsets` with only right padding.
  EdgeInsets get right => EdgeInsets.only(right: this);

  /// Creates an `EdgeInsets` with only top padding.
  EdgeInsets get top => EdgeInsets.only(top: this);

  /// Creates an `EdgeInsets` with only bottom padding.
  EdgeInsets get bottom => EdgeInsets.only(bottom: this);

  /// Creates an `EdgeInsets` with equal padding on all sides.
  EdgeInsets get all => EdgeInsets.all(this);

  /// Creates an `EdgeInsets` with symmetric horizontal padding (left and right).
  EdgeInsets get horizontal => EdgeInsets.symmetric(horizontal: this);

  /// Creates an `EdgeInsets` with symmetric vertical padding (top and bottom).
  EdgeInsets get vertical => EdgeInsets.symmetric(vertical: this);
}

/// Extension on `double` to simplify the creation of `BorderRadius` and `Radius` objects.
extension RadiusesDoubleExt on double {
  /// Creates a `BorderRadius` with the specified corners rounded.
  ///
  /// You can round specific corners by setting the boolean flags:
  /// `tl` (top-left), `tr` (top-right), `bl` (bottom-left), and `br` (bottom-right).
  BorderRadius ronly({
    bool tl = false,
    bool tr = false,
    bool bl = false,
    bool br = false,
  }) =>
      BorderRadius.only(
        topLeft: Radius.circular(tl ? this : 0),
        topRight: Radius.circular(tr ? this : 0),
        bottomLeft: Radius.circular(bl ? this : 0),
        bottomRight: Radius.circular(br ? this : 0),
      );

  /// Creates a `BorderRadius` with only the top-left corner rounded.
  BorderRadius get topLeft => BorderRadius.only(topLeft: Radius.circular(this));

  /// Creates a `BorderRadius` with only the top-right corner rounded.
  BorderRadius get topRight =>
      BorderRadius.only(topRight: Radius.circular(this));

  /// Creates a `BorderRadius` with only the bottom-left corner rounded.
  BorderRadius get bottomLeft =>
      BorderRadius.only(bottomLeft: Radius.circular(this));

  /// Creates a `BorderRadius` with only the bottom-right corner rounded.
  BorderRadius get bottomRight =>
      BorderRadius.only(bottomRight: Radius.circular(this));

  /// Creates a `BorderRadius` with symmetric horizontal corners rounded (left and right).
  BorderRadius get rhorizontal => BorderRadius.horizontal(
      left: Radius.circular(this), right: Radius.circular(this));

  /// Creates a `BorderRadius` with symmetric vertical corners rounded (top and bottom).
  BorderRadius get rvertical => BorderRadius.vertical(
      top: Radius.circular(this), bottom: Radius.circular(this));

  /// Creates a `BorderRadius` where all corners are rounded by the same amount.
  BorderRadius get borderRadius => BorderRadius.all(Radius.circular(this));

  /// Creates a `Radius` object with a circular radius equal to this value.
  Radius get circularRadius => Radius.circular(this);
}
