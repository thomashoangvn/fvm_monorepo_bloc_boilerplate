// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/talker_flutter.dart';
import 'package:flutter/material.dart';

/// A simple log formatter for `Talker` that formats logs with consistent padding and borders.
///
/// This formatter adds a border around each log entry and formats lines to a fixed width
/// by wrapping them when necessary. It ensures that logs are easily readable within a terminal.
class SimpleTalkerLogFormatter implements LoggerFormatter {
  @override
  String fmt(LogDetails details, TalkerLoggerSettings settings) {
    final String msg = details.message?.toString() ?? '';
    final int maxLineWidth = settings.maxLineWidth;

    final List<String> coloredLines = <String>[
      for (final String line in msg.split('\n'))
        for (final String wrappedLine in _wrapLine(maxLineWidth, line))
          formattedLine(wrappedLine, maxLineWidth, details.pen),
    ];

    final String topBorder = details.pen.write('${'*' * maxLineWidth}\n');
    final String bottomBorder = details.pen.write('*' * maxLineWidth);

    return '$topBorder${coloredLines.join('\n')}\n$bottomBorder';
  }

  /// Formats a line of text to fit within a specific width.
  String formattedLine(String line, int maxLineWidth, AnsiPen pen) {
    final int paddingSize = maxLineWidth - line.length;
    final String padding = ' ' * (paddingSize > 0 ? paddingSize : 0);

    return pen.write('$line$padding');
  }

  /// Wraps lines that exceed the specified width, splitting them into multiple lines.
  Iterable<String> _wrapLine(int maxContentWidth, String text) {
    final List<String> wrappedLines = <String>[];
    String currentLine = text.replaceAll('\t', '    ');

    while (currentLine.isNotEmpty) {
      final int cutPoint = currentLine.length > maxContentWidth
          ? maxContentWidth
          : currentLine.length;
      wrappedLines.add(currentLine.characters.getRange(0, cutPoint).toString());
      currentLine = currentLine.characters.getRange(cutPoint).toString().trim();
    }

    return wrappedLines;
  }
}
