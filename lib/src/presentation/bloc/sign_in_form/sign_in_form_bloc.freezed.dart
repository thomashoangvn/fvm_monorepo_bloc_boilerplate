// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_in_form_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SignInFormEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SignInFormEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SignInFormEvent()';
  }
}

/// @nodoc
class $SignInFormEventCopyWith<$Res> {
  $SignInFormEventCopyWith(
      SignInFormEvent _, $Res Function(SignInFormEvent) __);
}

/// @nodoc

class _Initial implements SignInFormEvent {
  const _Initial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SignInFormEvent.initial()';
  }
}

/// @nodoc

class _SignInWithEmail implements SignInFormEvent {
  const _SignInWithEmail();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _SignInWithEmail);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SignInFormEvent.signInWithEmail()';
  }
}

/// @nodoc

class _EmailOnChanged implements SignInFormEvent {
  const _EmailOnChanged(this.email);

  final String email;

  /// Create a copy of SignInFormEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EmailOnChangedCopyWith<_EmailOnChanged> get copyWith =>
      __$EmailOnChangedCopyWithImpl<_EmailOnChanged>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EmailOnChanged &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  @override
  String toString() {
    return 'SignInFormEvent.emailOnChanged(email: $email)';
  }
}

/// @nodoc
abstract mixin class _$EmailOnChangedCopyWith<$Res>
    implements $SignInFormEventCopyWith<$Res> {
  factory _$EmailOnChangedCopyWith(
          _EmailOnChanged value, $Res Function(_EmailOnChanged) _then) =
      __$EmailOnChangedCopyWithImpl;
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$EmailOnChangedCopyWithImpl<$Res>
    implements _$EmailOnChangedCopyWith<$Res> {
  __$EmailOnChangedCopyWithImpl(this._self, this._then);

  final _EmailOnChanged _self;
  final $Res Function(_EmailOnChanged) _then;

  /// Create a copy of SignInFormEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? email = null,
  }) {
    return _then(_EmailOnChanged(
      null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _PasswordOnChanged implements SignInFormEvent {
  const _PasswordOnChanged(this.password);

  final String password;

  /// Create a copy of SignInFormEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PasswordOnChangedCopyWith<_PasswordOnChanged> get copyWith =>
      __$PasswordOnChangedCopyWithImpl<_PasswordOnChanged>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PasswordOnChanged &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, password);

  @override
  String toString() {
    return 'SignInFormEvent.passwordOnChanged(password: $password)';
  }
}

/// @nodoc
abstract mixin class _$PasswordOnChangedCopyWith<$Res>
    implements $SignInFormEventCopyWith<$Res> {
  factory _$PasswordOnChangedCopyWith(
          _PasswordOnChanged value, $Res Function(_PasswordOnChanged) _then) =
      __$PasswordOnChangedCopyWithImpl;
  @useResult
  $Res call({String password});
}

/// @nodoc
class __$PasswordOnChangedCopyWithImpl<$Res>
    implements _$PasswordOnChangedCopyWith<$Res> {
  __$PasswordOnChangedCopyWithImpl(this._self, this._then);

  final _PasswordOnChanged _self;
  final $Res Function(_PasswordOnChanged) _then;

  /// Create a copy of SignInFormEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? password = null,
  }) {
    return _then(_PasswordOnChanged(
      null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$SignInFormState {
  RequestState get state;
  String get message;
  String get email;
  String get password;

  /// Create a copy of SignInFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignInFormStateCopyWith<SignInFormState> get copyWith =>
      _$SignInFormStateCopyWithImpl<SignInFormState>(
          this as SignInFormState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignInFormState &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, state, message, email, password);

  @override
  String toString() {
    return 'SignInFormState(state: $state, message: $message, email: $email, password: $password)';
  }
}

/// @nodoc
abstract mixin class $SignInFormStateCopyWith<$Res> {
  factory $SignInFormStateCopyWith(
          SignInFormState value, $Res Function(SignInFormState) _then) =
      _$SignInFormStateCopyWithImpl;
  @useResult
  $Res call(
      {RequestState state, String message, String email, String password});
}

/// @nodoc
class _$SignInFormStateCopyWithImpl<$Res>
    implements $SignInFormStateCopyWith<$Res> {
  _$SignInFormStateCopyWithImpl(this._self, this._then);

  final SignInFormState _self;
  final $Res Function(SignInFormState) _then;

  /// Create a copy of SignInFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
    Object? message = null,
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_self.copyWith(
      state: null == state
          ? _self.state
          : state // ignore: cast_nullable_to_non_nullable
              as RequestState,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _SignInFormState implements SignInFormState {
  const _SignInFormState(
      {required this.state,
      required this.message,
      required this.email,
      required this.password});

  @override
  final RequestState state;
  @override
  final String message;
  @override
  final String email;
  @override
  final String password;

  /// Create a copy of SignInFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SignInFormStateCopyWith<_SignInFormState> get copyWith =>
      __$SignInFormStateCopyWithImpl<_SignInFormState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SignInFormState &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, state, message, email, password);

  @override
  String toString() {
    return 'SignInFormState(state: $state, message: $message, email: $email, password: $password)';
  }
}

/// @nodoc
abstract mixin class _$SignInFormStateCopyWith<$Res>
    implements $SignInFormStateCopyWith<$Res> {
  factory _$SignInFormStateCopyWith(
          _SignInFormState value, $Res Function(_SignInFormState) _then) =
      __$SignInFormStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {RequestState state, String message, String email, String password});
}

/// @nodoc
class __$SignInFormStateCopyWithImpl<$Res>
    implements _$SignInFormStateCopyWith<$Res> {
  __$SignInFormStateCopyWithImpl(this._self, this._then);

  final _SignInFormState _self;
  final $Res Function(_SignInFormState) _then;

  /// Create a copy of SignInFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? state = null,
    Object? message = null,
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_SignInFormState(
      state: null == state
          ? _self.state
          : state // ignore: cast_nullable_to_non_nullable
              as RequestState,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
