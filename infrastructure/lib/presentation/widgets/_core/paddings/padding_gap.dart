// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: prefer-single-widget-per-file, prefer-single-declaration-per-file

import 'package:flutter/material.dart';
import 'package:infrastructure/presentation/super_class.dart';
import 'package:infrastructure/presentation/widgets/_core/gap/gap.dart';
import 'package:infrastructure/presentation/widgets/_core/gap/sliver_gap.dart';

/// [PaddingGap] is a specialized version of [Gap] that adds a flexible
/// gap with predefined padding values from the app's design system.
/// This widget helps maintain consistent spacing throughout the UI.
///
/// It supports various padding sizes (e.g., xs, sm, md) and allows
/// customization of the gap's color and cross-axis extent.
class PaddingGap extends Gap {
  /// Creates a [PaddingGap] with a specified main axis extent, optional
  /// color, and cross-axis extent.
  const PaddingGap(super.mainAxisExtent,
      {super.color, super.crossAxisExtent, super.key});

  /// Factory constructor for expanding the gap fully in the cross axis, with an optional color.
  factory PaddingGap.expand({Color? color, Key? key}) => PaddingGap(
        $.paddings.xxs,
        color: color,
        crossAxisExtent: double.infinity,
        key: key,
      );

  /// Factory constructor for a large gap.
  factory PaddingGap.lg({Color? color, double? crossAxisExtent, Key? key}) =>
      PaddingGap($.paddings.lg,
          color: color, crossAxisExtent: crossAxisExtent, key: key);

  /// Factory constructor for a medium gap.
  factory PaddingGap.md({Color? color, double? crossAxisExtent, Key? key}) =>
      PaddingGap($.paddings.md,
          color: color, crossAxisExtent: crossAxisExtent, key: key);

  /// Factory constructor for a small gap.
  factory PaddingGap.sm({Color? color, double? crossAxisExtent, Key? key}) =>
      PaddingGap($.paddings.sm,
          color: color, crossAxisExtent: crossAxisExtent, key: key);

  /// Factory constructor for an extra-large gap.
  factory PaddingGap.xl({Color? color, double? crossAxisExtent, Key? key}) =>
      PaddingGap($.paddings.xl,
          color: color, crossAxisExtent: crossAxisExtent, key: key);

  /// Factory constructor for an extra-small gap.
  factory PaddingGap.xs({Color? color, double? crossAxisExtent, Key? key}) =>
      PaddingGap($.paddings.xs,
          color: color, crossAxisExtent: crossAxisExtent, key: key);

  /// Factory constructor for an extra-extra-large gap.
  factory PaddingGap.xxl({Color? color, double? crossAxisExtent, Key? key}) =>
      PaddingGap($.paddings.xxl,
          color: color, crossAxisExtent: crossAxisExtent, key: key);

  /// Factory constructor for an extra-extra-small gap.
  factory PaddingGap.xxs({Color? color, double? crossAxisExtent, Key? key}) =>
      PaddingGap($.paddings.xxs,
          color: color, crossAxisExtent: crossAxisExtent, key: key);

  /// Factory constructor for an extra-extra-extra-small gap.
  factory PaddingGap.xxxs({Color? color, double? crossAxisExtent, Key? key}) =>
      PaddingGap($.paddings.xxxs,
          color: color, crossAxisExtent: crossAxisExtent, key: key);
}

/// [PaddingMaxGap] is a version of [MaxGap] that adds flexible gaps with
/// predefined padding values from the app's design system. It ensures
/// consistent spacing across the UI and supports various padding sizes.
class PaddingMaxGap extends MaxGap {
  /// Creates a [PaddingMaxGap] with a specified main axis extent, optional color,
  /// and cross-axis extent.
  const PaddingMaxGap(super.mainAxisExtent,
      {super.color, super.crossAxisExtent, super.key});

