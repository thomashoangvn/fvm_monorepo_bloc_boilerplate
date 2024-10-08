// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/styled_text.dart';
import 'package:flutter/material.dart';

extension StyledTextExt on String {
  /// A convenient extension on String to create a StyledText widget with predefined and custom styles.
  ///
  /// You can pass optional `style`, custom `tags` for specific text styles, and `widgets` for embedding widgets in text.
  /// The `styled` method also supports `TextAlign`, `TextOverflow`, `opacity` for widgets, and `maxLines`.
  StyledText styled({
    TextStyle? style,
    Map<String, TextStyle>? tags,
    Map<String, Widget>? widgets,
    TextAlign textAlign = TextAlign.start,
    TextOverflow overflow = TextOverflow.clip,
    double opacity = 1,
    int? maxLines,
  }) {
    /// Defines the default tags for styled text.
    /// The predefined tags are:
    /// - 'sb' for semi-bold text.
    /// - 'b' for bold text.
    /// - 'i' for italic text.
    Map<String, StyledTextTagBase> getTags() {
      return style == null
          ? <String, StyledTextTagBase>{}
          : <String, StyledTextTagBase>{
              'sb': StyledTextTag(
                style: style.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              'b': StyledTextTag(
                style: style.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              'i': StyledTextTag(
                style: style.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
            };
    }

    /// Converts the provided `tags` map into a map of `StyledTextTag` objects.
    Map<String, StyledTextTag> convertTextStyleTags() {
      return tags == null
          ? <String, StyledTextTag>{}
          : tags.map((String key, TextStyle textStyle) {
              return MapEntry<String, StyledTextTag>(
                  key, StyledTextTag(style: textStyle));
            });
    }

    /// Converts the provided `widgets` map into a map of `StyledTextTagBase` objects with opacity applied.
    Map<String, StyledTextTagBase> convertWidgetTags() {
      return widgets == null
          ? <String, StyledTextTag>{}
          : widgets.map((String key, Widget widget) {
              return MapEntry<String, StyledTextTagBase>(
                key,
                StyledTextWidgetTag(Opacity(opacity: opacity, child: widget)),
              );
            });
    }

    /// Returns a StyledText widget with the combined styles and tags.
    return StyledText(
      text: this,
      style: style,
      tags: <String, StyledTextTagBase>{
        ...getTags(),
        ...convertTextStyleTags(),
        ...convertWidgetTags(),
      },
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
