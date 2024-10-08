// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/talker_flutter.dart';
import 'package:flutter/material.dart';

/// A fancy log formatter for `Talker` that adds more detailed borders and formatting to logs.
///
/// This formatter wraps log messages in a border with additional visual indicators
/// like bullet points, and it adjusts the log format to be more visually distinct.
class FancyTalkerLogFormatter implements LoggerFormatter {
  @override
  String fmt(LogDetails details, TalkerLoggerSettings settings) {
    final String msg = details.message?.toString() ?? '';
    final int maxLineWidth = settings.maxLineWidth;
    final int maxContentWidth = maxLineWidth - 4;

    const List<String> noPrefixLabels = <String>['•', '«'];

    final List<String> coloredLines = <String>[
      for (final String line in msg.split('\n'))
        for (final String wrappedLine in _wrapLine(
          maxContentWidth,
          line,
          noPrefixKeywords: noPrefixLabels,
          prefix: ' ' * 16,
        ))
          _formatLine(wrappedLine, maxContentWidth, details.pen),
    ];

    final String topBorder =
        details.pen.write('┌${'─' * (maxLineWidth - 2)}┐\n');
    final String bottomBorder =
        details.pen.write('└${'─' * (maxLineWidth - 2)}┘');

    return '$topBorder${coloredLines.join('\n')}\n$bottomBorder';
  }

  /// Formats a line of text to fit within a border.
  String _formatLine(String line, int maxContentWidth, AnsiPen pen) {
    final int paddingSize = maxContentWidth - line.length;
    final String padding = ' ' * (paddingSize > 0 ? paddingSize : 0);

    return pen.write('│ $line$padding │');
  }

  /// Wraps lines that exceed the specified width, with optional prefixes.
  Iterable<String> _wrapLine(
    int maxContentWidth,
    String text, {
    List<String> noPrefixKeywords = const <String>[],
    String prefix = '',
  }) {
    final List<String> wrappedLines = <String>[];
    String currentLine = text.replaceAll('\t', '    ');

    while (currentLine.isNotEmpty) {
      int currentMaxWidth = maxContentWidth;

      final bool isStartWithKeyword = noPrefixKeywords
          .any((String keyword) => currentLine.startsWith(keyword));

      if (wrappedLines.isNotEmpty || !isStartWithKeyword) {
        currentMaxWidth -= prefix.length;
      }

      int cutPoint = currentLine.length > currentMaxWidth
          ? currentMaxWidth
          : currentLine.length;

      if (cutPoint < currentLine.length) {
        final int lastSpace = currentLine.characters
            .getRange(0, cutPoint)
            .toString()
            .lastIndexOf(' ');
        if (lastSpace > -1) {
          cutPoint = lastSpace;
        }
      }

      wrappedLines.add(
        ((wrappedLines.isEmpty && isStartWithKeyword) ? '' : prefix) +
            currentLine.characters.getRange(0, cutPoint).toString(),
      );
      currentLine = currentLine.characters.getRange(cutPoint).toString().trim();
    }

    return wrappedLines;
  }
}
