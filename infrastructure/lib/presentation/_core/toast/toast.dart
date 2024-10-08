// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:flutter/material.dart';
import 'package:infrastructure/_core/commons/extensions/double.ext.dart';
import 'package:infrastructure/presentation/super_class.dart';

/// [Toast] is a customizable widget to display toast notifications in the UI.
/// It supports various options including custom content, a close button, and
/// animations for showing/hiding the toast.
class Toast extends StatelessWidget {
  const Toast({
    required this.controller,
    required this.onTap,
    this.backgroundColor,
    this.child,
    this.curve,
    this.isClosable,
    super.key,
    this.leading,
    this.message,
    this.messageStyle,
    this.onClose,
    this.shadowColor,
    this.isInFront = false,
  }) : assert((message != null || message != '') || child != null);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          InkWell(
            child: child ??
                Container(
                  padding: $.paddings.md.all,
                  width: MediaQuery.sizeOf(context).width,
                  child: Row(
                    children: <Widget>[
                      if (leading != null) ...<Widget>[
                        leading!,
                        const SizedBox(width: 10),
                      ],
                      if (message != null)
                        Expanded(
                          child: Text(message ?? '', style: messageStyle),
                        ),
                    ],
                  ),
                ),
            onTap: onTap,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          if (isClosable ?? false)
            Positioned(
              top: 0,
              right: 16,
              bottom: 0,
              child: InkWell(
                child: const Icon(Icons.close, size: 18),
                onTap: onClose,
              ),
            ),
        ],
      ),
    );
  }

  final Color? backgroundColor;
  final Widget? child;
  final AnimationController? controller;
  final Curve? curve;
  final bool? isClosable;
  final bool isInFront;
  final Widget? leading;
  final String? message;
  final TextStyle? messageStyle;
  final VoidCallback? onClose;
  final VoidCallback onTap;
  final Color? shadowColor;
}