  /// Factory constructor for expanding the max gap fully in the cross axis, with an optional color.
  factory PaddingMaxGap.expand({Color? color, Key? key}) => PaddingMaxGap(
        $.paddings.xxs,
        color: color,
        crossAxisExtent: double.infinity,
        key: key,
      );

  /// Factory constructor for a large max gap.
  factory PaddingMaxGap.lg({Color? color, double? crossAxisExtent, Key? key}) =>
      PaddingMaxGap($.paddings.lg,
          color: color, crossAxisExtent: crossAxisExtent, key: key);

  /// Factory constructor for a medium max gap.
  factory PaddingMaxGap.md({Color? color, double? crossAxisExtent, Key? key}) =>
      PaddingMaxGap($.paddings.md,
          color: color, crossAxisExtent: crossAxisExtent, key: key);

  /// Factory constructor for a small max gap.
  factory PaddingMaxGap.sm({Color? color, double? crossAxisExtent, Key? key}) =>
      PaddingMaxGap($.paddings.sm,
          color: color, crossAxisExtent: crossAxisExtent, key: key);

  /// Factory constructor for an extra-large max gap.
  factory PaddingMaxGap.xl({Color? color, double? crossAxisExtent, Key? key}) =>
      PaddingMaxGap($.paddings.xl,
          color: color, crossAxisExtent: crossAxisExtent, key: key);

  /// Factory constructor for an extra-small max gap.
  factory PaddingMaxGap.xs({Color? color, double? crossAxisExtent, Key? key}) =>
      PaddingMaxGap($.paddings.xs,
          color: color, crossAxisExtent: crossAxisExtent, key: key);

  /// Factory constructor for an extra-extra-large max gap.
  factory PaddingMaxGap.xxl(
          {Color? color, double? crossAxisExtent, Key? key}) =>
      PaddingMaxGap($.paddings.xxl,
          color: color, crossAxisExtent: crossAxisExtent, key: key);

  /// Factory constructor for an extra-extra-small max gap.
  factory PaddingMaxGap.xxs(
          {Color? color, double? crossAxisExtent, Key? key}) =>
      PaddingMaxGap($.paddings.xxs,
          color: color, crossAxisExtent: crossAxisExtent, key: key);
}

/// [PaddingSliverGap] extends [SliverGap] to support predefined padding sizes,
/// ensuring consistent spacing within slivers, such as in scrolling contexts.
/// It also supports custom colors for the gap.
class PaddingSliverGap extends SliverGap {
  /// Creates a [PaddingSliverGap] with a specified main axis extent and an optional color.
  const PaddingSliverGap(super.mainAxisExtent, {super.color, super.key});

  /// Factory constructor for a large sliver gap.
  factory PaddingSliverGap.lg({Color? color, Key? key}) =>
      PaddingSliverGap($.paddings.lg, color: color, key: key);

  /// Factory constructor for a medium sliver gap.
  factory PaddingSliverGap.md({Color? color, Key? key}) =>
      PaddingSliverGap($.paddings.md, color: color, key: key);

  /// Factory constructor for a small sliver gap.
  factory PaddingSliverGap.sm({Color? color, Key? key}) =>
      PaddingSliverGap($.paddings.sm, color: color, key: key);

  /// Factory constructor for an extra-large sliver gap.
  factory PaddingSliverGap.xl({Color? color, Key? key}) =>
      PaddingSliverGap($.paddings.xl, color: color, key: key);

  /// Factory constructor for an extra-small sliver gap.
  factory PaddingSliverGap.xs({Color? color, Key? key}) =>
      PaddingSliverGap($.paddings.xs, color: color, key: key);

  /// Factory constructor for an extra-extra-large sliver gap.
  factory PaddingSliverGap.xxl({Color? color, Key? key}) =>
      PaddingSliverGap($.paddings.xxl, color: color, key: key);

  /// Factory constructor for an extra-extra-small sliver gap.
  factory PaddingSliverGap.xxs({Color? color, Key? key}) =>
      PaddingSliverGap($.paddings.xxs, color: color, key: key);
}
