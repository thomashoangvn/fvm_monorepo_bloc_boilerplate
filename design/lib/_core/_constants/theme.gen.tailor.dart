// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_element, unnecessary_cast

part of 'theme.gen.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$ThemeGenTailorMixin
    on ThemeExtension<ThemeGen>, DiagnosticableTreeMixin {
  Color get background;
  Color get surface;
  Color get onSurface;
  Color get border;
  Color get shadow;
  Color get placeholder;
  Gradients get gradients;
  Colours get colors;
  Fonts get fonts;
  Defaults get defaults;

  @override
  ThemeGen copyWith({
    Color? background,
    Color? surface,
    Color? onSurface,
    Color? border,
    Color? shadow,
    Color? placeholder,
    Gradients? gradients,
    Colours? colors,
    Fonts? fonts,
    Defaults? defaults,
  }) {
    return ThemeGen(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      border: border ?? this.border,
      shadow: shadow ?? this.shadow,
      placeholder: placeholder ?? this.placeholder,
      gradients: gradients ?? this.gradients,
      colors: colors ?? this.colors,
      fonts: fonts ?? this.fonts,
      defaults: defaults ?? this.defaults,
    );
  }

  @override
  ThemeGen lerp(covariant ThemeExtension<ThemeGen>? other, double t) {
    if (other is! ThemeGen) return this as ThemeGen;
    return ThemeGen(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      border: Color.lerp(border, other.border, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      placeholder: Color.lerp(placeholder, other.placeholder, t)!,
      gradients: t < 0.5 ? gradients : other.gradients,
      colors: t < 0.5 ? colors : other.colors,
      fonts: t < 0.5 ? fonts : other.fonts,
      defaults: t < 0.5 ? defaults : other.defaults,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ThemeGen &&
            const DeepCollectionEquality()
                .equals(background, other.background) &&
            const DeepCollectionEquality().equals(surface, other.surface) &&
            const DeepCollectionEquality().equals(onSurface, other.onSurface) &&
            const DeepCollectionEquality().equals(border, other.border) &&
            const DeepCollectionEquality().equals(shadow, other.shadow) &&
            const DeepCollectionEquality()
                .equals(placeholder, other.placeholder) &&
            const DeepCollectionEquality().equals(gradients, other.gradients) &&
            const DeepCollectionEquality().equals(colors, other.colors) &&
            const DeepCollectionEquality().equals(fonts, other.fonts) &&
            const DeepCollectionEquality().equals(defaults, other.defaults));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(background),
      const DeepCollectionEquality().hash(surface),
      const DeepCollectionEquality().hash(onSurface),
      const DeepCollectionEquality().hash(border),
      const DeepCollectionEquality().hash(shadow),
      const DeepCollectionEquality().hash(placeholder),
      const DeepCollectionEquality().hash(gradients),
      const DeepCollectionEquality().hash(colors),
      const DeepCollectionEquality().hash(fonts),
      const DeepCollectionEquality().hash(defaults),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ThemeGen'))
      ..add(DiagnosticsProperty('background', background))
      ..add(DiagnosticsProperty('surface', surface))
      ..add(DiagnosticsProperty('onSurface', onSurface))
      ..add(DiagnosticsProperty('border', border))
      ..add(DiagnosticsProperty('shadow', shadow))
      ..add(DiagnosticsProperty('placeholder', placeholder))
      ..add(DiagnosticsProperty('gradients', gradients))
      ..add(DiagnosticsProperty('colors', colors))
      ..add(DiagnosticsProperty('fonts', fonts))
      ..add(DiagnosticsProperty('defaults', defaults));
  }
}

extension ThemeGenThemeData on ThemeData {
  ThemeGen get themeGen => extension<ThemeGen>()!;
}
